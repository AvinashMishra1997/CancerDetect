library("dplyr")
library("readr")
library("ggplot2")
library("corrplot")
library("pROC")
library("MASS")
library("caTools")
library("caret")
library("gbm")
library("rpart")


data <- read.csv("~/CancerDetect/data.csv")
View(data)
str(data)
data$diagnosis <- as.factor(data$diagnosis)
data[,33] <- NULL
summary(data)
prop.table(table(data$diagnosis))
corr_mat <- cor(data[,3:ncol(data)])
corrplot(corr_mat)
set.seed(1234)
data_index <- createDataPartition(data$diagnosis, p=0.7, list = FALSE)
train_data <- data[data_index, -1]
test_data <- data[-data_index, -1]
fitControl <- trainControl(method="cv",
                           number = 5,
                           preProcOptions = list(thresh = 0.99), # threshold for pca preprocess
                           classProbs = TRUE,
                           summaryFunction = twoClassSummary)
set.seed(1)
to_pred <- list(radius_mean=20,texture_mean=30,perimeter_mean=40,area_mean=50,smoothness_mean=60,compactness_mean=70,concavity_mean=80,concave.points_mean=90,symmetry_mean=100,fractal_dimension_mean=10,radius_se=111,texture_se=1111,perimeter_se=1111,area_se=1111,smoothness_se=1111,compactness_se=1111,concavity_se=1111,concave.points_se=1111,symmetry_se=1111,fractal_dimension_se=1111,radius_worst=1111,texture_worst=1111,perimeter_worst=1111,area_worst=1111,smoothness_worst=1111,compactness_worst=1111,concavity_worst=1111,concave.points_worst=1111,symmetry_worst=1111,fractal_dimension_worst=1111)

#Random Forest
model_rf <- train(diagnosis~.,
                  train_data,
                  method="ranger",
                  metric="ROC",
                  #tuneLength=10,
                  #tuneGrid = expand.grid(mtry = c(2, 3, 6)),
                  preProcess = c('center', 'scale'),
                  trControl=fitControl)
pred_rf <- predict(model_rf, test_data)
print(pred_rf)
cm_rf <- confusionMatrix(pred_rf, test_data$diagnosis, positive = "M")
print(cm_rf)
pred1<-predict(model_rf,to_pred)
print(pred1)

#cart model

set.seed(1)
cart_model <- train(diagnosis ~ ., train_data, method="rpart")
pred2 <- predict(cart_model,to_pred)
print(pred2)



#boosted tree
gbm_model <- train(diagnosis ~ ., train_data, method="gbm", verbose=FALSE)
gbm_model
gbm_model$finalModel
pred_bt <- predict(gbm_model, test_data)
confusionMatrix(pred_bt, test_data$diagnosis, positive="M")
pred3 <- predict(gbm_model, to_pred)
print(pred3)

