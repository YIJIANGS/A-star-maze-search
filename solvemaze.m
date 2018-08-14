function solvemaze(im,map,start,des)
%% heuristic map
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
    if rem(cost,500)==0
        disp(cost)
    end
end
disp('ÕýÔÚ»­Í¼')
%%
list1=ismember(h_info(:,1),des(1));
list2=ismember(h_info(:,2),des(2));
list=list1+list2;
id=find(list==2);
imshow(im)
hold on
tpos=h_info(id,1:2);
while tpos(1)~=start(1) || tpos(2)~=start(2)
    id=h_info(id,5);
    tpos=h_info(id,1:2);
    plot(tpos(2),tpos(1),'.','color','r','MarkerSize',11)
end