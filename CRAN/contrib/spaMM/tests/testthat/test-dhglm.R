cat("\ntest of DHGLM:")

data("crack") # crack data, LeeNP06 chapter 11 etc
hlfit <- HLfit(y~crack0+(1|specimen),family=Gamma(log),data=crack, HLmethod="REML", 
               rand.family=inverse.Gamma(log), resid.model=list(formula=~cycle+(1|specimen))   )
# testthat::expect_equal(hlfit$APHLs$p_v,789.60762,tolerance=1e-4)
# testthat::expect_equal(hlfit$APHLs$p_bv,785.36745,tolerance=1e-4)
testthat::expect_equal(AIC(hlfit)[2],c("    conditional AIC:"=-1576.2316),tolerance=1e-4)
