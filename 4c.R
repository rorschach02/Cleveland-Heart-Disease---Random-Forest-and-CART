### Clear the environment 
rm(list = ls())


### First we will set the directory of the R script 
setwd("C:/Users/anike/Desktop/Sem 1/EAS 506 Statistical Data Mining/Homework/Homework 4")



## Loading all the libraries 
library(ISLR)
library(corrplot)
library(MASS)
library(klaR)
library(leaps)
library(lattice)
library(ggplot2)
library(corrplot)
library(car)
library(caret)
library(class)

## Loading the dataset 

data('Auto')
head(Auto)

median_value <- median(Auto$mpg)
median_value

mpg01 <- ifelse(Auto$mpg > median_value,1,0)
Auto <- subset(Auto, select = c(2:9))
Auto <- cbind(mpg01, Auto)
Auto <- subset (Auto , select = -(9))
head(Auto,3)

# EDA 

#Histogram
x11()
par(mfrow = c(4,2))
for( i in 1:8){
  hist(Auto[,i], main = colnames(Auto)[i],xlab = colnames(Auto)[i], col = 'yellow')
}

colnames(Auto)

#Boxplot 
x11()
par(mfrow = c(2,2))
boxplot(cylinders~mpg01, ylab="cylinders", xlab= "mpg01", col="light blue",data = Auto)
boxplot(displacement~mpg01, ylab="displacement", xlab= "mpg01", col="light blue",data = Auto)
boxplot(horsepower~mpg01, ylab="horsepower", xlab= "mpg01", col="light blue",data = Auto)
boxplot(weight~mpg01, ylab="weight", xlab= "mpg01", col="light blue",data = Auto)


# Scatterplots
x11()
scatterplotMatrix(~mpg01+cylinders+displacement+horsepower+weight, data=Auto, main="Scatterplot Matrix with Features : cylinders+displacement+horsepower+weight")

x11()
scatterplotMatrix(~mpg01+acceleration+year+origin, data=Auto, main="Scatterplot Matrix with Features : acceleration+year+origin")


# Co-relation Plot 
x11()
corrplot(cor(Auto) , method = 'number')
#Seems like cylinders, displacement, horsepower and weight are highly negatively co-related to mpg 
#whereas acceleration, year and origin are highly positively co-related to mpg. 


# Splitting data into training and test set: 
set.seed(1)
trainIndex <- createDataPartition(Auto$mpg, p = 0.80,list =FALSE,times = 1)
train_data <- Auto[trainIndex,]
test_data <- Auto[-trainIndex,]
dim(train_data)
dim(test_data)


#Performing LDA
lda.model <- lda(mpg01~cylinders+displacement+horsepower+weight, data=train_data)
lda.model


#Predicting results.
pred.lda.model = predict(lda.model, newdata = test_data )
table(Predicted=pred.lda.model$class, Survived=test_data$mpg01)
test_pred_y <- pred.lda.model$class
# Error: 
mean(test_data$mpg01 != test_pred_y)


# Performing QDA
qda.model <- qda (mpg01~cylinders+displacement+horsepower+weight, data=train_data)
qda.model

#Predicting results.
pred.qda.model <- predict(qda.model , newdata = test_data)
table(Predicted=pred.qda.model$class, Survived=test_data$mpg01)
qda_test_pred_y = pred.qda.model$class

#Error: 
mean(test_data$mpg01 != qda_test_pred_y)


#Performing Logistic Regression 
logistic_reg <- glm(mpg01~cylinders+displacement+horsepower+weight,data = train_data, family = binomial)
logistic_reg
summary(logistic_reg)

#Predicting Results
logistic_reg_pred_model = predict(logistic_reg, newdata = test_data, type="response")
pred_values = rep(0, length(test_data$mpg01))
pred_values[logistic_reg_pred_model > 0.5] = 1

table(Predicted= pred_values , Survived = test_data$mpg01)

#Error:
mean(test_data$mpg01 != pred_values)


# Performing KNN: 
x_train <- subset(train_data , select = -c(1))

x_test <- subset(test_data , select = -c(1))

# k = 1
set.seed(123)
testing_knn <- knn(x_train , x_test , train_data$mpg01 , k=1)
confusion_matrix_knn <- table(testing_knn , test_data$mpg01)
confusion_matrix_knn1<- confusionMatrix(confusion_matrix_knn)


# Accuracy of KNN is : 83.33
round(confusion_matrix_knn1$overall[1]*100 , digits = 2)


# k = 5

set.seed(123)
testing_knn1 <- knn(x_train , x_test , train_data$mpg01 , k=5)
confusion_matrix_knn2 <- table(testing_knn1 , test_data$mpg01)
confusion_matrix_knn3<- confusionMatrix(confusion_matrix_knn2)

# Accuracy of KNN is : 84.62
round(confusion_matrix_knn3$overall[1]*100 , digits = 2)

# k = 10 

set.seed(123)
testing_knn2 <- knn(x_train , x_test , train_data$mpg01 , k=10)
confusion_matrix_knn4 <- table(testing_knn2 , test_data$mpg01)
confusion_matrix_knn5<- confusionMatrix(confusion_matrix_knn4)
confusion_matrix_knn5
# Accuracy of KNN is : 83.33
round(confusion_matrix_knn5$overall[1]*100 , digits = 2)
