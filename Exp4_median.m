clc
clear all
close all
% 
% a=input('Enter the Choice')
disp('This is a MASK of Median Filter')
    q1=input('Enter the size of Mask ')
g1=[1 1 1;1 1 1;1 1 1]
subplot(2,2,3)
imshow(g1,[])
title('This is Mask')
a1=imread('cameraman.tif');
subplot(2,2,1)
a11=double(a1);
imshow(a1)
title('Original image')
[r,c] = size(a11);
a2= imnoise(a1,'salt & pepper',0.02);
subplot(2,2,2)
imshow(a2)
title('Input Image with Salt and Pepper Noise')
NIm=zeros(r,c);
t=(q1-1)/2;
xc=t+1;

q2=((q1+1)/2)-1
for i=xc:r-1
    for j=xc:c-1
        temp=0;
    for k=-t:t
        for l=-t:t
        temp(i,j)=(a2(k+i,l+j).*g1(k+xc,l+xc));
      temp2(k+2,l+2)=(temp(i,j));
       temp3=temp2(:);
       temp4=sort(temp3');
       temp5=temp4(ceil(end/2));
       NIm(i+q2-1,j+q2-1)=temp5;
       
        end      
    end
    end
end
subplot(2,2,4)
imshow(NIm,[])
title('Output Image')