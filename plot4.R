## Set working directory
setwd(".../Household_project")


hdata <- read.table ("household_power_consumption.txt", sep= ";", header = TRUE, stringsAsFactors=FALSE)



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
