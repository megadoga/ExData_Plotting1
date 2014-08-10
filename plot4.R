library(data.table)

#Reading file
raw<-as.data.frame(fread("household_power_consumption.txt", sep=";", na.strings = "?", skip = 66600, nrows = 3000))
colnames(raw)<-colnames(raw_header)
date_time<-paste(raw[,1],raw[,2])
date_time<-strptime(date_time,"%d/%m/%Y %H:%M:%S")
raw<-cbind(date_time,raw[,3:9])
#Subsetting
begin_time<-as.POSIXct("2007-02-01 00:00:00")
end_time<-as.POSIXct("2007-02-03 00:00:00")
dataset<-raw[with(raw,date_time>=begin_time & date_time<end_time),]
#Plotting
Sys.setlocale("LC_TIME", "en_US")
png(file="plot4.png",width=480,height=480)
par(mfcol=c(2,2))
#plot 1
plot(dataset[,1],dataset[,2],type="l",ylab="Global Active Power (in kilowatts)",xlab="")
#plot 2
with(dataset,plot(date_time,Sub_metering_1,ylab="Energy sub metering",xlab="",type="n"))
lines(dataset$date_time,dataset$Sub_metering_1,col="black")
lines(dataset$date_time,dataset$Sub_metering_2,col="red")
lines(dataset$date_time,dataset$Sub_metering_3,col="blue")
legend("topright", col = c("black","red","blue"),legend = colnames(dataset[,6:8]),lty=1)
#plot 3
plot(dataset[,1],dataset[,4],type="l",ylab="Voltage",xlab="datetime")
#plot 4
plot(dataset[,1],dataset[,3],type="l",ylab="Global_reactive_power",xlab="datetime")
dev.off()