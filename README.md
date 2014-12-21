Getting-and-Cleaning-Data
=========================

---

**NOTE: THIS README files also exists in Rmarkdown html output.  It may be easier to see 
text instructions and the associated code side by side.**

In the code in the run_analysis.R file, we first create a folder in the working directory 
called **projectdata**, and then download and unzip the files associated with the project 
using the provided URL.


Now, we begin reading the various tables in.  We read tables on the files in the 'test' &
'train' folders and store them as **xtest, xtrain, ytest, ytrain, subtest, subtrain.**

We also read in the files that we want to variable names for the columns of the data frame
("features.txt"), and as activity labels for the rows in my activity column 
("activity labels").

Now we can begin with the steps of the assignment.


**1.  Merges the training and the test sets to create one data set.**
For this, merge the train and test files, by rows.  So append **'xtest'** to **'xtrain'**
using *rbind()* 

And then give names to the columns, using the values in column 2 from the data frame in 
the "features.txt" file.

Merge the **'ytrain' 'ytest'** as well as  **'subtrain' 'subtest'** files in the same way
and give the name "activity" to the column in the merged y files, and "subject" to the 
column in the merged subject files.
Merge the three datasets into one large dataset using *cbind()*.


**2. Extracts only the measurements on the mean and standard deviation for 
each measurement.**
Use a basic command that we use on data frames to select specific rows and columns 
*data.frame[rows, columns]*.  
However, for the 'columns' argument, use the *grep()* function,and a variety of meta 
characters to extract all columns that match the pattern **mean()** and **std()** in the
column header.  Also extract  **activity** and **subject** columns.


**3. Uses descriptive activity names to name the activities in the data set** 
The 'activities' correspond to the values in the 'y' files.  We have already added this 
column and named it "activity" above.  But we need to make them "descriptive", right now 
they are number values between 1 and 6.  
Use the second column of the data frame in "activity_labels.txt" *.  Then factor
"activity" column, the last column in data frame, which currently has the class = integer.


**4. Appropriately labels the data set with descriptive variable names.**
This was partially taken care when we used "features.txt" to give column titles. But we 
need to clean up the column titles of typos, any unnecessary character, 
and eliminate abbreviations don't to avoid guesswork.  Use the *gsub()* command.


**From the data set in step 4, creates a second, independent tidy data set with the 
average of each variable for each activity and each subject.**
We have to make a second data frame using the variables (columns) and values (rows) from 
the dataset we have thus far.

Use the *""dplyr package""*. Then, simply group the data frame by "subject" first and 
"activity" second, storing the grouped data in a new dataframe. Use *group_by()*.

Then summarize each of the variables, to get just one value that averages the selected 
variables (66 variables that are measurements of mean and std) for each of the six 
activities and each of the 30 volunteers. Use *summarize_each()*.

We should get a dataframe of 180 rows and 68 columns.

