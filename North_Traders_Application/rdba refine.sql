create table customers
( 
 customer_id    number,
 company    varchar2(20),
 last_name    varchar2(20),
 first_name   varchar2(20),
 email_address  varchar(60),
 job_title    varchar2(30),
 business_phone varchar2(14),
 home_phone   varchar2(14),
 mobile_phone     varchar2(14),
 fax_number   varchar2(14),
 address    varchar2(50),
 city     varchar2(25),
 state_or_province     varchar2(2),
 zip_or_postal_code    varchar2(5),
 country_or_region   varchar2(3),
 web_page   varchar(60),
 notes    varchar2(80),
 attachment   blob);
 
 create table employee_privileges
 (
  employee_id   varchar2(20),
  privilege_id    varchar2(20));
  
  
create table employees(
  employees_id  number,
  company   varchar2(20),
  last_name   varchar2(20),
  first_name    varchar2(20),
  email_address   varchar(60),
  job_title   varchar2(30),
  business_phone varchar2(14),
  home_phone varchar2(14),
  mobile_phone    varchar2(14),
  fax_phone varchar2(14),
  address    varchar2(50),
  city     varchar2(25),
  state_or_province     varchar2(2),
  zip_or_postal_code    varchar2(5),
  country_or_region   varchar2(3),
  web_page   varchar(60),
  notes    varchar2(80),
  attachment   blob);
  
  create table inventory_transaction_types(
    i_d  number,
    type_name   varchar2(10));
    
 create table inventory_transaction(
  transaction_id    number,
  transaction_type    varchar2(10),
  transaction_created_date  date,
  transaction_modified_date   date,
  product_id    number,
  quantity    number,
  purchase_order_id number,
  customer_order_id   number,
  comments    varchar2(100));