/* Name:Naimon Hafiz 
Homework 6 
Stat 840*/ 


*5.23(a)/1,2,3,4/;
data flavor; 
infile "C:\Users\cinthia\Desktop\840\flavor.txt" dlm=' '; 
input flavor weeks;
run; 
 
proc iml;
x = {1 8,
     1 4,
     1 0,
     1 -4,
     1 -8};
y = {7.8,9,10.2,11,11.7}; 
 

b = inv(x`*x) * x`*y; *vector of estimated regression coefficients, b_zero=9.94 ans b_one=-.245;  
print b; 
yhat = x*b;
r = y-yhat;*vector of residuals.
print yhat r; 
sse = ssq(r);
dfe = nrow(x)-ncol(x);
mse = sse/dfe;
print sse dfe mse; 
run;
 
*verified sse,mse,vector of residuals and vector of estimated regression coefficient ; 
proc reg data=flavor; 
model flavor=weeks; 
run;  
 
*5.23(c); 
proc iml;
x = {1 8,
     1 4,
     1 0,
     1 -4,
     1 -8};
y = {7.8,9,10.2,11,11.7}; 
 
H=x*inv(x`*x)*x`;*hat matrix; 
print H; 
I=I(5); 
s2=.0493*(I-H);*5.23(d).S_square(e); 
print s2 ; 
run; 
 
*6.5(a-d) 
*Here y=brandliking, X1= moisture content X2=sweetness;

data brand; 
infile "C:\Users\cinthia\Desktop\840\brand.txt" dlm=' '; 
input y x1 x2; 
run;  


proc glm data=brand; 
model y= x1 x2; 
output out=two r=ehat p=yhat; 
run;
  
*6.5(a);
proc sgscatter data=brand;
title "Scatterplot Matrix for brand";
matrix y x1 x2;
run; 

proc corr data= brand plots= matrix(histogram);
  
var y x1 x2;
run;  
 
*From the scatter plot matrix and correlation matrix we can see that the pearson coefficient betweeen brandliking and moisture 
 contents is r=.89 which is showing strong linear realtionship. On other hand  the pearson coefficient betweeen brandliking and  
sweetness is r=.39 which is little low. 
 
 
ods graphics on; 
 
/*6.5(b) 
Regression model: Brabdliking=Beta_0+Beta_1*X1(moisture content)+Beta_2*X2(sweetness)+ epsilon 
Regression Function: Y=37.650+4.425x1+4.375x2 
Here b_1=4.45 which indicates the change in Brandliking by 4.425 with per unit increase in moisture content when sweetness  
held costant.*/;  
 
*6.5(c)box plots of residuals;  
data brand1;
set two;
group=1;
run;
title box plot of residuals;
proc boxplot data=brand1;
   plot ehat*group / horizontal;
 
run;  
 
*Here we can see the box plot of reisidual of 16 observations.The residuals are very symetrically distributed because the median is 
located in middle of the box. 
 
*6.5(d); 
 
proc plot data=brand1; 
title "plot of residuals angaint Y-hat"; 
plot ehat*yhat; 
run; 
 
*In the redidual and yhat plot we can see that the residuals and the fitted values are uncorelated.So its good.;
 
proc plot data=brand1; 
title "plot of residuals againt X1"; 
plot ehat*x1; 
run; 
*In residual vs X1 plot we can see that the plots bounce randomly and form a horizontal band around the residul=0. So its a good 
fit. 
 
proc plot data=brand1;  
title "plot of residuals angaint X2"; 
plot ehat*x2; 
run; 
* In this reidual vs X2 plot we can see its a non linear fit; 
 
data brand2;
set brand1;
group1=x1*x2;
run; 
proc plot data=brand2;  
title "plot of residuals angaint X1X2"; 
plot ehat*group1; 
run; 
*residual vs x1x2 plots  its showing positive linear relationships with some outliers.  

 ods graphics on;
Title QQ plot;
 proc reg data=brand2 plots(only)=qq;
 model y=x1 x2;
 run; 
 title;
*the normal probablity plot of residuals show more or less  normality here. 






 
 

run;
 
 
