#https://mc-stan.org/docs/stan-users-guide/robust-noise-models.html

source("stan_toothdat.R")

# df is a parameter
stan(model_code = "data {
  int<lower=0> N;
  vector[N] smk;
  vector[N] pd;
}
parameters {
  real b0;
  real b1;
  real<lower=0> v;            // degrees of freedom
  real<lower=0> s;            // scale parameter
}
model {
  pd ~ student_t(v, b0 + b1 * smk, s);
  //v ~ exponential(0.01);
}", 
data = toothdat, 
iter = 100, chains = 2)


