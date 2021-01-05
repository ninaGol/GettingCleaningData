# GettingCleaningData

- The training and the test data sets are merged (including the different labels and subject numbering)
The following (provided) files were read in R and merged: 'features.txt', 'activity_labels.txt', 'train/subject_train.txt', 'train/X_train.txt', 'train/y_train.txt', 'test/X_test.txt', 'test/y_test.txt'
- in the merging step, the variable names are already renamed to more descriptive labels (see task 4)
- then all the variables with mean or standard deviation are filtered
- the activity labels are used for better understanding
- a data set with the averages of all variables (from the previous step) per subject and activity is created
- last data set is exported as csv file (tidyData.csv)
