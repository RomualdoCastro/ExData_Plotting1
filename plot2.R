
#Set the correct directory 
# make sure that the household_power_consumption.txt file is in the same location that R file
WD <- getwd()
if (!is.null(WD)) setwd(WD)

#Read the data
require("data.table")
suppressWarnings(data <- fread("household_power_consumption.txt" , sep=";",na.strings="?"))

# Use just two days in 2007-02 and transform the Data, Time etc...
data$DateTime <-   paste(data$Date, data$Time) 
data$Date<-as.Date(data$Date,format="%d/%m/%Y")
dataDays1<-grep("2007-02-01", data$Date,value=FALSE)
dataDays2<-grep("2007-02-02", data$Date,value=FALSE)
df<-data[c(dataDays1,dataDays2),]

# and transform the Data, Time etc...
Sys.setlocale("LC_ALL","C")
library(lubridate)
df$DT<-dmy_hms(df$DateTime)
df$Global_active_power<-as.numeric(df$Global_active_power) 

# Print plot2
plot(df$DT,df$Global_active_power, type="l", xlab="",ylab="Global Active Power(kilowatts)" ,cex.lab=0.7,lty=1)
