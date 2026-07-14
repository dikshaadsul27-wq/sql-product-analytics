-- Title: Checkout Funnel Drop-off by Entry Channel
-- Business question: Where is checkout leaking, and is the leak the same across paid social vs organic search?
-- What this tells us: The funnel is stable through address, shipping, and payment steps, with only 1–4% drop-offs. The largest leak occurs at the final purchase step, where
-- ~7–8% of users abandon after entering payment details. This pattern is consistent across all channels, with referral and affiliate slightly worse.
-- PM Action: Investigate the purchase confirmation step (post-payment) using session recordings and heatmaps in the next sprint. Focus on whether users encounter friction,
-- errors, or trust issues after submitting payment, and validate payment gateway performance.
-- Sanity check: Every later step count ≤ the prior step. 

with session_step_reached as (
  select
    s.session_id,
    sc.channel,
    max(case
      when se.event_type = 'purchase'        then 5
      when se.event_type = 'add_payment'     then 4
      when se.event_type = 'select_shipping' then 3
      when se.event_type = 'add_address'     then 2
      when se.event_type = 'begin_checkout'  then 1
      else 0
    end) as max_step
  from ecom.sessions s
  join ecom.session_channels sc using (session_id)
  join ecom.session_events se using (session_id)
  group by 1, 2
)
select
  channel,
  count(*) filter (where max_step >= 1) as begin_checkout,
  count(*) filter (where max_step >= 2) as address,
  count(*) filter (where max_step >= 3) as shipping,
  count(*) filter (where max_step >= 4) as payment,
  count(*) filter (where max_step >= 5) as purchased,
  round(1 - (count(*) filter (where max_step >= 2)::numeric / nullif(count(*) filter (where max_step >= 1),0)),3) as drop_address_pct,
  round(1 - (count(*) filter (where max_step >= 3)::numeric / nullif(count(*) filter (where max_step >= 2),0)),3) as drop_shipping_pct,
  round(1 - (count(*) filter (where max_step >= 4)::numeric / nullif(count(*) filter (where max_step >= 3),0)),3) as drop_payment_pct,
  round(1 - (count(*) filter (where max_step >= 5)::numeric / nullif(count(*) filter (where max_step >= 4),0)),3) as drop_final_pct
from session_step_reached
where max_step >= 1
group by 1
order by begin_checkout desc;
