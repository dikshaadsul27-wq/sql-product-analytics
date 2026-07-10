# saas_schema.md

## Section A — Table Inventory
(Grain, approx row count, purpose for each table) [Inventory](https://github.com/dikshaadsul27-wq/sql-product-analytics/blob/501170d117a298af1cad3c8f9372bb5689905ec4/notes/Inventory.md)

## Section B — Column Dictionary

Row counts:[Row counts](https://github.com/dikshaadsul27-wq/sql-product-analytics/blob/501170d117a298af1cad3c8f9372bb5689905ec4/notes/Row%20counts.md)

## Section C — ER Diagram (Mermaid)

```mermaid
erDiagram
    customers          ||--o{ orders : places
    orders             ||--|{ order_items : contains
    order_items        }o--|| product_variants : ships
    product_variants   }o--|| products : sku_of
    products           }o--|| categories : in
    orders             ||--o{ payment_intents : pays_via
    payment_intents    ||--o{ payment_transactions : attempts
    orders             ||--o{ refunds : may_have
    orders             ||--o{ return_requests : may_return
    return_requests    ||--|{ return_items : with
    orders             ||--o{ shipments : ships
    customers          ||--o{ sessions : starts
    sessions           ||--o{ session_events : logs
    sessions           ||--o{ attribution_touches : has
    attribution_touches }o--o| attribution_campaigns : maps_via_bridge
    attribution_campaigns }o--|| marketing_campaigns : refs
```

## Section D — Column dictionary for key tables

## Section E — Data quality and quirks section

## Section F — Six probe questions answered explicitly

## Section G — Sample queries section with the three queries and short interpretations


