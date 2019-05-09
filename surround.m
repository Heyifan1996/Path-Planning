function [ pro_path ] = surround( temppoint )%生成周围点的坐标
pro_path=zeros(8,2);
x=temppoint(1);
y=temppoint(2);
pro_path(1,:)=[x,y+1];
pro_path(2,:)=[x+1,y+1];
pro_path(3,:)=[x+1,y];
pro_path(4,:)=[x+1,y-1];
pro_path(5,:)=[x,y-1];
pro_path(6,:)=[x-1,y-1];
pro_path(7,:)=[x-1,y];
pro_path(8,:)=[x-1,y+1];
end

