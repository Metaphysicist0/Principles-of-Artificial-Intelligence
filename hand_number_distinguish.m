clc;clear all;close all;
% 给出训练和测试数据路径，利用imageDatastore载入数据集
%C:\Users\MengMa\Desktop\math_distinguish\MNIST_data
addpath C:\Users\MengMa\Desktop\math_distinguish\MNIST_data\minst\data_train\0
addpath C:\Users\MengMa\Desktop\math_distinguish\MNIST_data\minst\data_train\1
addpath C:\Users\MengMa\Desktop\math_distinguish\MNIST_data\minst\data_train\2
addpath C:\Users\MengMa\Desktop\math_distinguish\MNIST_data\minst\data_train\3
addpath C:\Users\MengMa\Desktop\math_distinguish\MNIST_data\minst\data_train\4
addpath C:\Users\MengMa\Desktop\math_distinguish\MNIST_data\minst\data_train\5
addpath C:\Users\MengMa\Desktop\math_distinguish\MNIST_data\minst\data_train\6
addpath C:\Users\MengMa\Desktop\math_distinguish\MNIST_data\minst\data_train\7
addpath C:\Users\MengMa\Desktop\math_distinguish\MNIST_data\minst\data_train\8
addpath C:\Users\MengMa\Desktop\math_distinguish\MNIST_data\minst\data_train\9


syntheticDir='C:\Users\MengMa\Desktop\math_distinguish\MNIST_data\minst\train';
handwrittenDir='C:\Users\MengMa\Desktop\math_distinguish\MNIST_data\minst\test';


filename='C:\Users\MengMa\Desktop\math_distinguish\MNIST_data\minst\train.txt';               %文件名
delimiterIn = ' ';                      %列分隔符
headerlinesIn = 0;                      %读取从第 headerlinesIn+1 行开始的数值数据
present=importdata(filename,delimiterIn,headerlinesIn);
%里面已经分好了 data是数据照片的值，textdata是数据照片的名字
judge_folder(present.data,present.textdata);
%这句话的作用是实现将数据集的数字图片分类到各个文件夹中

% 给出训练和测试数据路径，利用imageDatastore载入数据集
syntheticDir   = fullfile('C:\Users\MengMa\Desktop\math_distinguish\MNIST_data\minst\train');
handwrittenDir = fullfile('C:\Users\MengMa\Desktop\math_distinguish\MNIST_data\minst\test');

% imageDatastore递归扫描目录，将每个文件夹名称自动作为图像的标签
trainSet = imageDatastore(syntheticDir,   'IncludeSubfolders', true, 'LabelSource', 'foldernames');
testSet  = imageDatastore(handwrittenDir, 'IncludeSubfolders', true, 'LabelSource', 'foldernames');

%对测试集进行特征提取
cellSize = [4 4];
hogFeatureSize = length(hog_4x4);

% 提取HOG特征
tStart = tic; 
[trainFeatures, trainLabels] = extractHogFromImageSet(trainSet, hogFeatureSize, cellSize); % 训练集特征提取
[testFeatures, testLabels] = extractHogFromImageSet(testSet, hogFeatureSize, cellSize);    % 测试集特征提取

tEnd = toc(tStart);
%fprintf('提取特征所用时间：%.2f秒\n', tEnd);

% 训练支持向量机

t = templateSVM('SaveSupportVectors',true, 'Standardize', true, 'KernelFunction','polynomial', ...
    'KernelScale', 'auto','Verbose', 1);      % 利用polynomial核函数, 标准化处理数据，显示训练过程（verbose取0时取消显示）

tStart = tic; % 计时开始
classifier = fitcecoc(trainFeatures, trainLabels, 'Learner', t); % 训练SVM模型
tEnd = toc(tStart);
fprintf('训练模型所用时间：%.2f秒\n', tEnd);

tStart = tic;

% 对测试数据集进行预测
predictedLabels = predict(classifier, testFeatures);

tEnd = toc(tStart);
fprintf('模型对测试集进行预测所用时间：%.2f秒\n', tEnd);

% 使用混淆矩阵评估结果
confMat = confusionmat(testLabels, predictedLabels);
dispConfusionMatrix(confMat); % 显示混淆矩阵
% 绘制混淆矩阵图
plotconfusion(testLabels, predictedLabels);






