%Function to generate the required data for each experiment

function [A1 A2] = getData(experiment, y,p, numPixels)

switch(experiment)
    case 1
        %normal PCA
        %diff = zeros(p,80);
        A1 = y';
        A2 = y';
        
    case 2
        %Random Projection
        R = randn(numPixels,p);
        A1 = R';
        A2 = R';
        
    case 3
        %raw images
        A1 = 1;
        A2 = 1;
end

end