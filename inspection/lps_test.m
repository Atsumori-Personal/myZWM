addpath ../lib
addpath ../lib/FeatureExtraction

% wtr = Watermark("../../Image/jai-logo-100.jpg");
wtr = Watermark("../../Image/jai-logo-50.jpg");
% wtr = Watermark("../../Image/jai-logo-20.jpg");
% wtr = Watermark("../../Image/id.jpg");
% wtr = Watermark("../../Image/robo.jpg");


%% Embed
% audio = AudioLPS("../../Sound/speech/sqam/M_DE.wav");
% audio = AudioLPS("../../Sound/speech/sqam/F_DE.wav");
audio = AudioLPS("../../Sound/speech/sqam/M_EN.wav");
% audio = AudioLPS("../../Sound/voice.mp3");

% afb : audio feature binary
afb = audio.toB(wtr.height, wtr.width);
% imshow(afb);

key = Key(xor(wtr.data, afb));


%% Detection
% d_audio = AudioLPS("../../Sound/speech/sqam/F_DE(64).mp3");
% d_audio = AudioLPS("../../Sound/speech/sqam/F_DE(32).mp3");
d_audio = AudioLPS("../../Sound/speech/sqam/M_EN(zi).wav");
% d_audio = AudioLPS("../../Sound/voice(echo).mp3");
d_afb = d_audio.toB(wtr.height, wtr.width);


d_wtr = xor(d_afb, key.data);

%{
%% Evaluation
imshow(d_wtr);
[~, ber] = biterr(wtr.data, d_wtr);
disp("BER : " + num2str(ber));
%}


%% Fragile evaluation
difbit = xor(afb, d_afb);
imshow(difbit);
tmp = zeros(wtr.height, wtr.width);
[benum, ber] = biterr(difbit, tmp);
disp(ber);

wtrsz = wtr.height * wtr.width;
difidx = zeros(1, benum);
idx = 1;
for i = 1 : wtrsz
    if difbit(i) == 1
        difidx(idx) = i;
        idx = idx + 1;
    end
end