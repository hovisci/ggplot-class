{
  source(file="scripts/reference.R");  
  weatherData = read.csv(file="data/LansingNOAA2016.csv", 
                         stringsAsFactors = FALSE);
  
  # Putting four number sign at beginning and end of a line adds it to the "outline" 
  #### Part 1: Create a pressure level column ####
  
  # find the 20%, 40%, 60%, and 80% quantile values of "stnPressure" column
  # so, pressureQuant will be a vector with 4 values
  pressureQuant = quantile(weatherData$stnPressure,    
                           probs=c(.20, .40, .60, .80));

  # the variable day will takes on values from 1 to 366
  # the for loop iterates for each value of day (so, 366 iterations)
  for(day in 1:nrow(weatherData))  
  {
    ## Creating a new column, called pressureLevel,
    #  that gives relative pressure for the day (based on the quantile results)
    
    # if the standard pressure of the day is less than or equal to the 0.20 quantile value
    if(weatherData$stnPressure[day] <= pressureQuant[1])
    {
      weatherData$pressureLevel[day] = "Very Low";  # set the pressure to very low
    }
    # if the standard pressure of the day is less than or equal to the 0.40 quantile value
    else if(weatherData$stnPressure[day] <= pressureQuant[2])
    {
      weatherData$pressureLevel[day] = "Low";       # set the pressure to low
    }
    else if(weatherData$stnPressure[day] <= pressureQuant[3])
    {
      weatherData$pressureLevel[day] = "Medium";
    }
    else if(weatherData$stnPressure[day] <= pressureQuant[4])
    {
      weatherData$pressureLevel[day] = "High";
    }
    else  # all other values
    {
      weatherData$pressureLevel[day] = "Very High";
    }
  }
  
  #### Part 2: Boxplot of the wind speed vs pressure level ####
  
  #### For the three outliers...
  # index values for the windSusSpeed column in descending order 
  descendingIndex = order(weatherData$windSusSpeed, decreasing=TRUE);
  threeHigh = descendingIndex[1:3];   # the indices the of three highest values
  # get the three highest wind speeds
  highWindSpeeds = weatherData$windSusSpeed[threeHigh];
  # get the dates for the three highest wind speeds
  highWindDates = weatherData$date[threeHigh];

  # Force the order by level (otherwise, it will be alphabetical)
  pressureFact = factor(weatherData$pressureLevel,
                       levels=c("Very Low", "Low", "Medium", "High", "Very High"));
  
  thePlot = ggplot(data=weatherData) +
    geom_boxplot(mapping=aes(x=pressureFact, y=windSusSpeed),
                 # coef = 2.5,  # multiplier for interquartile range (IQR) to set whiskers -- default is 1.5 
                 outlier.shape = 24, 
                 outlier.fill = "red", 
                 outlier.size = 3) +
    theme_bw() +
    labs(title = "Wind Speeds vs. Pressure Levels",
         subtitle = "Lansing, Michigan: 2016",
         x = "Pressure Level",
         y = "Wind Speeds")  +
    # the three annotate() are for the three outliers
    annotate(geom="text", 
             x=1.3, 
             y=highWindSpeeds[1], 
             color="blue",   
             label=highWindDates[1] ) +
    annotate(geom="text", 
             x=0.7, 
             y=highWindSpeeds[2], 
             color="darkgreen",   
             label=highWindDates[2] ) +
    annotate(geom="text", 
             x=1.3, 
             y=highWindSpeeds[3], 
             color="red",   
             label=highWindDates[3] );
  plot(thePlot);
  
  ##### In-class application #### 
  #  Part 1: Practice with the breakpoints:  
  #    What is the breakpoint doing inside the for loops?
  #      note: you can add/remove breakpoints while debugging (especially useful when in for loops)
  #    Put it two (or more) breakpoints and use Continue
  
  #  Part 2: Humidity vs Precipitation boxplots
  #    Humidity goes on the y-axis
  #    Two boxes on the x-axis: (1) Days that had precip (2) Days that had no precip
  #    Use "weatherType" column to determine precipitation
  #      days with precip have either "RA" or "SN" in the "weatherType" column
  #    Break down the problem -- try to individually get "RA" and "SN" before trying to combine them
 
  ### My solution ###
  
  #  find days with snow and rain

  snow <- grepl(pattern = "SN", x=weatherData$weatherType) 
  rain <- grepl(pattern = "RA", x=weatherData$weatherType)
  
  for (i in 1:nrow(weatherData))
  {
    if(snow[i] == TRUE || rain[i] == TRUE)
    {
      weatherData$rainsnow[i] = "Precip";  
    }
    else  # all other values
    {
      weatherData$rainsnow[i] = "No Precip";
    }
  }
  
  thePlot = ggplot(data=weatherData) +
    geom_boxplot(mapping=aes(x=rainsnow, y=relHum)) +
    theme_bw() +
    labs(title = "Humidity vs. Precip",
         subtitle = "Lansing, Michigan: 2016",
         x = "",
         y = "Relative Humidity");

  plot(thePlot);
  
}  # this bracket was missing in the original code -- 
   # it matches the one at the beginning of the code as the sole purpose of these
   # breckets is to fix a if-else bug in R