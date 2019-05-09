function [value] = EV( barrier,local,endpoint)%¹À¼Ûº¯Êý
if local(1)<0||local(1)>100||local(2)<0||local(2)>100
    value=1000;
elseif ismember(local,barrier,'rows')
    value=1000;
else
    value=abs(endpoint(1)-local(1))+abs(endpoint(2)-local(2));
    %value=sqrt((endpoint(1)-local(1))^2+(endpoint(2)-local(2))^2);
end
end

