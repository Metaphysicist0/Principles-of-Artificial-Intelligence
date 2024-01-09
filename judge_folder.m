function judge_folder(data.number,data.name)
    folder_address='C:\Users\MengMa\Desktop\math_distinguish\MNIST_data\minst\train\';
    for picture_num=1:1:length(data.number)
        picture_name=data(picture_num).name;
        img=imread(strcat(folder_address,picture_name));
        switch data(picture_num).number
            case 0
               imwrite(img,['C:\Users\MengMa\Desktop\math_distinguish\MNIST_data\minst\data_train\0\',data(picture_num).name]);
            case 1
               imwrite(img,['C:\Users\MengMa\Desktop\math_distinguish\MNIST_data\minst\data_train\1\',data(picture_num).name]);
            case 2
               imwrite(img,['C:\Users\MengMa\Desktop\math_distinguish\MNIST_data\minst\data_train\2\',data(picture_num).name]);
            case 3
               imwrite(img,['C:\Users\MengMa\Desktop\math_distinguish\MNIST_data\minst\data_train\3\',data(picture_num).name]);
            case 4
               imwrite(img,['C:\Users\MengMa\Desktop\math_distinguish\MNIST_data\minst\data_train\4\',data(picture_num).name]);
            case 5
               imwrite(img,['C:\Users\MengMa\Desktop\math_distinguish\MNIST_data\minst\data_train\5\',data(picture_num).name]);
            case 6
               imwrite(img,['C:\Users\MengMa\Desktop\math_distinguish\MNIST_data\minst\data_train\6\',data(picture_num).name]);
            case 7
               imwrite(img,['C:\Users\MengMa\Desktop\math_distinguish\MNIST_data\minst\data_train\7\',data(picture_num).name]);
            case 8
               imwrite(img,['C:\Users\MengMa\Desktop\math_distinguish\MNIST_data\minst\data_train\8\',data(picture_num).name]);
            case 9
               imwrite(img,['C:\Users\MengMa\Desktop\math_distinguish\MNIST_data\minst\data_train\9\',data(picture_num).name]);
            default
                imwrite(img,['C:\Users\MengMa\Desktop\math_distinguish\MNIST_data\minst\data_train\0\','error.jpg']);
        end
    end
end