source(file="scripts/reference.R");  
weatherData = read.csv(file="data/LansingNOAA2016-2.csv", 
                       stringsAsFactors = FALSE);

# Create a bar plot of Cooling Days (coolDays) for each month
# Add a title, and put appropriate labels on the axes.
# Change the bar width to 0.6

weatherData$month = format.Date(weatherData$dateYr, format="%b");

thePlot = ggplot(data=weatherData) +
  geom_col(mapping=aes(x=month, y=coolDays), 
           width=0.6) +
  theme_bw() +
  labs(title = "Cooling Days by Month",
       subtitle = "Lansing, Michigan: 2016",
       x = "Month",
       y = "Number of degrees diverging from 65");
plot(thePlot);

# Create a vector that consists of the first two values in the weatherType column
# (i.e., the new vector will have at most one weather condition for the day).
# Note:  I wasn't sure how to do this so I ahd to lift if from your answer keys a bit here

wType = weatherData$weatherType

# save only the first two characters in the weatherType
wType = substr(wType, start = 1, stop = 2);

# put in value of "--" for wType that have no value 
wType[which(wType=="")] = "--";

# Use the vector created in the previous step to fill the bars 
# (for fun, you can try to just use weatherType as the fill and see what happens...)
# Customize the colors of the 8 weather conditions (one of the conditions is empty).  
# Do this using component scale_fill_manual and the subcomponent values, which will be set a to a vector.  
# Note: this is the discrete version of the component scale_fill_gradient.

thePlot = ggplot(data=weatherData) +
  geom_col(mapping=aes(x=month, y=coolDays, fill=wType),
           width=0.6) +
  scale_x_discrete(limits = month.abb) +
  scale_fill_manual(values = c('cyan4', 'blue', 'deepskyblue', 'cyan', 
                               'deeppink', 'darkorchid', 'chartreuse', 
                               'aquamarine2')) +
  theme_bw() +
  labs(title = "Cool Days by Month",
       subtitle = "Lansing, Michigan: 2016",
       x = "Month",
       y = "Number of degrees diverging from 65");
plot(thePlot);


# Create a bar plot of Heating Days (heatDays) for each month
# Add a title, and put appropriate labels on the axes.
# Change the bar width to 0.6

thePlot = ggplot(data=weatherData) +
  geom_col(mapping=aes(x=month, y=heatDays, fill=wType),
           width=0.6) +
  scale_x_discrete(limits = month.abb) +
  scale_fill_manual(values = c('cyan4', 'blue', 'deepskyblue', 'cyan', 
                               'deeppink', 'darkorchid', 'chartreuse', 
                               'aquamarine2')) +
  theme_bw() +
  labs(title = "Heat Days by Month",
       subtitle = "Lansing, Michigan: 2016",
       x = "Month",
       y = "Number of degrees diverging from 65");
plot(thePlot);


# Add a horizontal line to the plot that represent the sum of all coolDays for the year (it should be in the 800s)
# Add a label (or, annotate) that describes what the line represents.
thePlot = ggplot(data=weatherData) +
  geom_col(mapping=aes(x=month, y=heatDays, fill=wType),
           width=0.6) +
  scale_x_discrete(limits = month.abb) +
  scale_fill_manual(values = c('cyan4', 'blue', 'deepskyblue', 'cyan', 
                               'deeppink', 'darkorchid', 'chartreuse', 
                               'aquamarine2')) +
  theme_bw() +
  labs(title = "Heat Days by Month",
       subtitle = "Lansing, Michigan: 2016",
       x = "Month",
       y = "Number of degrees diverging from 65") +
  annotate(geom="text", 
           x=7, 
           y=900, 
           color="red",   
           label="Number of cool day degrees") +
  geom_hline( mapping = aes( yintercept= sum(coolDays) ),
              color="blue",
              size=2,
              linetype=2);
plot(thePlot);

# Combine Heating and Cooling Days into one barplot
# Add a title, and put appropriate labels on the axes.
# Change the bar widths of both to 0.4
# Change the bar fill to solid colors: red for heatDays , blue for coolDays

thePlot = ggplot(data=weatherData) +
  geom_col(mapping=aes(x=month, y=heatDays),  
           fill = "red",
           width=0.4) +
  geom_col(mapping=aes(x=month, y=coolDays),  
           fill = "blue",
           width=0.4) +
  scale_x_discrete(limits = month.abb) +
  theme_bw() +
  labs(title = "Heating and Cooling Days",
       subtitle = "Lansing, Michigan: 2016",
       x = "Month",
       y = "Cumulative Heat/Cool Days");

plot(thePlot);
