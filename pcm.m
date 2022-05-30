clc;
close all;
clear all;
n=input('Enter for n-bit PCM system: ');  %encoded bit;
n1=input('Enter sampling frequency: ');  %sampling frequency
L=2^n;  %quantization levels

%%Anlog signal and its sampled form
Vmax=4;
x=0:pi/n1:4*pi;
InputSignal=Vmax*sin(x);
subplot (3,1,1); 
grid on 
plot(InputSignal);  %Analog signal 
title('Analog Signal'); 
subplot (3,1,2); 
stem (InputSignal);  % Sampled Signal grid on;
grid on;
title('sampled signal');

%%Quantization process
Vmin=-Vmax;
Stepsize=(Vmax-Vmin)/L;  %differene btw each quantization level
Partition=Vmin:Stepsize:Vmax;  %quantization levels-partione
codebook=Vmin-(Stepsize/2):Stepsize:Vmax+(Stepsize/2); %quantization vales_as final outpu

[ind,q]=quantiz(InputSignal,Partition,codebook);%it is command for quantize value to store in Q
%Quantization process
NonZeroInd=find(ind~=0);%ind provides Index
ind(NonZeroInd)=ind(NonZeroInd)-1;

BelowVmin=find(q==Vmin-(Stepsize/2));
q(BelowVmin)=Vmin+(Stepsize/2);

%AboveVmax=find(q==Vmax+(Stepsize/2);

subplot(3,1,3);
stem(q);
grid on;  %display the quantization values
title('Quantized Signal');

%Encoding process
figure
TransmittedSig=de2bi(ind,3,'left-msb'); %encode the quantization level
%by default de2bi give right msb
%Y=TransmittedSig'
encode=reshape(TransmittedSig',[1,size(TransmittedSig,1)*size(TransmittedSig,2)])
subplot(2,1,1);
grid on;
stairs(encode)  % display the serial code bit stream
axis([0 100 -2 3]) ;
title('TransmittedSig sign3al');
%% Demodulation of pcm signal

RecevedCode=reshape(encode,n,length(encode)/n);
%Again convert the serialcode into frame of 1 byte
decode_sig=bi2de(RecevedCode',3,'left-msb');
%binary to decimal conversion
q=(Stepsize*decode_sig);  %convert into voltage values 
q=q+(Vmin+(Stepsize/2));  %above gives a DC shifted version of Actual signal
%Thus it is necessary to bring it to zero levels

subplot(2,1,2);
grid on;
plot(q); %plot demodulation signal
title('Demodulated Siganl');