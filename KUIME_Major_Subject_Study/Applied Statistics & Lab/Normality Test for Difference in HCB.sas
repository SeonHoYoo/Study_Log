/* 데이터 입력 */
data hcb_data;
    input Depth $ HCB;
    datalines;
Surface 3.74
Surface 4.61
Surface 4.00
Surface 4.67
Surface 4.87
Surface 5.12
Surface 4.52
Surface 5.29
Surface 5.74
Surface 5.48
Bottom 5.44
Bottom 6.88
Bottom 5.37
Bottom 5.44
Bottom 5.03
Bottom 6.48
Bottom 3.89
Bottom 5.85
Bottom 6.85
Bottom 7.16
;
run;

/* 데이터 변환: 차이 값 계산 */
proc sort data=hcb_data; by Depth; run;

data paired_data;
    merge hcb_data(where=(Depth="Surface") rename=(HCB=Surface))
          hcb_data(where=(Depth="Bottom") rename=(HCB=Bottom));
    Difference = Surface - Bottom;
run;

/* 차이 값의 정규성 검정 */
proc univariate data=paired_data normal;
    var Difference;
    histogram Difference / normal;
    probplot Difference / normal(mu=est sigma=est);
    title "Normality Test for Difference in HCB Concentrations";
run;

/* (b) 평균의 동일성 검정 (독립 표본 t-검정) */
proc ttest data=hcb_data;
    class Depth;
    var HCB;
    title "T-Test for Mean HCB Concentrations by Depth";
run;

/* (c) 2.0 ng 차이를 검출하기 위한 검정력 계산 */
proc power;
    twosamplemeans
        test=diff
        groupmeans = 0 | 2 /* 그룹 평균 차이 */
        stddev = 1 /* 가정된 표준편차 */
        power = .
        alpha = 0.05;
    title "Power Calculation for Detecting 2.0 ng Difference";
run;

/* (d) 1.0 ng 차이를 검출하기 위한 샘플 크기 계산 */
proc power;
    twosamplemeans
        test=diff
        groupmeans = 0 | 1 /* 그룹 평균 차이 */
        stddev = 1 /* 가정된 표준편차 */
        power = 0.9
        alpha = 0.05
        ntotal = .;
    title "Sample Size Calculation for Detecting 1.0 ng Difference";
run;
