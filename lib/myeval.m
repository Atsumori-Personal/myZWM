function res = myeval(feature, attack, method)

% EMBED
wtr = Watermark("../Image/jai-logo-100.jpg");
switch feature
    case 'dht'
        audio = AudioDHT("../Sound/Thousand Yard Stare.wav");
    case 'fe'
        audio = AudioFE("../Sound/Thousand Yard Stare.wav");
    otherwise
        audio = AudioLBP("../Sound/Thousand Yard Stare.wav");
end
afb = audio.toB(wtr.height, wtr.width);
key = Key(xor(wtr.data, afb));

% DETECTION
switch attack
    case '32mp3'
        if strcmp(feature, 'dht')
            audio = AudioDHT("../Sound/Thousand Yard Stare(32).mp3");
        elseif strcmp(feature, 'fe')
            audio = AudioFE("../Sound/Thousand Yard Stare(32).mp3");
        else
            audio = AudioLBP("../Sound/Thousand Yard Stare(32).mp3");
        end
    case '64mp3'
        if strcmp(feature, 'dht')
            audio = AudioDHT("../Sound/Thousand Yard Stare(64).mp3");
        elseif strcmp(feature, 'fe')
            audio = AudioFE("../Sound/Thousand Yard Stare(64).mp3");
        else
            audio = AudioLBP("../Sound/Thousand Yard Stare(64).mp3");
        end
    case '128mp3'
        if strcmp(feature, 'dht')
            audio = AudioDHT("../Sound/Thousand Yard Stare(128).mp3");
        elseif strcmp(feature, 'fe')
            audio = AudioFE("../Sound/Thousand Yard Stare(128).mp3");
        else
            audio = AudioLBP("../Sound/Thousand Yard Stare(128).mp3");
        end
    case 'awgn'
        if strcmp(feature, 'dht')
            audio = AudioDHT("../Sound/Thousand Yard Stare(awgn).wav");
        elseif strcmp(feature, 'fe')
            audio = AudioFE("../Sound/Thousand Yard Stare(awgn).wav");
        else
            audio = AudioLBP("../Sound/Thousand Yard Stare(awgn).wav");
        end
    case 'echo'
        if strcmp(feature, 'dht')
            audio = AudioDHT("../Sound/Thousand Yard Stare(echo).wav");
        elseif strcmp(feature, 'fe')
            audio = AudioFE("../Sound/Thousand Yard Stare(echo).wav");
        else
            audio = AudioLBP("../Sound/Thousand Yard Stare(echo).wav");
        end
    case 'lpf'
        if strcmp(feature, 'dht')
            audio = AudioDHT("../Sound/Thousand Yard Stare(lpf).wav");
        elseif strcmp(feature, 'fe')
            audio = AudioFE("../Sound/Thousand Yard Stare(lpf).wav");
        else
            audio = AudioLBP("../Sound/Thousand Yard Stare(lpf).wav");
        end
    case 'requantized'
        if strcmp(feature, 'dht')
            audio = AudioDHT("../Sound/Thousand Yard Stare(requantized).wav");
        elseif strcmp(feature, 'fe')
            audio = AudioFE("../Sound/Thousand Yard Stare(requantized).wav");
        else
            audio = AudioLBP("../Sound/Thousand Yard Stare(requantized).wav");
        end
    case 'resampling'
        if strcmp(feature, 'dht')
            audio = AudioDHT("../Sound/Thousand Yard Stare(resampling).wav");
        elseif strcmp(feature, 'fe')
            audio = AudioFE("../Sound/Thousand Yard Stare(resampling).wav");
        else
            audio = AudioLBP("../Sound/Thousand Yard Stare(resampling).wav");
        end
    case 'reverse'
        if strcmp(feature, 'dht')
            audio = AudioDHT("../Sound/Thousand Yard Stare(reverse).wav");
        elseif strcmp(feature, 'fe')
            audio = AudioFE("../Sound/Thousand Yard Stare(reverse).wav");
        else
            audio = AudioLBP("../Sound/Thousand Yard Stare(reverse).wav");
        end
    otherwise
        if strcmp(feature, 'dht')
            audio = AudioDHT("../Sound/Thousand Yard Stare.wav");
        elseif strcmp(feature, 'fe')
            audio = AudioFE("../Sound/Thousand Yard Stare.wav");
        else
            audio = AudioLBP("../Sound/Thousand Yard Stare.wav");
        end
end
afb = audio.toB(key.height, key.width);
detImg = xor(afb, key.data);


% EVALUATION
% method ( ber / nc )
if strcmp(method, 'ber')
    [~, res] = biterr(wtr.data, detImg);
else
end


end