table_name	column_name	data_type	is_nullable
accounts	account_id	bigint	NO
accounts	name	text	NO
accounts	account_type	text	NO
accounts	industry	text	YES
accounts	employee_count	integer	YES
accounts	country	text	YES
accounts	signup_date	timestamp with time zone	YES
accounts	acquisition_channel	text	YES
email_sends	send_id	bigint	NO
email_sends	user_id	integer	YES
email_sends	campaign_name	text	YES
email_sends	send_type	text	YES
email_sends	sent_at	timestamp with time zone	YES
email_sends	opened_at	timestamp with time zone	YES
email_sends	clicked_at	timestamp with time zone	YES
events	event_id	integer	NO
events	user_id	integer	YES
events	event_type	text	YES
events	occurred_at	timestamp without time zone	YES
events	properties	text	YES
events	account_id	bigint	YES
events	feature_id	integer	YES
experiment_assignments	assignment_id	integer	NO
experiment_assignments	experiment_id	integer	YES
experiment_assignments	user_id	integer	YES
experiment_assignments	variant	text	YES
experiment_assignments	assigned_at	timestamp without time zone	YES
experiment_assignments	variant_id	integer	YES
experiment_variants	variant_id	integer	NO
experiment_variants	experiment_id	integer	YES
experiment_variants	variant_name	text	YES
experiment_variants	allocation_pct	numeric	YES
experiment_variants	is_control	boolean	YES
experiments	experiment_id	integer	NO
experiments	name	text	YES
experiments	start_date	timestamp without time zone	YES
experiments	end_date	timestamp without time zone	YES
experiments	hypothesis	text	YES
experiments	owner	text	YES
experiments	status	text	YES
features	feature_id	integer	NO
features	feature_name	text	YES
features	category	text	YES
features	release_date	timestamp without time zone	YES
invoices	invoice_id	integer	NO
invoices	user_id	integer	YES
invoices	subscription_id	integer	YES
invoices	amount	numeric	YES
invoices	status	text	YES
invoices	issued_date	timestamp without time zone	YES
invoices	paid_date	timestamp without time zone	YES
invoices	due_date	timestamp without time zone	YES
invoices	account_id	bigint	YES
legacy_companies	id	integer	NO
legacy_companies	name	character varying	NO
legacy_companies	industry	character varying	NO
legacy_companies	employee_count	integer	NO
legacy_companies	signup_date	date	NO
legacy_companies	country	character varying	NO
legacy_events	id	integer	NO
legacy_events	company_id	integer	NO
legacy_events	event_type	character varying	NO
legacy_events	event_date	date	NO
legacy_events	properties	jsonb	YES
legacy_invoices	id	integer	NO
legacy_invoices	company_id	integer	NO
legacy_invoices	subscription_id	integer	NO
legacy_invoices	amount	numeric	NO
legacy_invoices	status	character varying	NO
legacy_invoices	issued_date	date	NO
legacy_invoices	paid_date	date	YES
legacy_subscriptions	id	integer	NO
legacy_subscriptions	company_id	integer	NO
legacy_subscriptions	plan	character varying	NO
legacy_subscriptions	start_date	date	NO
legacy_subscriptions	end_date	date	YES
legacy_subscriptions	mrr	numeric	NO
legacy_subscriptions	status	character varying	NO
legacy_subscriptions	cancelled_at	timestamp without time zone	YES
legacy_subscriptions	cancellation_reason	character varying	YES
legacy_support_tickets	id	integer	NO
legacy_support_tickets	company_id	integer	NO
legacy_support_tickets	subject	character varying	NO
legacy_support_tickets	priority	character varying	NO
legacy_support_tickets	status	character varying	NO
legacy_support_tickets	created_at	timestamp without time zone	NO
legacy_support_tickets	resolved_at	timestamp without time zone	YES
legacy_support_tickets	category	character varying	NO
payment_attempts	attempt_id	integer	NO
payment_attempts	invoice_id	integer	YES
payment_attempts	user_id	integer	YES
payment_attempts	subscription_id	integer	YES
payment_attempts	amount	numeric	YES
payment_attempts	status	text	YES
payment_attempts	failure_reason	text	YES
payment_attempts	attempt_number	integer	YES
payment_attempts	attempted_at	timestamp without time zone	YES
payment_attempts	account_id	bigint	YES
plans	plan_id	integer	NO
plans	plan_name	text	NO
plans	monthly_price	numeric	NO
plans	seat_limit	integer	YES
plans	billing_interval	text	NO
seats	seat_id	bigint	NO
seats	account_id	bigint	YES
seats	user_id	integer	YES
seats	activated_at	timestamp with time zone	YES
seats	deactivated_at	timestamp with time zone	YES
signups	user_id	integer	YES
signups	account_id	bigint	YES
signups	signup_date	timestamp without time zone	YES
signups	signup_source	text	YES
subscription_events	event_id	integer	NO
subscription_events	subscription_id	integer	YES
subscription_events	user_id	integer	YES
subscription_events	event_type	text	YES
subscription_events	event_time	timestamp without time zone	YES
subscription_events	from_plan	text	YES
subscription_events	to_plan	text	YES
subscription_events	mrr_delta	numeric	YES
subscription_events	account_id	bigint	YES
subscription_events	actor_user_id	integer	YES
subscription_events	seats_delta	integer	YES
subscriptions	subscription_id	integer	NO
subscriptions	user_id	integer	YES
subscriptions	plan	text	YES
subscriptions	start_date	timestamp without time zone	YES
subscriptions	end_date	timestamp without time zone	YES
subscriptions	mrr	numeric	YES
subscriptions	status	text	YES
subscriptions	cancelled_at	timestamp without time zone	YES
subscriptions	cancellation_reason	text	YES
subscriptions	account_id	bigint	YES
subscriptions	seat_count	integer	YES
subscriptions	plan_id	integer	YES
support_tickets	ticket_id	bigint	NO
support_tickets	account_id	bigint	YES
support_tickets	opened_by_user_id	integer	YES
support_tickets	opened_at	timestamp with time zone	YES
support_tickets	closed_at	timestamp with time zone	YES
support_tickets	priority	text	YES
support_tickets	category	text	YES
support_tickets	csat	integer	YES
trials	trial_id	bigint	NO
trials	account_id	bigint	YES
trials	started_at	timestamp with time zone	YES
trials	ends_at	timestamp with time zone	YES
trials	converted_at	timestamp with time zone	YES
trials	converted_subscription_id	bigint	YES
users	user_id	integer	NO
users	email	text	YES
users	company_name	text	YES
users	signup_date	timestamp without time zone	YES
users	signup_source	text	YES
users	plan_type	text	YES
users	is_active	integer	YES
users	last_login_date	timestamp without time zone	YES
users	account_id	bigint	YES
users	role	text	YES
<img width="985" height="4641" alt="image" src="https://github.com/user-attachments/assets/63581ebe-e8a8-460b-8433-5a724197eb3c" />
