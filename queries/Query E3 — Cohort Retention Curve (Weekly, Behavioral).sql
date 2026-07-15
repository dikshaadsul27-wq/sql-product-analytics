-- Title: Query E3 — Cohort Retention Curve (Weekly, Behavioral)
-- Business question: Of users who signed up in week W, what fraction came back and did something meaningful in week W+1, W+2, W+3, W+4?
-- What this tells us: 
-- PM Action: 
-- Sanity check: cohort size = week0 active customers

with signup_cohorts as (
 select 
        c.customer_id,
        least(min(se.occurred_at),c.created_at) as signup_time,
		date_trunc('week',least(min(se.occurred_at),c.created_at)) as cohort_week
    from ecom.customers c
	left join ecom.session_events se
    on c.customer_id = se.customer_id
    where c.created_at >= '2026-04-19' -- exclude uninstrumented cohorts
	group by c.customer_id
),
retention as (
    select
        sc.cohort_week
        , sc.customer_id
        , floor(extract(epoch from (se.occurred_at - sc.signup_time)) / (86400*7)) as week_index
    from signup_cohorts sc
    join ecom.session_events se
        on sc.customer_id = se.customer_id
    where se.event_type in ('product_view','add_to_cart','purchase')
      and se.occurred_at >= sc.signup_time
)

select
    sc.cohort_week
    , count(distinct sc.customer_id) as cohort_size
    , count(distinct sc.customer_id) as w0_active -- always equal to cohort_size
    , count(distinct case when week_index = 1 then sc.customer_id end) as w1_retained
    , count(distinct case when week_index = 2 then sc.customer_id end) as w2_retained
    , count(distinct case when week_index = 3 then sc.customer_id end) as w3_retained
    , count(distinct case when week_index = 4 then sc.customer_id end) as w4_retained
	, ROUND(count(distinct case when week_index = 1 then sc.customer_id end)::numeric/count(distinct sc.customer_id),2) as w1_retention_rate
	, ROUND(count(distinct case when week_index = 2 then sc.customer_id end)::numeric/count(distinct sc.customer_id),2) as w2_retention_rate
	, ROUND(count(distinct case when week_index = 3 then sc.customer_id end)::numeric/count(distinct sc.customer_id),2) as w3_retention_rate
	, ROUND(count(distinct case when week_index = 4 then sc.customer_id end)::numeric/count(distinct sc.customer_id),2) as w4_retention_rate
	
from signup_cohorts sc
left join retention r on sc.customer_id = r.customer_id
group by sc.cohort_week
order by sc.cohort_week;

