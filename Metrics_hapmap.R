### Snp Density on Chromosome I

maff5 <- read.delim("~/Desktop/Imputation/Metrics/0.05.snpden")
maff1 <- read.delim("~/Desktop/Imputation/Metrics/0.01.snpden")
all <- read.delim("~/Desktop/Imputation/Metrics/all.snpden")


barplot(all[,3], ylab = "# of variants", xlab = "Chromosome I, 0.5Mb bins", main = "SNP density")
barplot(maff1[,3],col="green", add=T)
barplot(maff5[,3],col="red", add=T)
