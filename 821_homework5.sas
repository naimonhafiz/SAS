libname orion "C:\Users\cinthia\Desktop\spring2018\SAS P3 Data\SAS P3 Data";

*Chapter 3:
Level 2
1.	Creating Reduced Length Numerics and Precision
a.   Open the program p303e05 and submit it.
p303e05;

data five;
   length Num5 5 Num8 8;
   do Num8=1e10 to 1e13 by 1e11;
      Num5=Num8;
      output;
   end;
run;

proc print data=five;
   title 'Reducing the length of numeric data to 5';
   format Num5 Num8 20.;
run;

*b.   At what point in the sequence of numbers does the length of the variable Num5 lose precision?;
*Answer: At 7th observations it started losing precision;


*Level 2
2.	Creating a DATA Step View
a, b;

data ccdonations/view = ccdonations;
set orion.employeedonations;
where PaidBy ='Credit Card';

if PaidBy ='Credit Card' then TotalDonations = Qtr1+Qtr2+Qtr3+Qtr4;

If TotalDonations<100 then DonationCategory = "Less Than 100";
Else DonationCategory = "$100 or More";

run;


*2.c;
proc means data=ccdonations sum n nonobs maxdec=2;
   class DonationCategory;
   var TotalDonations;
run;


*2.	Creating a DATA Step View;
*d.   Create an identical view, named ccdonationssql, but use PROC SQL instead of a DATA step.;

proc sql;
create view ccdonationssql as
select 
	e.*, 
	Qtr1+Qtr2+Qtr3+Qtr4 as TotalDonations, 
	case 
		when Qtr1+Qtr2+Qtr3+Qtr4 <100 then "Less Than 100"
		else  "$100 or More"
	end as DonationCategory
from orion.employeedonations e 
where PaidBy ='Credit Card';
quit;



*Chapter 5
Level 1
*1.   Using a One-Dimensional Array to Combine Data;

data compare;
keep CustomerID EmployeeID StreetID OrderDate DeliveryDate OrderID Month MedianRetailPrice;

array retail{1:12} Month1-Month12;
if _n_=1 then set orion.retailinformation
(where=(Statistic='MedianRetailPrice'));

set orion.retail;
Month = Month(OrderDate);
MedianRetailPrice = retail{Month};

run;

*Print first 5 observations;
proc print data=compare(obs=5);
run;




*Chapter 7
Level 1
1.   Merging or Joining Data to Create Multiple Data Sets;
*a and b;

/* Name: Naimon Hafiz 
Homework Assignment 5/ Exam 3  
Date: 05-13-2018  *////



libname orion "C:\Users\cinthia\Desktop\spring2018\SAS P3 Data\SAS P3 Data";

proc sort data=orion.orderfact;
by CustomerId;

data nopurchases;
keep CustomerId CustomerName;

merge orion.orderfact(in=S keep=CustomerId) orion.customerdim(in=A keep=CustomerId CustomerName);
by CustomerId;
if not S; *Only customers who did not place orders;

run;


data purchases;
keep CustomerId CustomerName ProductId OrderId Quantity TotalRetailPrice;

merge orion.orderfact(in=S keep=CustomerId ProductId OrderId Quantity TotalRetailPrice) orion.customerdim(in=A keep=CustomerId CustomerName);
by CustomerId;
if A and S; *Only products that has been ordered;

run;

proc sort data=orion.orderfact;
by ProductId;


data noproducts;
keep ProductId ProductName SupplierName;

merge orion.orderfact(in=S keep=ProductId) orion.productdim(in=A keep=ProductId ProductName SupplierName);
by ProductId;
if not S; *Only products that has no orders;

run;

*Print first 5 observations;
proc print data=nopurchases(obs=5) noobs;
   title 'Partial nopurchases Data Set';
run;

*Print first 5 observations;
proc print data=purchases(obs=5) noobs ;   
   title 'Partial purchases Data Set';
run;

*Print first 5 observations;
proc print data=noproducts(obs=5) noobs;
   title 'Partial noproducts Data Set';
run;



*4.   Combining Summary Data with Multiple Statistics with Detail Data;

data compare(drop=i);
if _N_=1 then do i=1 to TotObs;
	set orion.employeedonations(keep=Qtr1 Qtr2 Qtr3 Qtr4) nobs=TotObs;
	if Qtr1 = null then Qtr1=0; *replace nulls with 0;
	if Qtr2 = null then Qtr2=0;
	if Qtr3 = null then Qtr3=0;
	if Qtr4 = null then Qtr4=0;
	GrandTot + Qtr1 + Qtr2 + Qtr3 + Qtr4; *Accumulate total;
end;

set orion.employeedonations;
if Qtr1 = null then Qtr1=0; *replace nulls with 0;
if Qtr2 = null then Qtr2=0;
if Qtr3 = null then Qtr3=0;
if Qtr4 = null then Qtr4=0;

EmpContrib = Qtr1 + Qtr2 + Qtr3 + Qtr4; *Accumulate total for all quarters;
Avg = round(GrandTot/TotObs,0.01);
Difference = Avg - EmpContrib;

run;

*Print first 5 observations;
proc print data=compare(keep=EmployeeId EmpContrib Avg Difference obs=5) noobs;
   title 'Compare Data Set';
run;
