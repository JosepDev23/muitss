# Exercise 1: Inspection of data

## The “titanic.csv” file (available from the course documentation page
## at poliformat) contains data on the sinking of the Titanic. More concretely, 
## the file contains data for 891 of the real Titanic passengers.
## Copy the file in your working directory. Then, go to R and use the
## command

titanic <- read.csv("./titanic.csv",header=TRUE, sep=',')

## and choose the relevant csv file. You may write the file name (including 
## the path to the file) instead of file.choose(), as shown in the
## R seminar and used in the Practical Work 1, i.e. ‘titanic.csv’. Notice
## how you can change the field separator character according to what is
## used in the csv file, so that the file is interpreted in the correct way.
## Show the names of the columns. 

names(titanic)

## Observe that the first column (whose
## name is "PassengerId") is redundant (it denotes the identifier of each
## instance) so it could be removed. To do this, we can use the select
## function of the dplyr package:

install.packages("dplyr")
library(dplyr)

titanic<-select(titanic,-1)

## After that, we inspect the resulting data frame:

head(titanic)
summary(titanic)

## Which variables are quantitative and which variables are categorical?

##### Quantitative: Age, SibSp, Parch, Fare
##### Categorical: Survived, Pclass, Name, Sex, Ticket, Cabin, Embarked

# Exercise 2: Looking at the protected attributes

## The data in the titanic.csv dataset is an example of biased data. Answer the 
## following questions:

## 1. Identify which attributes correspond to personal data. Are there
## any that we can rule out (that is, disregard) for data analysis?
  
##### Personal data: Name, Sex, Age, Ticket, Cabin, Embarked, SibSp, Parch
##### Data that we can rule out: Name, Ticket, Cabin

## 2. Identify which attributes are protected (sex, ...).

##### Sex, Age, Embarked

## 3. Use table() to analyse the class distribution (attribute Survided)
## for each protected attribute, and comment the results.

table(titanic$Survived, titanic$Sex)
##### Hay una clara diferencia, las mujeres sobrevivieron en una proporción
##### mucho mayor

table(titanic$Survived, titanic$Embarked)
##### Hay una ligera diferencia, los pasajeros que embarcaron en el puerto C,
##### tuvieron una mayor proporción de supervivientes

median_age <- median(titanic$Age, na.rm = TRUE)
titanic$AgeGroup <- ifelse(titanic$Age <= median_age, "Young", "Older")
table(titanic$Survived, titanic$AgeGroup)
##### No existe diferencia, jóvenes y mayores sobrevivieron en proporciones casi 
##### idénticas

# Exercise 3: Data transformation I.

## Download the file “airquality.csv” from poliformat. This dataset contains 
## some New York air quality measurements. Solve the following exercises:

airquality <- read.csv("airquality.csv")

## 1. Discretise the Ozone column into five bins (‘bin1’, ‘bin2’, ...) of
## equal width and a sixth bin (‘binNA’) for NA.

airquality$Ozone_bin <- cut(airquality$Ozone, breaks = 5, labels = paste0("bin", 1:5))
airquality$Ozone_bin <- addNA(airquality$Ozone_bin)
levels(airquality$Ozone_bin)[is.na(levels(airquality$Ozone_bin))] <- "binNA"

## 2. Discretise the Solar column into four bins of equal frequency and
## a fifth bin for NA.

quantiles <- quantile(airquality$Solar.R, probs = seq(0, 1, length.out = 4 + 1), na.rm = TRUE)
airquality$Solar_bin <- cut(airquality$Solar.R, breaks = quantiles, labels = paste0("bin", 1:4), include.lowest = TRUE)
airquality$Solar_bin <- addNA(airquality$Solar_bin)
levels(airquality$Solar_bin)[is.na(levels(airquality$Solar_bin))] <- "binNA"

# Exercise 4: Data transformation II

## Download the file “titanic2.csv” from poliformat (a simplified version
## of the original titanic dataset), and solve the following exercises:

titanic2 <- read.csv("titanic2.csv")

## 1. Numerise the ‘class’ column, where Crew=4, 1st=3, 2nd=2 and 3rd=1.

library(dplyr)

titanic2 <- titanic2 %>%
  mutate(Class = recode(Class, "Crew" = 4, "1st" = 3, "2nd" = 2, "3rd" = 1))

head(titanic2)

## 2. Transform the titanic2 data frame into a new data frame (titanic3) with as 
## many examples as passengers using the Freq column. In other words, there should 
## be no rows for those for which Freq=0 and there should be 35 replicated rows 
## for those with Freq=35.

titanic3 <- titanic2[rep(seq_len(nrow(titanic2)), titanic2$Freq), ]

head(titanic3)

# Exercise 5: Data selection.

airquality <- read.csv("airquality.csv")

## 1. Using the data frame ‘air’, perform a simple random sampling of 50 examples.

simple_random_sample <- airquality[sample(nrow(airquality), 50), ]

head(simple_random_sample)

## 2. Using the data frame ‘air’, perform a stratified random sampling of 5 
## examples of each month.

library(dplyr)

air_sample <- airquality[unlist(lapply(unique(airquality$Month), function(x) sample(which(airquality$Month == x), 5, replace = FALSE))), ]


stratified_sample <- airquality %>%
  group_by(Month) %>%
  sample_n(5, replace = TRUE)


