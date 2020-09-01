% Iterative Thresholding

clc;
clear all;
close all;

I=imread('C:\Users\COEP\Desktop\a1.tif');
subplot(2,2,1);
imshow(I);
[r,c]=size(I);

Ih=imhist(I);
subplot(2,2,2);
stem(Ih);
axis tight;

m1=max(max(I));
T=round(0.7*m1)

I1=0;
for i=1:r
    for j=1:c
        if I(i,j)>T
            I1(i,j)=1;
        else
            I1(i,j)=0;
        end
    end
end

subplot(2,2,3);
imshow(I1);

Tnew=0;
Tb=0;
To=0;
count1=0;count2=0;
  while ((Tnew-T)<=0.001)
for i=1:r
    for j=1:c
     
        if I(i,j)< T
            Tb1(i,j)=I(i,j);
            %Tb=Tb+Tb1(i,j);
            count1=count1+1;
            Tb=sum(sum(Tb1));
        else
            To1(i,j)=I(i,j);
            %To=To+To1(i,j);
            count2=count2+1;
            To=sum(sum(To1));
        end
        Tbm1=Tb/count1;
        Tom1=To/count2;
        
    end
end
T2=Tbm1+Tom1;
Tnew=(T2/2)
 end



I2=0;
for i=1:r
    for j=1:c
        if I(i,j)>Tnew
            I2(i,j)=1;
        else
            I2(i,j)=0;
        end
    end
end

subplot(2,2,4);
imshow(I2);