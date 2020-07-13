# Create a script file in your scripts folder called app05.r. 
# Open the data frame created in this lesson: LansingNOAA2016-2.csv
# Do a histogram of average humidity -- add titles and appropriate labels.
# Create a column in your data frame called biMonth that divides the year into 6 categories: JanFeb, MarApr, MayJun, JulAug, SepOct, and NovDec
# Using faceting, facet_grid(), create a separate histogram for each biMonth category
# Create a stacked histogram, using fill subcomponent, of average humidity using biMonth
# Add two vertical lines that give the mean relative humidity for JanFeb and JulAug.
# Hint: you want to find the mean of the values in the relHum column and JanFeb (JulAug) rows
# Challenge: The legend is currently wasting a lot of white-space on the right side of the plot. Move the legend over the plot in a way that it does not cover the plot data. (in extension and lesson 7)
# Challenge: The months are in alphabetical order instead of ordered by date.  Change the order of the months by date -- this is covered in detail in the next lesson.