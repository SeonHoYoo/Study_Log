/* ������ �Է� */
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

/* ������ ��ȯ: ���� �� ��� */
proc sort data=hcb_data; by Depth; run;

data paired_data;
    merge hcb_data(where=(Depth="Surface") rename=(HCB=Surface))
          hcb_data(where=(Depth="Bottom") rename=(HCB=Bottom));
    Difference = Surface - Bottom;
run;

/* ���� ���� ���Լ� ���� */
proc univariate data=paired_data normal;
    var Difference;
    histogram Difference / normal;
    probplot Difference / normal(mu=est sigma=est);
    title "Normality Test for Difference in HCB Concentrations";
run;

/* (b) ����� ���ϼ� ���� (���� ǥ�� t-����) */
proc ttest data=hcb_data;
    class Depth;
    var HCB;
    title "T-Test for Mean HCB Concentrations by Depth";
run;

/* (c) 2.0 ng ���̸� �����ϱ� ���� ������ ��� */
proc power;
    twosamplemeans
        test=diff
        groupmeans = 0 | 2 /* �׷� ��� ���� */
        stddev = 1 /* ������ ǥ������ */
        power = .
        alpha = 0.05;
    title "Power Calculation for Detecting 2.0 ng Difference";
run;

/* (d) 1.0 ng ���̸� �����ϱ� ���� ���� ũ�� ��� */
proc power;
    twosamplemeans
        test=diff
        groupmeans = 0 | 1 /* �׷� ��� ���� */
        stddev = 1 /* ������ ǥ������ */
        power = 0.9
        alpha = 0.05
        ntotal = .;
    title "Sample Size Calculation for Detecting 1.0 ng Difference";
run;
