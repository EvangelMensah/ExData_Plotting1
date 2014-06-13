
## Set working directory
setwd("./Project/Household_project")

#hdata <- read.table ("household_power_consumption.txt", sep= ";", header = TRUE, nrows = 50)

hdata <- read.table ("household_power_consumption.txt", sep= ";", header = TRUE, stringsAsFactors=FALSE)

edit(hdata)

classes <- sapply(hdata, class)    #### Checking the classes of the data

newdata <-  subset(hdata, hdata$Date == "1/2/2007" | hdata$Date == "2/2/2007")   ### Subsetting the required data

newdata <- data.frame(newdata, row.names = NULL)
newdata[, 3]<- as.numeric(newdata[, 3])
newdata[, 4]<- as.numeric(newdata[, 4])
newdata[, 5]<- as.numeric(newdata[, 5])
newdata[, 6]<- as.numeric(newdata[, 6])
newdata[, 7]<- as.numeric(newdata[, 7])
newdata[, 8]<- as.numeric(newdata[, 8])
newdata[, 9]<- as.numeric(newdata[, 9])

write.csv(newdata, "subHousing.csv", row.names = F)    #### Write a new file for easy loading

#### Reading of New Files

hsedata <- read.csv("subHousing.csv", stringsAsFactors=FALSE )

#hsedata[,1] <- gsub("/", "-", hsedata[,1])

#hsedata[,1] <- as.Date(hsedata[,1], format = "%d-%m-%Y", tz = " GMT")



## Plot 1

par(mfrow=c(1,1))
png("plot1.png", width = 480, height = 480)
hist( hsedata[,3], col = "red", main = "Global Active Power", xlab = "Global Active Power (Kilowatts)")
dev.off()

## Plot 2
# convert Date and Time variables to Date,Time classes and concatenate
hsedata$Date <- as.Date(hsedata$Date , "%d/%m/%Y", TZ = " GMT")
hsedata$DateTime <- paste(hsedata$Date, hsedata$Time, sep=" ")
hsedata$DateTime <- strptime(hsedata$DateTime, "%Y-%m-%d %H:%M:%S")

png("plot2.png", width = 480, height = 480)
plot(hsedata$DateTime, hsedata[,3], xlab = "", ylab = "Global Active Power (kilowatts)", type = "l")
dev.off() 

# plot( hsedata[,3], type = "l", main = "", ylab = "Global Active Power (Kilowatts)", xaxt = "n", xlab ="")
# axis(side=1, at=c(0, 1500, 2900), labels=c("Thu", "Fri", "Sat"))


## Plot 3

png("plot3.png", width = 480, height = 480)
ylimits = range(c(hsedata$Sub_metering_1, hsedata$Sub_metering_2, hsedata$Sub_metering_3))
with(hsedata, plot(hsedata$DateTime, hsedata[,7], xlab = "", ylab = "Energy Sub Metering", type = "n"))
plot(hsedata$DateTime, hsedata[,7], xlab = "", ylab = "Energy Sub Metering", type = "l", ylim = ylimits)
par(new = TRUE)
plot(hsedata$DateTime, hsedata[,8], xlab = "", ylab = "Energy Sub Metering", type = "l",ylim = ylimits, col = "red")
par(new = TRUE)
plot(hsedata$DateTime, hsedata[,9], xlab = "", ylab = "Energy Sub Metering", type = "l",ylim = ylimits, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = c(1,1,1),
       col = c("black", "red", "blue"), title.adj = c(0, 0.1))

dev.off()


## Plot 4

png("plot4.png", width = 480, height = 480)

par(mfrow = c(2,2))
plot(hsedata$DateTime, hsedata[,3], xlab = "", ylab = "Global Active Power (kilowatts)", type = "l")

plot(hsedata$DateTime, hsedata[,5], ylab = "Voltage", xlab = "datetime", type = "l")


ylimits = range(c(hsedata$Sub_metering_1, hsedata$Sub_metering_2, hsedata$Sub_metering_3))
with(hsedata, plot(hsedata$DateTime, hsedata[,7], xlab = "", ylab = "Energy Sub Metering", type = "n"))
par(new =T)
plot(hsedata$DateTime, hsedata[,7], xlab = "", ylab = "Energy Sub Metering", type = "l", ylim = ylimits)

par(new = TRUE)
plot(hsedata$DateTime, hsedata[,9], xlab = "", axes = F, ylab = "Energy Sub Metering", type = "l",ylim = ylimits, col = "blue")
par(new = TRUE)
plot(hsedata$DateTime, hsedata[,8], xlab = "", axes = F, ylab = "Energy Sub Metering", type = "l",ylim = ylimits, col = "red")

par(new = T)
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = c(1,1,1), bg = "transparent",
       bty = "n",
       col = c("black", "red", "blue"))


plot(hsedata$DateTime, hsedata[,4], ylab = "Global_reactive_power", xlab = "datetime", type = "l")
dev.off()
