function unitDelayPrettify(system)
% UNITDELAYPRETTIFY - Align unit delay blocks with the block that they came
% out of.
% If no system is given, run it on the current system;
if nargin<1
    system=gcs;
end
% If we are running this on an entire model, unlock it.
if strcmp(system,bdroot(system))
    set_param(bdroot(system), 'Lock', 'off');
end
% Set a fixed size
blockWidth=40;
blockHeight=40;
delay1=find_system(system,'BlockType','UnitDelay');
delay2=find_system(system,'BlockType','Delay');
delays = [delay1;delay2];
for delay=delays' 
    Ports		  =get_param(delay{1},'LineHandles');
    SourceBlock	  =get(Ports.Inport,'SrcBlockHandle');
    %DstBlock      =get(Ports.Outport,'DstBlockHandle');
    %if SourceBlock==DstBlock
    %    continue;
    %end
    SourcePosition=get(SourceBlock,'Position');
    LinePosition  =get(Ports.Inport,'Points');
    SourceName    =get(get(Ports.Inport,'SrcPortHandle'),'Name');
    Y=LinePosition(end,end);
    X=SourcePosition(3);
    set_param(delay{1},'Position',[X-blockWidth Y-blockHeight/2 X Y+blockHeight/2]);
    if ~isempty(SourceName)
        set_param(delay{1},'Name',sprintf('%sDelay',SourceName));
    end
end
% If we ran this on the entire model, save it afterwards
if strcmp(system,bdroot(system))
    save_system(bdroot(system));
end
