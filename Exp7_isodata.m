% Isodata Thresholding

clc;
clear all;
close all;

a=imread('C:\Users\COEP\Desktop\a1.tif');
figure(1);
imshow(a);
b=im2bw(a);
figure(2);
imshow(b);
[r c]=size(a);

t=round(0.6*max(max(a)));

count1=0;count2=0;

for i=1:r
    for j=1:c
        if a(i,j)>t
            count1=count1+1;
            r1(i,j)=a(i,j);
            m1=sum(sum(r1));
            t1=m1/count1;
        else
            count2=count2+1;
            r2(i,j)=a(i,j);
            m2=sum(sum(r2));
            t2=m2/count2;
        end
    end
end

figure(3);
imshow(r1);
title('region1');
figure(4);
imshow(r2);
title('region2');