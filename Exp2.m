% Histogram Of an Image without using Direct function

clc
clear all
close all

a=imread('cameraman.tif')
subplot(2,1,1)
imshow(a)
title('Original Image')

[r,c] = size(a);
x= 1:1:255		
y= (zeros(1,255));
in = 1;
count = 0;
output=zeros(256,1);
NIm=uint8(zeros(size(a,1),size(a,2)));
%Finding Histogram Of image without using direct function
while( in <256 )	
    count = 0;
    for i = 1:r
        for j = 1:c
            if a(i,j) == in
                count = count+1;
            end
        end
    end
    y(1,in) = count;
    in = in+1;
end
subplot(2,1,2)
stem(x,y)
axis tight
title('Histogram of Image')
