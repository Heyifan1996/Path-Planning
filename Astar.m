% G=zeros(100);%随机网络为100*100大小
% %随机生成两个长为L1的路障
% L1=90;
% L2=90;
% LL=19+randperm(80,1);
% LL1=19+randperm(80,1);
% s1=randperm(100-L1,1);
% s2=randperm(100-L1,1);
% G(s1:(s1+L1),LL)=1;
% G(s2:(s2+L2),LL1)=1;
load G;
[x,y]=find(G==1);
% plot(y,x,'s');
% set(gca,'Ylim',[0 100]);
% set(gca,'Xlim',[0 100]);
% barrier=[0,0];
barrier=[y,x];
beginpoint=[0,0];%初始点
endpoint=[100,100];%终止点
tempdist=0;
temppoint=[beginpoint,beginpoint,tempdist];
openlist=[];%初始设置两个空列表
closedlist=[];
root=temppoint(1:2);
while isempty(closedlist)||isequal(closedlist(end,1:2),endpoint)==0%当closedlist不为空且closedlist最后一个结点为end结点时终止
    tic;
    pro_path=surround(root);
    for i=1:length(pro_path)
        templeaf=pro_path(i,:);%当前叶结点
         if rem(i,2)==1
            v=1;
         else
            v=sqrt(2);
         end
         templist=[templeaf,root,tempdist+v];
         if ~isempty(closedlist)&&ismember(templeaf,closedlist(:,1:2),'rows');%如果新的页节点已存在与closedlist则进行下一步
             continue
         end
         if ismember(templeaf,barrier,'rows')||templeaf(1)<=0||templeaf(1)>100||templeaf(2)<=0||templeaf(2)>100
             continue
         elseif ~isempty(openlist)&&ismember(templeaf,openlist(:,1:2),'rows')%如果已存在与openlist
             index=F(templeaf,openlist(:,1:2));%找出点所在位置
             tempv=openlist(index,end);%找出原先从原点到该点的距离
             if tempv<templist(end)%如果小于现在的就不变
                 continue
             else%否则删除原先的，加入新的
                 openlist(index,:)=[];
                 openlist=cat(1,openlist,templist);
             end    
         else%如不存在openlist直接存入openlist
             openlist=cat(1,openlist,templist);
         end   
    end%已把新遍历的结点加入了openlist
    %寻找最优的结点作为下一次的结点，并放入closedlist,从openlist移除
    value=zeros(size(openlist,1),1);%求出所有openlist中结点的预测路径长度
    for i=1:length(value)
        temp=openlist(i,:);
        value(i)=temp(end);%+EV(barrier,temp(1:2),endpoint);%Astar采用欧式距离,去掉EV即为Djistra
    end
    [~,index]=min(value);%最小的位置
    closedlist=cat(1,closedlist,openlist(index,:));
    root=openlist(index,1:2);
    tempdist=openlist(index,end);
    openlist(index,:)=[];  
    toc;
end



%反向求得路径
tic;
path=endpoint;
tempp=endpoint;
C=closedlist(:,1:2);
while isequal(beginpoint,tempp)==0
    ins=F(tempp,C);
    tempp=closedlist(ins,3:4);
    path=cat(1,closedlist(ins,3:4),path);
end
toc;



figure(2)
B=cat(1,closedlist(:,1:2),openlist(:,1:2));
plot(B(:,1),B(:,2),'bo');hold on
%plot(closedlist(:,1),closedlist(:,2),'b','LineWidth',5);
%plot(nodelist(:,1),nodelist(:,2),'o');hold on
% plot(y(1:L1+1),x(1:L1+1),'r','LineWidth',5);hold on
% plot(y(L1+2:end),x(L1+2:end),'r','LineWidth',5);hold on
plot(y,x,'rp');
set(gca,'Ylim',[0 100]);
set(gca,'Xlim',[0 100]);
set(gca,'Fontsize',15);
title(['Begin Point is ' num2str(beginpoint) ' and End Point is ' num2str(endpoint)])

plot(path(:,1),path(:,2),'g','LineWidth',5);
%plot(nodelist(end-100:end,1),nodelist(end-100:end,2),'g','LineWidth',5);
set(gca,'Fontsize',15);
set(gca,'Ylim',[0 100]);
set(gca,'Xlim',[0 100]);%画出路障
title(['Begin Point is ' num2str(beginpoint) ' and End Point is ' num2str(endpoint)]) 