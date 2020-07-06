source(file="scripts/reference.R");   # include the reference.r file
weatherData = read.csv(file="data/LansingNOAA2016.csv",
                       stringsAsFactors = FALSE);

# scatterplot of windSpeed vs. tempDept

plotData = ggplot(data = weatherData) +
  geom_point(mapping = aes(y = windSpeed, x = abs(tempDept)),
             alpha = .7,
             size = 2,
             color = rgb(red=0, green=.6, blue=.6),
             shape = 5) +
  geom_smooth(mapping = aes(y = windSpeed, x = abs(tempDept)),
              method = "lm",
              linetype = 3,
              color = "red",
              fill = "blue") +
  labs(title = "Average Windspeed vs Daily Temperature Departure",
       subtitle = "Lansing, Michigan 2016",
       y = "Windspeed (mph)",
       x = "Temperature Departure (F)") +
  theme( axis.text.y = element_text(angle = 45),
         plot.subtitle = element_text(color ="purple", size = 11),
         axis.text.x = element_text(face = 'italic', color = 'purple'));
  
plot(plotData);
       

# This scatterplot shows that windspeed and the amount of temperature deviation have a positive relationship        
