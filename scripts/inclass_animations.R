{
  source(file="scripts/reference.R");  # this line will be in all your scripts
  weatherData = read.csv(file="data/LansingNOAA2016-3.csv", 
                         stringsAsFactors = FALSE);

  library(package=gganimate);  # package used to create the animation mappings

  # Same plot as last example -- this time we are going to save to a gif
  plot2 = ggplot(data=weatherData) +
    geom_point(mapping=aes(x=avgTemp, y=relHum)) +
    labs(title = 'Humidity (y) vs. Temperature (x) by {closest_state} (animation)',
         subtitle = 'Lansing, MI - 2016',
         x = 'Average Temp', 
         y = 'Humidity') +
    theme_bw() +
    transition_states(states = season, 
                      transition_length = 1, # relative animation time (default: 1)  
                      state_length = 2,      # relative pause time (default: 1)
                      wrap = TRUE);          # gif always wraps so this is useless

  
  # anim_save() also take parameters from animate()
  anim_save(filename="media/anim_example1.gif",
            animation = plot2);
  
  
  # anim_save() with animation() parameters used
  #  note: device parameter CANNOT be used here 
  anim_save(filename = "media/anim_example2.gif",
            animation = plot2,
            nframes = 60,       # number of frames in animation
            fps = 5,            # frames per second
            start_pause = 10,   # first frame lasts for 10 frames
            end_pause = 10,     # last frame lasts for 5 frames
            rewind = TRUE);     # like wrap, FALSE does not do much for gif
  
  # note: fps * duration = nframes -- 
  #       you can use two of the three (I did not use duration)
  
  
  
  plot3 = ggplot(data=weatherData) +
    geom_point(mapping=aes(x=maxTemp, y=dewPoint)) +
    labs(title = 'Max Temp (y) vs. dewPoint (x) by {closest_state} (animation)',
         subtitle = 'Lansing, MI - 2016',
         x = 'Max Temp', 
         y = 'dewpoint') +
    theme_bw() +
    transition_states(states = season, 
                      transition_length = 1, # relative animation time (default: 1)  
                      state_length = 2,      # relative pause time (default: 1)
                      wrap = TRUE);          # gif always wraps so this is useless
  
  anim_save(filename="media/inclassgif_1.gif",
            animation = plot3);
  
  
  
  plot4 = ggplot( data=weatherData ) + 
    geom_histogram( mapping=aes(x=avgTemp, y=..count..),
                    bins=40,
                    color="grey20",
                    fill="darkblue") + 
    labs(title = 'Average Temp by {closest_state} (animation)',
         subtitle = 'Lansing, MI - 2016',
         x = 'Count', 
         y = 'Average temp') +
    transition_states(states = season, 
                      transition_length = 2, # relative animation time (default: 1)  
                      state_length = 1,      # relative pause time (default: 1)
                      wrap = TRUE);          # gif always wraps so this is useless;
  
  anim_save(filename="media/inclassgif_2.gif",
            animation = plot4);
  
  plot5 = ggplot( data=weatherData ) + 
      geom_col(mapping=aes(x=season, y=avgTemp), 
               width=0.6) +
      theme_bw() +
      labs(title = "Cumulative Avg Temp ",
           subtitle = "Lansing, Michigan: 2016",
           x = "Season",
           y = "Avg temp") +
    transition_states(states = windDir, 
                      transition_length = 2, # relative animation time (default: 1)  
                      state_length = 1,      # relative pause time (default: 1)
                      wrap = TRUE) +          # gif always wraps so this is useless;
    annotate(geom="text", 
             x=1.55, 
             y=3000, 
             color="red",   
             label= "Wind direction = {closest_state}");
  
  anim_save(filename="media/inclassgif_3.gif",
            animation = plot5);
  
  
  
library(av)
  
anim_save(filename = "media/anim_example1.mp4",
            animation = plot3,
            renderer = av_renderer(),
            nframes = 60,       # number of frames in animation
            fps = 3);           # frames per second
  
  
  
  
  
  
  
  
  
  
}