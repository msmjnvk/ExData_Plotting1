# Plot 2 Time series plot of the Global_active_power
library(ggplot2)
library(dplyr)

setwd("C:\Users\msmjn\OneDrive\Documents\R\ExData_Plotting1")

powerdata1 <- read.table( "powerdata.txt", sep = " ", header = TRUE, stringsAsFactors = FALSE )  

# combine the date and time column from the original dataset
# strptime reference : http://stat.ethz.ch/R-manual/R-devel/library/base/html/strptime.html
powerdata1$my_dates <- paste   ( powerdata1$Date, powerdata1$Time, sep="" )
powerdata1$my_dates <- strptime( powerdata1$my_dates, format = "%Y-%m-%d%H:%M:%S" )

# labels = date_format("%A") gives the weekday 
# scale_x_datetime works with POSIXct 
# scale_x_date works with Date 
png("plot2.png")

ggplot( powerdata1, aes( x = my_dates, y = Global_active_power ) ) + geom_line( size = 1 , color = "deepskyblue3" ) +   
  scale_x_datetime( labels = c( "Thu", "", "Fri", "", "Sat" ) ) + xlab("") + ylab("Global Active Power(kilowatts)") + theme(  
    axis.title = element_text( size = 14 ),
    axis.text  = element_text( size = 12 ))

dev.off()

