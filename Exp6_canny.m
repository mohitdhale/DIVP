% Canny Edge Detection

clc
clear all
close all
img=imread('C:\Users\COEP\Desktop\a.tif');
img=im2double(img);
[x,y]=size(img);

G=1/159*[2 4 5 6 2;4 9 12 9 4;5 12 15 12 5;4 9 12 9 4;2 4 5 4 2];

Gf=imfilter(img,G);
figure(1);
imshow(Gf);
title('Gaussian filtering');

s=[-1 0 1;-2 0 2;-1 0 1];
Fx=imfilter(Gf,s);
figure(2);
imshow(Fx);
title('Horizontal filtering');

Fy=imfilter(Gf,s');
figure(3);
imshow(Fy);
title('Vertical Filtering');

figure(4);
imshow((Fx+Fy),[]);
title('H+V');

% calculating Directions
Gfx=size(Gf,1);
Gfy=size(Gf,2);

for i=1:Gfx
    for j=1:Gfy
    D(i,j)=atan(Fy(i,j)/Fx(i,j));
    end
end
D=D*180/pi;

% ADJUSTMENT FOR NEGATIVE DIRECTION
for i=1:Gfx
    for j=1:Gfy
        if(D(i,j)<0)
            D1(i,j)=360+D(i,j);
        end
    end
end

D2=zeros(Gfx,Gfy);

% ADJUSTING DIRECTIONS TO NEAREST 0,45,90 OR 135
for i=1:Gfx
    for j=1:Gfy
        if(D(i,j)>=0) && (D(i,j)<22.5)
            D2(i,j)=0;
            elseif(D(i,j)>=22.5)&& (D(i,j)<67.5)
            D2(i,j)=45;
            elseif(D(i,j)>=67.5)&& (D(i,j)<112.5)
            D2(i,j)=90;
            elseif(D(i,j)>=112.5)&& (D(i,j)<135)
            D2(i,j)=135;
        end
    end
end

% CALCULATING MAGNITUDE
mag=Fx.^2+Fy.^2;
mag2=sqrt(mag);

% NON-MAXIMAL SUPPRESSION
NIm3=zeros(Gfx,Gfy);
for u=2:Gfx-2
    for v=2:Gfy-2
        
        if (D2(u,v)==0)
            if (mag2(u,v)<mag2(u,v-1)||mag2(u,v)<mag2(u,v+1))
                NIm3(u,v)=0;
            else
                NIm3(u,v)=mag2(u,v);
            end
        end
        
         if (D2(u,v)==45)
            if (mag2(u,v)<mag2(u+1,v-1)||mag2(u,v)<mag2(u-1,v+1))
                NIm3(u,v)=0;
            else
                NIm3(u,v)=mag2(u,v);
            end
         end
        
          if (D2(u,v)==90)
            if (mag2(u,v)<mag2(u+1,v)||mag2(u,v)<mag2(u-1,v))
                NIm3(u,v)=0;
            else
                NIm3(u,v)=mag2(u,v);
            end
          end
           if (D2(i,j)==135)
            if (mag2(u,v)<mag2(u-1,v-1)||mag2(u,v)<mag2(u+1,v+1))
                NIm3(u,v)=0;
            else
                NIm3(u,v)=mag2(u,v);
            end
          end
    end
end
figure(5);
imshow(NIm3);
title('Non-Maximal Suppression');

% HYSTERESIS THRESHOLDING
T_low = 0.10;
T_high = 0.60;
T_res=zeros(Gfx,Gfy);
T_res1=zeros(Gfx,Gfy);

% STRONG AND WEAK EDGES SEPARATELY
for i=1:Gfx
    for j=1:Gfy
        if(NIm3(i,j)<T_low)
            T_res(i,j)=0;
        elseif (NIm3(i,j)>T_high)
            T_res(i,j)=1;
        elseif(NIm3(i,j)<T_high)||NIm3(i,j)>T_low
            T_res1(i,j)=1;
        end
    end
end

% WEAK EDGES NEAR TO STRONG EDGES

for i=1:Gfx-2
    for j=1:Gfy-2
            if T_res(i,j)==1 && T_res(i,j-1)==1
            T_res(i,j-1)=1;
            elseif T_res(i,j)==1 && T_res(i-1,j-1)==1
            T_res(i-1,j-1)=1;
            elseif T_res(i,j)==1 && T_res(i-1,j)==1
            T_res(i-1,j)=1; 
            elseif T_res(i,j)==1 && T_res(i-1,j+1)==1
            T_res(i-1,j+1)=1; 
             elseif T_res(i,j)==1 && T_res(i,j+1)==1
            T_res(i,j+1)=1; 
             elseif T_res(i,j)==1 && T_res(i+1,j+1)==1
            T_res(i+1,j+1)=1; 
             elseif T_res(i,j)==1 && T_res(i+1,j)==1
            T_res(i+1,j)=1; 
             elseif T_res(i,j)==1 && T_res(i+1,j-1)==1
            T_res(i+1,j-1)=1;
        end
    end
end

% CANNY EDGE IMAGE
figure(6);
imshow(T_res);
title('Canny Edge Detection')
