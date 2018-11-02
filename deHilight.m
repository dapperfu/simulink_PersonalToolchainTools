function deHilight(system)
% Clears all hilighting on the models. After a failed update or other
% simulink error sometimes the blocks are left as clear

% If no system is given, run it on the current system;
if nargin<1
    system=gcs;
end
%
set_param(bdroot(system), 'Lock', 'off');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
handles=find_system(system,'FindAll','on','FollowLinks','on');
handles=reshape(handles,1,length(handles));
for hand=handles
    try;set(hand,'HiliteAncestors','none'); end
    try;set(hand,'ForegroundColor','black');end
    try;set(hand,'BackgroundColor','white');end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% If we ran this on the entire model, save it afterwards
save_system(bdroot(system));