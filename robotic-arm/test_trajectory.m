% following a pre-defined trajectory.
clc
clear
close all

%% initial conditions
a1 =1;
b1 = 1;
theta1=pi/12;
theta2=pi/12;
theta3=pi/12;
L1=1;
L2=1;
L3=1;
deltatheta1=0;
deltatheta2=0; 
deltatheta3=0; % theta1,2,3 velocity
Xc=2.9; 
Yc=0.1; % ending point
a = 0;
b = 0;

%% moving initial point to ending point
while a == 0 
   while b == 0
       theta1=theta1+deltatheta1/4;
       theta2=theta2+deltatheta2/4;
       theta3=theta3+deltatheta3/4;

       % Jacobian matrix and inverse Jacobian.
       J= [-L1*sind(theta1)-L2*sind(theta1+theta2)-L3*sind(theta1+theta2+theta3),...
       -L2*sind(theta1+theta2)-L3*sind(theta1+theta2+theta3),...
       -L3*sind(theta1+theta2+theta3);...
       L1*cosd(theta1)+L2*cosd(theta1+theta2)+L3*cosd(theta1+theta2+theta3),...
       L2*cosd(theta1+theta2)+L3*cosd(theta1+theta2+theta3),...
       L3*cosd(theta1+theta2+theta3)];
       W = eye(3);
       lambda = 0.3;
       pseudoJ = inv(J'*J+lambda.*W)*J'; 
     
       % end-effector location
       P3 = [L1*cosd(theta1)+L2*cosd(theta1+theta2)+L3*cosd(theta1+theta2+theta3),...
       L2*sind(theta1)+L2*sind(theta1+theta2)+L3*sind(theta1+theta2+theta3)];
       % center
       P0 = [0 0];
      
       % location of the middle two joints
       P1 = [L1*cosd(theta1) ; L1*sind(theta1)]';
       P2 = P1 + [L2*cosd(theta1+theta2);L2*sind(theta1+theta2)]';
 
       Q1=[P0(1,1) P1(1,1) P2(1,1) P3(1,1)];
       Q2=[P0(1,2) P1(1,2) P2(1,2) P3(1,2)];

       Plot = plot(Q1,Q2,'-o','LineWidth',4);
       plot(P3(1,1),P3(1,2),'b.');
       axis([-4,4,-4,4]);
       axis square
       grid on;
       hold on
       Xinit=P3(1,1);
       Yinit=P3(1,2);
       Xend=Xc;
       Yend=Yc; 
       Xspeed=(Xend-Xinit);
       Yspeed=(Yend-Yinit);     
       OrinEnd=atan2d(Yend,Xend);
       Orininit=atan2d(Yinit,Xinit);
       orin_error=OrinEnd-Orininit;
       if  abs(orin_error)<=0.02
           b=1;
       end
     
       thetadot=pseudoJ*[Xspeed;Yspeed];
       theta1dot=thetadot(1,1);
       theta2dot=thetadot(2,1);
       theta3dot=thetadot(3,1);
       deltatheta1=rad2deg(theta1dot); 
       deltatheta2=rad2deg(theta2dot);
       deltatheta3=rad2deg(theta3dot);
       pause(0.01);

       delete(Plot);
   end
   %% for taking new input 
   if b==1   
       X = [2.9, 0;
           2.8 0.1;
           2.7 0.2;
           2.6 0.3;
           2.5 0.4;
           2.4 0.5;
           2.3 0.6;
           2.2 0.7;
           2.1 0.8;
           2   0.9;
           1.9 1;
           1.8 1.1;
           1.7 1.1;
           1.6 1.1 ;
           1.5 1.1;
           1.4 1.1;
           1.3 1.1;
           1.2 1.1;
           1 1;
           1.1 1.2;
           1.2 1.3;
           1.2 1.4;
           1.2 1.5;
           1.25 1.6;
           1.3 1.7;
           1.3 1.6;
           1.3 1.5;
           1.25 1.5;
           1.2 1.6;
           1.3 1.7;
           1.3 1.8;
           1.3 1.9;
           1.25 2.0;
           1.2 2.1;
           1.1 2.2;
           1   2.3;
           0.9 2.4;
           0.8 2.5;
           0.7 2.6;
           0.6 2.7;
           0.5 2.8;
           0.4 2.9;
           0.3 3;
           0.2 3.1;
           0.1 3.2;
           -0.1 3.3;
           -0.2 3.4;
           -0.3 3.5;
           -0.4 3.1;
           -0.5 2.9;
           -0.5 2.8;
           -0.6 2.7;
           -0.7 2.6;
           -0.8 2.5;
           -0.8 2.4;
           -0.86 2.3;
           -0.9 2.2;
           -0.95 2.1;
           -1 2];
       
       %% to take input from trajectory matrix X
       for a1 = a1
           for b1 = b1
               d1 = b1+1;
           end
           c1 = a1;
       end
       Xc = X(a1,b1);
       Yc = X(c1,d1);
       a1 = a1+1;
       b=0;
    end
end
