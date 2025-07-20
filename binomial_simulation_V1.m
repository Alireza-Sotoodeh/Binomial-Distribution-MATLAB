%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%{
This program was written by Dr. Amir Zaimbashi at Shahid Bahonar
University of Kerman, Kerman, Iran (a.zaimbashi@uk.ac.ir)
Edited by: Alireza Sotoodeh(Student ID:401412056) 
Subject:
%}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
clc
close all
%-------------------------------------------------------------------------
n=100;
p=0.4;
q=1-p;
s=n*p*q;
mu=n*p;
mu2=n*q;
k=0:1:n;

for u=1:length(k)

%p2(u)=factorial(n)/(factorial(n-k)*factorial(k))*p^k*((1-p).^(n-k));

p2(u)=nchoosek(n,k(u))*p^k(u)*((1-p).^(n-k(u)));

po(u)=exp(-(mu))*((mu)^k(u)/factorial(k(u)));

f(u)=1/sqrt(2*pi*s)*exp(-(k(u)-mu)^2/(2*s));

end

stem(k,p2)

hold on

stem(k,po)

hold on

plot(k,f)

hold on

plot(n*p-3*sqrt(n*p*q).*ones(1,10),0:max(f)/10:max(f)-max(f)/10,'r')

hold on

plot(n*p+3*sqrt(n*p*q).*ones(1,10),0:max(f)/10:max(f)-max(f)/10,'r')

legend('Binomial','Poisson','Gaussian')

ylabel('pdf')

xlabel('k')

set(get(gca,'XLabel'),'Interpreter','latex', 'FontSize',10)

set(get(gca,'YLabel'),'Interpreter','latex', 'FontSize',10)

set(get(gca,'legend'),'Interpreter','latex', 'FontSize',9