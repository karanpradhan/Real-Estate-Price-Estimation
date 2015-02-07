%% This script is the starter script which should be called to make all the
% files and add all the paths

clc
clear 
libPath = genpath('ll');

addpath(libPath)
cd ll/matlab
make
cd ..
cd ..

libPath = genpath('libsvm-3.20');

addpath(libPath)
cd libsvm-3.20/matlab
make
cd ..
cd ..
