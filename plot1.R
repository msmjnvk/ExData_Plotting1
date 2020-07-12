# Plot 1 Histogram of the count of Global_active_power
# will only be using data in the timeline of 2007-02-01 and 02
library(ggplot2)
library(dplyr)


setwd("C:\Users\msmjn\OneDrive\Documents\R\ExData_Plotting1")

# download and unzip the file
fileurl   <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file( fileurl, destfile = "consumption.zip" )
unzip( "consumption.zip" )

# list the name of the unzipped files
# list.files()                              

# read in the file to R
powerdata <- read.table( "household_power_consumption.txt", sep = ";", header = TRUE, stringsAsFactors = FALSE, na.strings = "?")     

# change the Date column to Date type and subset the dataset 
powerdata$Date <- as.Date( powerdata$Date, format = "%d/%m/%Y" )
powerdata1     <- filter ( powerdata, Date == as.Date("2007-02-01") | Date == as.Date("2007-02-02") ) 

# write out the subsetted data
write.table( powerdata1, "powerdata.txt", row.names = FALSE )

# plot the data
attach(powerdata1)
binsize <- diff( range(Global_active_power) ) 

png("plot1.png")

ggplot( powerdata1, aes( x = Global_active_power ) ) + geom_histogram( color = "black", fill = "lightblue", binwidth = binsize/12  ) + 
  ggtitle( "Global Active Power" ) + xlab( "Global Active Power(kilowatts)" ) + ylab( "Frequency" ) + theme(
    plot.title = element_text( size = 24, face = "bold" ),
    axis.title = element_text( size = 16 ),
    axis.text  = element_text( size = 12 ))

dev.off()

