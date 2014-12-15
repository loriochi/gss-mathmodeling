function d = GSSConstructionExclusive( T0,s )
%GSSCONSTRUCTION 
% Input - T0 : Basis of access structure, s: secret
% Output - d: n-by-2 matrix
%            where the 1st & 2nd column denotes the x and y coordinate for
%            each particpant's share respectively.
%---------------------------------------------------------
% Author: Tamalika Mukherjee
%---------------------------------------------------------

[rsize,csize]=size(T0);
B=zeros(1,5);
for i=1:rsize
    c=0;
    for j=1:csize
        if T0(i,j)==1
            c=c+1;
        end
    end
    B(i)=c;
end
c=1;
for i=1:rsize
    if(B(i)==0)
        break;
    end
    d1=ShamirSharing(s,B(i),B(i));
    count=1;
    for j=1:csize
        if T0(i,j)==1
            d(c,1)=d1(count,1);
            d(c,2)=d1(count,2);
            count=count+1;
            c=c+1;
        end
        
    end
end
            

end