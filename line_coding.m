close all;
bits=[1 0 1 0 0 0 1 1 0];
bitrate=1; %bits per second
%ALOK YADAV 2019BECE033

T=length(bits)/bitrate;  %time of bit sequences
n=200;
N=n*length(bits);
dt=T/N;
t=0:dt:T;
x=zeros(1,length(t));

%Unipolar NRZ
for i=0:length(bits)-1
  if bits(i+1)==1
    x(i*n+1:(i+1)*n)=1;
  else 
    x(i*n+1:(i+1)*n)=0;
  end

end

figure ;
plot(t,x,'LineWidth',2);
axis([0 t(end) -0.1 1.1])
grid on;
title(['2019BECE033 Unipolar NRZ: ',[num2str(bits)]]);


%Polar RZ
for i=0:length(bits)-1
  if bits(i+1)==1
    x(i*n+1:(i+0.5)*n)=1;
    x((i+0.5)*n+1:(i+1)*n)=0;
  else 
    x(i*n+1:(i+0.5)*n)=-1;
    x((i+0.5)*n+1:(i+1)*n)=0;
  end

end

figure ;
plot(t,x,'LineWidth',2);
axis([0 t(end) -1.1 1.1])
grid on;
title(["2019BECE033 Polar RZ: ",num2str(bits)]);

%Manchester coding
for i=0:length(bits)-1
  if bits(i+1)==1
    x(i*n+1:(i+0.5)*n)=1;
    x((i+0.5)*n+1:(i+1)*n)=-1;
  else 
    x(i*n+1:(i+0.5)*n)=-1;
    x((i+0.5)*n+1:(i+1)*n)=1;
  end

end

figure ;
plot(t,x,'LineWidth',2);
axis([0 t(end) -1.1 1.1])
grid on;
title(['Manchester: 2019BECE033 ',[num2str(bits)]]);