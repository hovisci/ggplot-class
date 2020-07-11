source(file="scripts/reference.R")
weatherData = read.csv(file="data/LansingNOAA2016.csv", 
                       stringsAsFactors = FALSE);

### Add date column with year ####

theDate = weatherData$date;      # get all values from the dates column

theDate = paste(theDate, "-2016", sep="");

theDate = as.Date(theDate, format="%m-%d-%Y");

weatherData$dateYr = theDate;

### Convert temperature columns from F to C ###

FtoC <- function(data) {
  Celcius <- (5/9)*(data - 32)
  return(Celcius)
}

weatherData$maxTempC <- FtoC(weatherData$maxTemp)
weatherData$minTempC <- FtoC(weatherData$minTemp)
weatherData$avgTempC <- FtoC(weatherData$avgTemp)

### Make a plot

myPlot = ggplot(data=weatherData) +
  geom_line(mapping=aes(x=dateYr, y=maxTempC),
            color="palevioletred1") +
  geom_line(mapping=aes(x=dateYr, y=minTempC),
            color="aquamarine2") +
  geom_smooth(mapping=aes(x=dateYr, y=avgTempC), 
              color="black", 
              method="loess", 
              linetype=4, 
              fill="gray") +
  labs(title = "Temperature vs. Date",
       subtitle = "Lansing, Michigan: 2016",
       x = "Date",
       y = "Temperature (C)") +
  theme(plot.title = element_text(hjust = 1.0),
        plot.subtitle = element_text(hjust = 1.0),
        axis.text.x = element_text(color="blue", family="mono", size=9),
        axis.text.y = element_text(color="red", family="mono", size=9)) +
  scale_y_continuous(limits = c(min(weatherData$minTempC),max(weatherData$maxTempC)),
                     breaks = seq(from=-10, to=35, by=15))  +
  scale_x_date(limits=c(as.Date("2016-03-21"), as.Date("2016-9-21")),
               date_breaks = "8 weeks", 
               date_labels = format("%b-%d-%Y"));
  
plot(myPlot);
