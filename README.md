# Project_Getting-and-Cleaning-Data

## Explanation for the run_analysis.R script work
The script works with 6 different phases:

### 1.Create new folder for analysis and create general URL for downloads
* Check if Data folder exist and if not create the folder
* The Url will general for all downloads and link to raw.githubusercontent.com on my Repo --- Download take a bit time !

### 2.Download data from my Github web page into new folde called "Data" on the working directory.Files are then loaded into R in order to be manipulated and thus creating several data.frame to be manipulated by the script.
* First set of downloads/Reads are test data - They are then combine in unique Test.data removing the older data.frames
* Second set of downloads/Reads are train data

### 3.Create the global data set
* Combine both previous Test and train datasets
* Download and read columns names thanks to features.txt files
* Renames colomn names

### 4.Extract from Global data set only the variables we are interested in: Mean & Std
* Create to research vectors (mean_vector & std_vector) which are logical vectors pointing towards the location of desired columns.
* Apply this vector to Global_data to extract only the required columns ising subset function - create subset_data
* Again remove the old Global_Data set

### 5.Create a clean vector to work on
* Download and read activities labels from activity_labels.txt file
* Use for function + subsetting to rename all activity lablels inside clean_data
* Again remove the old Subset_Data set

### 6.Create the final clean & tidy dataset with mean of columns 
* On clean_data: group by activies & subject, summarize each column with mean function
* Write this new final_dataset inside the required "Clean&Tidy.txt" file
* Remove the remaining vectors & logicals and let the working environment clean
