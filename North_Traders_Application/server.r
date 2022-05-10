library(shiny)
library(RODBC)
shinyServer(function(input,output){
  connect<-odbcConnect("northwind",uid = "nwdba",pwd = "nwdba",believeNRows=FALSE)
  
  text1<-reactive({input$table})
  text2<-reactive({input$subtable})
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
  
  
  
  datasetinput2<-reactive({
    switch(input$subtable,
           "order.employees"=sqlQuery(connect,"select employee_id from nwdba.orders"),
           "order.company"=sqlQuery(connect,"select customer_id from nwdba.orders"),
           "order.shipping via"=sqlQuery(connect,"select shipper_via from nwdba.orders"),
           "purchase_orders.supplier id"=sqlQuery(connect,"select supplier_id from nwdba.purchase_orders"),
           "purchase orders.created by"=sqlQuery(connect, "select created_by from nwdba.purchase_orders"),
           "order details.product_id"=sqlQuery(connect,"select product_id from nwdba.order_details"),
           "inventory transactions.type"=sqlQuery(connect,"select transaction_type from nwdba.inventory_transaction")
    )
  })
  product<- sqlQuery(connect, "select * from nwdba.products")
  List_price<-product$LIST_PRICE
  Standard_price<-product$STANDARD_COST
  mod1<-lm(List_price~Standard_price)
  mod1_sm<-summary(mod1)
  Target_level<-product$TARGET_LEVEL
  Reorder_level<-product$REORDER_LEVEL
  mod2<-lm(Target_level~Reorder_level)
  mod2_sm<-summary(mod2)
  
  datasetinput3<- reactive({
    switch(input$reg,
           "reorder level vs target level"=mod1_sm,
           "standard cost vs list price"= mod2_sm
    )
  })
  
  filetype2<-reactive({
    switch(input$downloaddata,
           "Excel (CSV)"="csv",
           "Text (TSV)"="txt",
           "Text (Space separated)"="txt",
           "DOC"="doc")
  })
  
  output$downloaddata<-downloadHandler(
    filename = function(){
      paste(input$table,filetype2(),sep = ".")
    },
    content = function(file2){
      sep<- switch(
        input$filetype2,
        "Excel (CSV)"=",",
        "Text (TSV)"="\t",
        "Text (Space separated)"=" ",
        "DOC"=" "
      )
      write.table(datasetinput(),file2,sep = sep, row.names = FALSE)
    }
  )
  output$x <- renderText(input$x)
  
  output$reg<-renderPrint({
    datasetinput3()
  })
  output$sin<-renderPrint({
    count3<- coefficients(datasetinput3())
    paste("Y=",count3[1,1],"+",count3[2,1],"X")
  })
  
  
  output$table <- renderTable({
    datasetinput()
  })
  output$text1<- renderText({
    paste("THE TABLE DISPLAYED IS FOR ",text1())
  })
  output$text4<-renderText({
    paste("THE DIAGRAMS BELOW ARE USED TO CHECK THE LINEARITY BETWEEN STANDARD COST AND THE LIST PRICE BASED 
          ON THE LINEAR REGRESSION ASSUMPTIONS")
  })
  output$text5<- renderText({
    paste("THE DIAGRAMS BELOW ARE USED TO CHECK THE LINEARITY BETWEEN REORDER LEVEL AND THE TARGET LEVEL BASED 
          ON THE LINEAR REGRESSION ASSUMPTIONS")
  })
  
  output$text2<-renderText({
    paste("THE BAR PLOT OF",text2())})
  output$text3<-renderText({ 
    paste("TIHS IS THE SUMMARY OF",text2())
  })
  output$subtable<-renderTable({
    datasetinput2()
  })
  
  output$plot<- renderPlot({
    count<-table(datasetinput2())
    barplot(count,main = text2(),ylab = "frequency",las=2)#try and rotate the label
  })
  output$plot2<-renderPlot({
    product<- sqlQuery(connect, "select * from nwdba.products")
    y<-product$LIST_PRICE
    x<-product$STANDARD_COST
    mod1<-lm(y~x)
    plot(x,y,main = "SCATTERPLOT FOR STANDARD COST VS LIST COST", xlab = "standard cost", ylab = "list price")
    abline(mod1)
  })
  output$plot3<-renderPlot({
    product<- sqlQuery(connect, "select * from nwdba.products")
    y<-product$LIST_PRICE
    x<-product$STANDARD_COST
    plot(x,y)
    abline(mod1)
    par(mfrow=c(2,2))
    plot(mod1)
  })
  output$plot4<-renderPlot({
    product<- sqlQuery(connect, "select * from nwdba.products")
    m<-product$TARGET_LEVEL
    n<-product$REORDER_LEVEL
    mod2<-lm(m~n)
    plot(n,m,main = "SCATTERED PLOTS FOR REORDER LEVEL VS TARGET LEVEL", xlab = "reorder level", ylab = "target level")
    abline(mod2)
  })
  output$plot5<-renderPlot({
    m<-product$TARGET_LEVEL
    n<-product$REORDER_LEVEL
    plot(n,m)
    abline(mod2)
    par(mfrow=c(2,2))
    plot(mod2)
  })
  output$structure<- renderPrint({
    count2<-summary(datasetinput2())
    count2
  })
  output$down1<- downloadHandler(
    filename = function(){
      paste("",input$filetype,sep = ".")  
    },
    content = function(file){
      if(input$filetype == "png")
        png(file)
      else
        pdf(file)
      count<-table(datasetinput2())
      barplot(count,main = text2(),ylab = "frequency",las=2)#try and rotate the label
      dev.off()
    }
  )
  output$down2<- downloadHandler(
    filename = function(){
      paste("", input$filetype, sep = ".")
    },
    content = function(file){
      if(input$filetype== "png")
        png(file)
      else
        pdf(file)
      product<- sqlQuery(connect, "select * from nwdba.products")
      y<-product$LIST_PRICE
      x<-product$STANDARD_COST
      mod1<-lm(y~x)
      plot(x,y,main = "SCATTERPLOT FOR STANDARD COST VS LIST COST", xlab = "standard cost", ylab = "list price")
      abline(mod1)
      dev.off()
      
    }
  )
  output$down3<- downloadHandler(
    filename = function(){
      paste("", input$filetype, sep = ".")
    },
    content = function(file){
      if(input$filetype=="png")
        png(file)
      else
        pdf(file)
      product<- sqlQuery(connect, "select * from nwdba.products")
      y<-product$LIST_PRICE
      x<-product$STANDARD_COST
      plot(x,y)
      abline(mod1)
      par(mfrow=c(2,2))
      plot(mod1)
      dev.off()
    }
  )
  output$down4<- downloadHandler(
    filename = function(){
      paste("", input$filetype, sep = ".")
    },
    content = function(file){
      if(input$filetype=="png")
        png(file)
      else
        pdf(file)
      product<- sqlQuery(connect, "select * from nwdba.products")
      m<-product$TARGET_LEVEL
      n<-product$REORDER_LEVEL
      mod2<-lm(m~n)
      plot(n,m,main = "SCATTERED PLOTS FOR REORDER LEVEL VS TARGET LEVEL", xlab = "reorder level", ylab = "target level")
      abline(mod2)
      dev.off()
    })
  output$down5<- downloadHandler(
    filename = function(){
      paste("", input$filetype, sep = ".")
    },
    content = function(file){
      if(input$filetype=="png")
        png(file)
      else
        pdf(file)
      product<- sqlQuery(connect, "select * from nwdba.products")
      m<-product$TARGET_LEVEL
      n<-product$REORDER_LEVEL
      plot(n,m)
      abline(mod2)
      par(mfrow=c(2,2))
      plot(mod2)
      dev.off()
    })
  
  })