

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

# Print plot3
df$Sub_metering_1<-as.numeric(df$Sub_metering_1)
df$Sub_metering_2<-as.numeric(df$Sub_metering_2)
df$Sub_metering_3<-as.numeric(df$Sub_metering_3)
plot(df$DT,df$Sub_metering_1, type="l" ,lty=1, xlab="",ylab="Energy Sub meetering" ,cex.lab=0.7)
lines(df$DT,df$Sub_metering_2, type="l",lty=1, col=2) 
lines(df$DT,df$Sub_metering_3, type="l",lty=1, lwd=0.01,col=4) 
legend("topright", c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"),cex=0.3, col=c(1,2,4),lty=1)
