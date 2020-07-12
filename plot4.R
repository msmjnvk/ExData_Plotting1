# Plot4
library(ggplot2)
library(dplyr)
library(gridExtra)
library(reshape2)

setwd("C:\Users\msmjn\OneDrive\Documents\R\ExData_Plotting1")

powerdata1 <- read.table( "powerdata.txt", sep = " ", header = TRUE, stringsAsFactors = FALSE )

# ----------- Preparing the dataset
# combine the date and time into a new column
powerdata1$my_dates <- paste   ( powerdata1$Date, powerdata1$Time, sep="" )
powerdata1$my_dates <- strptime( powerdata1$my_dates, format = "%Y-%m-%d%H:%M:%S" )

# extract only the needed data and reshape it 
# used for observing Sub_metering_1~3 
powerdata2 <- select( powerdata1, my_dates, Sub_metering_1:Sub_metering_3 )
powerdata3 <- melt  ( powerdata2, id.vars = "my_dates") 

# No idea why all rows after 2880 are converted to NAs have to rep it manually
# the melt function usually works fine with other data types
powerdata3$my_dates <- rep( powerdata3[ 1:nrow(powerdata2), 1 ], 3 )


# ------------------------------------------
# plot the four graphs , observe variables by my_dates
# plot11 = Global_active_power
plot11 <- ggplot( powerdata1, aes( x = my_dates, y = Global_active_power ) ) + geom_line( size = 0.6 , color = "deepskyblue3" ) +   
  scale_x_datetime( labels = c( "Thu", "", "Fri", "", "Sat" ) ) + xlab("") + ylab("Global Active Power") + theme(  
    axis.title = element_text( size = 14 ),
    axis.text  = element_text( size = 12 ))

# plot12 = Voltage
plot12 <- ggplot( powerdata1, aes( x = my_dates, y = Voltage ) ) + geom_line( size = 0.6 , color = "cornflowerblue" ) +   
            scale_x_datetime( labels = c( "Thu", "", "Fri", "", "Sat" ) ) + xlab("datetime") + theme(  
              axis.title = element_text( size = 14 ),
              axis.text  = element_text( size = 12 ))

# plot21 = Sub_metering_1~3
plot21 <- ggplot( powerdata3, aes( x = my_dates, y = value, color = variable ) ) + geom_line( size = 0.6 ) +   
            scale_x_datetime( labels = c( "Thu", "", "Fri", "", "Sat" ) ) + xlab("") + ylab("Energy sub metering") + theme(   
              legend.background = element_rect( fill = "white" ),
              legend.position   = c( 0.65, 0.75 ),
              axis.title   = element_text( size = 14 ),
              axis.text    = element_text( size = 12 ),
              legend.title = element_text( size = 12 ),
              legend.text  = element_text( size = 10 )) + 
                scale_color_manual( values = c( "grey50", "red", "royalblue") )

# plot22 = Global_reactive_power
plot22 <- ggplot( powerdata1, aes( x = my_dates, y = Global_reactive_power ) ) + geom_line( size = 0.6 , color = "springgreen3" ) +   
            scale_x_datetime( labels = c( "Thu", "", "Fri", "", "Sat" ) ) + xlab("datetime") + theme(  
              axis.title = element_text( size = 14 ),
              axis.text  = element_text( size = 12 ))

png("plot4.png")
grid.arrange( plot11, plot12, plot21, plot22, ncol = 2, nrow = 2 )
dev.off()

