

clc
clear all
close all
disp('This is a MASK of Gaussian Low Pass Filter')
a2=imread('cameraman.tif');
subplot(2,2,1)
a3=double(a2);
imshow(a2)
title('Original image')
[r,c] = size(a2);
NIm=zeros(r,c);
m=input('enter the size of the mask:');
    
    g=input('the value of std deviation sigma is:'); % std deviation
    g2=g*g; % variance
        
    t=(m-1)/2
    for k=-t:t
        for l=-t:t
             x1=-(((k*k)+(l*l))/g2);
             x2=exp(x1);
             x3=2*pi*g2;
             x4=1/x3;
             x5=x4*x2;
             a1(k+t+1,l+t+1)=x5;
            %a1(i,j)=input('the value is:')
        end
    end
    
    b1=zeros(r,c);

    for i=t+1:r-t
        for j=t+1:c-t
            count=0;
            for k=-t:t
                for l=-t:t
                    count = count + (a2(i+k,j+l).*a1(k+t+1,l+t+1));
                end
            end
            b1(i,j)=count;
        end
    end
    
    subplot(2,2,2);
    imshow(a1);
    subplot(2,2,3);
    imshow(abs(b1),[]);
    title('filtered Image')




