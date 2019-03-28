/*Name: Naimon Hafiz 
Home work= 4 
840 linear Regression*/ 


*2.8(C). Here Null:Beta_1<= 0 alternative: Beta_1 > 0; 

*Here F=105.88, given in the printout,not relavent for the test in part(a) because F test can not be used for one sided  
alternative involving beta_1(<= >=)0 versus Beta_1(> <).; 
  
  
*2.18.t test is two tailed test whereas F test is one tailed test.At any given alpha level,we can use either the t test or F test 
for testing beta_one=0 versus Beta_one notequal 0.Whenever one test leads to null, so will the other, and correspondingly for 
alternative. The t test,however,is more flexible and versatile since it can be used for one sided alternatives,while the 
F test cant not;

 

2.23.(a);

data gradepoint; 
infile "C:\Users\cinthia\Desktop\840\gradepoint.txt" dlm=' '; 
input GPA ACTscore;
run;  
 
 
proc reg data=gradepoint; 
model GPA=ACTscore; *here y=GPA, X=ACTscore; 
run;
 


*2.23(b)The Mean Squared Error (MSE) is a measure of how close a fitted line is to data points. The smaller the means 
squared error, the closer we are to finding the line of best fit:The mean square due to regression, denoted MSR,  
is computed by dividing SSR(regression sum squred) by a number referred to as its degrees of freedom. when F statistic is close  
to 1 or 1. In that case we accetp the null and reject the alternative.;  
  
*2.23(c)here Ho:Beta_1= 0= no relattionship between X and Y 
        Ha:Beta_1<>0 = a linear relationship exist  
       alpha=.01(99%); 
 
proc reg data=gradepoint alpha=.01; 
model GPA=ACTscore; *here y=GPA, X=ACTscore; 
run;
 
* Here from the result viewer window we we can see MSR=3.59 and MSE =.39,  F*= 3.59/.39=9.24;
 
proc iml;
numdf=1;
dendf=118;
alpha=0.01;
critval = finv(1-alpha,numdf,dendf);
print critval;*critical value of F=6.85 
  
* decision rule and conclusion:Here the critical value of F is 6.85. Since F* is greater than F. So we reject the null and we  
conclude that beta_1 is not equal zero and there is a relationship between GPA and ACTscore. ;



*2.23(d) without X model;
proc reg data=gradepoint alpha=.01; 
model GPA=ACTscore; *here y=GPA, X=ACTscore; 
run; 
 
 
delete ACTscore;
print;
run; 
 
*When X is introduced;  
 
proc reg data=gradepoint alpha=.01; 
model GPA=ACTscore; *here y=GPA, X=ACTscore; 
run;
 
* When X is intorduced then SSR= 3.588. And SSTO is 49.405. So the relative reduction is 3.588/49.405=.0726;  
*The name of the latter measure is R square.
 
*2.23(e)Here R squared is .0726 so r=+.27(square root of R squared with a (+) sign since the slope of the fitted line is  
positive). So There is positive linear relationship.; 
 
 
*2.23(f) Regression models do not contain a parameter to be estimated by R square and r. These are simply descriptive measures 
of the degree of linear association between X and Y. I would say, R square has the more clear cut operational interpretation 
since it explains the proportionate reduction of total variation in Y associated with the use of the predictor variable X.  
 
 
*2.26(a,b); 
data plastic; 
infile "C:\Users\cinthia\Desktop\840\plastichardness.txt" dlm=' '; 
input hardness time;
run;  
 
*here X= time Y=Hardness. 
here Ho:Beta_1= 0= no relattionship between X and Y 
        Ha:Beta_1<>0 = a linear relationship exist  
       alpha=.01(99%);  
 
ods graphics on;
proc reg data= plastic alpha=.01;
model hardness=Time; 
run; 
 *Here from the result viewer window we we can see MSR=5297.51250 and MSE =10.45893,  F*= 5297.51250/10.45893=506.51; 
  
 
proc iml;
numdf=1;
dendf=14;
alpha=0.01;
critval = finv(1-alpha,numdf,dendf);
print critval;*8.862; 

*Here the critical value of F is 8.862. Since F* is far greater than F. So we reject the null and we conclude that beta_1 is not 
equal  zero and there is a strong linear relationship between hardness and time; 
 
  

*decision rule and conclusion:Here the critical value of F is 8.862. Since F* is far greater than F. So we reject the null and we conclude that beta_1 is not 
equal  zero and there is a strong linear relationship between hardness and time; 
 
*2.26(c); 

   ods graphics on;
   proc glm PLOTS=RESIDUALS  ;
      model hardness=time;
   run;
   ods graphics off; 
    
   *2.26(c). From the two graphs we can say SSR appears to be the larger componenet of SSTO which implies larger R square.



 *2.26(d). we can calculate the R square through the relative magnitude of reduction in the variation  in Y when X is introduced by  
dividing SSR with SSTO. So R squared=SSR/SSTO=5297.51250/5443.93750=.9731, 
r=+sqrt(.9731)=+.9864. So there is almost perfect positive linear relationship between X and Y.
 
 
*2.31(a),(b); 
 
 
data crime_rate; 
infile "C:\Users\cinthia\Desktop\840\crime_rate.txt" dlm=' '; 
input diploma crime;
run; 
 
*here X= diploma Y=crime. 
here Ho:Beta_1= 0= no relattionship between X and Y 
        Ha:Beta_1<>0 = a linear relationship exist  
       alpha=.01(99%);   

proc reg data= crime_rate alpha=.01; 
model crime=diploma; 
run;  
  
*Here from the result viewer window we we can see MSR=547.12132 and MSE =32.50142,  F*= 547.12132/32.50142=16.83; 
 
 
proc iml;
numdf=1;
dendf=82;
alpha=0.01;
critval = finv(1-alpha,numdf,dendf);
print critval;*6.9544;

*Here the critical value of F is 6.9544. Since F* is greater than F. So we reject the null and we conclude that beta_1 is not 
equal  zero and there is a strong linear relationship exist between X and Y;  
 
 
/* *t test:We can see in anove table that, t*= -4.10 and abosulute value of -4.10 is 4.10; */

 
 
 data tcritival; 
alpha=.01; 
p= 1-alpha/2; 
df=82; 
critival=TINV(p,df); 
run; 
* Here t(1-alpha/2,n-2)=2.637.  

Here we see t*> t, so we conclude for alternative which means there is a linear relationship exist between X and Y  ; 
 
*In F test we also concluded for alternative like t. The value for p=.005 is same for F test and t test, and the p value is less 
than .01 which also indicates that we reject null and accept alternative.
 
 
2.31(c). ; 
*Without X model;

proc reg data=crime_rate alpha=.01; 
model crime=Diploma; *here y=crime, X=diploma; 
run; 
 
 
delete diploma;
print;
run;
 
 
*introduced is  X here;  
proc reg data= crime_rate alpha=.01; 
model crime=diploma; 
run;

 

*when X is introduced,the reduction of the total variation in crime is= SSE/SSTO=547.12132/3212.23810=.1703. This is relatively 
 small reduction; 
 
*2.31(d). r=-sqrt(.1703)=-.413. Here r is negative because of the downward slope.So there is negetive linear association.








 
 

 
 
 
 
 


