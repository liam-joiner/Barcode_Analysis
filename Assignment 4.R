library(sangerseqR)
library(seqinr)
library(dplyr)

#Reduces data to just the name of the files that pass the quality check
data<-read.csv("BarcodePlateStats.csv")
QualityCheckData<-filter(data, Ok == "TRUE")
Y<- QualityCheckData$Chromatogram

#creates vector of all .ab1 file names
data.ab1 <- dir(pattern = "*.ab1")

#subsets the list of .ab1 files to just those that pass the quality check
Z<-subset(data.ab1, data.ab1 %in% Y)

#creates a vector for the for loop to put outputs in
output<- ?vector("list", ncol(Z))

#makes the vector output contain just the base pairs of the primary sequences
for (i in length(Z)){
  name <-paste(Z, i,)
  ITS<-read.abif(name)
  ITSseq <- sangerseq(ITS)
  SeqX<-makeBaseCalls(ITSseq)
  final<-sub(".*Primary Basecalls:\\s* (.*) *\\n*", "\\1", SeqX)
  output[i]<-final
  }
