function X = ReadImgs(Folder,ImgType)
    Imgs = dir([Folder '/' ImgType]);
    NumImgs = size(Imgs,1);
    image = double(imread([Folder '/' Imgs(1).name]));
    X = zeros([NumImgs size(image)]);
    for i=1:NumImgs,
      image = double(imread([Folder '/' Imgs(i).name]));
      if (size(image,3) == 1)
        X(i,:,:) = image;
      else
        X(i,:,:,:) = image;
      end
    end
end