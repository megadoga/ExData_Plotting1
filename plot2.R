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
png(file="plot2.png",width=480,height=480)
plot(dataset[,1],dataset[,2],type="l",ylab="Global Active Power (in kilowatts)",xlab="")
dev.off()