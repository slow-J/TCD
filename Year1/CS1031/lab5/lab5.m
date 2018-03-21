size =1000000;                              %BER = 10^-5 in question, so size = 10^6 (Question)
QAM = 4;


while QAM <= 256                            %test QAM's : 4,16,64,256
    SNR=0;                                  %Have to test compare sound noise ratio(SNR) to bit rate error (BER) for each QAM
    wrongBits = [];                         %array to count the number of bit errors between origial signal and demodulated signal
    stream=randi([0 QAM-1], size, 1);       %generates random stream of bits
    mod = qammod(stream, QAM);              %modulates the signal using specified QAM
    while SNR <=35                          %vary SNR between 0-35 at intervals of 2(in Q) chose 35 cause thats what marcos graph goes up to
        signal_noise=awgn(mod, SNR, 'measured');%add noise to the modulated signal (function given in question)
        Dem=qamdemod(signal_noise, QAM);    %demodulate signal
        index = 1;                          %below is a for loop that compares the original signal to the demodulatd one and counts the number of differences (errors) between the 2
        bitError = 0;
        while index < length(stream)
            originalBit = stream(index);
            demodulatedBit = Dem(index);
            if originalBit ~= demodulatedBit
                bitError= bitError+1;
            end 
            index=index+1;
        end
    BER = bitError / length(Dem);            % bit error ratio = number of wrong bits / total number of bits
    wrongBits = [wrongBits BER];             %store bit error ratio for this specific SNR in an array
    SNR = SNR +1;                            %increase SNR and run test again
end
axis([0 35 (10^-6) (10^0)]);                 %set up axis for plot
semilogy(wrongBits);                         %plot using the function
hold on;
QAM = QAM*4;                                 %move to next QAM, run again
end





;;;;;;;;;;;;;
part 2:
size = 10^4;



QAM=16;
SNR =20;
stream=randi([0 QAM-1], size, 1);
mod = qammod(stream, QAM);
signal_noise=awgn(mod, SNR, 'measured');
const=comm.ConstellationDiagram('ShowReferenceConstellation',false, 'XLimits', [-4 4], 'YLimits', [-4 4]);
step(const, signal_noise);
Dem=qamdemod(signal_noise, QAM);
