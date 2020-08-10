source( file="scripts/reference.R" ); 
weatherData = read.csv( file="data/LansingNOAA2016-3.csv", 
                        stringsAsFactors = FALSE );
library(gridExtra)

# Create a histogram of tempDept restricted to days that meet a condition in the weatherType column:
# To restrict the data, you can subset with the indices that meet the condition (e.g., data=weatherData[daysWithRain,])
# Place a vertical line at the average tempDept for the condition and label the line with the average value

unique(weatherData$weatherType)

rainDays = grep(weatherData$weatherType, pattern = "RA");  # rain
rainAve = mean(weatherData[rainDays,]$tempDept);

# histogram of rainy days
raHist = ggplot( data=weatherData[rainDays,]) + 
  geom_histogram( mapping=aes(x=tempDept, y=..count..),
                  bins=40,
                  color="grey20",
                  fill="darkblue") +
  theme_classic() +
  geom_vline(mapping=aes(xintercept=median(rainAve)),
             color="red",
             size=1) +
  geom_text(x=15, 
            y=8, 
            label="Average tempDept = 5.01", 
            color='red') +
  labs(title = "TempDept for rainy Days",
       subtitle = "Lansing, Michigan: 2016",
       x = "Temperature Departure",
       y = "Frequency");
plot(raHist);


# Repeat step 2 for two more conditions in the weatherType column (so, three histograms in all)

tsDays = grep(weatherData$weatherType, pattern = "TS");    # thunderstorms
fogDays = grep(weatherData$weatherType, pattern = "FG");   # fog

tsAve = mean(weatherData[tsDays,]$tempDept);
fogAve = mean(weatherData[fogDays,]$tempDept);

# histogram of days of thunderstorms
tsHist = ggplot( data=weatherData[tsDays,]) + 
  geom_histogram( mapping=aes(x=tempDept, y=..count..),
                  bins=40,
                  color="grey20",
                  fill="darkblue") +
  theme_classic() +
  geom_vline(mapping=aes(xintercept=median(tsAve)),
             color="red",
             size=1) +
  geom_text(x=10, 
            y=5, 
            label="Average tempDept = 7.43", 
            color='red') +
  labs(title = "TempDept for Thunderstorm Days",
       subtitle = "Lansing, Michigan: 2016",
       x = "Temperature Departure",
       y = "Frequency");
plot(tsHist);

# histogram of foggy days
fgHist = ggplot( data=weatherData[fogDays,]) + 
  geom_histogram( mapping=aes(x=tempDept, y=..count..),
                  bins=40,
                  color="grey20",
                  fill="darkblue") +
  theme_classic() +
  geom_vline(mapping=aes(xintercept=median(fogAve)),
             color="red",
             size=1) +
  geom_text(x=-3, 
            y=3, 
            label="Average tempDept = 2.58", 
            color='red') +
  labs(title = "TempDept for Foggy Days",
       subtitle = "Lansing, Michigan: 2016",
       x = "Temperature Departure",
       y = "Frequency");
plot(fgHist);

# Create a histogram of tempDept restricted to days where two conditions occur in the weatherType column (e.g., rainy AND breezy).
# Place a vertical line at the average tempDept and label the line with the average value

rainAndThunderstorms = intersect(rainDays, tsDays); # days with rain AND thunderstorms
rainAndTSAve = mean(weatherData[rainAndThunderstorms,]$tempDept);

# histogram of rain and thunderstorms
tsANDraHist = ggplot( data=weatherData[rainAndThunderstorms,]) + 
  geom_histogram( mapping=aes(x=tempDept, y=..count..),
                  bins=40,
                  color="grey20",
                  fill="darkblue") +
  theme_classic() +
  geom_vline(mapping=aes(xintercept=median(rainAndTSAve)),
             color="red",
             size=1) +
  geom_text(x=10, 
            y=4.5, 
            label="Average tempDept = 7.45", 
            color='red') +
  labs(title = "TempDept for rain and TS Days",
       subtitle = "Lansing, Michigan: 2016",
       x = "Temperature Departure",
       y = "Frequency");
plot(tsANDraHist);

# Create a histogram of tempDept restricted to days where one of two conditions occur in the weatherType column (e.g., rainy OR breezy).
# Place a vertical line at the average tempDept and label the line with the average value

rainOrFog = union(rainDays, fogDays);      # days with rain OR fog
rainOrFogAve = mean(weatherData[rainOrFog,]$tempDept);

# histogram of rain or fog
rnORfgHist = ggplot( data=weatherData[rainOrFog,]) + 
  geom_histogram( mapping=aes(x=tempDept, y=..count..),
                  bins=40,
                  color="grey20",
                  fill="darkblue") +
  theme_classic() +
  geom_vline(mapping=aes(xintercept=median(rainOrFogAve)),
             color="red",
             size=1) +
  geom_text(x=10, 
            y=9, 
            label="Average tempDept = 4.25", 
            color='red') +
  labs(title = "TempDept for rain or Foggy Days",
       subtitle = "Lansing, Michigan: 2016",
       x = "Temperature Departure",
       y = "Frequency");
plot(rnORfgHist);

# Using grid.arrange(), place the 5 histograms you created in the previous steps on one canvas
h1 = raHist
h2 = tsHist
h3 = fgHist
h4 = tsANDraHist
h5 = rnORfgHist

grid.arrange(h1, h2, h3, h4, h5,
             nrow=3);
# Using grid.arrange(), pick three histograms from steps 2-4 and place them on a canvas
# Resize at least 2 of the histogram so they take up more than 1 cell

grid.arrange(h1, h2, h3, h4, h5,
             layout_matrix = rbind(c(1,1,5,5),
                                   c(1,1,NA,NA),
                                   c(4,4,2,2),
                                   c(4,4,3,3)));