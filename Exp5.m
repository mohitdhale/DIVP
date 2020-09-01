clc
clear all
close all
disp('This is a MASK of Gaussian Low Pass Filter')
a2=imread('C:\Users\COEP\Desktop\a.tif');
subplot(3,3,1)
a3=double(a2);
imshow(a2)
title('Original image')
[r,c] = size(a2);
NIm=zeros(r,c);
NIm3=zeros(r,c);
m=input('Enter the size of the mask:');
    
% Gaussian Filter
g=input('The value of std deviation sigma is:'); 
g2=g*g;
        
    t=(m-1)/2
    for k=-t:t
        for l=-t:t
             x1=-(((k*k)+(l*l))/g2);
             x2=exp(x1);
             x3=2*pi*g2;
             x4=1/x3;
             x5=x4*x2;
             a1(k+t+1,l+t+1)=x5;
            
        end
    end
    
  for i=t+1:r-t
        for j=t+1:c-t
            count=0;
            for k=-t:t
                for l=-t:t
                    count = count + (a2(i+k,j+l).*a1(k+t+1,l+t+1));
                end
            end
            NIm(i,j)=count;
        end
    end
    
    subplot(3,3,2);
    imshow(a1);
    subplot(3,3,3);
    imshow(abs(NIm),[]);
    title('Gaussian filtered Image')

% Sobel Filter
d1=[-1 0 1;-2 0 2;-1 0 1]
d2=[-1 -2 -1;0 0 0 ;1 2 1]

% Applying Sobel Filter on Gaussian Output Image
t=(3-1)/2;
xc=t+1;

for i=xc:r-t
    for j=xc:c-t
        temp1=0;
        temp2=0;
    for k=-t:t
        for l=-t:t
        temp1=temp1 +(NIm(k+i,l+j).*d1(k+xc,l+xc));
        temp2=temp2 +(NIm(k+i,l+j).*d2(k+xc,l+xc));
         end
    end
      NIm1(i,j)=temp1;
      NIm2(i,j)=temp2;
    end
end

subplot(3,3,4)
imshow(abs(NIm1),[])
title('Filtered Gx Image')
subplot(3,3,5)
imshow(abs(NIm2),[])
title('Filtered Gy Image')

% Magnitude And Direction Plotting
mg=sqrt((NIm1.^2)+(NIm2.^2));
di=atand(NIm2./NIm1);

subplot(3,3,6)
imshow(mg,[])
title('Magnitude')
subplot(3,3,7)
imshow(di,[])
title('Direction')

% Non-Maximal Suppression 
[r1,c1]=size(di);
for i=1:r1
    for j=1:c1
        
        if (-1)*90<=di(i,j)<(-1)*45
            NIm3(i,j)=0;
        elseif (-1)*45<di(i,j)<0
            NIm3(i,j)=1;
        elseif (0<di(i,j)<45)
            NIm3(i,j)=2;
        else
            NIm3(i,j)=3;

        end
    end
end

subplot(3,3,8)
imshow(NIm3,[])
title('Non-maximal suppression')
