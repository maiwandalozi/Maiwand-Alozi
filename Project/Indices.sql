CREATE INDEX package_quantity ON package(amount);
CREATE INDEX package_type ON package(type);
CREATE INDEX total_price_of_bill ON bill(total_price);
CREATE INDEX status_of_track ON track(status);