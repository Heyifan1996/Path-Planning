function [closelist] =Djistra( a,D )
%����closelist
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
    can_id=find(D(endpoint,:)<topbound);%�ҵ���endpoint�����Ľ��
    can_id=setdiff(can_id,c2);%ȥ����ȷ���Ľڵ�
    for i=1:length(can_id)
        temp=can_id(i);
        tempvalue=endpointvalue+D(endpoint,temp);
        if ~ismember(temp,o2)%����temp�ڵ�֮ǰδ���ֹ�
            openlist=[openlist;endpoint,temp,tempvalue];
        else
            index=find(o2==temp);%�ҳ���openlist�е�λ��
            if tempvalue<openlist(index,end);
                openlist(index,:)=[endpoint,temp,tempvalue];
            else
                continue
            end  
        end
    end
    [~,index]=min(openlist(:,end));%�ҵ���С·����Ӧ�Ľڵ�
    closelist=[closelist;openlist(index,:)];%��¼��һ�εľ�����ǰһ�ڵ�
    endpoint=openlist(index,2);%�������սڵ㣬����һ����ʼ�ڵ�
    openlist(index,:)=[];
end
%ͨ��closelist���·����
toc;
end

