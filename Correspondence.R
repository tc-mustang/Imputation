#### Comparing WGS with GBS markers ###

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


