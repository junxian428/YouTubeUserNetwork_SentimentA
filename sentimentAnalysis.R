install.packages("RMySQL")
library(RMySQL)
mydb = dbConnect(MySQL(),user="root",password="",dbname="machine", host="localhost")
dbListTables(mydb)
rs = dbSendQuery(mydb, "select * from inventory")
data = fetch(rs, n=10)

data
#1.scatterplot 
plot(data$month,data$product_qty)
#2. correlation
cor(data$month,data$product_qty)
#The Model: Simple Linear Regression
r <- lm(month~product_qty , data=data)
#4. add regression line 
abline(r)
summary(r)
names(r)
r$fitted
fitted(r)
plot(data$month,data$product_qty)
coefficients(r)
coefficients(r)[1]
r$coefficients[1]+r$coefficients[2]*15

predict(r,data.frame(month=c(2,3,5)))

