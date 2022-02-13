classdef AudioLPS
    properties
        data
        fs
        length
        channel
    end
    methods
        function obj = AudioLPS(path)
            [obj.data, obj.fs] = audioread(path);
            [obj.length, obj.channel] = size(obj.data);
            
            % In the case of stereo or more channels signal,
            % the sound of 1st-channel is tantatively used.
            if obj.channel ~= 1
                obj.data = obj.data(:, 1);
            end
            % obj.data = highpass(obj.data, 0.02);
        end

        function res = toB(obj, height, width)
            % M : hight x width (Watermark)
            % Q : Number of samples each frame has
            M = height * width;
            Q = floor(obj.length / M);

            ave = mean(lps(obj.data));
            LPS = zeros(1, M);
            for i = 1:M
                tmp = lps(obj.data((i-1)*Q+1 : i*Q));
                LPS(i) = mean(tmp);
            end
            B = zeros(1, M, 'logical');
            for i = 1:M
                if LPS(i) > ave
                    B(i) = 1;
                else
                    B(i) = 0;
                end
            end
            res = (reshape(B, [width, height]))';
            % res = ave / max(abs(lps(obj.data)));
        end
    end
end