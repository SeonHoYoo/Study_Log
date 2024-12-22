/* ODS 그래픽 활성화 */
ods graphics on;

/* 데이터 입력 */
data nozzle_data;
    input Nozzle_Type $ Velocity_11_73 Velocity_14_37 Velocity_16_59 Velocity_20_43 Velocity_23_46 Velocity_28_74;
    datalines;
1 0.78 0.80 0.81 0.75 0.77 0.78
2 0.85 0.85 0.92 0.86 0.81 0.83
3 0.93 0.92 0.95 0.89 0.89 0.83
4 1.14 0.97 0.98 0.88 0.86 0.83
5 0.97 0.86 0.78 0.76 0.76 0.75
;
run;

/* 데이터 재구조화 (Wide to Long Format) */
proc transpose data=nozzle_data out=long_data(rename=(col1=Shape_Measure)) name=Velocity;
    by Nozzle_Type;
    var Velocity_11_73--Velocity_28_74;
run;

/* GLM 분석 및 잔차 저장 */
proc glm data=long_data;
    class Nozzle_Type;
    model Shape_Measure = Nozzle_Type;
    output out=residuals r=resid p=predicted;
run;

/* 잔차 vs. 예측값 플롯 */
proc sgplot data=residuals;
    scatter x=predicted y=resid / markerattrs=(symbol=circlefilled);
    refline 0 / axis=y lineattrs=(pattern=shortdash);
    title "Residual Plot: Residuals vs Predicted Values";
    xlabel "Predicted Values";
    ylabel "Residuals";
run;

/* 잔차 vs. 독립 변수(노즐 유형) 플롯 */
proc sgplot data=residuals;
    scatter x=Nozzle_Type y=resid / markerattrs=(symbol=circlefilled);
    refline 0 / axis=y lineattrs=(pattern=shortdash);
    title "Residual Plot: Residuals vs Nozzle Type";
    xlabel "Nozzle Type";
    ylabel "Residuals";
run;

/* Q-Q 플롯 및 정규성 분석 */
proc univariate data=residuals;
    var resid;
    histogram resid / normal;
    probplot resid / normal(mu=est sigma=est);
    title "Residual Analysis with Normality Check";
run;

/* ODS 그래픽 비활성화 */
ods graphics off;
