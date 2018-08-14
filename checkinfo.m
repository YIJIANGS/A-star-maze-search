% Check if pos is visited
function a=checkinfo(h_info,pos1,pos2)
% pos1=8;
% pos2=8;
list1=ismember(h_info(:,1),pos1);
list2=ismember(h_info(:,2),pos2);
list=list1+list2;
if find(list==2)
    a=0;
else
    a=1;
end