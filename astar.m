clear;clc;close;
row=25; %迷宫的列数
col=25; %迷宫的行数
visited=zeros(row-1,col-1);
maze=ones(row*2+1,col*2+1);
maze(2:2:row*2,2:end-1)=0;
maze(2:end-1,2:2:col*2)=0;
% maze(3,2)=1;
maze(end-2,end-1)=1;

x=1;
y=1;
while find(visited==0)
move=randi(4);
switch move
    case 1 %向上移动
        if x>1 && visited(x-1,y)==0
            visited(x-1,y)=1;
            x=x-1;
            maze(2*x+2,2*y+1)=1;
        elseif x>1 && maze(2*x,2*y+1)==1
            x=x-1;
        end
    case 2 %向下移动
        if x<row-1 && visited(x+1,y)==0
            visited(x+1,y)=1;
            x=x+1;
            maze(2*x,2*y+1)=1;
        elseif x<row-1 && maze(2*x+2,2*y+1)==1
            x=x+1;
        end
    case 3 %向左移动
        if y>1 && visited(x,y-1)==0
            visited(x,y-1)=1;
            y=y-1;
            maze(2*x+1,2*y+2)=1;
        elseif y>1 && maze(2*x+1,2*y)==1
            y=y-1;
        end
    case 4 %向右移动
        if y<col-1 && visited(x,y+1)==0
            visited(x,y+1)=1;
            y=y+1;
            maze(2*x+1,2*y)=1;
        elseif y<col-1 && maze(2*x+1,2*y+2)==1
            y=y+1;
        end
end
end
map=kron(maze,ones(2));
%% heuristic map
start=[6 6]; %starting position
des=[98 98]; %destination
h_map=map;
h_map(h_map==0)=inf;
for i=1:size(h_map,1)
    for j=1:size(h_map,2)
        if h_map(i,j)==1
        h_map(i,j)=abs(i-des(1))+abs(j-des(2));
        end
    end
end
%%
h_info=zeros(1,5); %h_info stores pos(1,2),heuristic value(3),is node visited(4) and previous pos(5)
c_pos=start;
i=1;
cost=0;
h_info(1,1:2)=c_pos; 
h_info(1,3)=cost+h_map(c_pos(1),c_pos(2));
h_info(1,4)=1; %mark current pos as visited
id=1;
while c_pos(1)~=des(1) || c_pos(2)~=des(2)
    cost=cost+1;
    if map(c_pos(1)+1,c_pos(2))==1 && checkinfo(h_info,c_pos(1)+1,c_pos(2))==1
        i=i+1;
        h_info(i,1)=c_pos(1)+1; h_info(i,2)=c_pos(2);
        h_info(i,3)=cost+h_map(c_pos(1)+1,c_pos(2));
        h_info(i,5)=id;
    end
    if map(c_pos(1)-1,c_pos(2))==1 && checkinfo(h_info,c_pos(1)-1,c_pos(2))==1
        i=i+1;
        h_info(i,1)=c_pos(1)-1; h_info(i,2)=c_pos(2);
        h_info(i,3)=cost+h_map(c_pos(1)-1,c_pos(2));
        h_info(i,5)=id;
    end
    if map(c_pos(1),c_pos(2)+1)==1 && checkinfo(h_info,c_pos(1),c_pos(2)+1)==1
        i=i+1;
        h_info(i,1)=c_pos(1); h_info(i,2)=c_pos(2)+1;
        h_info(i,3)=cost+h_map(c_pos(1),c_pos(2)+1);
        h_info(i,5)=id;
    end
    if map(c_pos(1),c_pos(2)-1)==1 && checkinfo(h_info,c_pos(1),c_pos(2)-1)==1
        i=i+1;
        h_info(i,1)=c_pos(1); h_info(i,2)=c_pos(2)-1;
        h_info(i,3)=cost+h_map(c_pos(1),c_pos(2)-1);
        h_info(i,5)=id;
    end
    valid=find(h_info(:,4)==0);
    [~,id]=min(h_info(valid,3));
    temp_info=h_info(valid(id),:);
    h_info(valid(id),4)=1;
    c_pos=temp_info(1:2);
    id=valid(id);
%     posplot=plot(c_pos(1),c_pos(2),'.','color','r');
    if rem(cost,200)==0
        disp(cost)
    end
end
%%
% imshow(map')
list1=ismember(h_info(:,1),des(1));
list2=ismember(h_info(:,2),des(2));
list=list1+list2;
id=find(list==2);
imshow(map')
hold on
tpos=h_info(id,1:2);
while tpos(1)~=start(1) || tpos(2)~=start(2)
    id=h_info(id,5);
    tpos=h_info(id,1:2);
    plot(tpos(1),tpos(2),'.','color','r','MarkerSize',12)
end