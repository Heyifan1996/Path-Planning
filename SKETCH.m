load AIRport;
nodenum=max(max(AIRport(:,1:2)));
D=zeros(nodenum);%距离矩阵（无向图为对称阵）
for i=1:length(AIRport)
    D(AIRport(i,1),AIRport(i,2))=AIRport(i,3);
end
%选择种子节点
seednum=floor(log2(nodenum))+1;
seeds=zeros(seednum,1);
for i=1:seednum
    seeds(i)=2^(i-1);
end
SeedPath=cell(seednum,nodenum);%种子节点到其它所有节点的最短路径
SeedDist=zeros(seednum,nodenum);%种子节点到其它所有节点的最短路径距离
for i=1:seednum
    closelist=Djistra( seeds(i),D );
    for j=1:nodenum
    [P,value]= path( seeds(i),j,closelist );
    SeedPath{i,j}=P;
    SeedDist(i,j)=value;  
    end
end
a=500;%开始节点(a~=b)
b=5;%结束结点
%利用种子结点
Possible_path=cell(seednum,1);%使用每个种子节点的最短路径
Possible_dist=zeros(seednum,1);%使用每个种子结点的路径长度
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
    unionpath=[fliplr(apath(t-1:end)),bpath(t-1:end)];%组装两个路径
    unionpath(length(apath)-t+2)=[];%把重复结点删除
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
