with orders_without_payments as (

    select
        id,
        user_id as customer_id,
        order_date,
        status

    from raw.jaffle_shop.orders

),

stg_payments as (

    select * from {{ ref('stg_payments') }}

),

orders_with_payments as (

    select  
        order_id,
        customer_id,
        order_date,
        case 
            when payment_status = 'success' then amount
            else 0
        end as amount
    from orders_without_payments
    left join {{ ref('stg_payments') }} on orders_without_payments.id = stg_payments.order_id
)

select * from orders_with_payments
