clear;

[signal,f_ech] = audioread('Audio/parole.wav');
if size(signal,2)>1
	signal = mean(signal,2);
end
f_max = f_ech/2;
sound(signal,f_ech);

save enregistrement;
