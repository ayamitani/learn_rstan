## This file takes a VERY long time to run... something is wrong...

#https://seanvdm.co.za/post/tfit1/

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
  real d;                     // skewness parameter
  //vector<lower=0>[N] z;         // weights of skewness
  real<lower=0> z;         // weights of skewness
}
transformed parameters {
  vector[N] mushift;
  mushift = b0 + b1 * smk + d * z;
}
model {
  for (i in 1:N)
  //z[i] ~ normal(0,1) T[0,];
  pd ~ student_t(v, mushift, s);
  v ~ exponential(0.1);
}", 
data = toothdat, 
iter = 100, chains = 2)
