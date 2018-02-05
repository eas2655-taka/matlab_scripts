function R=correlation(x,y)


covxy = mean(x.*y)-mean(x)*mean(y);
varx = mean(x.*x) - mean(x)^2;
vary = mean(y.*y) - mean(y)^2;

R= covxy/sqrt(varx*vary);


