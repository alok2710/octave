clc;
clear all;


fm=1;


fs=20*fm;

A=1;

t=0:1/fs:1;

sig=sin(2*pi*fm*t);



d=0.8*(2*pi*fm*A/fs);



for i=1:length(sig)
    if i==1
        diffsig(i)=sig(i)-0;
        qsig(i)=d*sign(diffsig(i));
        xcap(i)=qsig(i);
    else diffsig(i)=sig(i)-xcap(i-1);
        qsig(i)=d*sign(diffsig(i));
        xcap(i)=qsig(i)+xcap(i-1);
    end
end
%recons
for i=1:length(sig)
    if i==1
       xcapr(i)=qsig(i);
    else 
        xcapr(i)=qsig(i)+xcapr(i-1);
    end
end
plot(t,sig);
hold on;
stairs(t,xcapr);


