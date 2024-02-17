function chConf(block)
%MSFUNTMPL A Template for a MATLAB S-Function
%   The MATLAB S-function is written as a MATLAB function with the
%   same name as the S-function. Replace 'msfuntmpl' with the name
%   of your S-function.  

%   Copyright 2003-2018 The MathWorks, Inc.
  
%
% The setup method is used to setup the basic attributes of the
% S-function such as ports, parameters, etc. Do not add any other
% calls to the main body of the function.  
%   
setup(block);
  
%endfunction

% Function: setup ===================================================
% Abstract:
%   Set up the S-function block's basic characteristics such as:
%   - Input ports
%   - Output ports
%   - Dialog parameters
%   - Options
% 
%   Required         : Yes
%   C MEX counterpart: mdlInitializeSizes
%
function setup(block)

  % Register the number of ports.
  block.NumInputPorts  = 0;
  block.NumOutputPorts = 0;
  
  % Register the parameters.
  block.NumDialogPrms     = 53;
  tmp = cell(1,block.NumDialogPrms);
  for i=1:block.NumDialogPrms
    tmp{i}='Nontunable';
  end
  block.DialogPrmsTunable=tmp;
  
  % Register the sample times.
  %  [0 offset]            : Continuous sample time
  %  [positive_num offset] : Discrete sample time
  %
  %  [-1, 0]               : Inherited sample time
  %  [-2, 0]               : Variable sample time
  block.SampleTimes = [-1 0];
  
  % -----------------------------------------------------------------
  % Options
  % -----------------------------------------------------------------
  % Specify if Accelerator should use TLC or call back to the 
  % MATLAB file
  block.SetAccelRunOnTLC(true);
  
  % Specify the block's operating point compliance. The block operating 
  % point is used during the containing model's operating point save/restore)
  % The allowed values are:
  %   'Default' : Same the block's operating point as of a built-in block
  %   'UseEmpty': No data to save/restore in the block operating point
  %   'Custom'  : Has custom methods for operating point save/restore
  %                 (see GetOperatingPoint/SetOperatingPoint below)
  %   'Disallow': Error out when saving or restoring the block operating point.
  block.OperatingPointCompliance = 'Default';
  
  block.RegBlockMethod('WriteRTW', @WriteRTW);
  block.RegBlockMethod('Outputs', @nullFCN);     % Required
  block.RegBlockMethod('Terminate', @nullFCN); % Required
  block.RegBlockMethod('PostPropagationSetup',    @DoPostPropSetup);
%endfunction

% -------------------------------------------------------------------
% The local functions below are provided to illustrate how you may implement
% the various block methods listed above.
% -------------------------------------------------------------------

function nullFCN(~)
  
function DoPostPropSetup(block)
 
  % Register all tunable parameters as runtime parameters.
  block.AutoRegRuntimePrms;

%endfunction

function WriteRTW(block)
  if (block.DialogPrm(1).Data)
    block.WriteRTWParam('string','CH_CFG_SMP_MODE', 'TRUE');
  else
    block.WriteRTWParam('string','CH_CFG_SMP_MODE', 'FALSE');
  end

  if (block.DialogPrm(2).Data)
    block.WriteRTWParam('string','CH_CFG_OPTIMIZE_SPEED', 'TRUE');
  else
    block.WriteRTWParam('string','CH_CFG_OPTIMIZE_SPEED', 'FALSE');
  end

  CH_CFG_ST_RESOLUTION=block.DialogPrm(3).Data;
  block.WriteRTWParam('string','CH_CFG_ST_RESOLUTION', sprintf('%.0f',CH_CFG_ST_RESOLUTION));

  if (block.DialogPrm(4).Data<0)
    warning('CHIBIOS:CH_CFG_ST_FREQUENCY','System tick frequency must be a positive integer. Setting to 1.');
    CH_CFG_ST_FREQUENCY=1;
  elseif (mod(block.DialogPrm(4).Data,1)~=0)
    warning('CHIBIOS:CH_CFG_ST_FREQUENCY','System tick frequency must be a whole integer.');
    CH_CFG_ST_FREQUENCY=round(block.DialogPrm(4).Data);
  else
    CH_CFG_ST_FREQUENCY=block.DialogPrm(4).Data;
  end
  block.WriteRTWParam('string','CH_CFG_ST_FREQUENCY', sprintf('%.0f',CH_CFG_ST_FREQUENCY));

  CH_CFG_INTERVALS_SIZE=block.DialogPrm(5).Data;
  block.WriteRTWParam('string','CH_CFG_INTERVALS_SIZE', sprintf('%.0f',CH_CFG_INTERVALS_SIZE));
  
  CH_CFG_TIME_TYPES_SIZE=block.DialogPrm(6).Data;
  block.WriteRTWParam('string','CH_CFG_TIME_TYPES_SIZE', sprintf('%.0f',CH_CFG_TIME_TYPES_SIZE));
  
  CH_CFG_ST_TIMEDELTA=block.DialogPrm(7).Data;
  block.WriteRTWParam('string','CH_CFG_ST_TIMEDELTA', sprintf('%.0f',CH_CFG_ST_TIMEDELTA));

  CH_CFG_TIME_QUANTUM=block.DialogPrm(8).Data;
  block.WriteRTWParam('string','CH_CFG_TIME_QUANTUM', sprintf('%.0f',CH_CFG_TIME_QUANTUM));

  if (block.DialogPrm(9).Data)
    block.WriteRTWParam('string','CH_CFG_NO_IDLE_THREAD', 'TRUE');
  else
    block.WriteRTWParam('string','CH_CFG_NO_IDLE_THREAD', 'FALSE');
  end

  CH_CFG_HARDENING_LEVEL=block.DialogPrm(10).Data;
  block.WriteRTWParam('string','CH_CFG_HARDENING_LEVEL', sprintf('%.0f',CH_CFG_HARDENING_LEVEL));

  if (block.DialogPrm(11).Data)
    block.WriteRTWParam('string','CH_CFG_USE_TM', 'TRUE');
  else
    block.WriteRTWParam('string','CH_CFG_USE_TM', 'FALSE');
  end

  if (block.DialogPrm(12).Data)
    block.WriteRTWParam('string','CH_CFG_USE_TIMESTAMP', 'TRUE');
  else
    block.WriteRTWParam('string','CH_CFG_USE_TIMESTAMP', 'FALSE');
  end

  if (block.DialogPrm(13).Data)
    block.WriteRTWParam('string','CH_CFG_USE_REGISTRY', 'TRUE');
  else
    block.WriteRTWParam('string','CH_CFG_USE_REGISTRY', 'FALSE');
  end

  if (block.DialogPrm(14).Data)
    block.WriteRTWParam('string','CH_CFG_USE_WAITEXIT', 'TRUE');
  else
    block.WriteRTWParam('string','CH_CFG_USE_WAITEXIT', 'FALSE');
  end

  if (block.DialogPrm(15).Data)
    block.WriteRTWParam('string','CH_CFG_USE_SEMAPHORES', 'TRUE');
  else
    block.WriteRTWParam('string','CH_CFG_USE_SEMAPHORES', 'FALSE');
  end

  if (block.DialogPrm(16).Data)
    block.WriteRTWParam('string','CH_CFG_USE_SEMAPHORES_PRIORITY', 'TRUE');
  else
    block.WriteRTWParam('string','CH_CFG_USE_SEMAPHORES_PRIORITY', 'FALSE');
  end

  if (block.DialogPrm(17).Data)
    block.WriteRTWParam('string','CH_CFG_USE_MUTEXES', 'TRUE');
  else
    block.WriteRTWParam('string','CH_CFG_USE_MUTEXES', 'FALSE');
  end

  if (block.DialogPrm(18).Data)
    block.WriteRTWParam('string','CH_CFG_USE_MUTEXES_RECURSIVE', 'TRUE');
  else
    block.WriteRTWParam('string','CH_CFG_USE_MUTEXES_RECURSIVE', 'FALSE');
  end

  if (block.DialogPrm(19).Data)
    block.WriteRTWParam('string','CH_CFG_USE_CONDVARS', 'TRUE');
  else
    block.WriteRTWParam('string','CH_CFG_USE_CONDVARS', 'FALSE');
  end

  if (block.DialogPrm(20).Data)
    block.WriteRTWParam('string','CH_CFG_USE_CONDVARS_TIMEOUT', 'TRUE');
  else
    block.WriteRTWParam('string','CH_CFG_USE_CONDVARS_TIMEOUT', 'FALSE');
  end

  if (block.DialogPrm(21).Data)
    block.WriteRTWParam('string','CH_CFG_USE_EVENTS', 'TRUE');
  else
    block.WriteRTWParam('string','CH_CFG_USE_EVENTS', 'FALSE');
  end

  if (block.DialogPrm(22).Data)
    block.WriteRTWParam('string','CH_CFG_USE_EVENTS_TIMEOUT', 'TRUE');
  else
    block.WriteRTWParam('string','CH_CFG_USE_EVENTS_TIMEOUT', 'FALSE');
  end

  if (block.DialogPrm(23).Data)
    block.WriteRTWParam('string','CH_CFG_USE_MESSAGES', 'TRUE');
  else
    block.WriteRTWParam('string','CH_CFG_USE_MESSAGES', 'FALSE');
  end

  if (block.DialogPrm(24).Data)
    block.WriteRTWParam('string','CH_CFG_USE_MESSAGES_PRIORITY', 'TRUE');
  else
    block.WriteRTWParam('string','CH_CFG_USE_MESSAGES_PRIORITY', 'FALSE');
  end

  if (block.DialogPrm(25).Data)
    block.WriteRTWParam('string','CH_CFG_USE_DYNAMIC', 'TRUE');
  else
    block.WriteRTWParam('string','CH_CFG_USE_DYNAMIC', 'FALSE');
  end

  if (block.DialogPrm(26).Data)
    block.WriteRTWParam('string','CH_CFG_USE_MAILBOXES', 'TRUE');
  else
    block.WriteRTWParam('string','CH_CFG_USE_MAILBOXES', 'FALSE');
  end

  if (block.DialogPrm(27).Data)
    block.WriteRTWParam('string','CH_CFG_USE_MEMCHECKS', 'TRUE');
  else
    block.WriteRTWParam('string','CH_CFG_USE_MEMCHECKS', 'FALSE');
  end

  if (block.DialogPrm(28).Data)
    block.WriteRTWParam('string','CH_CFG_USE_MEMCORE', 'TRUE');
  else
    block.WriteRTWParam('string','CH_CFG_USE_MEMCORE', 'FALSE');
  end

  CH_CFG_MEMCORE_SIZE=block.DialogPrm(29).Data;
  block.WriteRTWParam('string','CH_CFG_MEMCORE_SIZE', sprintf('%.0f',CH_CFG_MEMCORE_SIZE));

  if (block.DialogPrm(30).Data)
    block.WriteRTWParam('string','CH_CFG_USE_HEAP', 'TRUE');
  else
    block.WriteRTWParam('string','CH_CFG_USE_HEAP', 'FALSE');
  end

  if (block.DialogPrm(31).Data)
    block.WriteRTWParam('string','CH_CFG_USE_MEMPOOLS', 'TRUE');
  else
    block.WriteRTWParam('string','CH_CFG_USE_MEMPOOLS', 'FALSE');
  end

  if (block.DialogPrm(32).Data)
    block.WriteRTWParam('string','CH_CFG_USE_OBJ_FIFOS', 'TRUE');
  else
    block.WriteRTWParam('string','CH_CFG_USE_OBJ_FIFOS', 'FALSE');
  end
  
  if (block.DialogPrm(33).Data)
    block.WriteRTWParam('string','CH_CFG_USE_PIPES', 'TRUE');
  else
    block.WriteRTWParam('string','CH_CFG_USE_PIPES', 'FALSE');
  end

  if (block.DialogPrm(34).Data)
    block.WriteRTWParam('string','CH_CFG_USE_OBJ_CACHES', 'TRUE');
  else
    block.WriteRTWParam('string','CH_CFG_USE_OBJ_CACHES', 'FALSE');
  end

  if (block.DialogPrm(35).Data)
    block.WriteRTWParam('string','CH_CFG_USE_DELEGATES', 'TRUE');
  else
    block.WriteRTWParam('string','CH_CFG_USE_DELEGATES', 'FALSE');
  end

  if (block.DialogPrm(36).Data)
    block.WriteRTWParam('string','CH_CFG_USE_JOBS', 'TRUE');
  else
    block.WriteRTWParam('string','CH_CFG_USE_JOBS', 'FALSE');
  end

  if (block.DialogPrm(37).Data)
    block.WriteRTWParam('string','CH_CFG_USE_FACTORY', 'TRUE');
  else
    block.WriteRTWParam('string','CH_CFG_USE_FACTORY', 'FALSE');
  end

  CH_CFG_FACTORY_MAX_NAMES_LENGTH=block.DialogPrm(38).Data;
  block.WriteRTWParam('string','CH_CFG_FACTORY_MAX_NAMES_LENGTH', sprintf('%.0f',CH_CFG_FACTORY_MAX_NAMES_LENGTH));

  if (block.DialogPrm(39).Data)
    block.WriteRTWParam('string','CH_CFG_FACTORY_OBJECTS_REGISTRY', 'TRUE');
  else
    block.WriteRTWParam('string','CH_CFG_FACTORY_OBJECTS_REGISTRY', 'FALSE');
  end

  if (block.DialogPrm(40).Data)
    block.WriteRTWParam('string','CH_CFG_FACTORY_GENERIC_BUFFERS', 'TRUE');
  else
    block.WriteRTWParam('string','CH_CFG_FACTORY_GENERIC_BUFFERS', 'FALSE');
  end

  if (block.DialogPrm(41).Data)
    block.WriteRTWParam('string','CH_CFG_FACTORY_SEMAPHORES', 'TRUE');
  else
    block.WriteRTWParam('string','CH_CFG_FACTORY_SEMAPHORES', 'FALSE');
  end

  if (block.DialogPrm(42).Data)
    block.WriteRTWParam('string','CH_CFG_FACTORY_MAILBOXES', 'TRUE');
  else
    block.WriteRTWParam('string','CH_CFG_FACTORY_MAILBOXES', 'FALSE');
  end

  if (block.DialogPrm(43).Data)
    block.WriteRTWParam('string','CH_CFG_FACTORY_OBJ_FIFOS', 'TRUE');
  else
    block.WriteRTWParam('string','CH_CFG_FACTORY_OBJ_FIFOS', 'FALSE');
  end

  if (block.DialogPrm(44).Data)
    block.WriteRTWParam('string','CH_CFG_FACTORY_PIPES', 'TRUE');
  else
    block.WriteRTWParam('string','CH_CFG_FACTORY_PIPES', 'FALSE');
  end

  if (block.DialogPrm(45).Data)
    block.WriteRTWParam('string','CH_DBG_STATISTICS', 'TRUE');
  else
    block.WriteRTWParam('string','CH_DBG_STATISTICS', 'FALSE');
  end

  if (block.DialogPrm(46).Data)
    block.WriteRTWParam('string','CH_DBG_SYSTEM_STATE_CHECK', 'TRUE');
  else
    block.WriteRTWParam('string','CH_DBG_SYSTEM_STATE_CHECK', 'FALSE');
  end

  if (block.DialogPrm(47).Data)
    block.WriteRTWParam('string','CH_DBG_ENABLE_CHECKS', 'TRUE');
  else
    block.WriteRTWParam('string','CH_DBG_ENABLE_CHECKS', 'FALSE');
  end

  if (block.DialogPrm(48).Data)
    block.WriteRTWParam('string','CH_DBG_ENABLE_ASSERTS', 'TRUE');
  else
    block.WriteRTWParam('string','CH_DBG_ENABLE_ASSERTS', 'FALSE');
  end

  CH_DBG_TRACE_MASK=block.DialogPrm(49).Data;
  block.WriteRTWParam('string','CH_DBG_TRACE_MASK', sprintf('%.0f',CH_DBG_TRACE_MASK));

  CH_DBG_TRACE_BUFFER_SIZE=block.DialogPrm(50).Data;
  block.WriteRTWParam('string','CH_DBG_TRACE_BUFFER_SIZE', sprintf('%.0f',CH_DBG_TRACE_BUFFER_SIZE));

  if (block.DialogPrm(51).Data)
    block.WriteRTWParam('string','CH_DBG_ENABLE_STACK_CHECK', 'TRUE');
  else
    block.WriteRTWParam('string','CH_DBG_ENABLE_STACK_CHECK', 'FALSE');
  end

  if (block.DialogPrm(52).Data)
    block.WriteRTWParam('string','CH_DBG_FILL_THREADS', 'TRUE');
  else
    block.WriteRTWParam('string','CH_DBG_FILL_THREADS', 'FALSE');
  end
  
  if (block.DialogPrm(53).Data)
    block.WriteRTWParam('string','CH_DBG_THREADS_PROFILING', 'TRUE');
  else
    block.WriteRTWParam('string','CH_DBG_THREADS_PROFILING', 'FALSE');
  end
   
%endfunction
