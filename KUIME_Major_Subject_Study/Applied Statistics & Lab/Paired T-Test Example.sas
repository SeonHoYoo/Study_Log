DATA Specimen;
INPUT K L @@;
	DIFF = K-L;
CARDS;
215 203
226 216
226 217
219 211
222 215
231 218
234 224
219 210
209 201
216 207
ods graphics on;
PROC UNIVARIATE DATA = Specimen NORMAL;
	VAR DIFF;
TITLE 'PAIRED T-TEST BY PROC UNIVARIATE';
PROC TTEST DATA = Specimen;
	PAIRED K*L;
TITLE 'PAIRED TTEST BY PROC TTEST';
RUN; ods graphics off;
QUIT;
