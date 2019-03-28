 /* Name: Naimon Hafiz 
  Homework_8 stat 840*/
 
 
  
*Here X1=age and y= muscle mass; 

data muscle; 
infile "C:\Users\cinthia\Desktop\840\muscle_mass.txt" dlm=' '; 
input Y X1; 
run;

data muscle2;
set Muscle;
x1sqr=x1*x1;
run;
*8.4(a);
ods graphics on;

proc reg data=muscle2 alpha=.05 ;*quadratic regression;
model Y=x1 x1sqr  ;
run; 

ods graphics off; 
*Here R square is .7632.; 
 
 

proc reg data=muscle2 alpha=.05 ;* without x1sqr, no plynomial;
model Y=x1  ;
run; 

ods graphics off; 
*Here R square is .7501. 
Though R square is slightly higher in  quadratic equation so i think quadratic equation appears to be a good fit here.;  
 
*8.4(b) 
My model is- 
Y=Beta_0+Beta_1 X1+Beta_11 X1xqr 
 
here Ho:Beta_1=beta_11= 0= no relattionship between X and Y 
        Ha:Beta_1 and beta_11<>=0 =  relationship exist  
       alpha=.05(99%) 
Here F=91.84; 
 
 
proc iml;
numdf=2;
dendf=57;
alpha=0.05;
critval = finv(1-alpha,numdf,dendf);
print critval; *critical value of F is 3.16;
;   
	    
* decision rule and conclusion:Here the critical value of F is 3.16. Since F* is greater than F. So we reject the null and we  
conclude that beta_1 is not equal zero and there is a relationship. 
 
*8.4(c)  
 

 
Regression equation Y= 207.35-2.96 X1+ .015 X1sqr 
 when x= 48 Y=99.82 
*t critival value;
data tcritval;
*p = 1 - alpha/2, df = degrees of freedom;
alpha = 0.05;
p = 1 - alpha/2;
df = 57;
CritVal = TINV(p,df);
proc print data=tcritval; run;  

*t(.975,57)=2.002  
;
 
 
/*95% percent confidence interval for beta-1 is between 
   -2.96+/-(2.002*.1.003) 
   So -4.97<=Beta-1<=-.95 
   Interpretation- The interval method we used,It will caputure the true unknown value of beta_1 and the truth 
   is .95 out of 1 which means the chance to miss is only 5 percent;*/ 
  
/*95% percent confidence interval for beta_11 is between 
   .015+/-(2.002*.0084) 
   So -.002<=Beta-1<=.032 
   Interpretation- The interval method we used,It will caputure the true unknown value of beta_11 and the truth 
   is .95 out of 1 which means the chance to miss is only 5 percent;*/ 
 
*8.4(e); 
 proc reg data=muscle2;
      id x1;
      model y=x1 x1sqr / r cli clm;
   run; 
    
   *Prediction interval: 82.9116<= muscle mass<= 115.5976. Muscle mass for women whose age is 48 years old will be between  
82.92 to 115.5976. 
    
    
 *8.4(f):Y=Beta_0+Beta_1 X1+Beta_11 X1xqr ;  
   /*Ho(null):Beta_11=0 
   Ha(alternative)=Beta_11 Not equal 0 

   From test we can see that the p value of the quadratic term is .08 which is above our signifiacnec level.So we fail will reject 
   the null and will drop the quadratic term x1sqr. ;*/  
    
    
   *8.5(g);  
   
proc reg data=muscle2 alpha=.05 ;* without x1sqr, no plynomial;
model Y=x1  ;
run; 

ods graphics off; 

   *The fitted regression function with the original X variable is 

   Y=156.35-1.19 x1;   
 
*8.4(g); 
 ods graphics on;
title 'correlation';
proc corr data=muscle2 sscp cov plots;
   var  x1 x1sqr ;
run;
ods graphics off; 
 
  
Proc means data=muscle2 mean; 
var x1 x1sqr; 
run; 


data muscle3; 
set muscle2; 
x=X1-59.89; *Centered variable; 
xsqr= x1sqr-3734.85; *centered variable; 
run;  
 
 ods graphics on;
title 'correlation between centered variables';
proc corr data=muscle3 sscp cov plots;
   var  x xsqr ;
run;
ods graphics off; 
  
 
*The use of centered variable does not make any diffrence here. ; 
 
*8.11(a); 
 
data brand; 
infile "C:\Users\cinthia\Desktop\840\brand.txt" dlm=' '; 
input y x1 x2; 
run; 
 proc reg data=brand alpha=.05; 
model y=x1 x2; 
run; 
 
*Regression Model Y=36.65+4.43 x1+4.38 x2;

 
data brand1; 
set brand; 
x1x2=x1*x2; 
run; 
 
proc glm data=brand1 ; 
model y= x1 x2 x1x2; 
output out=brand2; 
run; 
 
  /* With interaction term the model is Y= Beta_0+Beta_1 x1+ Beta_2 x2+ Beta_3 x1x2 
Ho(null):Beta_3=0 
   Ha(alternative):Beta_3 id not equal 0 
  The p value of the interaction term is .097 which is above our significance level .05. So we will fail to reject the null and 
conclude that interaction term is not helpful and will drop the interaction term.*/  
 
 
*8.14- The positive coefficient b2 shows how much higher or lower the learning time for the class coded 1 than the class coded 0. 
here b2=22.3 which means male needs 22.3 higher learning time than female. 
  
 
  
 

 
