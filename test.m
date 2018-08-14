clear;clc;close;
im=imread('1.png');
im=imresize(im,.5);
% gray=rgb2gray(im);
bw=im>0;
bw(264:272,407)=0;
bw(407,94:106)=0;
imshow(bw)
%%
start=[267 403];
des=[405 99];
solvemaze(im,bw,start,des)