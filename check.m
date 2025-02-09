load testnum1.mat test1
load testnum2.mat test2
% load testnum4.mat test4
% load testnum5.mat test5
if test1==test2
    fprintf('yes\n');
else
    test3=test1-test2;
    fprintf('no\n');
end
% if test4==test5
%     fprintf('yes\n');
% else
%     fprintf('no\n');
% end