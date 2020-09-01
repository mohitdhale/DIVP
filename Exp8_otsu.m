clc;
clear all;
close all;

% Reading the image
I=imread('C:\Users\COEP\Desktop\a1.tif');
subplot(2,1,1);
imshow(I);
[r,c]=size(I);
I1=double(I);

% Histogram using function
Ih=imhist(I);
subplot(2,1,2);
stem(Ih);
axis tight;

% Calculating otsu threshold using function
m1=255;
ot=otsuthresh(Ih) 
T1=ot*m1
I2=0;
for i=1:r
    for j=1:c
        if I1(i,j)>T1
            I2(i,j)=1;
        else
            I2(i,j)=0;
        end
    end
end
figure(2)
imshow(I2);
title('thresholding using direct function otsu threshold');

% CALCULATING OTSU THRESHOLD WITHOUT USING FUNCTION

%histogram without function
k=1;
count=0;
while(k<=256)
    count=0;
    for i=1:r
        for j=1:c
            if I1(i,j)==k-1
                count=count+1;
            end
        end
    end
    y(1,k)=count;
    k=k+1;
end

%pdf
s1=sum(y);
p1=y./s1;  % PDF
for i=1:256    
    mg1(i)=i*p1(i); % CUMULATIVE MEAN m(k)
end
mg=sum(mg1); % GLOBAL MEAN m(g)

%cdf
p2=0;p3=0;
for i=1:256
    p2=p2+p1(i);
    p3(i)=p2;  % CDF
end

%calculating k
mk=0;m1=0;a1=0;
for i=1:256
    sum=0;
    for j=1:i
        sum=sum+mg1(j);
    end
    mk(i)=sum;
    m1(i)=mk(i)./p3(i);
    a1(i)=((mg*p3(i))-(mk(i))).^2; % NUMERATOR OF EQUATION
    b1(i)=((p3(i))*(1-(p3(i)))); % DENOMINATOR OF EQUATION
%     if (b1(i))~=0
        s1(i)=a1(i)./b1(i); % INTER CLASS VARIANCE FOR EVERY k s2(k)
%     end
end

[val,thr]=max(s1); %INDEX GIVES VALUE OF GRAY LEVEL WHERE s2(k) IS MAXIMUM

I3=0;
for i=1:r
    for j=1:c
        if I1(i,j)>thr
            I3(i,j)=1;
        else
            I3(i,j)=0;
        end
    end
end
%I3=imbinarize(I,thr);
figure(3)
imshow(I3);
title('Thresholding Using OTSU Threshold');