pollutantmean<-function(directory = getwd(), pollutant, id = 1:332)
{
  #This vector is to collect the values from different files
  consolidatedValues <- c()
  for(i in id)
  {
    fileNameWithLeadingZeros = sprintf("%03d", i)
    fileName = paste(fileNameWithLeadingZeros, ".csv", sep = "")
    filePath <- file.path(directory,fileName)
    data <- read.csv(filePath)
    values <- data[,pollutant]
    cleanValues <- values[!is.na(values)]
    consolidatedValues <- c(consolidatedValues, cleanValues)
  }
  meanValue <- mean(consolidatedValues)
  #Example output has mean rounded to three decimal places.
  round(meanValue, 3)
}
