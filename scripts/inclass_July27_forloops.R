
#### For loops and state variables ####

{
  source(file="scripts/reference.R");  
  weatherData = read.csv(file="data/LansingNOAA2016-3.csv", 
                         stringsAsFactors = FALSE);
 
  ### Replace "T" in precip column with 0.005 using gsub()
  weatherData$precip2 = gsub(x=weatherData$precip, 
                             pattern="T", 
                             replacement="0.005");
  
  ### Probably want the column to be numeric...
  weatherData$precip3 = as.numeric(gsub(x=weatherData$precip, 
                             pattern="T", 
                             replacement="0.005"));
  
  ### Plot humidity vs. precip2 (precip2 is string value -- this will cause problems!) 
  thePlot = ggplot(data=weatherData) +
    geom_point(mapping=aes(x=relHum, y=precip2)) +
    theme_bw() +
    labs(title = "Relative Humidity vs. Precipitation",
         subtitle = "Lansing, Michigan: 2016",
         x = "Humidity",
         y = "Precipitation (string/character/factor/categorical values)");
  plot(thePlot);


  ### Plot humidity vs. precip3 (much better)  
  thePlot = ggplot(data=weatherData) +
    geom_point(mapping=aes(x=relHum, y=precip3)) +
    theme_bw() +
    labs(title = "Relative Humidity vs. Precipitation",
         subtitle = "Lansing, Michigan: 2016",
         x = "Humidity",
         y = "Precipitation (numeric values)");
  plot(thePlot);
  
  # First 10 days of precipitaion (using precip3)
  precipAmount = 0;   # starts at zero (this is sometimes called a "state" variable)

  ## show with debugger values going up  
  for(i in 1:10)
  {
    precipAmount = precipAmount + weatherData$precip3[i]; 
  }
  
  # February precipitation take 1
  FebPrecip = 0;
  for(i in 32:60)
  {
    FebPrecip = FebPrecip + weatherData$precip3[i]; 
  }
  
  # February precipitation take 2
  FebPrecip2 = 0;
  for(i in 1:length(weatherData$precip3))
  {
    if(i >= 32 & i <= 60)      # & vs && (| vs ||)
    {
      FebPrecip2 = FebPrecip2 + weatherData$precip3[i]; 
    }
  }
  
  # February precipitation take 3
  FebPrecip3 = 0;
  for(i in 1:length(weatherData$precip3))
  {
    if(grepl(x=weatherData$date[i], pattern="02-"))
    {
      FebPrecip3 = FebPrecip3 + weatherData$precip3[i]; 
    }
  }
  
  # 1) Using one for loop:
  #    Find the total rainfall in April, July, and November
  #    - you will need three state variables
  
  AprilPrecip = 0;
  JulyPrecip = 0;
  NovPrecip = 0;
  
  for(i in 1:length(weatherData$precip3))
  {
    if(grepl(x=weatherData$date[i], pattern="04-"))
    {
      AprilPrecip = AprilPrecip + weatherData$precip3[i]; 
    }
    else if(grepl(x=weatherData$date[i], pattern="07-"))
    {
    JulyPrecip = JulyPrecip + weatherData$precip3[i]; 
    }
    else if(grepl(x=weatherData$date[i], pattern="11-"))
    {
    NovPrecip = NovPrecip + weatherData$precip3[i]; 
    }
  }
  
  
AprilPrecip; JulyPrecip; NovPrecip  

  

  
  # 2) Using one for loop:
  #    Find the total rainfall for the first three months and the last three months
  #    - you can extend the grep pattern (i.e., pattern="RA|SN|FG"  
  #                                             looks for rain, snow, or fog)

First3moPrecip = 0;
Last3moPrecip = 0;

for(i in 1:length(weatherData$precip3))
{
  if(grepl(x=weatherData$date[i], pattern="01-|02-|03-"))
  {
    First3moPrecip = First3moPrecip + weatherData$precip3[i]; 
  }
  else if(grepl(x=weatherData$date[i], pattern="10-|11-|12-"))
  {
    Last3moPrecip = Last3moPrecip + weatherData$precip3[i]; 
  }
}

First3moPrecip; Last3moPrecip


  # 3) Using one for loop:
  #    Find the month with the most amount of rain

months = rep(0,12)
pattern = c("01-", "02-", "03-", "04-", "05-", "06-", "07-", "08-", "09-", "10-", "11-", "12-")

for(m in 1:length(pattern))
{ 
  for (i in 1:length(weatherData$precip3))
  {
    if(grepl(x=weatherData$date[i], pattern=pattern[m]))
    {
      months[m] = months[m] + weatherData$precip3[i];
    }
  }
}

which.max(months)
}


