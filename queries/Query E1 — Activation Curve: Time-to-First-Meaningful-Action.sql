-- Title: Query E1 — Activation Curve: Time-to-First-Meaningful-Action
-- Business question: How fast do new signups become real users, and how has that changed cohort-over-cohort?
-- What this tells us: 
-- PM Action: [one concrete change a PM/founder could action this sprint, OR one follow-up query to fund next]
-- Sanity check: [what you ran to verify this isn't lying to you] -> [the actual result]

with signup_cohorts as (
    select 
        c.customer_id,
        date_trunc('week', c.created_at) at time zone 'utc' as signup_week,
        c.created_at at time zone 'utc' as signup_time
    from ecom.customers c
    where c.created_at >= '2026-04-19' -- exclude uninstrumented cohorts
),
first_actions as (
    select 
        se.customer_id,
        min(se.occurred_at) at time zone 'utc' as first_action_time
    from ecom.session_events se
    where se.event_type in ('add_to_cart','begin_checkout','purchase')
    group by se.customer_id
),
activation as (
    select 
        sc.signup_week,
        sc.customer_id,
        case 
            when fa.first_action_time is not null
			 and fa.first_action_time > sc.signup_time
             and fa.first_action_time <= sc.signup_time + interval '7 days'
            then 1 else 0 
        end as activated_7d,
        case
    		when fa.first_action_time > sc.signup_time
    		then extract(epoch from (fa.first_action_time - sc.signup_time))/60
    		else null
		end as minutes_to_activation

    from signup_cohorts sc
    left join first_actions fa on sc.customer_id = fa.customer_id
)
select 
    signup_week,
    count(distinct customer_id) as cohort_size,
    sum(activated_7d) as activated_7d,
    round(sum(activated_7d)::numeric / count(distinct customer_id), 4)*100 as activation_rate_7d_in_pct,
    percentile_cont(0.5) within group (order by minutes_to_activation) as median_minutes_to_activation,
    percentile_cont(0.9) within group (order by minutes_to_activation) as p90_minutes_to_activation
from activation
group by signup_week
order by signup_week;

