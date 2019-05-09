load AIRport;
nodenum=max(max(AIRport(:,1:2)));
D=zeros(nodenum);%�����������ͼΪ�Գ���
for i=1:length(AIRport)
    D(AIRport(i,1),AIRport(i,2))=AIRport(i,3);
end
%ѡ�����ӽڵ�
seednum=floor(log2(nodenum))+1;
seeds=zeros(seednum,1);
for i=1:seednum
    seeds(i)=2^(i-1);
end
SeedPath=cell(seednum,nodenum);%���ӽڵ㵽�������нڵ�����·��
SeedDist=zeros(seednum,nodenum);%���ӽڵ㵽�������нڵ�����·������
for i=1:seednum
    closelist=Djistra( seeds(i),D );
    for j=1:nodenum
    [P,value]= path( seeds(i),j,closelist );
    SeedPath{i,j}=P;
    SeedDist(i,j)=value;  
    end
end
a=500;%��ʼ�ڵ�(a~=b)
b=5;%�������
%�������ӽ��
Possible_path=cell(seednum,1);%ʹ��ÿ�����ӽڵ�����·��
Possible_dist=zeros(seednum,1);%ʹ��ÿ�����ӽ���·������
for i=1:seednum
    apath=SeedPath{i,a};
    adist=SeedDist(i,a);
    bpath=SeedPath{i,b};
    bdist=SeedDist(i,b);
    t=1;
    while apath(t)==bpath(t) && t<min(length(apath),length(bpath))
        t=t+1;
    end
    common=apath(t-1);
    unionpath=[fliplr(apath(t-1:end)),bpath(t-1:end)];%��װ����·��
    unionpath(length(apath)-t+2)=[];%���ظ����ɾ��
    Possible_path{i}=unionpath;
    Possible_dist(i)=adist+bdist-2*SeedDist(i,common);
end
[~,index]=min(Possible_dist);
mindist=Possible_dist(index);
minpath=Possible_path{index};
disp(mindist);
disp(minpath);
closelist=Djistra( a,D );
[P,value]= path( a,b,closelist );
disp(mindist-value);
