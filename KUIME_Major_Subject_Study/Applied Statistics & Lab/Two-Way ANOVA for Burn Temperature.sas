/* 데이터 입력 */
data burn_test;
    input Level Salt $ Burn_Temperature;
    datalines;
1 Untreated 812
1 MgCl2 752
1 NaCl 739
1 CaCO3 733
1 CaCl2 725
1 Na2CO3 751
1 Untreated 827
1 MgCl2 728
1 NaCl 731
1 CaCO3 728
1 CaCl2 727
1 Na2CO3 761
1 Untreated 876
1 MgCl2 764
1 NaCl 726
1 CaCO3 720
1 CaCl2 719
1 Na2CO3 755
2 Untreated 945
2 MgCl2 794
2 NaCl 741
2 CaCO3 786
2 CaCl2 756
2 Na2CO3 910
2 Untreated 881
2 MgCl2 760
2 NaCl 744
2 CaCO3 771
2 CaCl2 781
2 Na2CO3 854
2 Untreated 919
2 MgCl2 757
2 NaCl 727
2 CaCO3 779
2 CaCl2 814
2 Na2CO3 848
;
run;

/* (a) 이원 분산 분석 */
proc glm data=burn_test;
    class Level Salt;
    model Burn_Temperature = Level Salt Level*Salt;
    means Level Salt / tukey;
    title "Two-Way ANOVA for Burn Temperature";
run;

/* (b) 상호작용 그래프 */
proc sgplot data=burn_test;
    series x=Salt y=Burn_Temperature / group=Level markers;
    title "Interaction Plot: Salt vs Burn Temperature by Level";
    xaxis label="Salt Type";
    yaxis label="Burn Temperature";
run;

/* 상자 그림 생성 */
proc sgplot data=burn_test;
    vbox Burn_Temperature / category=Salt group=Level;
    title "Box Plot of Burn Temperature by Salt and Level";
run;

/* (c) 잔차 분석 */
proc glm data=burn_test;
    class Level Salt;
    model Burn_Temperature = Level Salt Level*Salt;
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
