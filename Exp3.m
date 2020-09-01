% Histogram Equalisation Without using Direct Function

clc
clear all
close all

a=imread('pout.tif')
subplot(2,2,1)
imshow(a)
title('Original Image')

[r,c] = size(a);
x= 1:1:255		
y= (zeros(1,255));
in = 1;
count = 0;
output=zeros(256,1);
NIm=uint8(zeros(size(a,1),size(a,2)));

% Finding Histogram Of image without using direct function
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
subplot(2,2,2)
stem(x,y)
axis tight
title('Histogram of Original Image')

s1=sum(y)

s2=y./s1

%CDF
h=0
for i=2:255
    
    h(i)=s2(i-1)+h(i-1)
    j(i)=round(h(i)*255)
    
end


for i1=1:r

    for h1=1:c

            NIm(i1,h1)=j(a(i1,h1))+1;

    end

end
subplot(2,2,3)
imshow(NIm)
title('Histogram Equalised Image')
subplot(2,2,4)

% Histogram by using direct function
imhist(NIm)
title('Histogram of Equalised Image')

% Histogram Equalisation by using direct function
gh=histeq(a)

% Just to check the difference
df=NIm-gh
xc=max(df)


