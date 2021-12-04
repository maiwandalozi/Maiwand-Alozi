create table customer
(
    id         integer primary key,
    address    varchar(255) NOT NULL ,
    name       varchar(255) NOT NULL ,
    phone      varchar(255) NOT NULL
);
create table company
(
    id             integer primary key,
    name           varchar(255) NOT NULL
);

create table package
(
    id           integer primary key,
    amount    varchar(255) NOT NULL DEFAULT 1,
    type        varchar(255) NOT NULL ,
    name        varchar(255) NOT NULL ,
    cost        integer NOT NULL
);

create table account
(
    id             integer primary key,
    login          varchar(255) NOT NULL ,
    credit_card_id integer NOT NULL ,
    customer_id    integer references customer(id) NOT NULL
);

create table bill
(
    id integer primary key,
    total_price integer
);

create table transport
(
    name    varchar(255) UNIQUE ,
    price_for_delivery integer NOT NULL
);

create table shipment
(
    id                     integer primary key,
    customer_id            integer references customer(id),
    company_id             integer references company(id),
    package_id             integer references package(id),
    bill_id                integer references bill(id),
    transport_name         varchar(255),
    order_date             date,
    delivery_date          date
);

create table track(
    track_id    integer primary key  references shipment(id),
    status      varchar(255) NOT NULL ,
    vehicle     varchar(255) NOT NULL ,
    start_loc   varchar(255) NOT NULL ,
    current_loc   varchar(255) NOT NULL ,
    end_loc       varchar(255) NOT NULL

);

create table history(
    id       integer references track(track_id),
    date     date NOT NULL ,
    location   varchar(255) NOT NULL
);

create table credit_card
(
    id              integer primary key,
    cvv             numeric(3) NOT NULL ,
    expiration_date date NOT NULL ,
    full_name       varchar(255) NOT NULL ,
    bill_id         integer references bill(id) ,
    date            date NOT NULL
);

create table prices
(
    cost  integer NOT NULL ,
    package_type varchar(255) NOT NULL UNIQUE
);

create table hazardous_material
(
    type         varchar(255) NOT NULL ,
    package_id   integer references package

);

create table international_shipment
(
    declaration_id integer primary key
);