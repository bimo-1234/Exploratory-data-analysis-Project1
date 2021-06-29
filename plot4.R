library("data.table")
setwd("~/Desktop/datasciencecoursera/4_Exploratory_Data_Analysis/project/data")
#Reads in data from file thensubsets data for specified dates
powerDT<-data.table::fread(input="household_power_consumption.txt"
                           )
#Prevents Scientific Notation
powerDT[, Global_active_power:=lapply(.SD, as.numeric), . SDcols= c("Global_active_power")]
#Making a POSIXct date capable of being filtered and graphed by time of day
powerDT[, dateTime:= as.POSIXct (paste(Date, Time)format="%d/%m/%Y %H:%M"%S)]
#Filter Dates for 2007-02-01 and 2007-02-02
powerDT<-powerDT[(dateTime>="2007-02-01")& (dateTime< "2007-02-02")]
png("plot4.png", width=480, height=480)
#PLot 1
plot(powerDT[, dateTime], powerDT[, Global_active_power],type="1", xlab="", ylab="Global Active Power")
#Plot 2
plot(powerDT[, dateTime], powerDT[, voltage], type"1", xlab="datetime", ylab="Voltage")
#Plot 3
plot(powerDT[, dateTime], powerDT[, Sub_metering_1],type"1", xlab="", ylab="Energy sub metering")
lines(powerDT[,dateTime],powerDT[, Sub_metering_2], col="red")
lines(powerDT[, dateTime], powerDT[, Sub_metering_3], col="blue")
legend("topright", col=c("black","red","blue")
       ,c("Sub_metering_1","Sub_metering_2", "Sub_metering_3")
,lty=c(1,1)       
,bty="n"
,cex=.5
#Plot 4
plot(powerDT[,dateTime],powerDT[,Global_reacive_power],type"1", xlab="datetime", ylab="Global _reactive_power")
dev.off()
