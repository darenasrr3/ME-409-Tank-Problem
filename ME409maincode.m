clear
clear all
clc

% Tank 1
% Y'= Inflow/Min - Outflow/Min
% Y'= -a11(Y1)+ a12(Y2)
b=6;
c=100;
a12=b/c
d=16;
f=200;
a11=-d/f
% Tank 2
% Y'= Inflow/Min - Outflow/Min
% Y'= a21(Y1)+ a22(Y2)
d=16;
f=200;
a21=d/f
g=10;
h=100;
i= 6;
a22= -i/h-g/h

A =[a11 a12;a21 a22]
P = poly(A)
roots(P)
% Eigenvalues
Eigenvalues = eig(A)
% Eigenvectors
[V,D] = eig(A);
V1 = V(:,1);
V11 = V1/V(1,1);
V2 = V(:,2);
V22 = V2/V(1,2);

Vectors = table(V22,V11) 
% Displaying Eigenvalues and Eigenvectors in a table
K = table (Eigenvalues,V22,V11)
%  C1 + 1.5C2 = 160
% -2C1 + C2   =  0 
J = [V22,V11]
b = [160;0];
% Solving for Constants
C = inv(J)*b
%  Y1 = 40 e^(-0.2)t + 120 e^(-0.04)t
%  Y2 = -80 e^(-0.2)t + 80 e^(-0.04)t

% To plot y(t) we must model y(t) = C1(y1)+C2(y2) 
% Where C are the constants C1 and C2 
t = [0 27.5 50 100]';
y = [160 40.1080 16.2420 2.1979]';
T = (0:27.5:50:100)';
%  Modeling y(t) = C1(y1)+C2(y2)= 40 e^(-0.2)t + 120 e^(-0.04)t
Y1 = [exp(-0.2*T) exp(-0.04*T)]*C;
% % % Solving for T and Y
%  Modeling y(t) = C1(y1)+C2(y2)= -80 e^(-0.2)t + 80 e^(-0.04)t
z =[-80 80]'
Y2 = [exp(-0.2*T) exp(-0.04*T)]*z
% Displaying Tables for T,Y1 and T2,Y2
B = table(T,Y1)
w = table(T,Y2)
plot(T,Y1,'-',t,y,'o',T,Y2,'r')
title('y(t) vs. Time (Minutes)') 
xlabel('Time (Minutes)')
ylabel(' y(t)')
grid
