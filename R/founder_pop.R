# figure with founder populations

library(here)

pdf(here("Figs/founder_pop.pdf"), height=5, width=5, pointsize=18)
par(mar=rep(0.1, 4), bty="n")
plot(0,0,type="n", xlab="", ylab="", xaxt="n", yaxt="n",
     xlim=c(0, 100), ylim=c(0, 100), xaxs="i")

x <- c(0, 100)
y <- c(0, 100)

segments(x[c(1,1,2)], y[c(1,1,1)],
         x[c(2,1,2)], y[c(1,2,2)], lwd=8)


# find points that are at least r apart
set.seed(20210828)
n <- 20000
r <- 14
x <- runif(n, r, 100-r)
y <- runif(n, r, 100-r)

n_points <- 22

keep <- NULL
drop <- NULL
for(i in 1:n) {
    if(i %in% drop) next
    keep <- c(keep, i)
    if(length(keep) == n_points) break
    left <- (i+1):n
    left <- left[!(left %in% drop)]

    d <- sqrt((x[i] -x[left])^2 + (y[i] - y[left])^2)
    drop <- c(drop, left[d < r])
}
stopifnot(length(keep) == n_points)

x <- x[keep]
y <- y[keep]
color <- qtl2::CCcolors[c(2:4,6:8)]
g <- rep(1:6,c(6,5,1,5,3,2))
points(x, y, pch=21, bg="gray80", col=color[g], cex=5.5, lwd=2)
text(x, y, LETTERS[g], cex=1.5, col=color[g])

dev.off()
