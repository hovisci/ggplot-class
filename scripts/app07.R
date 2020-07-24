source(file="scripts/reference.R");  
weatherData = read.csv(file="data/LansingNOAA2016-3.csv");

{
# Create a vector that holds the quantile values for the 30th and 70th 
# percentile of relHumidity.

  relHumQuant = quantile(weatherData$relHum, probs=c(.30, .70)); 


# Using the quantile values, create a new column called humidityLevel that creates
# three levels for relHumidity
  

  
  for(day in 1:nrow(weatherData))  # nrow(weatherData) = 366
  {
    # if the value in relHum is less than or equal to the 30th quant value
    if(weatherData$relHum[day] <= relHumQuant[1]) # <= 63
    {
      weatherData$relHumLvl[day] = "Low";
    }
    # the value in relHum is greater than the 70th quant
    else if(weatherData$relHum[day] >= relHumQuant[2]) # >= 75
    {
      weatherData$relHumLvl[day] = "High";
    }
    else # the value in relHum is between 30th and 70th quant (63,75)
    {
      weatherData$relHumLvl[day] = "Medium";
    }
  }
  
# Create a boxplot of stnPressure vs humidityLevel
# Put humidityLevel in order of increasing humidity
  
  
  relHumLvlFact = factor(weatherData$relHumLvl,
                         levels=c("Low", "Medium", "High"));
  
  thePlot = ggplot(data=weatherData) +
    geom_boxplot(mapping=aes(x=relHumLvlFact, y=stnPressure)) +
    theme_bw() +
    labs(title = "Humidity Level vs. Pressure",
         subtitle = "Lansing, Michigan: 2016",
         x = "Humidity Level",
         y = "Pressure");
  plot(thePlot);
  
# Add windDir as a fill to the boxplot
# Change order of windDir to North - East - South - West

  windDirFact = factor(weatherData$windDir,
                         levels=c("North", "East", "South", "West"));
  
    
  thePlot = ggplot(data=weatherData) +
    geom_boxplot(mapping=aes(x=relHumLvlFact, y=stnPressure, fill=windDirFact)) +
    theme_bw() +
    labs(title = "Humidity Level vs. Pressure",
         subtitle = "Lansing, Michigan: 2016",
         x = "Humidity Level",
         y = "Pressure");
  plot(thePlot);
  
# Add a horizontal facet (along the x-axis) using windSpeedLevel
 
  windLabels = c(Low = "Light Winds",
                 Medium = "Medium Winds",
                 High = "Strong Winds");
  
  thePlot = ggplot(data=weatherData) +
    geom_boxplot(mapping=aes(x=relHumLvlFact, y=stnPressure, fill=windDirFact)) +
    theme_bw() +
    facet_grid(facets = .~factor(windSpeedLevel,
                               levels=c("Low", "Medium", "High")),
               labeller=as_labeller(windLabels)) +
    labs(title = "Humidity Level vs. Pressure",
         subtitle = "Lansing, Michigan: 2016",
         x = "Humidity Level",
         y = "Pressure",
         fill = "Wind Direction");
  plot(thePlot);
  
}  
  
  
  