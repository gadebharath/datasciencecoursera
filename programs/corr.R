corr<-function(directory = getwd(), threshold = 0)
{
  index = 1;
  returnVal <- c()
  for(i in list.files(directory))
  {
    filePath <- file.path(directory,i)
    data <- read.csv(filePath)
    cleanData <- data[rowSums(is.na(data)) == 0,]
    if(nrow(cleanData) > threshold)
    {
      sulfateValues <- cleanData[,"sulfate"]
      nitrateValues <- cleanData[,"nitrate"]
      returnVal <- c(returnVal,cor(sulfateValues, nitrateValues))
    }
  }
  returnVal
}
