#https://mc-stan.org/docs/stan-users-guide/linear-regression.html

source("stan_toothdat.R")

# version one
stan(model_code = "data {
  int<lower=0> N;
  vector[N] smk;
  vector[N] pd;
}
parameters {
  real b0;
  real b1;
  real<lower=0> sigma;
}
model {
  b0 ~ normal(0, 1);
  b1 ~ normal(0, 1); 
  sigma ~ gamma(2, 1);
  pd ~ normal(b0 + b1 * smk, sigma);
}", 
data = toothdat50, 
chains= 1,
warmup = 100,
iter = 200)


# version two
# stan(model_code = "data {
#   int<lower=1> N;                   //number of data points
#   vector[N] smk;
#   vector[N] pd;
# }
# parameters {
#   vector[2] beta;            //fixed intercept and slope
#   real<lower=0> sigma_e;     //error sd
# }
# model {
#   pd ~ normal(beta[1] + beta[2] * smk, sigma_e);
# }", 
# data = toothdat50, 
# iter = 100, chains = 2)


summary(lm(pd ~ smk, data = toothdat50))

out.t <- stan_glm(maxpd ~ smoke, family = gaussian("identity"), data = tooth50)
summary(out.t)

