library(tidyverse)

#Change the animals data frame to a tibble called animals_tb. Save the row names to a column called animal_names before turning it into a tibble.
animals <- read.csv(file="data/animals.txt")

animals_tb <- as_tibble(rownames_to_column(animals, var = "animal_names"))


#Use ggplot2 to plot the animal names (x-axis) versus the speed of the animal (y-axis) in animals_tb using a scatterplot. Customize the plot to display as shown below.
library(ggplot2)

personal_theme <- function(){
  theme_bw() +
    theme(axis.title=element_text(size=rel(1.5))) +
    theme(plot.title=element_text(size=rel(1.5), hjust=0.5))
}


#Use the arrange() function to order the rows by speed from slowest to fastest. Then use the pull() function to extract the animal_names column as a vector of character values. Save the new variable as names_ordered_by_speed.
animals_tb <- animals_tb %>% arrange(speed)

library(dplyr)

names_ordered_by_speed <- animals_tb %>% pull(animal_names)


#Turn the animal_names column of animals_tb into a factor and specify the levels as names_ordered_by_speed from slowest to fastest (output in part a). 
#Note: this step is crucial, because ggplot2 uses factor as plotting order, instead of the order we observe in data frame.
animals_tb <- animals_tb %>% mutate(animal_names = factor(animal_names, levels = names_ordered_by_speed))

#Re-plot the scatterplot with the animal names in order from slowest to fastest.
ggplot(animals_tb) +
  geom_point(aes(x=animal_names, y=speed), color = "purple") +
  xlab("Animal") +
  ylab("Speed (km/h)") +
  ggtitle("Speed Comparisons Between Animals") +
  ggplot2::theme(plot.title = ggplot2::element_text(hjust = 0.5))


#Save the plot as a PDF called animals_by_speed_scatterplot.pdf to the results folder.
ggsave("results/animals_by_speed_scatterplot.pdf")


# Extract the rows of animals_tb tibble with color of gray or tan, order the rows based from slowest to fastest speed, and save to a variable called animals_gray_tan.
animals_gray_tan <- animals_tb %>% 
  filter(color %in% c("Gray", "Grey", "Tan"))  %>%
  arrange(speed)


#Save animals_gray_tan as a comma-separated value file called animals_tb_ordered.csv to the results folder.
write.csv(animals_gray_tan, file="results/animals_tb_ordered.csv")









