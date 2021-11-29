library(tidyverse)
library(readxl)
library(glmnet)
library(caret)
library(ROCR)
source("scripts/helper_functions.R")

ensure_dir("figures")
ensure_dir("logs")

set.seed(1128)

all_predictive_data <- read_csv("derived_data/all_predictive_data.csv") %>%
  mutate(Happiness_level = factor(ifelse(Happiness_score > median(Happiness_score),
                                  "High", "Low"), levels = c("Low", "High"))) %>%
  mutate(GDP_level = factor(ifelse(GDP_per_capita > median(GDP_per_capita),
                                  "High", "Low"), levels = c("Low", "High")))

# Train elastic net model to predict high/low happiness score

explanatory <- all_predictive_data %>% 
  select(GHG_per_capita_emissions, Energy_per_capita, 
         Renewable_energy_percent, Agricultural_area_percent, 
         Forest_area_percent, Protected_area_percent) %>% names()
formula <- as.formula(sprintf("Happiness_level ~ %s", 
                              paste(explanatory, collapse=" + ")))

split <- createDataPartition(all_predictive_data$Happiness_level, p = 0.6)
training_data <- all_predictive_data %>% slice(split$Resample1)
testing_data <- all_predictive_data %>% slice(-split$Resample1)

cv_5 <- trainControl(method = "cv", number = 10)
model <- train(formula, data = training_data, method = "glmnet", 
             metric = "Accuracy", trControl = cv_5)

con <- file("logs/GDP_elasticnet_model.txt")
sink(con, append=TRUE)
model
close(con)

# Model performance
pred_train <- prediction(predict(fit, newdata = training_data, type = 'prob')$Low,
                         labels = training_data %>% pull(Happiness_level))
pred_test <- prediction(predict(fit, newdata = testing_data, type = 'prob')$Low,
                        labels = testing_data %>% pull(Happiness_level))

auc_train <- signif(performance(pred_train, measure = 'auc')@y.values[[1]][1], 2)
auc_test <- signif(performance(pred_test, measure = 'auc')@y.values[[1]][1], 2)
