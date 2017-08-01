# Create a line graph of "Global Active Power" over time

library(lubridate)

plot2 <- function() {
        # Read in the data and reduce to just the days 2007-02-01 and 2007-02-02
        data <- read.table("../household_power_consumption.txt", header=TRUE, 
                           sep=";", na.strings="?")
        subset <- data[as.Date(dmy(data$Date)) >= "2007-02-01" 
                    & as.Date(dmy(data$Date)) <= "2007-02-02"
                    & !is.na(data$Global_active_power), ]
        
        # Create the png to save
        png("plot2.png", width=480, height=480)
       
        # Create the plot
        par(mfrow=c(1,1))
        with(subset, plot(strptime(paste(Date,Time), "%d/%m/%Y %H:%M:%S"),
                Global_active_power, type="l",
                xlab="", ylab="Global Active Power (kilowatts)"))
        
        # Close the device
        dev.off()
}