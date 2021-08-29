# QTL results for Al-Barghouthi et al (2021) data
# show LOD curves + difference
# admit differences from the original paper

library(qtl2)
library(here)

dir <- here("Data/DO_data")
file1 <- file.path(dir, "scan1_do.rds")
file2 <- file.path(dir, "scan1_genail.rds")
out_scan1_do <- readRDS(file1)
out_scan1_genail <- readRDS(file2)
pmap <- readRDS(file.path(dir, "pmap.rds"))

pdf(here("Figs/do_qtl.pdf"), height=6, width=12, pointsize=12)
par(mar=c(3.1, 4.1, 0.6, 0.6), mfrow=c(2,1))

plot(out_scan1_do, pmap, lod="TMD", mgp.x=c(1.8, 0.3, 0), mgp.y=c(2.1, 0.3, 0), lwd=1)
plot(out_scan1_genail, pmap, lod="TMD", add=TRUE, col="violetred", lty=3, lwd=1)
legend("topright", c("DO", "genAIL8"), lwd=2, lty=c(1,3), col=c("slateblue", "violetred"), bg="gray90")


plot(out_scan1_do - out_scan1_genail, pmap, ylim=c(-0.02, 0.02), lod="TMD", lwd=1,
     ylab="LOD(DO) - LOD(genAIL8)", mgp.x=c(1.8, 0.3, 0), mgp.y=c(2.8, 0.3, 0))

dev.off()
