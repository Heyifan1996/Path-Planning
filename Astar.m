% G=zeros(100);%�������Ϊ100*100��С
% %�������������ΪL1��·��
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
beginpoint=[0,0];%��ʼ��
endpoint=[100,100];%��ֹ��
tempdist=0;
temppoint=[beginpoint,beginpoint,tempdist];
openlist=[];%��ʼ�����������б�
closedlist=[];
root=temppoint(1:2);
while isempty(closedlist)||isequal(closedlist(end,1:2),endpoint)==0%��closedlist��Ϊ����closedlist���һ�����Ϊend���ʱ��ֹ
    tic;
    pro_path=surround(root);
    for i=1:length(pro_path)
        templeaf=pro_path(i,:);%��ǰҶ���
         if rem(i,2)==1
            v=1;
         else
            v=sqrt(2);
         end
         templist=[templeaf,root,tempdist+v];
         if ~isempty(closedlist)&&ismember(templeaf,closedlist(:,1:2),'rows');%����µ�ҳ�ڵ��Ѵ�����closedlist�������һ��
             continue
         end
         if ismember(templeaf,barrier,'rows')||templeaf(1)<=0||templeaf(1)>100||templeaf(2)<=0||templeaf(2)>100
             continue
         elseif ~isempty(openlist)&&ismember(templeaf,openlist(:,1:2),'rows')%����Ѵ�����openlist
             index=F(templeaf,openlist(:,1:2));%�ҳ�������λ��
             tempv=openlist(index,end);%�ҳ�ԭ�ȴ�ԭ�㵽�õ�ľ���
             if tempv<templist(end)%���С�����ڵľͲ���
                 continue
             else%����ɾ��ԭ�ȵģ������µ�
                 openlist(index,:)=[];
                 openlist=cat(1,openlist,templist);
             end    
         else%�粻����openlistֱ�Ӵ���openlist
             openlist=cat(1,openlist,templist);
         end   
    end%�Ѱ��±����Ľ�������openlist
    %Ѱ�����ŵĽ����Ϊ��һ�εĽ�㣬������closedlist,��openlist�Ƴ�
    value=zeros(size(openlist,1),1);%�������openlist�н���Ԥ��·������
    for i=1:length(value)
        temp=openlist(i,:);
        value(i)=temp(end);%+EV(barrier,temp(1:2),endpoint);%Astar����ŷʽ����,ȥ��EV��ΪDjistra
    end
    [~,index]=min(value);%��С��λ��
    closedlist=cat(1,closedlist,openlist(index,:));
    root=openlist(index,1:2);
    tempdist=openlist(index,end);
    openlist(index,:)=[];  
    toc;
end



%�������·��
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
set(gca,'Xlim',[0 100]);%����·��
title(['Begin Point is ' num2str(beginpoint) ' and End Point is ' num2str(endpoint)]) 