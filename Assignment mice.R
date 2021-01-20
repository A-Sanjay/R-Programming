install.packages('mice')
library(mice)
airqualitydata<-read.csv("C:/Users/sanja/airquality.csv")
View(airqualitydata)

#1.summarise and converting a particular column as factor
summary(airqualitydata)
airqualitydata$Solar.R=as.factor(airqualitydata$Solar.R)
summary(airqualitydata)


#2.Cleaning the data:
airqualitydata$Ozone[which(is.na(airqualitydata$Ozone))] = mean(airqualitydata$Ozone,na.rm=TRUE)
View(airqualitydata)

#3.Finding missing data in the rows and columns :
datamiss <- function(x){sum(is.na(x))/length(x)*100}
apply(airquality,2,datamiss) #2 is for column 
apply(airquality,1,datamiss)  #1 is for row

#4.Finding the pattern 
md.pattern(airquality)

#5.Visual presentation of the missing data 
install.packages("VIM")
library(VIM)
aggr_plot <- aggr(airquality, col=c('navyblue','red'), numbers=TRUE, sortVars=TRUE, labels=names(airquality), cex.axis=.7, gap=3, ylab=c("Histogram of missing data","Pattern"))

#6.Imputing the missing data:
tempData <- mice(airquality,m=5,maxit=50,meth='pmm',seed=500)
summary(tempData)

#7.Regression 
#methods(mice)
#regairquality = airquality
#regairquality$Ozone=as.factor(regairquality$Ozone)
#my_imp = mice(airqualitydata,m=5,method=c(" ","pmm","logreg","pmm","pmm","pmm"),maxit=20)
#summary(regairquality$Wind) 
#my_imp$imp$bmi
#final_clean = complete(my_imp,5)
#View(final_clean)

#8.Imputing the data:
imputeairquality = airquality
tempData <- mice(imputeairquality,m=5,maxit=50,meth='pmm',seed=500)
summary(tempData)
tempData$imp$Ozone

#9.Finding imputed method:
tempData$meth

#10.complete
completedData <- complete(tempData,1)
View(completedData)

#11.Plotting Ozone against all other variables:
xyplot(tempData,Ozone ~ Wind+Temp+Solar.R,pch=18,cex=1)

#12.DensityPlot:
densityplot(tempData)
