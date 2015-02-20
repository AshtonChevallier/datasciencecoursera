Read Me File for Data Cleaning Course Project
===================
The run_Analysis.R is a stand alone file that should download the Samsung Acceleromter data into a new directory in your current working directory. If it's already there it will skip that part.

The script first loads the label and feature data for later use.
Next we load the Y data, combine the training and test data sets, and remove the extra variables from memory. We repeat the same process for the subject and X data.

We next extract the length of the total Observations to create a sequence to make matching IDs in each of datasets. This way we can ensure correct matches when merging data.

Next we rename the X Labels to be descriptive by setting the names function to the features.

Next we use the grepl function to match and extract the X Labels with mean or std observation; excluding meanFreq obeservations.

Next, we Insert ID variables to prepare for merging

Next, we rename Subject Labels to avoid mixing up column names

First we Merge and Rename Y Labels to create the first tidyData set.

Then we merge Subject Data.

Last we add in the X Data. At this point we have created a clean, tidy data set.

Finally, Use Group By and summarize to make a second data set of means for each subject and activity pair.

As a final touch, we trim Uneeded Columns from our 2 data sets.

