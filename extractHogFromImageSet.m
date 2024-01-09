function [trainFeatures, trainLabels] = extractHogFromImageSet(trainSet, hogFeatureSize, cellSize)
savepath=[trainSet,'\'];
%由于调用路径原因呢需要添加一个斜杠
namelist = dir(savepath);
%读取C盘存储照片地址文件夹中的所有内容
j=1;

for i = 1:length(namelist)
    if namelist(i).bytes ~=0
        %这个就是找数据图片 其他文件扔了
        img_path_list(j)=namelist(i);
        %因为dir文件中包含隐藏文件'.'和'..',所以进行赋值操作，弄出一个只有照片名字的数组
        j=j+1;
    end
end

for picture_number=1:1:length(img_path_list)
exampleImage = readimage(savepath, picture_number);
if numel(size(exampleImage))==3
        exampleImage = rgb2gray(exampleImage);   % 灰度化图片
end

% 提取HOG特征，并进行HOG可视化

[hogFeatureSize, trainFeatures] = extractHOGFeatures(exampleImage,'CellSize',cellSize);
trainLabels=picture_number;
% plot(vis4x4); 
% title({'CellSize = [4 4]'; ['Length = ' num2str(length(hog_4x4))]});
end
end