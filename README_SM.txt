README - SM 

Grab all the Data and create data frames so I can manipulate the data. Each file turns into a LOT of observations of 128 variables
they all have 128 variables, and 2947 observations, so that must be how all the data syncs up. 
I think each column/variable is a uniqe variable listed in the features document. 

ID mean and std dev data
	Features- items 1,2,3,4,5,6,41,42,43,44,45,46,81,82,83,8485,86,121,122,123,124,125,126,161,162,163,164,165,166,201,202
	X.Test and X.Train have the same # of variables as listed in features, so it's a direct correlation, attach vertically, lined up by variable
	Y.Test adn Y.Train have the same # of observations as their respective X document, I believe these are the Activity numbers (will replace with the 
	
Extract mean and std dev data
	make a string for easier data extraction
	relevant<- c(numbers listed above) 
	go ahead and make another string with all the column names
	Make another list for the generic column names V1, V2, V3....

Add all the data together in a data frame. 
	Use the Relevant list to extract the relevant data
	use the list of generic column names and variable names to rename the columns

Gather the Activity and subject data. 
	gsub to replace the activity names
	join factor names to the data table of relvant columns 
