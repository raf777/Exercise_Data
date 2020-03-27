
# Import the data from locally stored .xlsx file
library(readxl)
data <- read_xlsx(path = "C:/Users/Cillian Admin/OneDrive/Desktop/Data Projects/Workout_Data/Workout.xlsx",
          range = "A1:I17")


#----Data Cleaning-----
library(dplyr)

data <- as.data.frame(data)
str(data)

#changing columns types 
data$Weight <- as.double(data$Weight)
data$Cardio <- as.factor(data$Cardio)
data$Type <- as.factor(data$Type)
data$Day <- as.factor(data$Day)

#Changing column names
colnames(data) <- c("Date", "Day", "Minutes", "Calories", "Average.HR", "Highest.HR", "Weight", "Cardio", "Type")

data[11,7] <- 89.9
data[14,7] <- 90.3

#----Feature engineering-----
data$Calorie.Per.Min <- round(data$Calories / data$Minutes,2)


#----Data Vis-----
library(ggplot2)

#---some LMs
ggplot(data = data, aes(y = data$Calorie.Per.Min, x = data$Highest.HR 
                        )) +
        geom_point(na.rm = T, size = 5) +
        geom_smooth(method = "lm", formula = y ~ x)

ggplot(data = data, aes(x = data$Minutes, y = data$Calories 
                        )) +
        geom_point(na.rm = T, size = 5) +
        geom_smooth(method = "lm", formula = y ~ x)


#------
ggplot(data = data, aes(x = Calories, y = Average.HR, 
                        color = Day)) +
        geom_point(na.rm = T, size = 5)

#----Days
ggplot(data = data, aes(x = Day, fill = Day)) +
        geom_histogram(stat = "count", color = "Black")

#---Weight
ggplot(data = data, aes(x = Date, y = Weight)) +
        geom_point(size = 3, shape = 15, color = "Red") + 
        geom_line(na.rm = T, linejoin = "round", linetype = 1, size = 1,
                  color = "Blue1") +
        ylim(85,95)

#----Facet

ggplot(data = data, aes(x= Calories),) + 
        geom_histogram(binwidth = 50, aes(fill = Day)) +
        facet_grid(Day~., scales = "free") +
        ylab()
        






