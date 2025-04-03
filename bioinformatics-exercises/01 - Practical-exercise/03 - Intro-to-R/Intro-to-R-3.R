#Data Visualization with ggplot2

## load the new_metadata data frame into your environment from a .RData object
load("data/new_metadata.RData")

# this data frame should have 12 rows and 5 columns
View(new_metadata)

library(ggplot2)

ggplot(new_metadata) +
  geom_point(aes(x = age_in_days, y= samplemeans, color = genotype, shape=celltype), size=2.25) +
  theme_bw() + 
  theme(axis.title = element_text(size=rel(1.5)))


#Exercise 1
#x-axis is labeled “Age (days)” and the y-axis is labeled “Mean expression”.
#Use the ggtitle layer to add a plot title of your choice.
ggplot(new_metadata) +
  geom_point(aes(x = age_in_days, y= samplemeans, color = genotype, shape=celltype), size=2.25) +
  xlab("Age (days)") +
  ylab("Mean expression") +
  ggtitle("Mean expressions per Age") +
  theme_bw() + 
  theme(axis.title = element_text(size=rel(1.5))) + 
  theme(plot.title=element_text(hjust=0.5))


#Consistent formatting using custom functions
personal_theme <- function(){
  theme_bw() +
    theme(axis.title=element_text(size=rel(1.5))) +
    theme(plot.title=element_text(size=rel(1.5), hjust=0.5))
}

ggplot(new_metadata) +
  geom_point(aes(x=age_in_days, y=samplemeans, color=genotype, shape=celltype), size=rel(3.0)) +
  xlab("Age (days)") +
  ylab("Mean expression") +
  ggtitle("Expression with Age") +
  personal_theme()


#Generating a Boxplot with ggplot2
ggplot(new_metadata, aes(x=genotype, y=samplemeans, fill=celltype)) +
  geom_boxplot() +
  ggtitle("Genotype differences in average gene expression") +
  xlab("Genotype") +
  ylab("Mean expression") +
  personal_boxplot_theme()
  


#Changing the order of genotype on the Boxplot
new_metadata$genotype <- factor(new_metadata$genotype, levels = c("Wt", "KO"))

ggplot(new_metadata, aes(x=genotype, y=samplemeans, fill=celltype)) +
  geom_boxplot() +
  ggtitle("Genotype differences in average gene expression") +
  xlab("Genotype") +
  ylab("Mean expression") +
  personal_boxplot_theme()


#Changing default colors
ggplot(new_metadata, aes(x=genotype, y=samplemeans, fill=celltype)) +
  geom_boxplot() +
  ggtitle("Genotype differences in average gene expression") +
  xlab("Genotype") +
  ylab("Mean expression") +
  scale_fill_manual(values=c("purple","orange")) +
  personal_boxplot_theme() 
  
personal_boxplot_theme <- function(){
  theme_bw() +
    theme(axis.title=element_text(size=rel(1.25))) +
    theme(plot.title=element_text(size=rel(1.5), hjust=0.5))
}



#Writing data to file

# Save a data frame to file
write.csv(sub_meta, file="data/subset_meta.csv")

# Save a vector to file
glengths <- c(4.6, 3000, 50000)
write(glengths, file="data/genome_lengths.txt")

# Save a vector to file as a single column
write(glengths, file="data/genome_lengths.txt", ncolumns = 1)

ggplot(new_metadata) +
  geom_point(aes(x = age_in_days, y= samplemeans, color = genotype,
                 shape=celltype), size=rel(3.0))
ggsave("figures/scatterplot.pdf")



#Exercise 2
#Run the following code chunks and fix all of the errors. (Note: The code chunks are independent from one another.)
# Create vector of work days
work_days <- c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday")

# Create a function to round the output of the sum function
round_the_sum <- function(x){
  return(round(sum(x)))
}

# Create a function to add together three numbers
add_numbers <- function(x,y,z){
  sum(x,y,z)
}

add_numbers(5,9,2)



#Data Wrangling with Tidyverse
library(tidyverse)


#Pipes
## A single command
sqrt(83)

## Base R method of running more than one command
round(sqrt(83), digits = 2)

## Running more than one command with piping
sqrt(83) %>% round(digits = 2)


#Exercise 3
random_numbers <- c(81, 90, 65, 43, 71, 29)

#Use the pipe (%>%) to perform two steps in a single line:
mean(random_numbers) %>% round(digits = 3)


#Tibbles

# Read in the functional analysis results
functional_GO_results <- read_delim(file = "data/gprofiler_results_Mov10oe.txt", delim = "\t" )

# Take a look at the results
functional_GO_results



# Return only GO biological processes
bp_oe <- functional_GO_results %>% filter(domain == "BP")

View(bp_oe)


#Exercise 4
#For bp_oe, use the filter() function to only keep those rows where the relative.depth is greater than 4.
bp_oe <- bp_oe %>% filter(relative.depth > 4)

# Selecting columns to keep
bp_oe <- bp_oe %>% select(term.id, term.name, p.value, query.size, term.size, overlap.size, intersection)

View(bp_oe)

# Order by adjusted p-value ascending
bp_oe <- bp_oe %>%
  arrange(p.value)

# Provide better names for columns
bp_oe <- bp_oe %>% 
  dplyr::rename(GO_id = term.id, 
                GO_term = term.name)


#Exercise 5
#Rename the intersection column to genes to reflect the fact that these are the DE genes associated with the GO process.
bp_oe <- bp_oe %>% 
  dplyr::rename(genes = intersection)


# Create gene ratio column based on other columns in dataset
bp_oe <- bp_oe %>%
  mutate(gene_ratio = overlap.size / query.size)


#Exercise 6
#Create a column in bp_oe called term_percent
bp_oe <- bp_oe %>%
  mutate(term_percent = overlap.size / term.size)










