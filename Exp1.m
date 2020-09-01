% Calculations of mean, Variance by using direct function and by without functions.
% Checking the Row profile and column profile.
% Calculating Histogram by direct function and without function.



clc
clear all
close all
a=imread('cameraman.tif')
imshow(a)
a1=double(a)

% Mean by using function
s=mean(mean(a1))

% Mean without using function
a2=sum(a1)/256;
a3=sum(a2)/256

% Variance by using direct function
g=std2(a1)
a4=g*g

% Variance without function
b2=((a1-a3).^2)
b3=(sum(b2)/256)
b4=(sum(b3)/256)

% Profile of an image

imshow(a);
c1=input('Enter the no of coloumn :');
c2=input('Enter the no of row :');
P =a(:,c1)
H =a(c2,:)
figure(1)

subplot(2,1,1)
stem(P)
title('Column Profile')

subplot(2,1,2)
stem(H)
title('Row Profile')


% Histogram with using the function
figure(2)
subplot(2,1,1)
imhist(a)
title('Histogram with using the function')

% Histogram without using the function
[r,c] = size(a);
x= 1:1:255;		
y= (zeros(1,255));
in = 1;
count = 0;
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
title('Histogram without using the function')


