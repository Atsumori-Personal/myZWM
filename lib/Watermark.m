classdef Watermark
    properties
        height
        width
        data
    end
    methods
        function obj = Watermark(path)
            img = imread(path);
            grayImg = rgb2gray(img);
            binImg = imbinarize(grayImg, 'global');
            [obj.height, obj.width] = size(binImg);
            obj.data = binImg;
        end
    end
end