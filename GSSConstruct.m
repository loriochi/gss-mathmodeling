function d = GSSConstruct( p,B,s )
%GSSCONSTRUCT Returns a matrix with points to be distributed among the p
%participants
%   p- number of participants
%   B- Basis set
%   s- secret
%---------------------------------------------------------
% Author: Tamalika Mukherjee
%---------------------------------------------------------

[m,n]=size(B);
%to find the k-out-of-n sharings of each authority groups
KN=zeros(m,2);
for i=1:m
    c=0;
    for j=1:n
        if(B(i,j)~=0)
            c=c+1;
        end
            if(j==1)
                num=B(i,j);
                count=0;
                while(num>0)
                    digit=rem(num,10);
                    if(digit==1)
                        count=count+1;
                    end
                    num=fix(num/10);
                end
                KN(i,1)=count; %storing k
            end
    end
    syms l;
    KN(i,2)=floor(solve(nchoosek(l,count)==c,l)); %storing n
    end
dm=zeros(p,2*m);
c1=1; c2=2;
%distribute sharing to each participant
for i=1:m
    d1=ShamirSharing(s,KN(i,1),KN(i,2)); %polynomial assigned for k-out-of-n
    c=1;
    fprintf('Coordinates from the %d-out-of-%d polynomial: \n',KN(i,1),KN(i,2));
    disp(d1);
    for j=1:n
        if (B(i,j) ~= 0)
            num=B(i,j); %example: 11000
            count=1; %keeps track of row in dm
            while(num>0)
               digit=rem(num,10);
               if((digit==1) && (dm(p-count+1,c1)==0) && (dm(p-count+1,c2)==0))
                   dm(p-count+1,c1)=d1(c,1); 
                   dm(p-count+1,c2)=d1(c,2);
                   c=c+1;
               end
               count=count+1;
               num=fix(num/10);               
            end
        end
    end
    c1=c1+2;
    c2=c2+2;
end

d=dm;            

end

