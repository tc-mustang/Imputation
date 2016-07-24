#### Comparing WGS with GBS markers ###

############################################################################################################

######### Compare 5 cassavas WITH FILTERED AR DATA  ############

############################################################################################################

setwd("/home/DB2/Imputation/BEAGLE_imputation/correspondence/Imputation_v2/validation_filter/")
                     
GBS3 <- read.delim("f03.DS.FORMAT")
GBS5 <- read.delim("f05.DS.FORMAT")

WGS <- read.delim("reference.DS.FORMAT")

WGS[,1] <- paste("S",WGS[,1],"_", WGS[,2], sep="") 
rownames(WGS) <- WGS[,1]
WGS <- WGS[,-1]
WGS <- WGS[,-1]
WGS <- t(WGS)


############# Working with filter 0.3  

GBS3[,1] <- paste("S",GBS3[,1],"_", GBS3[,2], sep="") 
rownames(GBS3) <- GBS3[,1]
GBS3 <- GBS3[,-1]
GBS3 <- GBS3[,-1]
GBS3 <- t(GBS3)

markers3 <- which(colnames(WGS) %in% colnames(GBS3))
WGS3 <- WGS[,markers3]

matriz3 <- rbind(WGS3, GBS3)
matriz3 <- matriz3 -1

library(rrBLUP)

K <- A.mat(matriz3)

library(RColorBrewer) 
library(rrBLUP)
library(gplots)

y <- K

a <- heatmap.2(y, col=bluered, tracecol="#303030",
               margins = c(9, 12))

#Getting some numbers:

matrix_round <-  round(matriz3)
mini <- matrix_round[sort(rownames(matrix_round)[6:23]),]

a <- as.numeric(matrix_round[5,])
tmp <- vector()

for (f in 1:18) {  
  b <- as.numeric(mini[f,])

  counter <- 1
  for (i in 1:length(a)){
    if (a[i]==b[i]){counter = counter + 1}
  }
  tmp <- c(tmp, counter/length(a))
}

Percentage[,5] <- tmp

write.table(Percentage, file='/home/roberto/Desktop/table',sep = "\t", quote = F, col.names = F, row.names = F)



############################################################################################################

######### Compare 5 cassavas that were WGS with the same cassavas that were projected from GBS  ############

############################################################################################################

setwd("/home/DB2/Imputation/BEAGLE_imputation/correspondence/Imputation_v2/validation/")

#Loading the files and formatting

GBS <- read.delim("imputed.DS.FORMAT")
WGS <- read.delim("reference.DS.FORMAT")

GBS[,1] <- paste("S",GBS[,1],"_", GBS[,2], sep="") 
rownames(GBS) <- GBS[,1]
GBS <- GBS[,-1]
GBS <- GBS[,-1]
GBS <- t(GBS)

WGS[,1] <- paste("S",WGS[,1],"_", WGS[,2], sep="") 
rownames(WGS) <- WGS[,1]
WGS <- WGS[,-1]
WGS <- WGS[,-1]
WGS <- t(WGS)

matriz <- rbind(WGS, GBS)
matriz <- matriz -1

library(rrBLUP)

K <- A.mat(matriz)

library(RColorBrewer) 
library(rrBLUP)
library(gplots)

y <- K
a <- heatmap.2(y, col=bluered, tracecol="#303030",
               margins = c(9, 12))



############################################################################################################

############# FIRST ATTEMPT WHEN THE VALIDATION WERE ALSO IN THE REFERENCE PANEL   #########################


############################################################################################################

#### Loading the dosage files ----

setwd("/home/DB2/Imputation/BEAGLE_imputation/correspondence/")

#Loading the files and formatting
GBS <- read.delim("gbs_ds.FORMAT")
WGS <- read.delim("WGS.DS.FORMAT")


GBS[,1] <- paste("S",GBS[,1],"_", GBS[,2], sep="") 
rownames(GBS) <- GBS[,1]
GBS <- GBS[,-1]
GBS <- GBS[,-1]
GBS <- t(GBS)

WGS[,1] <- paste("S",WGS[,1],"_", WGS[,2], sep="") 
rownames(WGS) <- WGS[,1]
WGS <- WGS[,-1]
WGS <- WGS[,-1]
WGS <- t(WGS)

matriz <- rbind(WGS, GBS)
matriz <- matriz -1

library(rrBLUP)

K <- A.mat(matriz)

library(RColorBrewer) 
library(rrBLUP)
library(gplots)

y <- K
a <- heatmap.2(y, col=bluered, tracecol="#303030",
               margins = c(9, 12))


