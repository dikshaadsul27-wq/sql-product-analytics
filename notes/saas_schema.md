# saas_schema.md

## Section A — Table Inventory
(Grain, approx row count, purpose for each table) [Inventory](https://github.com/dikshaadsul27-wq/sql-product-analytics/blob/501170d117a298af1cad3c8f9372bb5689905ec4/notes/Inventory.md)

### 1. accounts
- Grain: a single account
- Approx row count: 1,250
- Purpose: a company can have multiple accounts

### 2. email_sends
- Grain: an email sent out to a user
- Approx row count: 3,385
- Purpose:

### 3. events
- Grain: an event by a user
- Approx row count: 53,534
- Purpose:

### 4. experiment_assignments
- Grain: user invovled in the experiment
- Approx row count: 3,200
- Purpose:

### 5. experiment_variants
- Grain: variant of an experiment
- Approx row count: 8
- Purpose:

### 6. experiments
- Grain: an experiment conducted
- Approx row count: 4
- Purpose:

### 7. features
- Grain: a feature and its details
- Approx row count: 50
- Purpose:

### 8. invoices
- Grain: an invoice for a user
- Approx row count: 4,201
- Purpose:

### 9. legacy_companies
- Grain: a company and its details
- Approx row count: 200
- Purpose:

### 10. legacy_events
- Grain: an event recorded against a company
- Approx row count: 15,028
- Purpose:

### 11. legacy_invoices
- Grain: an invoice for a company (instead of a single user)
- Approx row count: 1,500
- Purpose:

### 12. legacy_subscriptions
- Grain: a subscription by a company (instead of a single user)
- Approx row count: 500
- Purpose:

### 13. legacy_support_tickets
- Grain: a ticked opened against a company (instead of a single user)
- Approx row count: 300
- Purpose:

### 14. payment_attempts
- Grain: a payment attempt made (including failed attempts)
- Approx row count: 5,690
- Purpose:

### 15. plans
- Grain: a plan with price and seat limit
- Approx row count: 8
- Purpose:

### 16. seats
- Grain: a user within an account with activated and/or deactivated date
- Approx row count: 1,556
- Purpose:

### 17. subscription_events
- Grain: a event that records change in subscription (start,changed,converted,cancelled,etc)
- Approx row count: 3,741
- Purpose:

### 18. subscriptions
- Grain: a subscription by user and subscription details
- Approx row count: 2,113
- Purpose:

### 19. support_tickets
- Grain: a ticket opened by users
- Approx row count: 1,249
- Purpose:

### 20. trials
- Grain: 
- Approx row count: 250
- Purpose:

### 21. users
- Grain: a user and their info
- Approx row count: 2,556
- Purpose:


## Section B — Column Dictionary

Row counts: [Row counts](https://github.com/dikshaadsul27-wq/sql-product-analytics/blob/501170d117a298af1cad3c8f9372bb5689905ec4/notes/Row%20counts.md)

## Section C — ER Diagram (Mermaid)

## 🧩 Entity-Relationship Diagram

```mermaid
erDiagram
    ACCOUNTS {
        bigint account_id PK
        text name
        text account_type
        text industry
        integer employee_count
        text country
        timestamp signup_date
        text acquisition_channel
    }

    USERS {
        integer user_id PK
        text email
        text company_name
        timestamp signup_date
        text signup_source
        text plan_type
        integer is_active
        timestamp last_login_date
        bigint account_id FK
        text role
    }

    SUBSCRIPTIONS {
        integer subscription_id PK
        integer user_id FK
        text plan
        timestamp start_date
        timestamp end_date
        numeric mrr
        text status
        timestamp cancelled_at
        text cancellation_reason
        bigint account_id FK
        integer seat_count
        integer plan_id FK
    }

    PLANS {
        integer plan_id PK
        text plan_name
        numeric monthly_price
        integer seat_limit
        text billing_interval
    }

    INVOICES {
        integer invoice_id PK
        integer user_id FK
        integer subscription_id FK
        numeric amount
        text status
        timestamp issued_date
        timestamp paid_date
        timestamp due_date
        bigint account_id FK
    }

    PAYMENT_ATTEMPTS {
        integer attempt_id PK
        integer invoice_id FK
        integer user_id FK
        integer subscription_id FK
        numeric amount
        text status
        text failure_reason
        integer attempt_number
        timestamp attempted_at
        bigint account_id FK
    }

    SEATS {
        bigint seat_id PK
        bigint account_id FK
        integer user_id FK
        timestamp activated_at
        timestamp deactivated_at
    }

    SUPPORT_TICKETS {
        bigint ticket_id PK
        bigint account_id FK
        integer opened_by_user_id FK
        timestamp opened_at
        timestamp closed_at
        text priority
        text category
        integer csat
    }

    TRIALS {
        bigint trial_id PK
        bigint account_id FK
        timestamp started_at
        timestamp ends_at
        timestamp converted_at
        bigint converted_subscription_id FK
    }

    ACCOUNTS ||--o{ USERS : "has"
    ACCOUNTS ||--o{ SUBSCRIPTIONS : "owns"
    ACCOUNTS ||--o{ INVOICES : "billed"
    ACCOUNTS ||--o{ PAYMENT_ATTEMPTS : "attempts"
    ACCOUNTS ||--o{ SEATS : "contains"
    ACCOUNTS ||--o{ SUPPORT_TICKETS : "raises"
    ACCOUNTS ||--o{ TRIALS : "initiates"

    USERS ||--o{ SUBSCRIPTIONS : "subscribes"
    USERS ||--o{ INVOICES : "receives"
    USERS ||--o{ PAYMENT_ATTEMPTS : "makes"
    USERS ||--o{ SEATS : "occupies"
    USERS ||--o{ SUPPORT_TICKETS : "opens"

    SUBSCRIPTIONS ||--o{ INVOICES : "generates"
    SUBSCRIPTIONS ||--o{ PAYMENT_ATTEMPTS : "triggers"
    SUBSCRIPTIONS ||--o{ TRIALS : "converts"
    PLANS ||--o{ SUBSCRIPTIONS : "defines"
```

## Section D — Column dictionary for key tables

## Section E — Data quality and quirks section

## Section F — Six probe questions answered explicitly

## Section G — Sample queries section with the three queries and short interpretations


