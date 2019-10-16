clear

rate = 44100; %Hz          --the number of individual samples per second
freq = 440; %Hz     --the frequency of the sine wave
duration = 5; %sec       --the length of time that the sine wave plays
bits = 16;
mono = 1;
recordtime = 5;


%make a vector containing [0, 1/rate, 2/rate, 3/rate,... duration] in time
time=[0:1/rate:duration]; 

note = sin(2*pi*freq*time);
fv= input('Enter value for vibrato frequency (value between 0 and 5): ');

noteoraudio = input('Enter 1 to add vibrato to a note or 2 to record audio: ');

if noteoraudio == 1
    tremorvib = input('Enter 1 for amplitude vibrato (tremolo) or 2 for frequency vibrato: ');
        if tremorvib == 1
            depth = input('Enter value for depth (value between 0 and 1): ');
            trem = 1+depth*sin(2*pi*fv*time);
            notevib = note.*trem;
            soundsc(notevib,rate);
        else
            depth = input('Enter value for depth (value greater than 0): ');
            vibra = sin(2*pi*freq*time+depth*sin(2*pi*fv*time));
            soundsc(vibra, rate);
        end
else
    recorder = audiorecorder(rate,bits,mono);
    recordblocking(recorder,recordtime);
    audio = getaudiodata(recorder);
    depth = input('Enter value for depth (value between 0 and 1): ');
    trem = 1+depth*sin(2*pi*fv*time);
    notevib = audio.*trem;
    soundsc(notevib,rate);
    
end



%attenuation = 0.5;

% RC=0.5
% decay = exp(-time/RC);
% growth = 1-exp(-time/RC);
% 
% for i=1:524:44100
%     if(mod(i,2) ==0)
%         num=1;
%         for j=i:1:i+524
%                q = note(j).*decay(num);
%                num = num+1;
%         end
%     else
%         num=1;
%         for k=i:1:i+524
%                 q2 = note(k).*growth(num);
%                 num = num+1;
%         end
%         
%     end
%     
%     % qtot = 
%     
% end

%tremnote = q+q2;
%soundsc(q, rate);









