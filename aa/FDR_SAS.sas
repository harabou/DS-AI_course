data raw;
input test$ raw_p;
datalines;
test1 .08201
test2 .67132
test3 .00112
test4 .54333
test5 .23112
test6 .02454
test7 .01423
test8 .04222
;
proc multtest pdata=raw
holm hoc fdr out=newvalue;
run;
proc print;
run;



data a;
input Test$ Raw_P @@;
datalines;
test01 0.28282 test02 0.30688 test03 0.71022
test04 0.77175 test05 0.78180 test06 0.88581
test07 0.54685 test08 0.84978 test09 0.24228
test10 0.58977 test11 0.03498 test12 0.41607
test13 0.31631 test14 0.05254 test15 0.45061
test16 0.75758 test17 0.12496 test18 0.49485
test19 0.21572 test20 0.50505 test21 0.94372
test22 0.81260 test23 0.77596 test24 0.36889
;
proc multtest inpvalues=a holm hoc fdr;
run;
