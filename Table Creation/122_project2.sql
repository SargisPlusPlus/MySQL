create schema project2_3; 
use project2_3; 



CREATE TABLE User(
driver_id INTEGER NOT NULL,
name VARCHAR(40),
email VARCHAR(40),
date_of_birth DATE,
PRIMARY KEY (driver_id)
);

CREATE TABLE CarCatalog(
car_catalog_id INTEGER NOT NULL,
category VARCHAR(40),
make VARCHAR(40),
model VARCHAR(40),
year INTEGER,
color VARCHAR(40),
PRIMARY KEY (car_catalog_id)
);

CREATE TABLE AccidentReport(
accident_id INTEGER NOT NULL,
datetime DATE,
severity INTEGER,
details VARCHAR(100),
PRIMARY KEY (accident_id)
);

CREATE TABLE Offer(
offer_id INTEGER NOT NULL,
offer_user_id INTEGER NOT NULL,
offer_datetime DATE,
lender_accept_datetime DATE,
borrower_accept_datetime DATE,
PRIMARY KEY (offer_id), 
FOREIGN KEY (offer_user_id) REFERENCES User(driver_id)
);

CREATE TABLE Deal(
deal_offer_id INTEGER NOT NULL,
lender_fee REAL,
borrower_fee REAL,
lender_rating FLOAT,
borrower_rating FLOAT,
PRIMARY KEY (deal_offer_id),
FOREIGN KEY (deal_offer_id) REFERENCES Offer(offer_id) ON DELETE CASCADE
);

CREATE TABLE Post(
post_id INTEGER NOT NULL,
posted_user_id INTEGER NOT NULL,
pickup_datetime DATE,
return_datetime DATE,
pickup_location VARCHAR(50),
return_location VARCHAR(40),
PRIMARY KEY (post_id),
FOREIGN KEY (posted_user_id) REFERENCES User(driver_id)
);

CREATE TABLE BorrowPost(
borrow_post_id INTEGER NOT NULL,
daily_price_min REAL,
daily_price_max REAL,
car_mileage_min REAL,
car_mileage_max REAL,
car_category VARCHAR(50),
PRIMARY KEY (borrow_post_id),
FOREIGN KEY (borrow_post_id) REFERENCES Post(post_id) ON DELETE CASCADE
);

CREATE TABLE Lender(
lender_user_id INTEGER NOT NULL,
lend_count INTEGER NOT NULL,
rating FLOAT,
PRIMARY KEY (lender_user_id),
FOREIGN KEY (lender_user_id) REFERENCES User(driver_id) ON DELETE CASCADE
);

CREATE TABLE Car(
car_id INTEGER NOT NULL,
lender_id INTEGER NOT NULL,
car_catalog_id INTEGER NOT NULL,
PRIMARY KEY (car_id),
FOREIGN KEY (lender_id) REFERENCES Lender(lender_user_id) ON DELETE CASCADE, 
FOREIGN KEY (car_catalog_id) REFERENCES CarCatalog(car_catalog_id) 
);


CREATE TABLE LendPost(
lender_post_id INTEGER NOT NULL,
car_id INTEGER NOT NULL,
daily_price REAL,
car_mileage REAL,
PRIMARY KEY (lender_post_id),
FOREIGN KEY (lender_post_id) REFERENCES Post(post_id) ON DELETE CASCADE,
FOREIGN KEY (car_id) REFERENCES Car(car_id)
);

CREATE TABLE Borrower(
borrower_user_id INTEGER NOT NULL,
borrow_count INTEGER,
rating FLOAT,
PRIMARY KEY (borrower_user_id),
FOREIGN KEY (borrower_user_id) REFERENCES User(driver_id) ON DELETE CASCADE
);

CREATE TABLE Involves(
involved_offer_id INTEGER NOT NULL,
lender_post_id INTEGER NOT NULL,
borrower_post_id INTEGER NOT NULL,
PRIMARY KEY (lender_post_id,borrower_post_id),
FOREIGN KEY (involved_offer_id) REFERENCES Offer(offer_id),
FOREIGN KEY (lender_post_id) REFERENCES Lender(lender_user_id) ON DELETE CASCADE,
FOREIGN KEY (borrower_post_id) REFERENCES Borrower(borrower_user_id) ON DELETE CASCADE
);

CREATE TABLE Involves2(
accident_id INTEGER NOT NULL,
driver_id INTEGER NOT NULL,
car_id INTEGER NOT NULL,
PRIMARY KEY (driver_id,car_id),
FOREIGN KEY (accident_id) REFERENCES AccidentReport(accident_id),
FOREIGN KEY (driver_id) REFERENCES User(driver_id) ON DELETE CASCADE,
FOREIGN KEY (car_id) REFERENCES Car(car_id) ON DELETE CASCADE
);


use information_schema; 
select * from tables where table_schema = 'project2_3'; 
select * from columns where table_schema = 'project2_3';





