library(tidyverse)
library(readxl)
library(ggpubr)
library(gridGraphics)
library(glmnet)
library(caret)
library(ROCR)
source("scripts/helper_functions.R")

ensure_dir("figures")
ensure_dir("outputs")

pdf(NULL)

set.seed(1128)

all_predictive_data <- read_csv("derived_data/all_predictive_data.csv") %>%
  mutate(GDP_level = factor(ifelse(GDP_per_capita > median(GDP_per_capita),
                                   "High", "Low"), levels = c("Low", "High")))

# Train elastic net model to predict high/low GDP

explanatory <- all_predictive_data %>% 
  select(GHG_per_capita_emissions, Energy_per_capita, 
         Renewable_energy_percent, Agricultural_area_percent, 
         Forest_area_percent, Protected_area_percent) %>% names()
formula <- as.formula(sprintf("GDP_level ~ %s", 
                              paste(explanatory, collapse=" + ")))

split <- createDataPartition(all_predictive_data$GDP_level, p = 0.6)
training_data <- all_predictive_data %>% slice(split$Resample1)
testing_data <- all_predictive_data %>% slice(-split$Resample1)

cv_10 <- trainControl(method = "cv", number = 10)
model <- train(formula, data = training_data, method = "glmnet", 
               metric = "Accuracy", trControl = cv_10)

saveRDS(model, "outputs/GDP_elasticnet_model.rds")

saveRDS(predict(model$finalModel, type = "coefficients", s = model$bestTune$lambda), 
        "outputs/GDP_elasticnet_coefficients.rds")

# Model performance

pred_train <- prediction(predict(model, newdata = training_data, type = 'prob')$High,
                         labels = training_data %>% pull(GDP_level),
                         label.ordering = c("Low", "High"))
pred_test <- prediction(predict(model, newdata = testing_data, type = 'prob')$High,
                        labels = testing_data %>% pull(GDP_level),
                        label.ordering = c("Low", "High"))

auc_train <- signif(performance(pred_train, measure = 'auc')@y.values[[1]][1], 2)
auc_test <- signif(performance(pred_test, measure = 'auc')@y.values[[1]][1], 2)

perf_train <- performance(pred_train, measure = 'tpr', x.measure = 'fpr')
perf_test <- performance(pred_test, measure = 'tpr', x.measure = 'fpr')

roc_plot <- plot_ROC(perf_train, perf_test, auc_train, auc_test, "Training", "Testing")

coef_plot <- plot_coef(model)

figure <- ggarrange(plotlist = list(roc_plot, coef_plot), nrow = 1, ncol = 2,
                    labels = c("A", "B"), widths = c(1.2, 1))

ggsave("figures/GDP_elasticnet_figures.png", 
       width = 10, height = 5, plot = figure, bg = "white")
