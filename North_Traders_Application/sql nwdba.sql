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
 alter table customers modify company    varchar2(20) constraint comp_pk primary key;
 alter table customers modify customer_id number constraint cus_id_uk unique;
 
 
 create table employee_privileges
 (
  employee_id   varchar2(20),
  privilege_id    varchar2(20));
  alter table employee_privileges modify employee_id varchar2(20) constraint emp_id_pk primary key;
  alter table employee_privileges modify employee_id varchar2(20) constraint emp_priv_fk references employees(names);
  alter table employee_privileges modify privilege_id varchar2(20) constraint priv_id_fk references privileges_(privilege_name);

drop table employees;  
create table employees(
  employees_id  number,
  company   varchar2(20),
  names   varchar2(20),
  email_address   varchar(60),
  job_title   varchar2(30),
  business_phone varchar2(14),
  home_phone varchar2(14),
  mobile_phone    varchar2(14),
  fax_phone varchar2(14),
  address    varchar2(60),
  city     varchar2(25),
  state_or_province     varchar2(2),
  zip_or_postal_code    varchar2(5),
  country_or_region   varchar2(3),
  web_page   varchar(60),
  notes    varchar2(150),
  attachment   blob);
  
  alter table employees modify employees_id number constraint emp_id  unique;
  alter table employees modify names varchar2(20) constraint  names_pk primary key;
  
  create table inventory_transaction_types(
    i_d  number,
    type_name   varchar2(10));
 alter table inventory_transaction_types modify type_name varchar2(10) constraint itt_pk primary key;
    
 CREATE Table inventory_transaction(
  transaction_id    number,
  transaction_type    varchar2(10),
  transaction_created_date  date,
  transaction_modified_date   date,
  product_id    VARCHar2(35),
  quantity    number,
  purchase_order_id number,
  customer_order_id   number,
  comments    varchar2(100));
  alter table inventory_transaction modify transaction_type    varchar2(10) constraint trans_typ_fk references inventory_transaction_types(type_name);
  
  alter table inventory_transaction modify purchase_order_id   number constraint pur_ord_fk references purchase_orders(purchase_order_id);
  
  alter table inventory_transaction modify  customer_order_id    number constraint cus_ord_id_fk references customers( customer_id);



alter table inventory_transaction modify transaction_id number  constraint inv_trans_pk primary key;  
  
create table invoices
(
  invoice_id    number,
  order_id    number,
  invoice_date    date,
  due_date    date,
  tax   number,
  shipping    number,
  amount_due    number);
  alter table invoices modify order_id    number constraint ord_ord_id_fk references orders(order_id);
  alter table invoices  modify  invoice_id  number  constraint inv_id_pk    unique;

create table order_details(
  i_d   number,
  order_id    number,
  product_id    varchar2(35),
  quantity    number,
  unit_price    number,
  discount    number,
  status_id   varchar2(15),
  date_allocated    date,
  purchase_order_id   number,
  inventory_id    number);
  alter table order_details modify order_id    number constraint ord_id_fk references orders(order_id);
   alter table order_details modify order_id    number constraint ord_id_fk references orders(order_id);
  alter table order_details modify status_id  varchar2(15) constraint sta_id_fk references order_details_status(status_name);
  alter table order_details modify  purchase_order_id   number constraint pur_ord_id references purchase_orders(purchase_order_id);
  alter table order_details modify  inventory_id   number constraint inven_id_fk references inventory_transaction(transaction_id);
  
create table order_details_status(
  status_id   number,
  status_name   varchar2(10));

alter table order_details_status modify status_name varchar2(10) constraint stat_name_pk primary key;

create table orders(
  order_id    number,
  employee_id varchar2(25),
  customer_id   varchar2(20),
  order_date  date,
  shipping_date   date,
  shipper_via    varchar2(30),
  ship_name   varchar2(30),
  ship_address    varchar2(60),
  ship_city     varchar2(25),
  ship_state_or_province     varchar2(2),
  ship_zip_or_postal_code    varchar2(5),
  ship_country_or_region   varchar2(3),
  shipping_free number,
  tax   number,
  payment_type  varchar2(15),
  paid_date   date,
  notes    varchar2(80),
  tax_rate    number,
  tax_status  number,
  status_id   varchar2(15));

alter table orders modify employee_id  varchar2(20) constraint emp_id_fk references employees(names);
alter table orders modify customer_id   varchar2(20) constraint cus_id_fk references customers(company);
alter table orders modify  shipper_via varchar2(20) constraint ship_fk references shippers(company);
alter table orders modify status_id   varchar2(15) constraint stat_fk references order_status(status_name);

alter table  orders modify order_id number constraint order_id_pk primary key;


create table order_status(
  status_id   number,
  status_name   varchar2(15));
  
  alter table order_status modify status_name varchar2(15) constraint sta_nm_pk primary key;
  
create table orders_tax_status(
  i_d   number,
  tax_status_name   varchar2(20));
  
  alter table orders_tax_status modify tax_status_name varchar2(20) constraint tsn_pk primary key;
  
create table privileges_(
  privilege_id    number,
  privilege_name    varchar2(20));
 
 alter table privileges_ modify privilege_name varchar2(20) constraint priv_name_pk primary key; 

create table products(
  supplier_ids  varchar2(15),
  i_d   number,
  product_code  varchar2(30),
  product_name    varchar2(50),
  description   varchar2(50),
  standard_cost   number,
  list_price    number,
  reorder_level   number,
  target_level    number,
  quantity_per_unit   varchar2(30),
  discontinued    varchar2(5),
  minimum_reorder_quantity    number,
  category_   varchar2(60),
  attachment    blob);
  
  alter table products modify product_name varchar2(50) constraint prod_name_pk primary key;
  
create table purchase_order_details(
  i_d number,
  purchase_order_id   number,
  product_id    varchar2(40),
  quantity    number,
  unit_cost   number,
  date_recieved date,
  posted_to_inventory   varchar2(5),
  inventory_id    number);
 
 alter table purchase_order_details modify i_d number constraint i_d_pk primary key;
  
create table purchase_order_status(
  status_id   number,
  status    varchar2(10));
  alter table purchase_order_status modify status varchar2(10) constraint status_pk primary key;
  
create table purchase_orders(
  purchase_order_id   number,
  supplier_id   varchar2(15),
  created_by    varchar2(25),
  submitted_date    date,
  created_date    date,
  status_id   varchar2(15),
  expected_date   date,
  shipping_fee  number,
  taxes   number,
  payment_date date,
  payment_amount  number,
  payment_method    varchar2(15),
  note   varchar2(60),
  approved_by   varchar2(20),
  approved_date date,
  submitted_by  varchar2(25));
 alter table purchase_orders modify supplier_id varchar2(20) constraint  sup_id_fk references suppliers(company); 
 alter table purchase_orders modify  created_by   varchar2(20) constraint  cre_by_fk references employees(names);
 alter table purchase_orders modify status_id    varchar2(10) constraint stat_id_fk references purchase_order_status(status);
 alter table purchase_orders modify approved_by  varchar2(20) constraint app_by_fk  references  employee_privileges(employee_id);
 alter table purchase_orders modify submitted_by  varchar2(20) constraint sub_by_fk  references employees(names);  
  alter table purchase_orders modify purchase_order_id number constraint pur_ord_id_pk primary key;

  
create table shippers(
  i_d   number,
  company varchar2(20),
  last_name   varchar2(20),
  first_name    varchar2(20),
  email_address varchar(60),
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
 
 alter table shippers modify company    varchar2(20) varchar2(20) constraint company_pk primary key;
  
  
  create table suppliers
( 
 i_d    number,
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
 
 alter table suppliers modify company varchar2(20) constraint cmpny_pk primary key;