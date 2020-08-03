source(file="scripts/reference.R");  
weatherData = read.csv(file="data/LansingNOAA2016-3.csv", 
                       stringsAsFactors = FALSE);


# Create a text plot of Precipitation vs Humidity
# Convert trace rain to the numeric value 0.005
# Label the points with avgTemp
weatherData$precipNum = weatherData$precip;
weatherData$precipNum[weatherData$precip == "T"] = 0.005;
weatherData$precipNum <- as.numeric(weatherData$precipNum)


thePlot = ggplot(data=weatherData) +
  geom_text(mapping=aes(x=relHum, y=precipNum, label=avgTemp)) +
  theme_bw() +
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank()) +
  labs(title = "Humidity vs. Precipitation",
       subtitle = "Lansing, Michigan: 2016",
       x = "Relative Humidity",
       y = "Precipitation");
plot(thePlot);

# Color the text points using a gradient that goes from blue (coldest temp) to darkgreen (middle), to red (hottest)

thePlot = ggplot(data=weatherData) +
  geom_text(mapping=aes(x=relHum, y=precipNum, label=avgTemp, color=maxTemp)) +
  scale_color_gradientn(colors=c("blue","darkgreen","red")) +
  theme_bw() +
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank()) +
  labs(title = "Humidity vs. Precipitation",
       subtitle = "Lansing, Michigan: 2016",
       x = "Relative Humidity",
       y = "Precipitation");
  
plot(thePlot);

# Change the y-axis to a logarithmic scale
# This can be done by adding the component: scale_y_continuous(trans="log10")

thePlot = ggplot(data=weatherData) +
  geom_text(mapping=aes(x=relHum, y=precipNum, label=avgTemp, color=maxTemp)) +
  scale_color_gradientn(colors=c("blue","darkgreen","red")) +
  scale_y_continuous(trans="log10") +
  theme_bw() +
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank()) +
  labs(title = "Humidity vs. Precipitation",
       subtitle = "Lansing, Michigan: 2016",
       x = "Relative Humidity",
       y = "Precipitation");

plot(thePlot);

# Move the legend into the plot area making sure not to cover any points. 
# The legend's position will still change as the canvas is resized -- do not worry about this

thePlot = ggplot(data=weatherData) +
  geom_text(mapping=aes(x=relHum, y=precipNum, label=avgTemp, color=maxTemp)) +
  scale_color_gradientn(colors=c("blue","darkgreen","red")) +
  scale_y_continuous(trans="log10") +
  theme_bw() +
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(),
        legend.position = c(0.15, 0.65)) +
  labs(title = "Humidity vs. Precipitation",
       subtitle = "Lansing, Michigan: 2016",
       x = "Relative Humidity",
       y = "Precipitation");

plot(thePlot);