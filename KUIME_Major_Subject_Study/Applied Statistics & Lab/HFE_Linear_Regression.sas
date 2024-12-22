/* Input data for example 6.22 */
data ex6_22;
    input EmitterRS BaseRS EtoBRS HFE @@;
    cards;
    14.620 226.00 7.000 128.40 16.120 226.50 3.750 59.06
    15.630 220.00 3.375 52.62 14.380 234.00 8.875 171.90
    14.620 217.40 6.375 113.90 15.500 230.00 4.000 66.80
    15.000 220.00 6.000 98.01 14.250 224.30 8.000 157.10
    14.500 226.50 7.625 139.90 14.500 240.50 10.870 208.40
    15.250 224.10 6.000 102.60 14.620 223.70 7.375 133.40
    15.130 223.50 6.125 109.60 16.120 220.50 3.375 48.14
    15.500 217.60 5.000 82.68 15.380 229.70 5.875 101.00
    15.130 228.50 6.625 112.60 15.630 225.60 5.375 89.09
    15.500 230.20 5.750 97.52 15.130 225.60 6.125 111.80
    ;
run;

/* Scatter Plot Matrix */
proc sgscatter data=ex6_22;
    matrix HFE EmitterRS BaseRS EtoBRS;
    title 'Scatter Plot Matrix for HFE Data';
run;

/* Linear Regression */
proc reg data=ex6_22;
    model HFE = EmitterRS BaseRS EtoBRS / influence;
    output out=new p=pred r=resid;
run;

/* Residual Plot */
symbol1 v=circle i=rl;
goptions hsize=15cm vsize=13cm;

proc gplot data=new;
    plot resid*(pred EmitterRS BaseRS EtoBRS) / vref=0;
    title 'Residual Plot';
run;

/* Normal Probability Plot */
proc univariate data=new noprint;
    qqplot resid / normal(mu=0 sigma=est);
run;

/* Correlation Analysis */
proc corr data=ex6_22;
    var HFE EmitterRS BaseRS EtoBRS;
run;

/* Variance Inflation Factor (VIF) */
proc reg data=ex6_22;
    model HFE = EmitterRS BaseRS EtoBRS / vif;
run;

quit;
