% Image Compression using DCT for 10% quality and 90% quality

clc;
clear all;
close all;

a=imread('cameraman.tif');
%a1=im2bw(a);
a2=double(a);
[r,c]=size(a2);
% subplot(2,1,1);
% imshow(a);
% subplot(2,1,2);
% imshow(a2);

%shifting level from (0 to 255) to (-127 to 127)
a3=0;
for i=1:r
    for j=1:c
        a3(i,j)=a2(i,j)-128;
    end
end

a4(1:1:r,1:1:c)=a3(1:1:r,1:1:c);

%creating a DCT matrix
imshow(a3);
N=8
N1=(N)^(0.5)
for u=0:7
    for v=0:7
        if u==0
            T(u+1,v+1)=1/(N1);
        else
            T(u+1,v+1)=(1.414/(N1))*cos((((2*v)+1)*u*pi)/(2*N));
        end
    end
end

for i=1:8:r-7
    for j=1:8:c-7
        dct1(i:i+7,j:j+7)=T*a3(i:i+7,j:j+7)*T';
    end
end


% quantization matrix for 10% quality
Q10=[80 60 50 80 120 200 255 255;
     55 60 70 95 130 255 255 255;
     70 65 80 120 200 255 255 255;
     70 85 110 145 255 255 255 255;
     90 110 185 255 255 255 255 255;
     120 175 255 255 255 255 255 255;
     245 255 255 255 255 255 255 255;
     255 255 255 255 255 255 255 255];

% quantization matrix for 90% quality
Q90=[3 2 2 3 5 8 10 12;
     2 2 3 4 5 12 12 11;
     3 3 3 5 8 11 14 11;
     3 3 4 6 10 17 16 12;
     4 4 7 11 14 22 21 15;
     5 7 11 13 16 12 23 18;
     10 13 16 17 21 24 24 21;
     14 18 19 20 22 20 20 20];
 
 for i=1:8:r-7
    for j=1:8:c-7
        C1(i:i+7,j:j+7)=round(dct1(i:i+7,j:j+7)./Q10);
        C2(i:i+7,j:j+7)=round(dct1(i:i+7,j:j+7)./Q90);
    end
end
%C11=round(dct1./Q10);C12=round(dct1./Q90);
figure(2);
subplot(2,2,1);
imshow(C1,[]);
subplot(2,2,2);
imshow(C2,[]);

 for i=1:8:r-7
    for j=1:8:c-7
        D1(i:i+7,j:j+7)=(C1(i:i+7,j:j+7).*Q10);
        D2(i:i+7,j:j+7)=(C2(i:i+7,j:j+7).*Q90);
    end
 end

 for i=1:8:r-7
    for j=1:8:c-7
        dct2(i:i+7,j:j+7)=round(T'*D1(i:i+7,j:j+7)*T);
        dct3(i:i+7,j:j+7)=round(T'*D2(i:i+7,j:j+7)*T);
    end
 end
%dct2=dct2+128;
%dct3=dct3+128; 
subplot(2,2,3);
imshow(dct2,[]);
subplot(2,2,4);
imshow(dct3,[]);