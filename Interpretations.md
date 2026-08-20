## Part A — ecom (5 queries)

**Query E1 — Activation Curve: Time-to-First-Meaningful-Action**

*Business question:* "How fast do new signups become real users, and how has that changed cohort-over-cohort?"

*Summary of the Output :* Activation is trending down across post-instrumentation cohorts: from 47.43% on April 20 to 30.22% on May 25 and 25.0% on June 1. Median time to first meaningful action is also inconsistent and often slow, indicating many users do not activate soon after signup.

*Sanity checks :*  
1. activated_7d <= cohort_size holds true for every row.
2. Cohorts before 2026‑04‑19 are excluded, so no uninstrumented rows are present.
3. The most recent cohort show artificially low activation rate because the 7‑day window hasn’t fully closed, this explains the very low 1.99% rate

*Interpretation :* Among valid post-instrumentation cohorts, activation is worsening cohort-over-cohort: fewer new users complete an add-to-cart, checkout, or purchase within seven days. The May 25 and June 1 cohorts are the key concern, though the most recent cohorts may still be artificially low until their 7-day windows close. The high and variable time-to-activation figures also suggest many users who do activate are taking longer to reach meaningful value.

*Actionable Takeaways :*
1. Investigate whether an onboarding change, homepage performance issue, or lower-intent paid traffic around the May 25 signup week caused the activation decline.
2. Compare funnel conversion, traffic source, onboarding version, and page-load performance against earlier cohorts.


**Query E2 — Checkout Funnel Drop-off by Entry Channel**

*Business question:* "Where is checkout leaking, and is the leak the same across paid social vs organic search?"

*Summary of the Output :* Across all entry channels, the checkout funnel shows relatively small leaks at each intermediate step (3–4% at address, ~2% at shipping, ~1–2% at payment). The largest drop consistently occurs at the final purchase step, where 7–8% of sessions abandon after adding payment details. Organic and paid channels have similar patterns, with referral and affiliate slightly worse at the final step (~8.3–8.2% drop).

*Sanity checks :*  
1. Each later step count is ≤ the prior step, so the funnel logic is correct.
2. Drop percentages are consistent across channels, no impossible >100% conversions.

*Interpretation :*  The funnel is relatively healthy through address, shipping, and payment stages — losses are modest. The critical leak is at the final purchase step, where ~8% of users abandon after entering payment details. This pattern is consistent across all channels (organic, paid, referral, email, affiliate), suggesting the issue is not channel‑specific but rather something in the purchase confirmation or payment processing experience. Referral and affiliate traffic show slightly higher drop‑offs, which may reflect lower trust or weaker intent compared to direct/organic traffic.

*Actionable Takeaways :*
1. Investigate the purchase confirmation step (post‑payment) with session recordings and heatmaps in the next sprint. Focus on whether users encounter friction, errors, or trust issues after submitting payment.
2. Validate payment gateway performance: check for latency, failed transactions, or confusing error messages.
3. Run usability testing on the final confirmation page to identify design or UX issues that could cause hesitation.

**Query E3 — Cohort Retention Curve (Weekly, Behavioral)**

*Business question:* "Of users who signed up in week W, what fraction came back and did *something meaningful* in week W+1, W+2, W+3, W+4?"

*Summary of the Output :* Early cohorts (April 13 – May 11) show steady engagement, with retention rates between 30–40% through week 4. Later cohorts (after May 18) show sharp drop‑offs, with week‑4 retention falling to 0–15%. Cohort sizes also shrink over time, suggesting reduced acquisition or incomplete instrumentation for newer weeks.

*Sanity checks :*  

*Interpretation :*  Most cohorts have w1 ≈ 30–35%, comfortably above the 20% threshold. Activation is not the bottleneck. Retention declines from ~40% in early cohorts to near 0% in later ones—indicating users fail to form sustained habits. Engagement decays faster in newer cohorts, implying either product fatigue, reduced onboarding quality, or external seasonality. Fewer signups post‑May 18 may distort later retention rates (small sample volatility).

*Actionable Takeaways :*
1. Introduce re‑engagement nudges (email/push reminders) around week 2–3.
2. Add habit‑loop features—saved carts, wish lists, or personalized recommendations—to encourage repeat meaningful actions.
3. Segment by acquisition channel to identify weak sources (organic vs paid vs referral).
4. Consider win‑back campaigns for users inactive after week 2.

**Query E4 — PDP Engagement: High-View, Low-Cart Products**

*Business question:* "Which products attract eyeballs but don't get added to cart? Those are either pricing problems, image problems, or stock problems."

*Summary of the Output :* The query highlights 10 products that attract significant views but underperform in add‑to‑cart conversions. Each product’s ATC rate is benchmarked against its category median, ensuring context‑sensitive evaluation. Categories include beauty (kajal, eyeshadow, crop top), fashion (jeans, jackets, windcheater), home (bedsheet, French press), and wearables (smartwatch, hybrid watch). Several products show negative gaps vs. category median, flagging them as potential problem SKUs.

*Sanity checks :*  
1. add_to_cart_sessions <= views for every product
2. atc_rate between 0 and 1.

*Interpretation :*  
Beauty SKUs (kajal, eyeshadow) → high visibility but lagging ATC vs. median → possible pricing or image quality issues.
Fashion SKUs (jeans, jackets, windcheater) → strong views but weak conversion → likely fit/size confidence gap or stock availability.
Home goods (bedsheet, French press) → lower ATC relative to median → could be price anchoring or competitive alternatives.
Wearables (smartwatch, hybrid watch) → high interest but low ATC → potential feature mismatch or stock constraints.

*Actionable Takeaways :*
1. Where ATC gap vs. median is large, consider discounts or bundles.
2. Audit product detail pages for visual quality, lifestyle imagery, and clarity.
3. If stockouts or limited sizes exist, ATC suppression is expected. Verify inventory levels for flagged SKUs.
4. Run competitive pricing analysis for beauty and fashion SKUs.

**Query E5 — Cart Abandonment by Cart Value Bucket**

*Business question:* "Cart abandonment is 70% overall — but is it the same for ₹500 carts as ₹15,000 carts? Where do we lose the most rupees?"

*Summary of the Output :*Overall abandonment rate is ~70%, but varies sharply by cart value. High‑value carts (₹15,000+ and ₹5,000–₹14,999) have low abandonment rates (12–20%), yet account for the largest GMV losses (₹866M and ₹624M left on table). Low‑value carts (<₹500) show the highest abandonment rate (53%), but GMV loss is negligible (~₹2.8M). Mid‑range carts (₹500–₹4,999) have moderate abandonment (31–45%) with meaningful GMV leakage (~₹218M combined).

*Sanity checks :*  
1. Sum of atc_sessions across buckets equals total ATC sessions in the same window.

*Interpretation :*  
High‑value carts: Even small abandonment percentages translate into massive rupee losses. Checkout reliability or payment friction disproportionately hurts revenue here.
Low‑value carts: High abandonment rates, but low GMV impact. Likely driven by shipping cost sensitivity or lack of perceived value.
Mid‑range carts: Significant abandonment (31–45%), contributing ~₹218M GMV loss. These users are engaged but hesitant—possibly due to pricing thresholds or promotions.
Strategic insight: GMV leakage is concentrated in top two buckets (₹5,000+), not in low‑value carts.

*Actionable Takeaways :*
1. Focus engineering and UX fixes on payment flows, error handling, and reliability. Even a 2–3% improvement in high‑value cart conversion yields hundreds of millions in GMV recovery.
2. For <₹500 carts, experiment with free‑shipping promotions or bundling incentives.
3. Target ₹500–₹4,999 carts with discount nudges, limited‑time offers, or loyalty points.

## Part B — saas (5 queries)

**Query S1 — Monthly MRR Movement Decomposition**

*Business question:* "How did MRR change last month — and what drove the change? New, expansion, contraction, or churn?"

*Summary of the Output :* Most months show positive net new MRR, driven primarily by new subscriptions and reactivations. Churn spikes in Jan, Mar, and May 2026, dragging down net growth despite strong new sales. June 2026 is an outlier, very low new MRR (~₹3k) and net new (~₹2.9k), due to incomplete data capture.

*Sanity checks :*  

*Interpretation :* 
New MRR is consistently the largest contributor (e.g., Oct 2025 ₹22.6k, May 2026 ₹24.1k).
Reactivation MRR provides meaningful boosts (Jan 2026 ₹4.1k, Apr 2026 ₹3.4k).
Expansion MRR is steady but modest (~₹1.3k–₹3.7k monthly).
Jan 2026 (₹9.5k), Mar 2026 (₹13.8k), May 2026 (₹7.6k). These months show strong new sales but churn erodes gains. Contraction MRR is relatively small.
March 2026 churn (₹13.8k) is the single biggest negative swing, dwarfing contraction and expansion.

*Actionable Takeaways :*
1. Investigate March 2026 churn spike — largest negative mover, cut by plan tier first.
2. Address churn volatility — strengthen customer success outreach and retention programs.
3. Run win‑back campaigns — target accounts that churned in Jan–Mar.
4. Boost expansion MRR — upsell campaigns, seat bundles, add‑ons to lift growth.
5. Board narrative — growth strong but churn volatility is the biggest risk, next step is cohort analysis by plan tier.

**Query S2 — Trial-to-Paid Conversion by Cohort**

*Business question:* "Of accounts that started a trial in week W, what fraction converted to paid by day 14, 30, 60?"

*Summary of the Output :* 
Cohorts are small (1–8 trials per week), so conversion rates swing sharply. Many cohorts show 100% conversion. Several cohorts show 0% conversion. Median days to convert cluster around 9–14 days, consistent with early‑stage adoption.

*Sanity checks :*  
1. converted_by_14d <= converted_by_30d <= converted_by_60d.
2. 

*Interpretation :*  
Weeks like April 14, 2026 (4/4 converted, 100%) and May 25, 2027 (5/6 converted, 83%) show excellent trial‑to‑paid performance.
Weeks with 0% conversion (e.g. May 12 2026, May 19 2026, May 26 2026, September 29 2026, February 9 2027, March 2 2027) are the worst performers.
Most conversions happen within ~10–12 days, showing that users decide early whether to pay.
Conversion is highly inconsistent, some weeks stellar, others completely flat. This points to external factors (marketing quality, signup source) rather than product quality alone.

*Actionable Takeaways :*
1. Check if these trials came from a weak marketing channel (e.g. low‑intent campaigns).
2. If source looks fine, pivot to plan trialed maybe a specific plan is failing to convert.
3. Segment poor cohorts by channel to isolate marketing vs. product problem.
4. Run targeted experiments on weak sources

**Query S3 — Gross Revenue Churn and Net Revenue Retention by Cohort**

*Business question:* "Of the MRR we had from a given monthly cohort 12 months ago, how much did we keep (gross retention) and how much did we keep INCLUDING expansion (net retention)?"

*Summary of the Output :* Across monthly cohorts, Gross Revenue Retention (GRR) is consistently well below 80%, often near 0–7%, indicating severe retention issues. Net Revenue Retention (NRR) is negative in almost all cohorts (values between –0.3 and –1.0), meaning expansion is not offsetting churn. A few cohorts show modest expansion. Overall, the company is in a retention crisis: most cohorts lose nearly all their starting MRR within 12 months.

*Sanity checks :*  
1. grr <= 1.0
2. nrr can exceed 1.0 (this is good news, not a bug). No value >1 was observed.
3. grr + (churn_mrr / starting_mrr) ≈ 1.0

*Interpretation :*  Retention problem: GRR consistently below 80% (often near 0%) meaning customers are not sticking around.
Expansion insufficient: Even when expansion occurs, churn wipes out gains, leaving NRR negative.
Cohort volatility: Some months show small retained MRR, but the pattern is not sustained.
Strategic implication: The company is firmly in the “retention problem” world, growth spend will not fix this until churn is addressed.

*Actionable Takeaways :*
1. Run cuts by plan tier, region, and customer segment to identify where churn is concentrated
2. GRR < 80% across the board means product/experience issues are driving customer exits.
3. Strengthen onboarding, support, and engagement programs to reduce early churn.
4. Retention collapse — GRR near 0%, NRR negative. Focus must be on fixing churn before pursuing growth.

**Query S4 — Feature Adoption vs Retention**

*Business question:* "Which product features predict 90-day retention? Which are red herrings?"

*Summary of the Output :* The query compares 90‑day retention rates between accounts that adopted a feature vs. those that did not. Some features show positive retention lift (e.g. Shared Reports, API Access, Real‑time Dashboard, Custom Fields, Funnel Analysis). Many features show negative lift, meaning adopters retained worse than non‑adopters (e.g. Dashboard, Live Chat, Custom Branding, Salesforce Sync, Automations).

Several features have no measurable lift (Priority Support, Advanced Analytics, Webhook Support, SSO, Bulk Export, Desktop App).

*Sanity checks :*  accounts_adopted + accounts_not_adopted = total_eligible_accounts

*Interpretation :* Positive signals: Shared Reports (+16.7pp, +20%) → strongest credible lift.
API Access (+5.9pp, +7.8%), Real‑time Dashboard (+5.9pp, +6.3%), Custom Fields (+4.8pp, +5%), Funnel Analysis (+3.5pp, +4.2%) → moderate lifts.
Neutral features: Priority Support, Advanced Analytics, Webhook Support, SSO, Bulk Export, Desktop App — no measurable impact.
Negative signals (red herrings): Dashboard (–10.8pp), Live Chat (–11.7pp), Custom Branding (–12.5pp), Salesforce Sync (–13.3pp), Automations (–62.5pp). These features correlate with lower retention, likely due to selection bias or poor adoption experience.
Selection bias caveat: Accounts adopting many features are systematically different from those adopting few. A naive comparison may overstate impact. A more rigorous approach would control for usage intensity or run propensity‑matched analysis. 

*Actionable Takeaways :* 
1. Shared Reports shows the largest credible lift (+16.7pp). Prioritize discoverability push (in‑app prompt, onboarding placement). Run a cohort cut by company size or plan tier to see if Shared Reports’ lift is consistent across segments.
3. API Access, Real‑time Dashboard, Custom Fields, Funnel Analysis secondary features worth deeper investigation.
4. Dashboard, Live Chat, Custom Branding, Salesforce Sync, Automations, do not prioritize. Investigate whether adoption correlates with struggling accounts.

**Query S5 — Expansion Revenue: Who's Upgrading and Why**

*Business question:* "Of accounts that expanded MRR in the last 6 months, what's the dominant expansion vector — seats added, plan upgrade, or add-on attach?"

*Summary of the Output :* Seats added dominate expansion revenue, they generate the highest MRR and happen relatively early (~49 days). Plan upgrades involve more accounts but contribute less per account and occur much later (~417 days). Add‑ons are negligible, with only one account expanded.

*Sanity checks :*  

*Interpretation :*  Expansion is primarily seat‑driven, showing that customers scale usage quickly after signup. Plan upgrades are a slower, long‑tail motion with modest revenue impact. Add‑ons barely register, suggesting limited adoption or poor cross‑sell visibility.

*Actionable Takeaways :*
1. Invest in seat‑management UX and admin features to maximize expansion revenue.
2. Plan upgrades can be improved with clearer tier differentiation and better upgrade prompts.
3. Add‑ons should be deprioritized until retention and adoption improve.
