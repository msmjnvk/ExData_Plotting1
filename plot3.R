# Plot 3 Time series plot of the Sub_metering_1~3
library(ggplot2)
library(dplyr)
library(reshape2)

setwd("C:\Users\msmjn\OneDrive\Documents\R\ExData_Plotting1")

powerdata1 <- read.table( "powerdata.txt", sep = " ", header = TRUE, stringsAsFactors = FALSE ) 
options(stringsAsFactors = FALSE)

# combine the date and time into a new column 
powerdata1$my_dates <- paste   ( powerdata1$Date, powerdata1$Time, sep="" )
powerdata1$my_dates <- strptime( powerdata1$my_dates, format = "%Y-%m-%d%H:%M:%S" )

# extract only the needed data and reshape it to be used for ggplot
powerdata2 <- select( powerdata1, my_dates, Sub_metering_1:Sub_metering_3 )
powerdata3 <- melt  ( powerdata2, id.vars = "my_dates") 

# No idea why all rows after 2880 are converted to NAs have to rep it manually
# the melt function usually works fine with other data types
powerdata3$my_dates <- rep( powerdata3[ 1:nrow(powerdata2), 1 ], 3 )

# plot the graph
png("plot3.png")

ggplot( powerdata3, aes( x = my_dates, y = value, color = variable ) ) + geom_line( size = 1 ) +   
  scale_x_datetime( labels = c( "Thu", "", "Fri", "", "Sat" ) ) + xlab("") + ylab("Energy sub metering") + theme(   
    legend.background = element_rect( fill = "white" ),
    legend.position   = c( 0.8, 0.85 ),
    axis.title   = element_text( size = 14 ),
    axis.text    = element_text( size = 12 ),
    legend.title = element_text( size = 14 ),
    legend.text  = element_text( size = 12 )) + 
      scale_color_manual( values = c( "grey50", "red", "royalblue") )

dev.off()
