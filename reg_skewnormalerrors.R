#https://mc-stan.org/docs/functions-reference/skew-normal-distribution.html

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
  real<lower=0> omega;
  real alpha;
}
model {
  pd ~ skew_normal(b0 + b1 * smk, omega, alpha);
}", 
data = toothdat, 
iter = 100, chains = 2)

