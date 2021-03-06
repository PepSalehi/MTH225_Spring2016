//model file for week6: single-factor ANOVA with three levels
data {
  int N;               //sample1 size
  int L;               //number of levels
  real y[N];           //y values
  int level[N];        //level for single factor ANOOVA
}
parameters {
  real alpha[L];            //Parameters for each level of the single factor
  real<lower=0> sigma[L];   //error standard deviation
}
model {
  int j;
  alpha ~ normal(0,10);     //normal priors for each alpha level
  sigma ~ cauchy(0,5);      //half-cauchy prior for error standard deviation 
  
  for (i in 1:N){                   //loop through y values
    j<-level[i];                    //j is the level number
    y[i] ~ normal(alpha[j],sigma[j]);  //y[j] has normal likelihood with mean alpha[j] and std deviation sigma
  }
}
generated quantities {
  real d12;
  real d13;
  real d23;
  
  d12<-alpha[1]-alpha[2];    //sample difference between alpha1 and alpha2
  d13<-alpha[1]-alpha[3];    //sample difference between alpha1 and alpha3
  d23<-alpha[2]-alpha[3];    //sample difference between alpha2 and alpha3
}
