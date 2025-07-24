
#Metaa-analysis

# load the metafor package　　　
library(metafor)

# look at the BCG dataset
dat.bcg

# dat <- read.csv("C:/Users/ahara/Downloads/BCG/BCG.csv")


### calculate log risk ratios and corresponding sampling variances (and use
### the 'slab' argument to store study labels as part of the data frame)
dat <- escalc(measure="OR", ai=tpos, bi=tneg, ci=cpos, di=cneg, data=dat,
              slab=paste(author, year, sep=", "))

### fit random-effects model
res <- rma(yi, vi, data=dat)


# calculate log risk ratios and corresponding sampling variances
dat <- escalc(measure="OR", ai=tpos, bi=tneg, ci=cpos, di=cneg,　data=dat.bcg)
dat

# random-effects model (using log risk ratios and variances as input)
res <- rma(yi, vi, data=dat)
res


# mixed-effects meta-regression model
res <- rma(yi, vi, mods = ~ ablat + alloc, data=dat)
res

### calculate (log) risk ratios and corresponding sampling variances
dat <- escalc(measure="OR", ai=tpos, bi=tneg, ci=cpos, di=cneg, data=dat.bcg)

### fit mixed-effects model with absolute latitude as predictor
res <- rma(yi, vi, mods = ~ ablat, data=dat)

### draw plot
regplot(res, xlim=c(10,60), predlim=c(10,60), xlab="Absolute Latitude", refline=0,
        atransf=exp, at=log(seq(0.2,1.6,by=0.2)), digits=1, las=1, bty="l",
        label=c(4,7,12,13), offset=c(1.6,0.8), labsize=0.9)

#funnel plot
funnel(res)

#test for funnel plot symmetry
ranktest(res)
regtest(res)


# random-effects model (using log risk ratios and variances as input)
escalc(measure="OR", ai=tpos, bi=tneg, ci=cpos, di=cneg, data=dat.bcg)
res <- rma(yi, vi, data=dat)
reporter(res)




### forest plot with extra annotations   "Simple type"”"
forest(res, atransf=exp, at=log(c(.05, .25, 1, 4)), xlim=c(-16,6),
       ilab=cbind(tpos, tneg, cpos, cneg), ilab.xpos=c(-9.5,-8,-6,-4.5), 
       cex=.75, header="Author(s) and Year", mlab="")
op <- par(cex=.75, font=2)
text(c(-9.5,-8,-6,-4.5), 15, c("TB+", "TB-", "TB+", "TB-"))
text(c(-8.75,-5.25),     16, c("Vaccinated", "Control"))
par(op)

### add text with Q-value, dfs, p-value, and I^2 statistic
text(-16, -1, pos=4, cex=0.75, bquote(paste("RE Model (Q = ",
                                            .(formatC(res$QE, digits=2, format="f")), ", df = ", .(res$k - res$p),
                                            ", p = ", .(formatC(res$QEp, digits=2, format="f")), "; ", I^2, " = ",
                                            .(formatC(res$I2, digits=1, format="f")), "%)")))




### copy BCG vaccine meta-analysis data into 'dat'
dat <- dat.bcg

### calculate log risk ratios and corresponding sampling variances (and use
### the 'slab' argument to store study labels as part of the data frame)
dat <- escalc(measure="OR", ai=tpos, bi=tneg, ci=cpos, di=cneg, data=dat,
              slab=paste(author, year, sep=", "))

### fit random-effects model
res <- rma(yi, vi, data=dat)
