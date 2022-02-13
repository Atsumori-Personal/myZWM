addpath ../lib
addpath ../lib/FeatureExtraction

wtr = Watermark("../../Image/jai-logo-100.jpg");
% wtr = Watermark("../../Image/id.jpg");


%% Embed
% dht_audio = AudioDHT("../../Sound/Thousand Yard Stare.wav");
% fe_audio = AudioFE("../../Sound/Thousand Yard Stare.wav");
% lbp_audio = MyAudioLBP("../../Sound/Thousand Yard Stare.wav");
fe_audio = AudioFE("../../Sound/voice.mp3");
lbp_audio = MyAudioLBP("../../Sound/voice.mp3");

% afb : audio feature binary
% dht_afb = dht_audio.toB(wtr.height, wtr.width);
fe_afb = fe_audio.toB(wtr.height, wtr.width);
lbp_afb = lbp_audio.toB(wtr.height, wtr.width);

% dht_key = Key(xor(wtr.data, dht_afb));
fe_key = Key(xor(wtr.data, fe_afb));
lbp_key = Key(xor(wtr.data, lbp_afb));


%% Detection
% d_dht_audio = AudioDHT("../../Sound/Thousand Yard Stare(awgn).wav");
% d_fe_audio = AudioFE("../../Sound/Thousand Yard Stare(awgn).wav");
% d_lbp_audio = MyAudioLBP("../../Sound/Thousand Yard Stare(awgn).wav");
d_fe_audio = AudioFE("../../Sound/voice.mp3");
d_lbp_audio = MyAudioLBP("../../Sound/voice.mp3");

% d_dht_afb = d_dht_audio.toB(dht_key.height, dht_key.width);
d_fe_afb = d_fe_audio.toB(fe_key.height, fe_key.width);
d_lbp_afb = d_lbp_audio.toB(lbp_key.height, lbp_key.width);

% d_dht_wtr = xor(d_dht_afb, dht_key.data);
d_fe_wtr = xor(d_fe_afb, fe_key.data);
d_lbp_wtr = xor(d_lbp_afb, lbp_key.data);


%% Evaluation
% BER : Bit Error Rate
% [~, dht_ber] = biterr(wtr.data, d_dht_wtr);
[~, fe_ber] = biterr(wtr.data, d_fe_wtr);
[~, lbp_ber] = biterr(wtr.data, d_lbp_wtr);

disp("====== BER ======");
disp("{ Add White-Gaussian Noise }")
% disp("DHT : " + num2str(dht_ber));
disp("FE : " + num2str(fe_ber));
disp("LBP : " + num2str(lbp_ber));
disp("=================");


% NC : Normalized Cross-correlation
sz = wtr.height * wtr.width;
wtr.data = reshape(wtr.data, 1, sz);
% d_dht_wtr = reshape(d_dht_wtr, 1, sz);
d_fe_wtr = reshape(d_fe_wtr, 1, sz);
d_lbp_wtr = reshape(d_lbp_wtr, 1, sz);
% dht_nc = (wtr.data, d_dht_wtr);
fe_nc = xcorr(wtr.data, d_fe_wtr, 'normalized');
lbp_nc = xcorr(wtr.data, d_lbp_wtr, 'normalized');

disp("====== NC =======");
disp("{ Add White-Gaussian Noise }")
% disp("DHT : " + num2str(dht_nc));
disp("FE : " + num2str(fe_nc));
disp("LBP : " + num2str(lbp_nc));
disp("=================");