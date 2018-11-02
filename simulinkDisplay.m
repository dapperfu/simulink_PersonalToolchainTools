function simulinkDisplay(model)
% simulinkDisplay(model) - enable commonly used formatting settings in simulink models.
%   model - model to use. Otherwise use output from 'bdroot'
%
%  http://www.mathworks.com/help/simulink/slref/model-parameters.html
%  WideLines - Enable
%  ShowPortDataTypes - Enable
%  ShowStorageClass -  Enable
%  ShowLineDimensions - Enable
%  LibraryLinkDisplay - All
%  SampleTimeColors - Enabled
%  SampleTimeAnnotations - Enabled 
if nargin<1
    model=bdroot;
else
    model=bdroot(model);
end
set_param(model,'WideLines','on')
set_param(model,'ShowPortDataTypes','on')
set_param(model,'ShowStorageClass','on')
set_param(model,'ShowTestPointIcons','on')
set_param(model,'ShowLineDimensions','on')
set_param(model,'LibraryLinkDisplay','all')
set_param(model,'SampleTimeColors','on')
set_param(model,'SampleTimeAnnotations','on')