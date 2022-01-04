### Clear the environment 
rm(list = ls())


### First we will set the directory of the R script 
setwd("C:/Users/anike/Desktop/Sem 1/EAS 506 Statistical Data Mining/Homework/Homework 5")


## loading the important libraries 
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
library(plotly)
library(rpart)
#install.packages("randomForest")
library(randomForest)
#install.packages("neuralnet")
library(neuralnet)
#install.packages('fastDummies')
library(fastDummies)


#Importing dataset 
load('cleveland.RData')
data1 <- cleveland

dim(data1)
head(data1 , 2)

# diag2 here can be disregarded 
data1 <- subset(data1, select = c(1:14))
head(data1 , 2)
table(data1$diag1)

#setting seed and dividing dataset into test and train dataset 
set.seed(1)
test_index <- sample(1:nrow(data1), .2 * nrow(data1))
test_data <- data1[test_index, ]
train_data <- data1[-test_index, ]
y_test_true <- test_data$diag1
y_train_true <- train_data$diag1


#CART
set.seed(1)
model.control <- rpart.control(minsplit = 5,xval = 10 , cp = 0 )
dt.fit <- rpart (diag1~. , data = train_data , method = "class" , control = model.control)

# plotting the decision tree 
x11()
plot(dt.fit)
text(dt.fit , use.n = TRUE , cex = 1)

# prune the tree back 
min_cp = which.min(dt.fit$cptable[,4] )

x11()
plot(dt.fit$cptable[,4] , main = " Cp for model selection" , ylab = " cv error")

pruned_fit <- prune(dt.fit , cp = dt.fit$cptable[min_cp , 1])

#plotting the prune fit 
x11()
plot(pruned_fit)
text(pruned_fit , use.n = TRUE , cex = 1)

#Compute test error for a single tree 
y_hat_dt <- predict(pruned_fit , newdata = test_data , type = "class")
table(y_hat_dt , y_test_true)

# test error : 25.42%
mean(y_test_true != y_hat_dt) * 100




#Random Forest 
set.seed(1)
rf.fit <- randomForest(diag1~. , data = train_data , ntree = 750 )
?randomForest
x11()
varImpPlot(rf.fit, main='Main Features')

importance(rf.fit)

#Predicting the test error

y_hat_rf <- predict(rf.fit , newdata = test_data , type = "response") 
table(y_hat_rf , y_test_true)

#Test Error: 11.86441
mean(y_test_true != y_hat_rf) * 100



#Neural Network 

#AS neural network only takes numeric values as input and our data contains of a lot of categorical variables 
# i first need to convert these variables into numerics. 

train_nn <- dummy_cols(train_data , select_columns = c('gender', 'cp' , 'restecg' , 'exang' , 'slope' , 'thal' , 'fbs'),remove_selected_columns = TRUE)
test_nn <- dummy_cols(test_data,select_columns = c('gender', 'cp' , 'restecg' , 'exang' , 'slope' , 'thal' , 'fbs'),remove_selected_columns = TRUE )

# source : https://www.marsja.se/create-dummy-variables-in-r/

# converting response variable into 0 and 1. if 'buff' : 0 and if 'sick' then 1.
train_data_diag1 <- as.numeric(train_data$diag1) -1 
test_data_diag1 <- as.numeric(test_data$diag1) -1 


train_nn <- subset(train_nn , select = c(-7))
test_nn <- subset(test_nn , select = c(-7))

train_nn <- cbind(train_nn , train_data_diag1)
test_nn <- cbind(test_nn, test_data_diag1)

names(train_nn)[26] <- 'diag1'
names(test_nn)[26] <- 'diag1'

y_hat_nn_test <- test_nn$diag1


# running neural net in loop 


test_error_store <- c()

set.seed(1)
for (i in 1:5) {
  #fit the neural network with "i" neurons
  nn1 <- neuralnet(diag1~. , data = train_nn , hidden = i , stepmax = 10^9 , err.fct = "ce" , linear.output = FALSE)
  
  #saving plots
  p = plot(nn1)
  ggsave(p , file = paste0("neural net plot" , i ,".png"), width = 40, height = 40, units = "cm")

  #calculate the train error 
  pred_nn <- predict(nn1 , newdata = test_nn)
  y_hat_test_nn <- round(pred_nn)
  test_err <- length(which(y_hat_nn_test != y_hat_test_nn)) / length (y_hat_test_nn)
  test_error_store <- c(test_error_store , test_err)
  
}

test_error_store

which.min(test_error_store) # neural net with 5 hidden layers has the least error rate 

