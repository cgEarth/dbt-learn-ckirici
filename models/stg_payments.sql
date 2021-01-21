with payments as (

    select id as payment_id,
    orderid as order_id,
    status as payment_status,
    amount::int * 0.01 as amount

from raw.stripe.payment

)

select * from payments