##Consola
##########################
rnorm(10)

x <- 5
x

##Paquetes
##########################
if (!require("dplyr")) { install.packages("dplyr", dependencies=TRUE)}
if (!require("ggplot2")) { install.packages("ggplot2", dependencies=TRUE)}

library(dplyr)
library(ggplot2)

##Codigo basico
##########################
a<-"hola"
#b<-log(10)

##Vectores
##########################
first_vec <- c(1, 3, 5)
first_vec


char_vec <- c("these", "are", "some", "words")
length(char_vec)

first_vec > c(2, 2, 2)

rep(0, times=3)

rep("abc", 4)

seq(from=1, to=5, by=2)

seq(10, 0, -5)

3:7

rep(seq(1,3,1), times=2)

######Ejercicio1
##########################


##Seleccionando datos de un vector
##########################
a <- seq(10,1,-1)
a[2]
a[seq(1,5)]
a[c(1,3,4)]

######Ejercicio 2
##########################

##Lectura de datos
##########################

######Ejercicio 3
##########################

##head(), tail()
##########################

head(dat_csv, 2)

tail(dat_csv, 8)

##Seleccionando datos de un data frame
##########################
mydata <- data.frame(patient=c("Smith", "Jones", "Williams"),
                     height=c(72, 61, 66),
                     diabetic=c(TRUE, FALSE, FALSE))

mydata[3,2]

mydata[1:2, "height"]

mydata[,"diabetic"]

######Ejercicio 4
##########################

mydata$height

mydata$height[2:3]

######Ejercicio 5
##########################

##Dando nombre a las columnas de un dataframe
##########################
colnames(mydata)

colnames(mydata) <- c("Patient", "Height", "Diabetic")
colnames(mydata)

colnames(mydata)[3] <- "Diabetes"
colnames(mydata)

##Examinando las dimensiones de un data frame
##########################
dim(mydata)

nrow(mydata)

ncol(mydata)

##Examinando la estructura de un objeto
##########################
str(mydata)

######Ejercicio 6
##########################

##filter()
##########################

dog_data <- data.frame(id = c("Duke", "Lucy", "Buddy", "Daisy", "Bear", "Stella"),
                       weight = c(25, 12, 58, 67, 33, 9),
                       sex=c("M", "F", "M", "F", "M", "F"),
                       location=c("north", "west", "north", "south", "west", "west"))



# dogs weighing more than 40
filter(dog_data, weight > 40)

# female dogs in the north or south locations
filter(dog_data, (location == "north" | location == "south") & sex == "F")

######Ejercicio 7
##########################


######Ejercicio 8
##########################

##select()
##########################
select(dog_data, id, sex)

select(dog_data, -c(id, sex))

######Ejercicio 9
##########################

more_dogs <- data.frame(id = c("Jack", "Luna"),
                        weight=c(38, -99),
                        sex=c("M", "F"),
                        location=c("east", "east"))
# appended dataset combines rows
all_dogs <- rbind(dog_data, more_dogs)
all_dogs 


######Ejercicio 10
##########################


##Añadiendo columnas usando una variable clave
##########################

dog_vax <- data.frame(id = c("Luna", "Duke", "Buddy", "Stella", "Daisy", "Lucy", "Jack", "Bear"),
                      vaccinated = c(TRUE, TRUE, TRUE, TRUE, TRUE, FALSE, FALSE, FALSE))

# id appears in both datasets, so will be used to match observations
dogs <- inner_join(all_dogs, dog_vax)
## Joining, by = "id"
dogs


######Ejercicio 11
##########################

##Valores faltantes
##########################
# a sum involving "undefined" is "undefined"
1 + 2 + NA

# NA could be larger or smaller or equal to 2
c(1, 2, 3, NA) > 2

# mean is undefined because of the presence of NA
dogs$weight

mean(dogs$weight)

sum(c(1,2,NA), na.rm=TRUE)

dogs$weight[dogs$weight == -99] <- NA
dogs$weight

x <- c(1, 2, NA)
is.na(x)

######Ejercicio 12
##########################

##Análisis de datos básico
##########################

bloodtest <- data.frame(id = 1:10,
                        gender = c("female", "male", "female", "female", "female", "male", "male", "female", "male", "female"),
                        hospital = c("CLH", "MH", "MH", "MH", "CLH", "MH", "MDH", "MDH", "CLH", "MH"),
                        doc_id = c(1, 1, 1, 2, 2, 2, 3, 3, 3, 3),
                        insured = c(0, 1, 1, 1, 0, 1, 1, 0, 1, 1),
                        age = c(23, 45, 37, 49, 51, 55, 56, 37, 26, 40),
                        test1  = c(47, 67, 41, 65, 60, 52, 68, 37, 44, 44),
                        test2 = c(46, 57, 47, 65, 62, 51 ,62 ,44 ,46, 61),
                        test3 = c(49, 73, 50, 64, 77, 57, 75, 55, 62, 55),
                        test4 = c(61, 61, 51, 71, 56, 57, 61, 46, 46, 46))
mean(bloodtest$age)

median(bloodtest$age)

var(bloodtest$age)

summary(bloodtest$test1)

##Correlaciones
##########################
cor(bloodtest$test1, bloodtest$test2)

# use dplyr select() to pull out just the test variables
scores <- select(bloodtest, test1, test2, test3, test4)
cor(scores)

######Ejercicio 13
##########################

##Tablas de frecuencia
##########################
table(bloodtest$gender)
prop.table(table(bloodtest$hospital))

my2way <- table(bloodtest$gender, bloodtest$hospital)
my2way

prop.table(my2way, margin=1)
prop.table(my2way, margin=2)

######Ejercicio 14
##########################

##Regresión lineal
##########################

# fit a linear model (ANOVA and linear regression)
m1 <- lm(test1 ~ age + gender, data=bloodtest)
# printing an lm object will list the coefficients only
m1


######Ejercicio 15
##########################

##Gráficos de dispersion
##########################

plot(bloodtest$test1, bloodtest$test2)

# factors are categorical variables with numeric codes and string labels
bloodtest$gender <- factor(bloodtest$gender)
plot(bloodtest$test1, bloodtest$test2, col=bloodtest$gender)

plot(bloodtest$test1, bloodtest$test2, 
     col=bloodtest$gender, 
     pch=17)

plot(bloodtest$test1, bloodtest$test2, 
     col=bloodtest$gender, 
     pch=17,
     xlab="Test 1",
     ylab="Test 2",
     main="Plot of Test1 vs Test2")

plot(bloodtest$test1, bloodtest$test2, 
     col=bloodtest$gender, 
     pch=17,xlab="Test 1",
     ylab="Test 2",
     main="Plot of Test1 vs Test2")
# specifies placement, labels, color, and symbol in legend box
legend("topleft", legend=levels(bloodtest$gender), col=c(1:2), pch=17)


######Ejercicio 16
##########################

##Histogramas
##########################

hist(bloodtest$test1)

hist(bloodtest$test1, breaks=2)

##Diagramas de caja
##########################

boxplot(bloodtest$test2 ~ bloodtest$insured)

boxplot(bloodtest$test2 ~ bloodtest$insured,
        xlab="Insured",
        ylab="Test 2",
        main = "Boxplots of Test2 by Insurance Status",
        col="lightblue")

##Gráficos de barras
##########################
tab <- table(bloodtest$gender, bloodtest$hospital)
barplot(tab,legend.text = TRUE)

ab <- table(bloodtest$gender, bloodtest$hospital)
barplot(tab, 
        legend.text = TRUE,
        beside=TRUE,
        col=c("lawngreen", "sandybrown"),
        xlab="Hospital",
        ylab="Frequency",
        main="Frequencies of gender by hospital")


######Ejercicio 17
##########################

##Introduccion a ggplot2
##########################

# a scatterplot of math vs write
ggplot(data=dat_csv, aes(x=math, y=write)) + 
  geom_point()

# a scatterplot of math vs write with best fit line
ggplot(dat_csv, aes(x=math, y=write)) + 
  geom_point() +
  geom_smooth(method="lm")
## `geom_smooth()` using formula 'y ~ x'

# a scatterplot and best fit line, by gender
#  color affects the best fit line, fill affects the confidence intervals
ggplot(dat_csv, aes(x=math, y=write, color=female, fill=female)) + 
  geom_point() +
  geom_smooth(method="lm")
## `geom_smooth()` using formula 'y ~ x'

ggplot(dat_csv, aes(x=math, y=write, color=female, fill=female)) + 
  geom_point() +
  geom_smooth(method="lm") +
  facet_wrap(~prog)

######Ejercicio 18
##########################

