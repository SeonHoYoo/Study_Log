/* 데이터 입력 */
data twins;
    input Pair Birth_Order_1 Birth_Order_2;
    Difference = Birth_Order_1 - Birth_Order_2;
    datalines;
1 6.08 5.73
2 6.22 5.80
3 7.99 8.42
4 7.44 6.84
5 6.48 6.43
6 7.99 8.76
7 6.32 6.32
8 7.60 7.62
9 6.03 6.59
10 7.52 7.67
;
run;

/* (a) 차이의 정규성 검정 */
proc univariate data=twins normal;
    var Difference;
    histogram Difference / normal;
    probplot Difference / normal(mu=est sigma=est);
    title "Normality Test for Difference";
run;

/* (b) 95% 신뢰구간 계산 */
proc ttest data=twins;
    paired Birth_Order_1*Birth_Order_2;
    title "Paired T-Test and Confidence Interval for Difference";
run;

/* (c) 필요한 샘플 크기 계산 */
proc power;
    pairedmeans
        test=diff
        meanpaireddiff=1
        stddev=0.5 /* 가정된 표준편차 */
        ntotal=.
        power=0.90;
    title "Sample Size Calculation for Detecting Mean Difference of 1 Point";
run;
