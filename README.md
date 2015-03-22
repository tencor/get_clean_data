
Dear Peer.

This script allows to tidy and aggregate the file indicated by our instructor. 

The structure of the script is very simple:

- First of all the script calls sveral libraries.
- Then it test if the folder 'data' exists. This folder will contain:
  > the zipped file downloaded from the web
  > the folder structure unzipped from the previous zip file.
- The next sets load into several variables the content of the files 
  > The activity labels, the features and the training and testing sets.
- Next step: we give the name to each measure (testing and training data).
- Then we select the target measures using grepl function
- Then we assign the name of each activity to the y's files 
  (we add another field with the origin (test/train))
- We assign to the y's vars the subject, the activity label, 
  we append that variables and we name the columns.
- We concatenate the x's variables (training and testing)
- We select the target measurements from the previous x's variables.
- We merge y data and x data (myset cotains the tidy data)
- Then we calculate de averages of each target measures
- Finally we write the tidy dat, the aggregated data and the timestamp of
  the data capture.
  
  Prerrequsites:
  - No folder called 'data' might exists in the working directory.
    If it exists no file will be downloade.
  Results:
  - aggregated_result.txt: Set of data with the averages of the target measurements,
    group by Subject and Activity.
  - non_aggregated_result.txt. Set of data with the target measurements, row by row.
  - result_date.txt: Time stamp of the data capture.
   