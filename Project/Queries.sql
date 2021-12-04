-1 query. **Assume truck 1721 is destroyed in a crash. Find all customers who had a package on that truck at the time of the crash.
-- Find all recipients who had a package on that truck at the time of the crash.
-- Find the last successful delivery by that truck prior to the crash.

select customer.id, customer.name
from customer inner join shipment on customer.id = shipment.customer_id
where shipment.id in (
    select track_id
    from track
    where vehicle = 'Rail' and status = 'on the way'
    );

select track_id, start_loc, end_loc, vehicle
from track
where vehicle = 'Truck' and status = 'delivered';

--2 query. **Find the customer who has shipped the most packages in the past year.**
SELECT customer.name
FROM customer
WHERE customer.id in (
    select customer_id
    from shipment inner join package on shipment.package_id = package.id
    WHERE package.amount = (
        select max(amount)
        from package
        )
);

--3 query. **Find the customer who has spent the most money on shipping in the past year.**
SELECT customer.name
FROM customer
WHERE customer.id in (
    SELECT customer_id
    FROM shipment, bill
    WHERE shipment.bill_id  = bill_id and bill.total_price = (
        select max(bill.total_price)
        from bill
        ) and shipment.order_date in (
            select order_date
            from shipment
            where extract(year from order_date) = 2020
        )
    );

--4 query. **Find the street with the most customers.**
SELECT address, number
FROM (
     SELECT address, count(address) as number
     FROM customer
    GROUP BY address
         ) sub
       WHERE number in (
           SELECT max(count)
           from (
                SELECT address, count(address)
                FROM customer
                GROUP BY address
                    ) sub
           );

--5 query. **Find those packages that were not delivered within the promised time**
select package.id, package.name
from package
where package.id in (
    select shipment.package_id
    from shipment,history
    where  shipment.id = history.id and shipment.delivery_date < history.date
    );

--6 query. **Generate the bill for each customer for the past month. Consider creating several types of bills.
select shipment.bill_id, package.amount * package.cost  as tot_sum, transport.price_for_delivery as tot_veh_sum,
       prices.cost as tot_type_sum, bill.total_price as tot_bill_sum
from shipment, package, bill, transport, prices
where shipment.package_id = package_id and shipment.delivery_date = transport.name and package.type = prices.package_type
and bill.id = shipment.bill_id