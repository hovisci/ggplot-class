source( file="scripts/reference.R" ); 
weatherData = read.csv( file="data/LansingNOAA2016-2.csv", 
                        stringsAsFactors = FALSE );


# Create a vector that holds the quantile values for StnPressure.
# 20, 40, 60, and 80th percentile

stnPressureQuant = quantile(weatherData$stnPressure, probs=c(.20, .40, .60, .80)); 

# Create a new column called pressureLevel that creates five evenly spaced levels

for(day in 1:nrow(weatherData))  # nrow(weatherData) = 366
{
  # if the value in stnPressure is less than or equal to the 20th quant value
  if(weatherData$stnPressure[day] <= stnPressureQuant[1])      # <= 28.94
  {
    weatherData$stnPressureLevel[day] = "Very Low";
  }
  # if the value in stnPressure is greater than the 80th quant value
  else if(weatherData$stnPressure[day] >= stnPressureQuant[4]) # >= 29.23
  {
    weatherData$stnPressureLevel[day] = "Very High";
  }
  # the value in stnPressure is between 20th and 40th quant
  else if(weatherData$stnPressure[day] > stnPressureQuant[1] && # > 28.94
          weatherData$stnPressure[day] <= stnPressureQuant[2]) # <= 29.05
  {
    weatherData$stnPressureLevel[day] = "Low";
  }
  # the value in stnPressure is between 40th and 60th quant
  else if(weatherData$stnPressure[day] > stnPressureQuant[2] && # > 29.05
          weatherData$stnPressure[day] <= stnPressureQuant[3]) # <= 29.14
  {
    weatherData$stnPressureLevel[day] = "Medium";
  }
  else # the value in stnPressure is between 60th and 80th quant (29.14,29.23]
  {
    weatherData$stnPressureLevel[day] = "High";
  }
}

# order pressure level from low to high

pressurelvlFact = factor(weatherData$stnPressureLevel,
                     levels=c("Very Low", "Low", "Medium", "High", "Very High"));


# Make a boxplot of windSusSpeed vs pressureLevel

thePlot = ggplot(data=weatherData) +
  geom_boxplot(mapping=aes(x=pressurelvlFact, y=windSusSpeed)) +
  theme_bw() +
  labs(title = "WindSpeed vs. Pressure Level",
       subtitle = "Lansing, Michigan: 2016",
       x = "Wind Speed",
       y = "Pressure Level");
plot(thePlot);


# Find the dates for the three outliers at the lowest pressure level.  
# The three outliers are also the three highest windSusSpeed for the year.

windSpeedOrdered <- order(weatherData$windSusSpeed,decreasing=TRUE) 
outliers <- weatherData$windSusSpeed[windSpeedOrdered[1:3]]
outliersDates <- weatherData$date[windSpeedOrdered[1:3]]


# Label the outliers for the lowest pressure level with the dates on the plot.

thePlot = ggplot(data=weatherData) +
  geom_boxplot(mapping=aes(x=pressurelvlFact, y=windSusSpeed)) +
  theme_bw() +
  annotate(geom="text", x=1.3, y=outliers[1], color="blue",   
           label=outliersDates[1] ) +
  annotate(geom="text", x=0.65, y=outliers[2], color="blue",   
           label=outliersDates[2] ) +
  annotate(geom="text", x=1.3, y=outliers[3], color="blue",   
           label=outliersDates[3] ) +
    labs(title = "WindSpeed vs. Pressure Level",
       subtitle = "Lansing, Michigan: 2016",
       x = "Wind Speed",
       y = "Pressure Level");

plot(thePlot);