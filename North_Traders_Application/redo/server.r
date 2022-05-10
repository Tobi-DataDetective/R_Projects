library(shiny)
library(RODBC)
shinyServer(function(input,output){
  connect<-odbcConnect("northwind",uid = "nwdba",pwd = "nwdba",believeNRows=FALSE)
  datasetinput<- reactive({
    switch(input$table,
           "customers"=sqlQuery(connect,"select customer_id,company,last_name||' '||first_name as name,email_address,job_title,business_phone,home_phone,mobile_phone,fax_number,address,city,state_or_province,zip_or_postal_code,country_or_region,web_page,notes from nwdba.customers"),
           "employees"=sqlQuery(connect,"select employees_id,company,names,email_address,job_title,business_phone,home_phone,mobile_phone,fax_phone,address,city,state_or_province,zip_or_postal_code,country_or_region,web_page,notes from nwdba.employees"),
           "employee privileges"=sqlQuery(connect,"select * from nwdba.employee_privileges"),
           "inventory transactions"=sqlQuery(connect,"select * from nwdba.inventory_transaction"),
           "inventory transaction types"=sqlQuery(connect,"select * from inventory_transaction_types"),
           "invoices"=sqlQuery(connect,"select * from nwdba.invoices"),
           "order details"=sqlQuery(connect,"select * from nwdba.order_details"),
           "order details status"=sqlQuery(connect,"select * from nwdba.order_details_status"),
           "order status"=sqlQuery(connect,"select * from nwdba.order_status"),
           "orders"=sqlQuery(connect,"select * from nwdba.orders"),
           "order tax status"=sqlQuery(connect,"select * from nwdba.orders_tax_status"),
           "post"=sqlQuery(connect,"select * from nwdba.post"),
           "privileges"=sqlQuery(connect,"select * from nwdba.privileges_"),
           "product"=sqlQuery(connect,"select supplier_ids,i_d,product_code,product_name,description,standard_cost,list_price,reorder_level,target_level,quantity_per_unit,discontinued,minimum_reorder_quantity,category_ from nwdba.products"),
           "purchase order details"=sqlQuery(connect,"select * from nwdba.purchase_order_details"),
           "purchase order status"=sqlQuery(connect,"select * from nwdba.purchase_order_status"),
           "purchase orders"=sqlQuery(connect,"select * from nwdba.purchase_orders"),
           "shippers"=sqlQuery(connect,"select i_d, company,last_name||' '||first_name as name,email_address,job_title,business_phone,home_phone,mobile_phone,fax_number,address,city,state_or_province,zip_or_postal_code,country_or_region,web_page,notes from nwdba.shippers"),
           "suppliers"=sqlQuery(connect,"select i_d,company,last_name||' '||first_name as name,email_address,job_title,business_phone,home_phone,mobile_phone,fax_number,address,city,state_or_province,zip_or_postal_code,country_or_region,web_page,notes from nwdba.suppliers"))
    
  })  
  output$table<-renderTable({datasetinput()})
})