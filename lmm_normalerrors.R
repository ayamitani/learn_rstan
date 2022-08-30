#https://mc-stan.org/users/documentation/case-studies/tutorial_rstanarm.html#using-the-rstanarm-package
#https://journal.r-project.org/archive/2018/RJ-2018-017/RJ-2018-017.pdf
#https://people.bath.ac.uk/jjf23/stan/

source("stan_toothdat.R")

## with rstanarm
stanlmm1 <- stan_lmer(maxpd ~ smoke + (1 | id), 
                      data = tooth50,
                      seed = 350)
stanlmm1
summary(stanlmm1)



## with brms
brmlmm1 <- brm(maxpd ~ smoke + (1 | id),
               data = tooth50,
               chains = 2, cores = 2)
summary(brmlmm1)
# look at the STAN code that brms used with
stancode(brmlmm1)




## with own stan code using stanlmm.stan adapted from https://github.com/julianfaraway/rexamples/blob/main/mixed/longitudinal.md
## BUT  THIS IS NOT WORKING!!!!
# set up stan to use multiple cores
options(mc.cores = parallel::detectCores())

# prepare data
lmod <- lm(maxpd ~ smoke, tooth50)
x <- model.matrix(lmod)
pddat <- list(Nobs = nrow(tooth50),
              Npreds = ncol(x),
              Ngroups = length(unique(tooth50$id)),
              y = tooth50$maxpd,
              x = x,
              group = tooth50$id)

# fit
rt <- stanc("stanlmm.stan")
sm <- stan_model(stanc_ret = rt, verbose=FALSE)
set.seed(350)
system.time(fit <- sampling(sm, data = pddat))
