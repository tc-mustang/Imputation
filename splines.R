require(graphics)

## Load the file with chromosome/genetic position/physical position [Chromosome I as a test]

GM_short <- read.delim("~/Desktop/Splines/GM_short.txt", header=FALSE) # Original Genetic Map
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





