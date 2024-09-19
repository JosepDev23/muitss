# 1. Generate the numbers 1, 2,. . ., 12, and store the result in the vector x
x = 1:12

# 2. Generate four repetitions of the sequence of numbers (6, 2, 4).
rep(c(6,2,4), 4)

# 3. Generate the sequence consisting of six 9s, then five 2s, and finally four 
#    5s. Store the numbers in a 5 by 3 matrix (populating it columnwise).
matrix(c(rep(9,6), rep(2,5), rep(5,4)), 5, 3)

# 4. Generate a vector consisting of 20 numbers generated randomly from
#    a normal distribution. Use the value 100 as seed (in order to be able
#    to replicate the experiments). Setting the seed is done as follows
#     > set.seed(100)
#    Then, calculate the following statistics about the generated vector:
#     mean, median, variance and the standard deviation.
#    Repeat the generation of the vector and the statistics with and without
#    changing the seed and observe what happens.
set.seed(100)
random_list = rnorm(20)
random_list_mean = mean(random_list)
random_list_median = median(random_list)
random_list_variance = var(random_list)
random_list_standard_deviation = sd(random_list)

# 5. From the resources folder at poliformat, download the file “data1.txt”
#    that contains information about students.

# (a) Read the data into an R object named students (data is in a
#     space-delimited text file and there is no header row).
students = read.table("data1.txt")

# (b) Add the following titles for columns (see section 10):
#     height, shoesize, gender, population
names(students) = c('height', 'shoesize', 'gender', 'population')

# (c) Check that R reads the file correctly
View(students)

# (d) Print the header names only
names(students)

# (e) Print the column height
students$height


# (f) What are the gender distribution (how many observations are
#     in each group) and the distribution of sampling sites (column
#     population) ?
gender_distribution = table(students$gender)
population_distribution = table(students$population)

# (g) Show the distributions in the above item at the same time by
#     using a contingency table.
contingency_table = table(students$gender, students$population)

# (h) Make two subsets of your dataset by splitting it according to
#     gender. Use data frame operations.
male_subset = subset(students, students$gender == "male")
female_subset = subset(students, students$gender == "female")

# (i) Make two subsets containing individuals below and above the
#     median height. Use the functions defined in the dplyr package.
install.packages("dplyr")
library(dplyr)

median_height = median(students$height)

below_median_height_subset = filter(students, height < median_height)
above_median_height_subset = filter(students, height > median_height)

# (j) Change height from centimetres to metres for all rows in the data
#     frame. Do this in three different ways: with basic primitives, a
#     loop using for and the function apply.

#         basic primitives
students = read.table("data1.txt")
names(students) = c('height', 'shoesize', 'gender', 'population')
students$height = students$height / 100

#         for
students = read.table("data1.txt")
names(students) = c('height', 'shoesize', 'gender', 'population')
for (i in 1:nrow(students)){
  students$height[i] = students$height[i] / 100
}

#         function apply
students = read.table("data1.txt")
names(students) = c('height', 'shoesize', 'gender', 'population')
# students$height = apply(students, 1, function(row) row$height / 100)
students$height = sapply(students$height, function(x) x / 100)

# (k) Plot height against shoesize, using blue circles for males 
#     and magenta crosses for females. Add a legend
install.packages("ggplot2")
library(ggplot2)

ggplot(students, aes(x = shoesize, y = height, color = gender, shape = gender)) +
  geom_point(size = 3) +
  scale_color_manual(values = c("male" = "blue", "female" = "magenta")) +
  scale_shape_manual(values = c("male" = 16, "female" = 4)) +
  labs(x = "shoesize",
       y = "height",
       color = "gender",
       shape = "gender")

