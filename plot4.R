# Create the four line graphs of "Global Active Power", "Voltage",
# "Enery sub metering", and "Global_reactive_power" over time

library(lubridate)

plot4 <- function() {
        # Read in the data and reduce to just the days 2007-02-01 and 2007-02-02
        data <- read.table("../household_power_consumption.txt", header=TRUE, 
                           sep=";", na.strings="?")
        subset <- data[as.Date(dmy(data$Date)) >= "2007-02-01" 
                    & as.Date(dmy(data$Date)) <= "2007-02-02", ]
        
        # Create the png to save
        png("plot4.png", width=480, height=480)
        
        # Create the first plot
        par(mfrow=c(2,2))
        with(subset, plot(strptime(paste(Date,Time), "%d/%m/%Y %H:%M:%S"),
                       na.omit(Global_active_power), type="l",
                       xlab="", ylab="Global Active Power"))
        
        # Create the second plot
        with(subset, plot(strptime(paste(Date,Time), "%d/%m/%Y %H:%M:%S"),
                       na.omit(Voltage), type="l",
                       xlab="datetime", ylab="Voltage"))
        
        # Create the third plot
        with(subset, {
                plot(strptime(paste(Date,Time), "%d/%m/%Y %H:%M:%S"),
                          na.omit(Sub_metering_1), type="l", col="black",
                          ylim=c(1,max(Sub_metering_1,Sub_metering_2,Sub_metering_3)),
                          xlab="", ylab="Energy sub metering")
        
                lines(strptime(paste(Date,Time), "%d/%m/%Y %H:%M:%S"),
                          na.omit(Sub_metering_2), col="red")
        
                lines(strptime(paste(Date,Time), "%d/%m/%Y %H:%M:%S"),
                          na.omit(Sub_metering_3), col="blue")
       
                legend("topright", col=c("black","red","blue"), lty=1,
                        legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
                        bty="n")
        })
        
        # Create the fourth plot
        with(subset, plot(strptime(paste(Date,Time), "%d/%m/%Y %H:%M:%S"),
                          na.omit(Global_reactive_power), type="l",
                          xlab="datetime", ylab="Global_reactive_power"))
        
        # Close the device
        dev.off()
}