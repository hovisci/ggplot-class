source(file="scripts/reference.R");   # include the reference.r file
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

ggsave(
  filename = "images/app03_1.jpeg",
  plot = plotData,
  width = 12,
  height = 7,
  units = "cm")
  
ggsave(
  filename = "images/pngFiles/app03_2.png",
  plot = plotData,
  width = 6,
  height = 8,
  units = "cm")       

# This scatterplot shows that windspeed and the amount of temperature deviation have a positive relationship        


# Attempt to copy plot for class 7/6/2020

plotData = ggplot(weatherData) +
  geom_point(mapping = aes(x=abs(tempDept), y=windSpeed),
             color=rgb(red=0, green=.6, blue=.6), 
             size=2, 
             shape=23,
             alpha = 0.7 ) +
  theme_bw() +
  labs(title = "Wind Speed vs. Temperature Difference",
       subtitle = "Lansing, Michigan: 2016",
       x = "Temperature (F)",
       y = "Windspeed (mph)") +
  scale_x_continuous(breaks = seq(from = -1, to = 29, by = 3))+
  scale_y_continuous(breaks = seq(from = 5, to = 20, by = 5), limits = c(0,20))+
  theme(axis.text.y=element_text(angle=30),
        axis.title.x=element_text(size=15, face="italic", 
                                  color=rgb(red=.8, green=.3, blue=0)),
        plot.subtitle=element_text(face="bold.italic",
                                   color ="brown"),
        aspect.ratio = 1/1) +
  # default confidence level is 95%
  geom_smooth(mapping=aes(x=abs(tempDept), y=windSpeed), 
              method="lm",
              color="purple", 
              size=1.2, 
              linetype=5, 
              fill="yellow");   

plot(plotData);

