% NEWPROB - Resets the matlab environment for working on a new problem.
%   Removes all paths beneath the 'project folder' from the path.
%   Closes all java and .dll files.
%   Closes all models.
%   Closes all figures
%   Clears all variables
%   Reloads Simulink.

% Author: Jed Frey
% May 2014


% Project Folder
if ~ispref(mfilename,'projFolder')||~isdir(getpref(mfilename,'projFolder'))
    dir=uigetdir('C:\', 'Select top level folder that has all of your projects in it.');
    if dir==0
        error('Project folder selection canceled. Exiting');
    end
    setpref(mfilename,'projFolder',dir);
end
projFolder=getpref(mfilename,'projFolder');
% Put current paths in cell array.
paths=textscan(path,'%s','delimiter',';');
paths=paths{1};
paths=reshape(paths,1,numel(paths));
javapaths=javaclasspath;
javapaths=reshape(javapaths,1,numel(javapaths));
% For each of them remove anything that is in the project folder. So you're
% not still reading <project folder>/Project1/lib_model.mdl when you're
% in <project folder>/Project2/lib_model.mdl
fprintf('Clearing Paths: ');
for p=paths
    if strncmpi(projFolder,p{1},length(projFolder))
        fprintf('#');
        rmpath(p{1});
    else        
        fprintf('.');
    end
end
% Save the new path
savepath;
fprintf('\nClearing Java Paths: ');
for p=javapaths
    if strncmpi(projFolder,p{1},length(projFolder))
        fprintf('#');
        javarmpath(p{1});
    else        
        fprintf('.');
    end
end
fprintf('\n');
close('all');   % Close all figures
bdclose('all'); % Close all models
fclose('all');  % Close all open files.
clear('all');   % Clear all
load_system('simulink'); % Reload Simulink.
clc; % Clear the screen.
