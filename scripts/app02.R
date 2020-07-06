# execute the lines of code from reference.r
source(file="scripts/reference.r");

# read in CSV file and save the content to packageData
deathData = read.csv(file="data/accdeaths.csv");



# scatterplot of accdeaths vs time

plotData = ggplot( data = deathData ) + 
  geom_point( mapping = aes(x = time, y = value) ) +
  ggtitle( label = "Accidental Deaths in US (1973 - 1978)" ) +
  scale_y_continuous( n.breaks = 3 ) +
  scale_x_continuous( breaks = seq(from = 0, to = 1978, by = 0.5) ) +
  theme( axis.text.x = element_text(angle = 45, hjust = 1) );

plot(plotData);