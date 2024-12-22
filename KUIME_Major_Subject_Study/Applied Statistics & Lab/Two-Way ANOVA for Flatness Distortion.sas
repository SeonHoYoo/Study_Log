/* 데이터 입력 */
data gear_data;
    input Gear_Type $ Time Distortion;
    datalines;
20-tooth 90 0.0265
20-tooth 90 0.0340
20-tooth 120 0.0560
20-tooth 120 0.0650
24-tooth 90 0.0430
24-tooth 90 0.0510
24-tooth 120 0.0720
24-tooth 120 0.0880
;
run;

/* (a) 이원 분산 분석 */
proc glm data=gear_data;
    class Gear_Type Time;
    model Distortion = Gear_Type Time Gear_Type*Time;
    means Gear_Type Time / tukey;
    title "Two-Way ANOVA for Flatness Distortion";
run;

/* (b) 요인 효과 시각화 */
proc sgplot data=gear_data;
    series x=Time y=Distortion / group=Gear_Type markers lineattrs=(pattern=solid);
    title "Effect of Heat-Treating Time on Flatness Distortion";
    xaxis label="Time (minutes)";
    yaxis label="Flatness Distortion";
run;

/* 상자 그림 생성 */
proc sgplot data=gear_data;
    vbox Distortion / category=Gear_Type group=Time;
    title "Box Plot of Flatness Distortion by Gear Type and Time";
run;

/* (c) 잔차 분석 */
proc glm data=gear_data;
    class Gear_Type Time;
    model Distortion = Gear_Type Time Gear_Type*Time;
    output out=residuals r=resid p=predicted;
run;

/* 잔차 플롯: 잔차 vs 예측값 */
proc sgplot data=residuals;
    scatter x=predicted y=resid / markerattrs=(symbol=circlefilled);
    refline 0 / axis=y lineattrs=(pattern=shortdash);
    title "Residual Plot: Residuals vs Predicted Values";
    xaxis label="Predicted Values";
    yaxis label="Residuals";
run;

/* 잔차 정규성 검정 */
proc univariate data=residuals normal;
    var resid;
    histogram resid / normal;
    probplot resid / normal(mu=est sigma=est);
    title "Normality Test for Residuals";
run;
