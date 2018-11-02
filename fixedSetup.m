function fixedSetup(model)
% fixedSetup(model) - enable commonly used setup settings in simulink models.
%   Set to FixedStepDiscrete, Step time 0.015, Disable limit 
%
%  http://www.mathworks.com/help/simulink/slref/model-parameters.html

if nargin<1
    model=bdroot;
else
    model=bdroot(model);
end
set_param(model,'BufferReuse','off')
set_param(model,'SolverName','FixedStepDiscrete')
set_param(model,'FixedStep','0.015')
set_param(model,'StopTime','1.5');
set_param(model,'SaveTime','off')
set_param(model,'SaveOutput','off')
set_param(model,'LimitDataPoints','off')
set_param(model,'BlockReductionOpt','off')