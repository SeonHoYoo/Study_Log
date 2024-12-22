/* ������ �Է� */
data tensile_strength;
    input Temperature $ Strength;
    datalines;
25 2.09
25 2.14
25 2.18
25 2.05
25 2.18
25 2.11
40 2.22
40 2.09
40 2.10
40 2.02
40 2.05
40 2.01
55 2.03
55 2.22
55 2.10
55 2.07
55 2.03
55 2.15
;
run;

/* (a) �л� �м� (ANOVA)�� P-�� ��� */
proc anova data=tensile_strength;
    class Temperature;
    model Strength = Temperature;
    means Temperature / tukey;
run;

/* (b) ���� �׸� ���� */
proc sgplot data=tensile_strength;
    vbox Strength / category=Temperature;
    title "Tensile Strength by Curing Temperature";
run;

/* (c) ���� �м� �� �� ���� */
proc glm data=tensile_strength;
    class Temperature;
    model Strength = Temperature;
    output out=residuals r=resid;
run;

proc univariate data=residuals;
    var resid;
    histogram resid / normal;
    probplot resid / normal(mu=est sigma=est);
    title "Residual Analysis";
run;
