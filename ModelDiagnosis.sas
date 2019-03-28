 
//*  Name:Naimon Hafiz; 
Homework 7(chapter 9), stat 840;* //


 /*Here y=length of stay x1=age x2=infection risk x3=routine culturing ratio x4= Routine chest x-ray ratio x5=number of beds 
x6=average daily census x7= number of nurses x8=available facilities and services*/
 
 
*9.25(a);
data senic; 
infile "C:\Users\cinthia\Desktop\840\senic(57-113).txt" dlm=' '; 
input ID Y x1 x2 x3 x4 x5 x6 Msa region x7 x8; 
run; 
 
data senic2; 
set senic; 
y2=log10(y); 
run;
title senic;
proc glm data=senic2; 
model y2= x1 x2 x3 x4 x5 x6 x7 x8; 
output out=senic3 r=ehat p=yhat; 
run; 
  

Title dot plot between y2 and x1;*x1=age;
proc sgplot data=senic3;
  dot y2/response = x1 stat=mean limits=both 
   Limitstat=studdev numstd=1;
run;  
*Comment:The ages appear to be spread evenly throughtout this interval.There are also no unusually large or small observation;
 
  
Title "dot plot between y2 and x2";*x2=infection risk;
proc sgplot data=senic3;
  dot y2/response = x2 stat=mean limits=both 
   Limitstat=studdev numstd=1;; 
 
run;  
 *Comment:The infection risk appear to be spread evenly throughtout this interval.There are also no unusually large or small  
 observation;
 

 

 
 Title "dot plot between y2 and x3" ;*x3=routine culturing ratio;;
proc sgplot data=senic3;
  dot y2/response = x3 stat=mean limits=both 
   Limitstat=studdev numstd=1; 
  
run;  
*Comment:The routine culturing ratio appear to be spread evenly throughtout this interval.Though there is one x3 oberservation 
which is little far but its y2 value is with in the limit. 
 
 
Title "dot plot between y2 and x4";*Routine Xray;
proc sgplot data=senic3;
  dot y2/response = x4 stat=mean limits=both 
   Limitstat=studdev numstd=1;  
run; 
 
*Comment:The routine Xray appears to be spread evenly throughtout this interval.but one x value is little far where x4=133 and  
its observation number is 48.;  
 
 Title dot plot between y2 and x5;*x5=number of beds;
proc sgplot data=senic3;
  dot y2/response = x5 
 stat=mean limits=both 
   Limitstat=studdev numstd=1; 
run;  
  
*Comment:The number of beds does not appear  to be spread evenly.There are some large and samall observation of x in their 
head and tail area.;
 
 
Title "dot plot between y2 and x6"; *X6= average daily census;
proc sgplot data=senic3;
  dot y2/response = x6 stat=mean limits=both 
   Limitstat=studdev numstd=1; 

run;  
 
*Comment: I think this plots looks good because there are only two types of x6 observations;
 
Title dot plot between y2 and x7;*x7=number of nurses;
proc sgplot data=senic3;
  dot y2/response = x7 stat=mean limits=both 
   Limitstat=studdev numstd=1; 
  
run; 
 
*Comment: There are one or two x7 values are little far from the cloud;
 
 Title dot plot between y2 and x8;*x8=available facilities and services;
proc sgplot data=senic3;
  dot y2/response = x8 stat=mean limits=both 
   Limitstat=studdev numstd=1; 
  
run; 
 
*Comment: There is one value of available facilities and services looke unusually low,rest of them spread evenly. 
   
 
*9.25(b); 
proc iml; 
varnames= {"x1" "x2" "x3" "x4" "x5" "x6" "x7" "x8"}; 
use work.senic3; 
read all var varnames into x;  
close work.senic3;

print x;

varnames= {"y2"}; 
use work.senic3; 
read all var varnames into y;  
close work.senic3;

print y;
quit; 
 
proc sgscatter data=senic3;
title "Scatterplot Matrix for brand";
matrix y2 x1 x2 x3 x4 x5 x6 x7 x8;
run; 
 
 proc corr data= senic3 plots= matrix(histogram);
  
var y2 x1 x2 x3 x4 x5 x6 x7 x8;
run;  
 
*From the corelation matrix of the x variables i see strong pairwise association between x5 and x7 which is almost 90%,and between 
x5 and x8 which is almost 76% and between x8 and x7 which is almost 70 percent.All of them are also significant.  
 
 
 
*9.25(c);
  proc reg data=senic3 outsscp=sscp;
      var x1 x2 x3 x4 x5 x6 x7 x8;
   proc print data=sscp;
   run; 
 
  proc reg data=senic3 outest=est;
      model Y2=x1 x2 x3 x4 x5 x6 x7 x8
            / selection=rsquare mse jp gmsep cp aic bic sbc b best=1;
   proc print data=est;
   run; 
    
   * from the cp value i have selected 3 subsets model..model 1 contains 5 parameters with x2 x4 x5 x6 where cp=4.99 
   model 2 contain 6 parameters with x1 x4 x5 x6 x7 where cp=5.97 
   model 3 contain 7 parameters with x1 x2 x4 x5 x6 x7 where cp=6.62 
   I have seleted model-1 as the best model based on the cp riterion: 
  Y2=beta_O+beta2 x2+Beta4 x4+Beta5 x5+Beta6 x6+epsilon
   ; 
  
    
    
    
   *9.27(a); 
 
 *best model from 9.25 problem on Cp crtiterion :Y2=beta_O+beta2 x2+Beta4 x4+Beta5 x5+Beta6 x6+epsilon; 

title "model building dataset";
proc glm data=senic2; 
model y2= x2 x4 x5 x6; 
output out=senic3 r=ehat p=yhat; 
run;  
 
    

data senicc; 
infile "C:\Users\cinthia\Desktop\840\senicc(1-56).txt" dlm=' '; 
input ID Y x1 x2 x3 x4 x5 x6 Msa region x7 x8; 
run;
 
data senicc2; 
set senicc; 
y2=log10(y); 
run;


title  "model validation dataset";;
proc glm data=senicc2; 
model y2= x2 x4 x5 x6 ; 
output out=senicc3 r=ehat p=yhat; 
run;   
 
/* comparison between Senicc3_Validation_dataset(1-56) and senic3(57-113)


Senicc3(1-56)-model validation 
 
 Parameter Estimate    Standard Error t Value Pr > |t| 
Intercept 0.7701471231 0.07327076     10.51   <.0001 
x2        0.0273260098 0.00756609     3.61    0.0007 
x4        0.0004837747 0.00048732     0.99    0.3255 
x5        0.0000747466 0.00005003     1.49    0.1414 
x6        0.0176944465 0.02755055     0.64    0.5236 





senic3(57-113-Model building 
 Parameter Estimate    StandardError t Value Pr > |t| 
Intercept 0.9018858195 0.07235587    12.46   <.0001 
x2        0.0079064205 0.00738515    1.07    0.2893 
x4        0.0012636741 0.00045878    2.75    0.0081 
x5        0.0001286084 0.00006098    2.11    0.0398 
x6        -.0549520066 0.02889228   -1.90    0.0627 



 

From this two regression analysis We can see that there are not that much diferences betweens intercept,x2, x4 and x5 regression 
coefficient. We can see some difference in x6 regression coefficient.This can certainly a cause problem.
We are not seeing any major differences in their standard deviation.

The error mean squares of validation data set is 0.00376733 and MSE of model building data set is 0.00333597,which are very 
close. 
The co-eeficient of multiple determinations model building and model validation dataset are 0.484558 and 0.382300 
which has little diffrence but not that significant.*/ 
 
 
 
*9.27(b) mean squared prediction for senic 3; 
 
  
*model validation; 
proc glm data=senicc2; 
model y2= x2 x4 x5 x6; 
output out=senic33 r=ehat p=yhat; 
run; 
 
data senic4; 
set senic33; 
MSPR=y2-ehat; 
MSPR1=sum(y2-ehat)**2;
run; 
 
 proc summary data=senic4; 
 var MSPR1; 
output out=ASE sum=sum n=n;  
run;  
 
 
* MSRP= Sum/number of cases in validation dataset= 56.1299/56=1.00, and the MSE of the model building data set is .00333597.  
So They are close . I dont thinkd there is a evidence of a substantial bias problem in MSE here.; 
 
 *9.279(c); 
 data senic; 
infile "C:\Users\cinthia\Desktop\840\senic.txt" dlm=' '; 
input ID Y x1 x2 x3 x4 x5 x6 Msa region x7 x8; 
run; 
 
data senicfull; 
set senic; 
y2=log(y); 
run; 
 
 
proc glm data=senicfull; 
model y2= x2 x4 x5 x6; 
output out=senicful1 r=ehat p=yhat; 
run;  

 
 
/*full with selected model
Parameter Estimate    StandardError t Value Pr > |t| 
Intercept 1.898227491 0.11870016    15.99   <.0001 
x2        0.046297574 0.01200237    3.86    0.0002 
x4        0.001926303 0.00077815    2.48    0.0149 
x5        0.000228866 0.00009001    2.54    0.0124 
x6       -0.034970793 0.04592440    -0.76   0.4480  


senic3(57-113-Model building 
 Parameter Estimate    StandardError t Value Pr > |t| 
Intercept 0.9018858195 0.07235587    12.46   <.0001 
x2        0.0079064205 0.00738515    1.07    0.2893 
x4        0.0012636741 0.00045878    2.75    0.0081 
x5        0.0001286084 0.00006098    2.11    0.0398 
x6        -.0549520066 0.02889228   -1.90    0.0627 



 
  */  
 * Here i can not see any major estimate difference in x2 x4 x5 and x6, only little diffrence in intercept which is acceptable. 
And the standard  deviation for this variables are also close.  
 
 

 
 
 



 

 

 
 


 
 
 
  

    
