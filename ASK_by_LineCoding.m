%ASK using linecoding
bits = [1 0 1 0 1 0 0 1 1 0 1];
bitrate = 1; % bits per second
T = length(bits)/bitrate; 
n = 200;
N = n*length(bits);
dt = T/N;
t = 0:dt:T;
x = zeros(1,length(t)); 

%% Unipolar NRZ
for i = 0:length(bits)-1
  if bits(i+1) == 1
    x(i*n+1:(i+1)*n) = 1;
  else
    x(i*n+1:(i+1)*n) = 0;
  end
end

fc=5;
c=amp.*sin(2*pi*fc*t);
subplot(3,1,1) %
plot(t,c)
xlabel('Time')
ylabel('Amplitude')
title('Carrier Wave')


m=1*square(2*pi*fp*t)+1;
subplot(3,1,2) 
plot(t,x+1,'LineWidth',4)
xlabel('Time')
ylabel('Amplitude')
title('Binary Message Pulses')


w=c.*(x+1); 
subplot(3,1,3) 
plot(t,w)
xlabel('Time')
ylabel('Amplitude')
title('Amplitide Shift Keyed Signal')
