#Reading in and inspecting data

#Read the .csv file into your environment and assign it to a variable called animals. Be sure to check that your row names are the different animals.
animals <- read.csv(file="data/animals.txt")

#Check to make sure that animals is a dataframe.
str(animals)

#How many rows are in the animals dataframe? How many columns?
dim(animals)


#Data wrangling
#Extract the speed value of 40 km/h from the animals dataframe.
animals[1, 1]

#Return the rows with animals that are the color Tan.
logical_idx <- animals$color == "Tan"
animals[logical_idx, ]

#Return the rows with animals that have speed greater than 50 km/h and output only the color column. Keep the output as a data frame.
sub_animals <- animals[which(animals$speed > 50), ]

#Change the color of “Grey” to “Gray”.
logical_idx <- animals$color == "Grey"
animals[logical_idx, 2] <- "Gray"

#Create a list called animals_list in which the first element contains the speed column of the animals dataframe and the second element contains the color column of the animals dataframe.
animals_list <- list(animals$speed, animals$color)

#Give each element of your list the appropriate name (i.e speed and color).
names(animals_list) <- c("speed", "color")
names(animals_list)


#The %in% operator, reordering and matching
ctrl_samples <- data.frame(row.names = c("sample3", "sample10", "sample8", "sample4", "sample15"), date = c("01/13/2018", "03/15/2018", "01/13/2018", "09/20/2018","03/15/2018"))

#How many of the ctrl_samples are also in the proj_summary dataframe? Use the %in% operator to compare sample names.
proj_summary <- read.table("data/project-summary.txt", header = TRUE, stringsAsFactors = FALSE)
length(which(rownames(ctrl_samples) %in% proj_summary$Name))

#Keep only the rows in proj_summary which correspond to those in ctrl_samples. Do this with the %in% operator. Save it to a variable called proj_summary_ctrl.
proj_summary_ctrl <- proj_summary[which(proj_summary$Name %in% rownames(ctrl_samples)),]

#We would like to add in the batch information for the samples in proj_summary_ctrl. Find the rows that match in ctrl_samples.
batch_idx <- match(proj_summary_ctrl$Name, rownames(ctrl_samples))

#Use cbind() to add a column called batch to the proj_summary_ctrl dataframe. Assign this new dataframe back to proj_summary_ctrl.
proj_summary[which(proj_summary$Name %in% rownames(ctrl_samples)),]

batch <- data.frame(batch = ctrl_samples[batch_idx, ])
proj_summary_ctrl <- cbind(proj_summary_ctrl, batch)


#BONUS
#Subset proj_summary to keep only the “high” and “low” samples based on the treament column. Save the new dataframe to a variable called proj_summary_noctl.
proj_summary_noctl <- proj_summary[which(proj_summary$treatment %in% c("high", "low")), ]

#Further, subset the dataframe to remove the non-numeric columns “Quality_format”, and “treatment”. Try to do this using the map_lgl() function in addition to is.numeric(). Save the new dataframe back to proj_summary_noctl.
library(purrr)
num_cols <- map_lgl(proj_summary_noctl, is.numeric)
proj_summary_noctl <- proj_summary_noctl[ , num_cols]















