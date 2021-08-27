# plot of genome scan, of snps and of haplotypes

library(here)
library(qtl2)

dir <- here("QTLresults")
pmap <- readRDS(file.path(dir, "pmap.rds"))
out_add <- readRDS(file.path(dir, "out_add.rds"))
out_snps <- readRDS(file.path(dir, "out_snps.rds"))
operm_add <- readRDS(file.path(dir, "operm_add.rds"))
operm_snps <- readRDS(file.path(dir, "operm_snps.rds"))

# line colors
altcolor <- "green4"
linecolor <- "violetred"


thr_add <- summary(operm_add)
thr_snps <- summary(operm_snps)

ymx_add <- maxlod(out_add)*1.04
ymx_snps <- thr_snps$A/thr_add$A*maxlod(out_add)*1.04
ymx <- max(c(ymx_add, ymx_snps))


res <- 255

png(here("Figs/qtl_scan_snps.png"), height=6.5*res, width=11*res, pointsize=14, res=res)
par(mar=c(2.1,4.1,1.1,1.1))
layout(c(2,1,2), height=c(0.25, 0.5, 0.25))

endA <- xpos_scan1(pmap, thechr=19, thepos=max(pmap[[19]]))+25/2

plot(out_snps$lod, out_snps$snpinfo, altcol=altcolor, xlab="",
     ylim=c(0, ymx))
u <- par("usr")
segments(u[1], thr_snps$A, endA, thr_snps$A, col=linecolor, lty=2)
segments(endA, thr_snps$X, u[2], thr_snps$X, col=linecolor, lty=2)
dev.off()


png(here("Figs/qtl_scan.png"), height=6.5*res, width=11*res, pointsize=10, res=res)
par(mar=c(2.1,4.1,1.1,1.1))
layout(c(1,2), height=c(0.5, 0.5))

plot(out_snps$lod, out_snps$snpinfo, altcol=altcolor, xlab="",
     ylim=c(0, ymx))
u <- par("usr")
segments(u[1], thr_snps$A, endA, thr_snps$A, col=linecolor, lty=2)
segments(endA, thr_snps$X, u[2], thr_snps$X, col=linecolor, lty=2)

plot(out_add, pmap, altcol=altcolor)
segments(u[1], thr_add$A, endA, thr_add$A, col=linecolor, lty=2)
segments(endA, thr_add$X, u[2], thr_add$X, col=linecolor, lty=2)
dev.off()
