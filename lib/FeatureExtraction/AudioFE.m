classdef AudioFE
    properties
        data
        fs
        length
        channel
    end
    methods
        function obj = AudioFE(path)
            [obj.data, obj.fs] = audioread(path);
            [obj.length, obj.channel] = size(obj.data);
            
            % In the case of stereo or more channels signal,
            % the sound of 1st-channel is tantatively used.
            if obj.channel ~= 1
                obj.data = obj.data(:, 1);
            end
            % obj.data = highpass(obj.data, 0.02);
            % [MFCC]
            % mfccres = mfcc(obj.data, obj.fs);
            % obj.data = mfccres(:,1);
            % [obj.length, ~] = size(obj.data);
        end

        function res = toB(obj, height, width)
            % M : hight x width (Watermark)
            % Q : Number of samples each frame has
            M = height * width;
            Q = floor(obj.length / M);

            sqData = obj.data .^ 2;
            Eave = sum(sqData) / M;
            FE = zeros(1, M);
            for i = 1:M
                FE(i) = sum(sqData((i-1)*Q+1 : i*Q));
            end
            E = zeros(1, M, 'logical');
            for i = 1:M
                if FE(i) > Eave
                    E(i) = 1;
                else
                    E(i) = 0;
                end
            end
            % res = (reshape(E, [width, height]))';
            res = Eave;
        end
    end
end