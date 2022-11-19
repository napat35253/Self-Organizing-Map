clear all;
clc

%% PARAMS

irisData = readmatrix("iris-data.csv");
irisLabels = readmatrix("iris-labels.csv");
irisDataSize = size(irisData,1);

nEpoch = 10;
eta = 0.1;
dEta = 0.01;
sigma = 10;
dSigma = 0.05;

% normalize iris data
irisData = irisData/max(irisData,[],'all');

nNeurons = 40;
w = rand(4,nNeurons,nNeurons);

w0 = w; %save initialize weight

%% TRAINING

for epoch = 1:nEpoch
    eta = eta * exp(-dEta * epoch);
    sigma = sigma * exp(-dSigma * epoch);

    for data = 1:irisDataSize

        chosenPoint = fix((rand * irisDataSize) + 1);
        
        r0 = GetWinningNeuron(nNeurons,w,irisData,chosenPoint);

        for i = 1:nNeurons
            for j = 1:nNeurons
                r = [i j];
                distance = vecnorm(r-r0);
                if distance < 3*sigma
                    h = exp(-(distance^2)/(2*sigma^2));
                    d_ = irisData(chosenPoint,:) - w(:,i,j)';                 
                    w(:,i,j) = w(:,i,j) + (eta*h*d_)';
                end
            end
        end 
    end
end

%% PLOT

position = zeros(150,2);

for data = 1:irisDataSize
    r0 = GetWinningNeuron(nNeurons,w0,irisData,data);
    position(data,:) = r0;
    i0 = r0(1);
    j0 = r0(2);
end

gscatter(position(:,1),position(:,2),irisLabels,'brg','...',20)
legend('iris type 1','iris type 2','iris type 3')
title('SOM MAP')
