require(graphics)

## Load the file with chromosome/genetic position/physical position [Chromosome I as a test]

GM_long <- read.delim("~/Desktop/Splines/GM_long.txt", header=FALSE)   # File Jessen sent

genetic <- GM_long[,2]
physical <- GM_long[,3]

## Splines interpolation

Rspline <- splinefun(physical, genetic, method = "hyman")

## Linear Interpolation:

x <- physical
y <- genetic
Rlinear <- approxfun(x, y)

## Plotting the two splines and the linear interpolation

curve(Rlinear(x), 0, 350000, col = "green",ylab = "Genetic Distances (cM)", xlab = "Physical Distance")
points(x[1:400],y[1:400])
curve(splinefun(physical[1:400], genetic[1:400], method = "hyman")   (x), add = TRUE, col = 4, n = 5001)
curve(splinefun(physical[1:400], genetic[1:400], method = "monoH.FC")   (x), add = TRUE, col = "red", n = 5001)

legend("topleft",
       paste0(c("linear", "monoH.FC (softsplines)", "hyman (softsplines")),
       col = c("green", "blue", "red"), lty = 1, bty = "n")


######### Predicting and outputting in Beagle genetic map Format -----

# Upload the hapmap positions (C1_physical.txt)

c1_physical <- read.delim("/home/roberto/Desktop/c1_physical.txt", header=FALSE, comment.char="#")


positions <- c1_physical[,2] # vector of positions
chromo <- c1_physical[,1] #vector of chromosomes

# Use Rspline to predict the genetic positions

GD  <- Rspline(positions)
GDl <- Rlinear(positions)   

#cor(GD[40000:800000],GDl[40000:800000]) # spline and linear interpolation gave almost the same results because the distance between each marker is pretty short

Beagle <- matrix(0, nrow = length(positions), ncol = 4) # Beagle genetic map format

Beagle[,1] <- chromo
Beagle[,2] <- "."
Beagle[,3] <- GD
Beagle[,4] <- positions

# Export the data frame in Beagle format
write.table(Beagle, file="/home/roberto/Desktop/Splines/c1_Beagle.map", sep="\t", quote = F, row.names = F, col.names = F)


#### Predicting and outputting in Impute2 genetic map Format -----

IMPUTE2 <- matrix(0, nrow = length(positions), ncol = 3) # IMPUTE2 genetic map format
colnames(IMPUTE2) <- c("position", "COMBINED_rate.cM.Mb.", "Genetic_Map.cM.")

IMPUTE2[,1] <- positions
IMPUTE2[,3] <- GD

for (i in 1:(dim(IMPUTE2)[1]-1)){
  # CM between markers
  cm <- IMPUTE2[i+1,3] - IMPUTE2[i,3]
  # Mb between markers
  mb <- IMPUTE2[i+1,1] - IMPUTE2[i,1]
  # Recombination Rate
  rr <- cm/(mb/1000000)
  IMPUTE2[i,2] <- rr
}

#remove last marker from the data.frame
IMPUTE2 <- IMPUTE2[-1991815,]

# Export the data frame in IMPUTE2 format
write.table(IMPUTE2, file="/home/roberto/Desktop/Splines/c1_IMPUTE2.map", sep="\t", quote = F, row.names = F, col.names = T)


require(graphics)


#####################################################################################################

######## Load the file with chromosome/genetic position/physical position [All Chromosomes now] -----

#####################################################################################################


setwd("/home/DB2/Imputation/Splines/")
GM_long <- read.delim("~/Desktop/genetic.map", header=FALSE)   # File Jessen sent

for (i in 14:14){
  chromosome <- paste("Chromosome", i, sep = "")

  genetic <- as.numeric(as.character(GM_long[grep(chromosome, GM_long[,1]),3]))
  physical <- as.numeric(as.character(GM_long[grep(chromosome, GM_long[,1]),4]))

  ## Splines interpolation
  Rspline <- splinefun(physical, genetic, method = "hyman")

  # Upload the hapmap positions (C1_physical.txt)
  
  posiciones <- paste("chr",i,".physical", sep = "")
  
  positions_hapmap <- read.delim(posiciones, header=FALSE, comment.char="#")
  positions <- positions_hapmap[,1] # vector of positions
  
  # Use Rspline (Roberto spline) to predict the genetic positions
  GD  <- Rspline(positions)
  
  Beagle <- matrix(0, nrow = length(positions), ncol = 4) # Beagle genetic map format
  
  Beagle[,1] <- i
  Beagle[,2] <- "."
  Beagle[,3] <- GD
  Beagle[,4] <- positions

  output <- paste("chr",i,"_Beagle.map", sep = "")
  # Export the data frame in Beagle format
  write.table(Beagle, file=output, sep="\t", quote = F, row.names = F, col.names = F)
}


######## SOLVING PROBLEMS FOR CHROMOSOME 14 #######################

chromosome <- "Chromosome14"

genetic <- as.numeric(as.character(GM_long[grep(chromosome, GM_long[,1]),3]))
physical <- as.numeric(as.character(GM_long[grep(chromosome, GM_long[,1]),4]))

## Splines interpolation
Rspline <- splinefun(physical, genetic, method = "hyman")

genetic[28131:28151] <- 117.887
tail(genetic, n=30)

posiciones <- paste("chr","14",".physical", sep = "")

positions_hapmap <- read.delim(posiciones, header=FALSE, comment.char="#")
positions <- positions_hapmap[,1] # vector of positions

tail(positions)

# Use Rspline (Roberto spline) to predict the genetic positions
GD  <- Rspline(positions)
length(GD)

Beagle <- matrix(0, nrow = length(positions), ncol = 4) # Beagle genetic map format

Beagle[,1] <- 14
Beagle[,2] <- "."
Beagle[,3] <- GD
Beagle[,4] <- positions

output <- paste("chr","14","_Beagle.map", sep = "")
# Export the data frame in Beagle format
write.table(Beagle, file=output, sep="\t", quote = F, row.names = F, col.names = F)



############# IMPUTE2 FORMAT FOR ALL CHROMOSOME #################################################

#Wont be calculating everythin again but just getting the physical positions and cM from the 
#Files already created for the plink format

IMPUTE2 <- matrix(0, nrow = length(positions), ncol = 3) # IMPUTE2 genetic map format
colnames(IMPUTE2) <- c("position", "COMBINED_rate.cM.Mb.", "Genetic_Map.cM.")

IMPUTE2[,1] <- positions
IMPUTE2[,3] <- GD

for (i in 1:(dim(IMPUTE2)[1]-1)){
  # CM between markers
  cm <- IMPUTE2[i+1,3] - IMPUTE2[i,3]
  # Mb between markers
  mb <- IMPUTE2[i+1,1] - IMPUTE2[i,1]
  # Recombination Rate
  rr <- cm/(mb/1000000)
  IMPUTE2[i,2] <- rr
}

#remove last marker from the data.frame
IMPUTE2 <- IMPUTE2[-1991815,]

# Export the data frame in IMPUTE2 format
write.table(IMPUTE2, file="/home/roberto/Desktop/Splines/c1_IMPUTE2.map", sep="\t", quote = F, row.names = F, col.names = T)


require(graphics)