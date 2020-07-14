source( file="scripts/reference.R" ); 

# Open the data frame created in this lesson: LansingNOAA2016-2.csv

weatherData = read.csv(file="data/LansingNOAA2016-2.csv", 
                       stringsAsFactors = FALSE);

# Do a histogram of average humidity -- add titles and appropriate labels.

plotData = ggplot( data=weatherData ) +
  geom_histogram( mapping=aes(x=relHum, y=..count..),
                  bins=40,
                  color="grey20",
                  fill="darkblue") +
  theme_classic() +
  labs(title = "Humidity Histogram",
       subtitle = "Lansing, Michigan: 2016",
       x = "Relative Humidity",
       y = "Count");
plot(plotData);

# Create a column in your data frame called biMonth that divides the year into 6 categories: 
# JanFeb, MarApr, MayJun, JulAug, SepOct, and NovDec


biMonth = vector(mode="character", length=length(weatherData$dateYr));

JanFeb = as.Date("01-01-2016", format="%m-%d-%Y");
MarApr = as.Date("03-01-2016", format="%m-%d-%Y");
MayJun = as.Date("05-01-2016", format="%m-%d-%Y");
JulAug = as.Date("07-01-2016", format="%m-%d-%Y");
SepOct = as.Date("09-01-2016", format="%m-%d-%Y");
NovDec = as.Date("11-01-2016", format="%m-%d-%Y");


for(i in 1:length(weatherData$dateYr)) # go through each date
{
  # if the date falls in JanFeb
  if(weatherData$dateYr[i] >= JanFeb && weatherData$dateYr[i] < MarApr)
  {
    biMonth[i] = "JanFeb";
  }
  # if the date falls in MarApr
  else if(weatherData$dateYr[i] >= MarApr && weatherData$dateYr[i] < MayJun)
  {
    biMonth[i] = "MarApr";
  }
  # if the date falls in MayJun
  else if(weatherData$dateYr[i] >= MayJun && weatherData$dateYr[i] < JulAug)
  {
    biMonth[i] = "MayJun";
  }
  # if the date falls in JulAug
  else if(weatherData$dateYr[i] >= JulAug && weatherData$dateYr[i] < SepOct)
  {
    biMonth[i] = "JulAug";
  }
  # if the date falls in SepOct
  else if(weatherData$dateYr[i] >= SepOct && weatherData$dateYr[i] < NovDec)
  {
    biMonth[i] = "SepOct";
  }
  # if the date falls in NovDec
  else if(weatherData$dateYr[i] >= NovDec || weatherData$dateYr[i] < JanFeb)
  {
    biMonth[i] = "NovDec";
  }
  else # something went wrong... always good to check
  {
    biMonth[i] = "Error";
  }
}

weatherData$biMonth = biMonth;


# Using faceting, facet_grid(), create a separate histogram for each biMonth category

plotData2 = ggplot(data=weatherData) +
  geom_histogram(mapping=aes(x=relHum, y=..count..),
                 bins=40,
                 color="grey20",
                 fill="darkblue") +
  theme_classic() +
  facet_grid( facet= biMonth ~ .) +
  labs(title = "Humidity Histogram",
       subtitle = "Lansing, Michigan: 2016",
       x = "Relative Humidity",
       y = "Count");
plot(plotData2);

# Create a stacked histogram, using fill subcomponent, of average humidity using biMonth

plotData3 = ggplot(data=weatherData) + 
  geom_histogram(mapping=aes(x=relHum, y=..count.., fill=biMonth),
                 bins=40,
                 color="grey20",
                 position="stack") +
  theme_classic() +
  labs(title = "Humidity Histogram",
       subtitle = "Lansing, Michigan: 2016",
       x = "Relative Humidity",
       y = "Count");
plot(plotData3);

# Add two vertical lines that give the mean relative humidity for JanFeb and JulAug.
# Hint: you want to find the mean of the values in the relHum column and JanFeb (JulAug) rows

plotData4 = ggplot(data=weatherData) + 
  geom_histogram(mapping=aes(x=relHum, y=..count.., fill=biMonth),
                 bins=40,
                 color="grey20",
                 position="stack") +
  geom_vline(xintercept=mean(weatherData$relHum[which(weatherData$biMonth == "JanFeb")])) +
  geom_vline(xintercept=mean(weatherData$relHum[which(weatherData$biMonth == "JulAug")]))
  theme_classic() +
  labs(title = "Humidity Histogram",
       subtitle = "Lansing, Michigan: 2016",
       x = "Relative Humidity",
       y = "Count");
plot(plotData4);

# Challenge: The legend is currently wasting a lot of white-space on the right side of the plot. Move the legend over the plot in a way that it does not cover the plot data. (in extension and lesson 7)
plotData5 = ggplot(data=weatherData) + 
  geom_histogram(mapping=aes(x=relHum, y=..count.., fill=biMonth),
                   bins=40,
                   color="grey20",
                   position="stack") +
  geom_vline(xintercept=mean(weatherData$relHum[which(weatherData$biMonth == "JanFeb")])) +
  geom_vline(xintercept=mean(weatherData$relHum[which(weatherData$biMonth == "JulAug")])) +
  theme_classic() +
  theme(legend.position= c(x=0.2, y=0.75) ) +  
  labs(title = "Humidity Histogram",
       subtitle = "Lansing, Michigan: 2016",
       x = "Relative Humidity",
       y = "Count");
  
  plot(plotData5); 
  
# Challenge: The months are in alphabetical order instead of ordered by date.  
# Change the order of the months by date -- this is covered in detail in the next lesson.
  
  biMonthFact = factor(weatherData$biMonth,
                       levels=c("JanFeb", "MarApr", "MayJun", "JulAug", "SepOct", "NovDec"));
  
  
  plotData6 = ggplot(data=weatherData) + 
  geom_histogram(mapping=aes(x=relHum, y=..count.., fill=biMonthFact),
                   bins=40,
                   color="grey20",
                   position="stack") +
  geom_vline(xintercept=mean(weatherData$relHum[which(weatherData$biMonth == "JanFeb")])) +
  geom_vline(xintercept=mean(weatherData$relHum[which(weatherData$biMonth == "JulAug")])) +
  theme_classic() +
  theme(legend.position= c(x=0.2, y=0.75) ) +  
  labs(title = "Humidity Histogram",
       subtitle = "Lansing, Michigan: 2016",
       x = "Relative Humidity",
       y = "Count");
  
  plot(plotData6); 
  
