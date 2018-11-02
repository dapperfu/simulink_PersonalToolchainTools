function alignIO(system,recurse,fatal)
% - alignIO(system,recurse)
% Aligns the all of the IO blocks on a current system level. Moves all
% Inport blocks to the leftmost of the Inport blocks. Moves the Outport
% blocks to the right most of the Outport blocks.
%
% system - default "gcs"
% recurse - recurse into all unmasked subsystems. 
%   Default "true"
% fatal - If the io blocks are not aligned, fail. To use as a lint test.
%   Default "false"

% If no system is given, run it on the current system;
if nargin<1||isempty(system)
    system=gcs;
end
if nargin<2||isempty(recurse)
    recurse=true;
end
if nargin<3||isempty(fatal)
    fatal=false;
end
% Unlock the base model.
set_param(bdroot(system), 'Lock', 'off');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Find all of the in and out blocks.
Ins=[find_system(system,'SearchDepth',1,'FindAll','on','BlockType','Inport');
    find_system(system,'SearchDepth',1,'FindAll','on','BlockType','InportShadow')];
Outs=find_system(system,'SearchDepth',1,'FindAll','on','BlockType','Outport');
% The block size of an inport block from standard simulink. Sometimes they
% got accidentally resized and it looks weird.
blockSize=[30 14];
if numel(Ins)>1
    % Get the position of all the Inports.
    InPos=cell2mat(get(Ins,'Position'));
    % Get the left most edge.
    LeftEdge=min(InPos(:,1));
    % Get the centerline of the in blocks.
    InCenterline=mean(InPos(:,[2,4]),2);
    for i=1:size(Ins,1)
        tmp=[LeftEdge InCenterline(i)-blockSize(2)/2 LeftEdge+blockSize(1) InCenterline(i)+blockSize(2)/2];
        if any(get(Ins(i),'Position')~=tmp)
            if fatal
                error('ALIGNIO:INPORT','Inport blocks are not aligned')
            else
                fprintf('Aligning: %s\n',get(Ins(i),'Name'));
                set(Ins(i),'Position',tmp);
            end
        end
    end
end
if numel(Outs)>1
    % Get the position of all the Outports.
    OutPos=cell2mat(get(Outs,'Position'));
    RightEdge=max(OutPos(:,3));
    OutCenterline=mean(OutPos(:,[2,4]),2);
    for i=1:size(Outs,1)
        tmp=[RightEdge-blockSize(1) OutCenterline(i)-blockSize(2)/2 RightEdge OutCenterline(i)+blockSize(2)/2];
        if any(get(Outs(i),'Position')~=tmp)
            if fatal
                error('ALIGNIO:OUTPORT','Inport blocks are not aligned')
            else
                fprintf('Aligning: %s\n',get(Outs(i),'Name'));
                set_param(Outs(i),'Position',tmp);
            end
        end
    end
end
if recurse
    % We must go deeper.
    subSystems=find_system(system,'SearchDepth',1,'BlockType','SubSystem');
    for i=1:numel(subSystems)
        % Ignore the current depth model.
        if strcmpi(system,subSystems{i})
            continue
        end
        try
            alignIO(subSystems{i})
        end
    end
end