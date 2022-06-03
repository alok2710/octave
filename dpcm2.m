clc;
clear all;


sig=[0 0.3 0.6 1 1.3 1.5 1.3 1 0.6  0.3 0 -0.3 -0.6 -1 -1.3 -1.5 -1.3 -1 -0.6 -0.3 0];
L=length(sig);
n=0:L-1;
subplot(221);
stem(n,sig,'r');
delaysig=[0 sig(1:end-1)];


diffsig=sig-delaysig;
subplot(222);
stem(n,diffsig,'g*');
%quantization
QSIG=[];
for i=1:L
    if diffsig(i)>0.3
        Qsig=0.5;
    elseif diffsig(i)>=0.1
        Qsig=0.25;
         elseif diffsig(i)>=0
        Qsig=0.1;
    elseif diffsig(i)<-0.3
        Qsig=-0.5;
        elseif diffsig(i)<-0.1
        Qsig=-0.25;
    elseif diffsig(i)<=0
        Qsig=-0.1;
    end
    QSIG=[QSIG Qsig];
end
hold on;
stem(n,QSIG,'b');

subplot(223);
stem(n,QSIG,'g*');

pred=0;
xcap=[];
for j=1:L
    xcapint=pred+QSIG(j);
    xcap=[xcap xcapint];
    pred=xcapint;%prediction filter
end
subplot(224);
stem(n,xcap,'k*');
hold on;
stem(n,sig,'mo');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc;
clear all;

fm=1;
fs=20*fm;
A=2;
t=0:1/fs:2;
sig=sin(2*pi*fm*t);

for i=1:length(sig)
    if i==1
        diffsig(i)=sig(i)-0;
        qsig(i)=round(diffsig(i));
        xcap(i)=qsig(i);
    else diffsig(i)=sig(i)-xcap(i-1);
        qsig(i)=round(diffsig(i));
        xcap(i)=qsig(i)+xcap(i-1);
    end
end

for i=1:length(sig)
    if i==1
       xcapr(i)=qsig(i);
    else 
        xcapr(i)=qsig(i)+xcapr(i-1);
    end
end
plot(t,xcapr);
hold on;
plot(t,sig);
