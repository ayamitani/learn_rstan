data {
     int<lower=0> Nobs;
     int<lower=0> Npreds;
     int<lower=0> Ngroups;
     vector[Nobs] y;
     matrix[Nobs,Npreds] x;
     int<lower=1,upper=Ngroups> group[Nobs];
}
parameters {
           vector[Npreds] beta;
           real<lower=0> sigmaint;
           real<lower=0> sigmaeps;

           vector[Ngroups] etaint;
}
transformed parameters {
  vector[Ngroups] ranint;
  vector[Nobs] yhat;

  ranint  = sigmaint * etaint;

  for (i in 1:Nobs)
    yhat[i] = x[i]*beta+ranint[group[i]];

}
model {
  etaint ~ normal(0, 1);
  y ~ normal(yhat, sigmaeps);
}

