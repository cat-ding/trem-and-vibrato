clear

rate = 44100; %Hz          --the number of individual samples per second
freq = 440; %Hz     --the base frequency of the sine wave
duration = 5; %sec       --the length of time that the sine wave plays
bits = 16;
mono = 1;

%make a vector containing [0, 1/rate, 2/rate, 3/rate,... duration] in time
time=[0:1/rate:duration]; 

note = sin(2*pi*freq*time); %creates note 

%allows user input for frequency of vibrato per second 
fv= input('Enter value for vibrato frequency (value between 0 and 5): '); 

%allows user to choose between note or recording own audio sample
noteoraudio = input('Enter 1 to add vibrato to a note or 2 to record audio: '); 

if noteoraudio == 1
    tremorvib = input('Enter 1 for amplitude vibrato (tremolo) or 2 for frequency vibrato: ');
    if tremorvib == 1
        depth = input('Enter value for depth (value between 0 and 1): '); %user input for depth (change in amplitude)
        trem = 1+depth*sin(2*pi*fv*time); %creates vector trem that utilizes user input frequency of fv
                                          %adds +1 to make sure trem ~= 0
        notevib = note.*trem; %multiples vectors note and trem 
        soundsc(notevib, rate); %plays notevib 
    else
        depth = input('Enter value for depth (value greater than 0): '); %user input for depth (change amplitude of phase shift)
        vibra = sin(2*pi*freq*time+depth*sin(2*pi*fv*time)); %adds a phase shift to note utilizing user input frequency of fv
        soundsc(vibra, rate); %plays vibra
    end
else
    recorder = audiorecorder(rate,bits,mono);
    recordblocking(recorder,duration);
    audio = getaudiodata(recorder); %allows for user to record own audio sample 
    depth = input('Enter value for depth (value between 0 and 1): ');%user input for depth (change in amplitude only)
    trem = 1+depth*sin(2*pi*fv*time); %modfies amplitude of note only
    audio = audio'; %changes a vertical vector to horizontal vector
    zero = zeros(1); %creates array of 1 zero
    audio = [audio zero]; %concatenates zero to audio  
    notevib = audio.*trem; %multiples vectors audio and trem 
    soundsc(notevib,rate); %play out notevib 
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









