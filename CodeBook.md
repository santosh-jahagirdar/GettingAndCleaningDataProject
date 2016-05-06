# Detailed Code Book

The script `run_analysis.R`performs the 5 steps described in the project assignment.

* The activity ids and names are read into the variable 'activity_master'
* The feature ids and names are read into the variable 'features_master'
* This is then filtered to include only mean, std measures and stored in 'filtered_features_master' variable
* The indices and names are then unlisted to be stored in vectors 'filteredFeaturesColIndices' and 'filteredFeaturesColNames'
* The training data, training subjects and training activities are read and merged (column binding) to a single dataset variable 'training_data_set'
* Likewise, the testing data, testing subjects and testing activities are read and merged (column binding) to a single dataset variable 'testing_data_set'
* The above datasets are then row merged to form a single consolidated dataset by the name 'combined_data_set'
* The column names to this dataset are provided using the 'filteredFeaturesColNames' vector created before
* Using dplyr package's group_by and summarize_each functions, a new dataset that contains the mean value of each observation for each subject,activity combination is created and stored as 'tidy_data_set'
* The activity ids in the dataset are replaced by the appropriate activity names
* Finally the 'tidy_data_set' variable is written to a file 'tidied_mean_data.txt'