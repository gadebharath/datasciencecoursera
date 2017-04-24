complete<-function(directory = getwd(), id = 1:332)
{
  completeMatrix <- matrix(ncol = 2)
  index <- 0
  for(i in id)
  {
    fileNameWithLeadingZeros = sprintf("%03d", i)
    fileName = paste(fileNameWithLeadingZeros, ".csv", sep = "")
    filePath <- file.path(directory,fileName)
    data <- read.csv(filePath)
    
    cleanData <- data[rowSums(is.na(data)) == 0,]
    numComplete <- nrow(cleanData)
    completeMatrix <- if(index ==0)
    {
      rbind(c(i,numComplete))
    }
    else
    {
      rbind(completeMatrix, c(i,numComplete))
    }
    index <- index + 1
  }
  completeFrame <- as.data.frame(completeMatrix)
  colnames(completeFrame) <- c("id","nobs")
  completeFrame
}
