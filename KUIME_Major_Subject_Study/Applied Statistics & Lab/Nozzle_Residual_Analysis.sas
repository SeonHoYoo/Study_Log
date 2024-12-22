/* ODS �׷��� Ȱ��ȭ */
ods graphics on;

/* ������ �Է� */
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

/* ������ �籸��ȭ (Wide to Long Format) */
proc transpose data=nozzle_data out=long_data(rename=(col1=Shape_Measure)) name=Velocity;
    by Nozzle_Type;
    var Velocity_11_73--Velocity_28_74;
run;

/* GLM �м� �� ���� ���� */
proc glm data=long_data;
    class Nozzle_Type;
    model Shape_Measure = Nozzle_Type;
    output out=residuals r=resid p=predicted;
run;

/* ���� vs. ������ �÷� */
proc sgplot data=residuals;
    scatter x=predicted y=resid / markerattrs=(symbol=circlefilled);
    refline 0 / axis=y lineattrs=(pattern=shortdash);
    title "Residual Plot: Residuals vs Predicted Values";
    xlabel "Predicted Values";
    ylabel "Residuals";
run;

/* ���� vs. ���� ����(���� ����) �÷� */
proc sgplot data=residuals;
    scatter x=Nozzle_Type y=resid / markerattrs=(symbol=circlefilled);
    refline 0 / axis=y lineattrs=(pattern=shortdash);
    title "Residual Plot: Residuals vs Nozzle Type";
    xlabel "Nozzle Type";
    ylabel "Residuals";
run;

/* Q-Q �÷� �� ���Լ� �м� */
proc univariate data=residuals;
    var resid;
    histogram resid / normal;
    probplot resid / normal(mu=est sigma=est);
    title "Residual Analysis with Normality Check";
run;

/* ODS �׷��� ��Ȱ��ȭ */
ods graphics off;
