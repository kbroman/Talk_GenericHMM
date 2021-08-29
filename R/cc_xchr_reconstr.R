# CC genotype probabilities on X chr

library(qtl2)
library(here)
library(broman)

dir <- here("Data/CC_data")

pmap <- readRDS(file.path(dir, "pmap.rds"))
pr_cc <- readRDS(file.path(dir, "pr_cc.rds"))
pr_genril <- readRDS(file.path(dir, "pr_genril.rds"))


pdf(here("Figs/cc_xchr_reconstr.pdf"), height=6, width=11, pointsize=14)

par(mfrow=c(2,1), mar=c(4.1, 4.1, 2.1, 1.1), las=1)
str <- "CC038/GeniUnc"

par(col.main="darkslateblue")
plot_genoprob(pr_cc, pmap, str, "X", main="more-exact model", yaxt="n",
              mgp.x=c(1.6, 0.2, 0), xlab="Chr X position (Mbp)", xaxt="n")
axis(side=2, at=8:1, names(CCcolors), tick=FALSE, mgp=c(0, 0.3, 0))
xat <- seq(20, 160, by=20)
axis(side=1, xat, mgp=c(1.6, 0.2, 0), tick=FALSE)

plot_genoprob(pr_genril, pmap, str, "X", main="approximate model", yaxt="n",
              mgp.x=c(1.6, 0.2, 0), xlab="Chr X position (Mbp)", xaxt="n")
axis(side=2, at=8:1, names(CCcolors), tick=FALSE, mgp=c(0, 0.3, 0))
axis(side=1, xat, mgp=c(1.6, 0.2, 0), tick=FALSE)

dev.off()
