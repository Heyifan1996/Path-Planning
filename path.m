function [ P,value ] = path( a,b,closelist )
value=closelist(closelist(:,2)==b,end);
value=value(1);
%通过closelist产生最短路径和最短路径长度
if size(closelist,1)>1
    closelist(1:2,:)=[];
end
P=b;
beg=b;
while beg~=a
    index= closelist(:,2)==beg;
     beg=closelist(index,1);
     P=[beg,P]; 
end


end

