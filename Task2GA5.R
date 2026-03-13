R version 4.5.2 (2025-10-31 ucrt) -- "[Not] Part in a Rumble"
Copyright (C) 2025 The R Foundation for Statistical Computing
Platform: x86_64-w64-mingw32/x64

R is free software and comes with ABSOLUTELY NO WARRANTY.
You are welcome to redistribute it under certain conditions.
Type 'license()' or 'licence()' for distribution details.

Natural language support but running in an English locale

R is a collaborative project with many contributors.
Type 'contributors()' for more information and
'citation()' on how to cite R or R packages in publications.

Type 'demo()' for some demos, 'help()' for on-line help, or
'help.start()' for an HTML browser interface to help.
Type 'q()' to quit R.

[Previously saved workspace restored]

> library(e1071)
> 
  > # load dataset
  > wbcd <- read.csv("wdbc.csv")
> 
  > # remove the last empty column if it exists
  > wbcd <- wbcd[, colSums(is.na(wbcd)) < nrow(wbcd)]
> 
  > # convert diagnosis to factor
  > wbcd$diagnosis <- as.factor(wbcd$diagnosis)
> 
  > # remove ID column
  > wbcd <- wbcd[, -1]
> 
  > # make column names valid for formulas
  > names(wbcd) <- make.names(names(wbcd))
> 
  > # split data
  > set.seed(1)
> train <- sample(1:nrow(wbcd), nrow(wbcd)/2)
> 
  > train_data <- wbcd[train, ]
> test_data  <- wbcd[-train, ]
> 
  > # train SVM with linear kernel
  > svm_model <- svm(diagnosis ~ ., data = train_data,
                     +                  kernel = "linear", cost = 1)
> 
  > # predictions
  > pred <- predict(svm_model, newdata = test_data)
> 
  > # confusion matrix
  > table(Predicted = pred, Actual = test_data$diagnosis)
Actual
Predicted   B   M
B 160   7
M   6 112
> 
  > # error rate
  > mean(pred != test_data$diagnosis)