## Part A — ecom (5 queries)

**Query E1 — Activation Curve: Time-to-First-Meaningful-Action**

*Business question:* "How fast do new signups become real users, and how has that changed cohort-over-cohort?"

*Summary of the Output :* Cohort sizes range from ~129 in the earliest week to ~800 in later weeks. Activation rates decline steadily: from ~16% in the first instrumented cohort down to ~2% in the most recent one. Median minutes to activation drop from ~27k minutes (~19 days) in early cohorts to ~2.9k minutes (~2 days) in the latest cohort. p90 minutes to activation also shrink from ~70k minutes (~48 days) to ~6.4k minutes (~4.5 days). Overall, activation is happening faster (lower median/p90), but fewer users are activating at all (falling activation rate).

*Sanity checks :*  
1. activated_7d <= cohort_size holds true for every row.
2. Cohorts before 2026‑04‑19 are excluded, so no uninstrumented rows are present.
3. The most recent cohort show artificiallys low activation rate because the 7‑day window hasn’t fully closed, this explains the very low 1.99% rate

*Interpretation :* There is a clear decline in activation rates across cohorts. On average, only about 8% of users take meaningful actions such as add_to_cart, begin_checkout, or purchase within 7 days of signup. However, a deeper look at the data reveals a significant anomaly: approximately 63% of users have a first action logged before their signup date. When those cases are excluded, roughly 50% of users still perform these actions either 7 days before or after the signup.
This strongly indicates a data quality issue. In most cases, first_action_time values precede signup_time by more than a month, which rules out simple timezone differences. A plausible explanation is that some events were backfilled or imported with incorrect timestamps during data ingestion, leading to misaligned timelines.

*Actionable Takeaways :*
1. Validate how session_events.occurred_at is being ingested. Check whether historical events were backfilled with incorrect timestamps or mismatched signup IDs.
2. Add automated sanity checks (e.g., first_action_time >= signup_time) to flag future anomalies early, before they distort cohort analysis.
3. After cleaning, recompute activation rates and time‑to‑activation. Compare the corrected results to the current output to quantify the impact of bad data.


**Query E2 — Checkout Funnel Drop-off by Entry Channel**

*Business question:* "Where is checkout leaking, and is the leak the same across paid social vs organic search?"

*Summary of the Output :*

*Sanity checks :*  

*Interpretation :*  

*Actionable Takeaways :*

**Query E3 — Cohort Retention Curve (Weekly, Behavioral)**

*Business question:* "Of users who signed up in week W, what fraction came back and did *something meaningful* in week W+1, W+2, W+3, W+4?"

*Summary of the Output :*

*Sanity checks :*  

*Interpretation :*  

*Actionable Takeaways :*

**Query E4 — PDP Engagement: High-View, Low-Cart Products**

*Business question:* "Which products attract eyeballs but don't get added to cart? Those are either pricing problems, image problems, or stock problems."

*Summary of the Output :*

*Sanity checks :*  

*Interpretation :*  

*Actionable Takeaways :*

**Query E5 — Cart Abandonment by Cart Value Bucket**

*Business question:* "Cart abandonment is 70% overall — but is it the same for ₹500 carts as ₹15,000 carts? Where do we lose the most rupees?"

*Summary of the Output :*

*Sanity checks :*  

*Interpretation :*  

*Actionable Takeaways :*

## Part B — saas (5 queries)

**Query S1 — Monthly MRR Movement Decomposition**

*Business question:* "How did MRR change last month — and what drove the change? New, expansion, contraction, or churn?"

*Summary of the Output :*

*Sanity checks :*  

*Interpretation :*  

*Actionable Takeaways :*

**Query S2 — Trial-to-Paid Conversion by Cohort**

*Business question:* "Of accounts that started a trial in week W, what fraction converted to paid by day 14, 30, 60?"

*Summary of the Output :*

*Sanity checks :*  

*Interpretation :*  

*Actionable Takeaways :*

**Query S3 — Gross Revenue Churn and Net Revenue Retention by Cohort**

*Business question:* "Of the MRR we had from a given monthly cohort 12 months ago, how much did we keep (gross retention) and how much did we keep INCLUDING expansion (net retention)?"

*Summary of the Output :*

*Sanity checks :*  

*Interpretation :*  

*Actionable Takeaways :*

**Query S4 — Feature Adoption vs Retention**

*Business question:* "Which product features predict 90-day retention? Which are red herrings?"

*Summary of the Output :*

*Sanity checks :*  

*Interpretation :*  

*Actionable Takeaways :*

**Query S5 — Expansion Revenue: Who's Upgrading and Why**

*Business question:* "Of accounts that expanded MRR in the last 6 months, what's the dominant expansion vector — seats added, plan upgrade, or add-on attach?"

*Summary of the Output :*

*Sanity checks :*  

*Interpretation :*  

*Actionable Takeaways :*
