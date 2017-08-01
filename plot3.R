# Create a line graph of the three Sub metering columns over time 

library(lubridate)

plot3 <- function() {
        # Read in the data and reduce to just the days 2007-02-01 and 2007-02-02
        data <- read.table("../household_power_consumption.txt", header=TRUE, 
                           sep=";", na.strings="?")
        subset <- data[as.Date(dmy(data$Date)) >= "2007-02-01" 
                    & as.Date(dmy(data$Date)) <= "2007-02-02", ]
        
        # Create the png to save
        png("plot3.png", width=480, height=480)
        
        # Create the plot
        par(mfrow=c(1,1))
        with(subset, plot(strptime(paste(Date,Time), "%d/%m/%Y %H:%M:%S"),
                        na.omit(Sub_metering_1), type="l", col="black",
                        ylim=c(1,max(Sub_metering_1,Sub_metering_2,Sub_metering_3)),
                        xlab="", ylab="Energy sub metering"))
        
        with(subset, lines(strptime(paste(Date,Time), "%d/%m/%Y %H:%M:%S"),
                       na.omit(Sub_metering_2), col="red"))
        
        with(subset, lines(strptime(paste(Date,Time), "%d/%m/%Y %H:%M:%S"),
                       na.omit(Sub_metering_3), col="blue"))
        
        legend("topright", col=c("black","red","blue"), lty=1,
               legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
        
        # Close the device
        dev.off()
}