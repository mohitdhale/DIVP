% Applying different kinds of filters on Image.


clc
clear all
close all

a1=imread('cameraman.tif');
subplot(2,2,1)
a11=double(a1);
imshow(a1,[])
title('Original image')
[r,c] = size(a11);
a2= imnoise(a1,'salt & pepper',0.02);
subplot(2,2,2)
imshow(a2)
title('Input Image with Salt and Pepper Noise')
NIm=zeros(r,c);


fprintf('\n1.Averaging Filter \n2.High Pass Filter \n3.Laplacian Function \n4.Median Filter \n5.User defined Filter \n\n')
a=input('Enter the Choice')

if(a==1)
    disp('This is Mask of Mean filter or Averaging')
    q1=3
    g1=(1/9)*[1 1 1;1 1 1;1 1 1]
    
elseif(a==2)
    disp('This is Mask of High-pass or Sharpening')
    q1=3
    g1=(1/1)*[-1 -1 -1;-1 8 -1;-1 -1 -1]
elseif(a==3)
      disp('This is Laplacian Function')
      q1=3
      g1=[0 1 0;1 -4 1;0 1 0]
    
    elseif(a==4)
    disp('This is a MASK of Median Filter')
    q1=input('Enter the size of Mask ')
    g1=[1 1 1;1 1 1;1 1 1]
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
    
elseif(a==5)
      disp('This is a User Defined MASK')
    q1=input('Enter the size of Mask ')
    for i=1:q1
        for j=1:q1
        g1(i,j)=input('Enter the values')
        end
    end
else
    disp('Sorry Wrong choice')
end
t=(q1-1)/2;
xc=t+1;

for i=xc:r-t
    for j=xc:c-t
        temp=0;
    for k=-t:t
        for l=-t:t
        temp=temp +(a11(k+i,l+j).*g1(k+xc,l+xc));
         end
    end
      NIm(i,j)=temp;
    end
end

subplot(2,2,3)
imshow(abs(NIm),[])
title('Filtered Image')