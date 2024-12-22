data ex6_18;
input mpg weight horsepower @@;
cards;
29.25 2464 130 17.00 4024 394
21.00 3942 235 17.00 3495 294
32.00 2604 110 18.50 4300 362
21.25 3241 260 16.00 4455 389
26.50 3283 200 10.50 3726 485
23.00 2809 240 12.50 3522 550
;
proc sgscatter data = ex6_18;
matrix mpg weight horsepower;
title 'Scatter Plot Matrix for MPG Data';

proc reg data = ex6_18;
model mpg = weight horsepower/r influence clm cli;
output out = new p = pred r = resid;

symbol1 v = circle i = rl;
goptions hsize = 15cm vsize = 13cm;

proc gplot data=new;
plot resid*(pred weight horsepower) / vref =0;
title 'Residual Plot';

proc univariate data = new noprint;
qqplot resid/normal(L=1 mu=0 sigma=est);
run;quit;

proc corr data = ex6_18;
var mpg weight horsepower;
proc reg data = ex6_18;
model mpg = weight horsepower/vif;
run;quit;
