function [closelist] =Djistra( a,D )
%生成closelist
tic;
topbound=sum(sum(D));
D(D==0)=topbound;
beginpoint=a;
endpoint=a;
openlist=[beginpoint,endpoint,0];
closelist=[beginpoint,endpoint,0];
% while endpoint~=b
while length(closelist)<=500
    c2=closelist(:,2);
    o2=openlist(:,2);
    endpointvalue=closelist(end,end);
    can_id=find(D(endpoint,:)<topbound);%找到与endpoint相连的结点
    can_id=setdiff(can_id,c2);%去除已确定的节点
    for i=1:length(can_id)
        temp=can_id(i);
        tempvalue=endpointvalue+D(endpoint,temp);
        if ~ismember(temp,o2)%如若temp节点之前未出现过
            openlist=[openlist;endpoint,temp,tempvalue];
        else
            index=find(o2==temp);%找出在openlist中的位置
            if tempvalue<openlist(index,end);
                openlist(index,:)=[endpoint,temp,tempvalue];
            else
                continue
            end  
        end
    end
    [~,index]=min(openlist(:,end));%找到最小路径对应的节点
    closelist=[closelist;openlist(index,:)];%记录这一段的距离与前一节点
    endpoint=openlist(index,2);%更换最终节点，即下一步开始节点
    openlist(index,:)=[];
end
%通过closelist求出路径；
toc;
end

