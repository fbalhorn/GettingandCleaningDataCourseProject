# GettingandCleaningDataCourseProject
My solution for the Getting and Cleaning Data Course Project

The R script run_analysis.R creates a neat and tidy dataset according to the task descriptions. I technically do NOT follow the steps 1-5 in specific and individual order. Nevertheless, I end up with a dataset as asked for.

First the data is loaded into appropriate variables. As a second step the test and training datasets are merged together by the X and Y prefix using rbind, respectively.

For the Y prefix, the indices, i.e. the activity codes, are exchanged with the respective activity labels.

The subject id is included in the column subject_id and the activity is coded in activity_code.

Using the package reshape2 and the melt function, both the fields activity_code and subject_id are declared as ids and the mean is calculated for the respective remaining variables.

Finaly, the output file is written using write.table()
