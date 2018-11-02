function closeSubSystems(system)
% closeSubSystems(model)
%   Close all open subsystems. Sometimes when opening a model from someone
%   else (or yourself) Simulink will re-open all of the previously opened
%   subsystems. closeSubSystems will close all open subsystems leaving only
%   the model open.

% If no system is given, run it on the current system;
if nargin<1
    system=bdroot;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Find all open blocks.
blocks=find_system(system,'FindAll','on','LookUnderMasks','all','FollowLinks','on','Open','on');
blocks=reshape(blocks,1,numel(blocks));
if isempty(blocks)
    return;
end
% Find which models aren't root.
nonRoot=~strcmp(get(blocks,'Name'),get(blocks,'Path'));
% Close the systems.
close_system(blocks(nonRoot));