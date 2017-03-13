Code Book

This document describes the code inside run_analysis.R.

The first section reads in the data which can be downloaded here: 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
It then combines the data together.  It does this seperately for the Subject Data and the Target (Y) data.

The code then extracts just the necessary mean and standard deviation measures
  Utilizing "Grep".  For more info: https://stat.ethz.ch/R-manual/R-devel/library/base/html/grep.html
  
The code then renames some variables to make it easier to understand what's going on.  \

Finally, a second tidy dataset is created which uses a "for" loop.
