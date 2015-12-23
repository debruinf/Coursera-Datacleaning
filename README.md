# Coursera-Datacleaning

The script ```run_analysis.R``` does the following:

1. Loads data files from the ```UCI HAR Dataset``` - as long as it exists in the working directory
2. Merges the training and test data
3. Selects the mean and standard deviation variables
4. Transforms the variable names, removes ```()``` and changes ```-``` to ```_```
5. Takes the mean value per subject-activity pair
6. Stores and writes the new data frame in ```dataMeans.csv``` in the working directory


