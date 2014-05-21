%Loads images from current directory give an extension

function [data labels images numberOfFiles, numPixels] = loadMP2Data(extension)

%Get names and info of all files in directory
files = dir(strcat('*',extension));
%Select resolution for images
resolution = {[90 70], [70 90], [45 35], [22 17], [9 8]};
desiredRes = 1;

numberOfFiles = length(files);
images = cell(numberOfFiles,1);
numPixels = resolution{desiredRes}(1)*resolution{desiredRes}(2);
%data = cell(numberOfFiles,1);

%Read all the files into cell array
for n = 1:numberOfFiles
    varname = regexp(files(n).name, extension, 'split');  %get the name of the file
    img = imresize(double(rgb2gray(imread(files(n).name))), resolution{desiredRes}); %reshape to desired resolution
    labels{n} = char(varname(1));
    images{n} = {labels(n) img};
    data(:,n) =  reshape(img, [numPixels 1]);
    
end

end
