function halConf(block)
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
  block.NumDialogPrms     = 59;
  
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
    block.WriteRTWParam('string','HAL_USE_PAL', 'TRUE');
  else
    block.WriteRTWParam('string','HAL_USE_PAL', 'FALSE');
  end

  if (block.DialogPrm(2).Data)
    block.WriteRTWParam('string','HAL_USE_ADC', 'TRUE');
  else
    block.WriteRTWParam('string','HAL_USE_ADC', 'FALSE');
  end

  if (block.DialogPrm(3).Data)
    block.WriteRTWParam('string','HAL_USE_CAN', 'TRUE');
  else
    block.WriteRTWParam('string','HAL_USE_CAN', 'FALSE');
  end

  if (block.DialogPrm(4).Data)
    block.WriteRTWParam('string','HAL_USE_CRY', 'TRUE');
  else
    block.WriteRTWParam('string','HAL_USE_CRY', 'FALSE');
  end

  if (block.DialogPrm(5).Data)
    block.WriteRTWParam('string','HAL_USE_DAC', 'TRUE');
  else
    block.WriteRTWParam('string','HAL_USE_DAC', 'FALSE');
  end

  if (block.DialogPrm(6).Data)
    block.WriteRTWParam('string','HAL_USE_EFL', 'TRUE');
  else
    block.WriteRTWParam('string','HAL_USE_EFL', 'FALSE');
  end

  if (block.DialogPrm(7).Data)
    block.WriteRTWParam('string','HAL_USE_GPT', 'TRUE');
  else
    block.WriteRTWParam('string','HAL_USE_GPT', 'FALSE');
  end

  if (block.DialogPrm(8).Data)
    block.WriteRTWParam('string','HAL_USE_I2C', 'TRUE');
  else
    block.WriteRTWParam('string','HAL_USE_I2C', 'FALSE');
  end

  if (block.DialogPrm(9).Data)
    block.WriteRTWParam('string','HAL_USE_I2S', 'TRUE');
  else
    block.WriteRTWParam('string','HAL_USE_I2S', 'FALSE');
  end

  if (block.DialogPrm(10).Data)
    block.WriteRTWParam('string','HAL_USE_ICU', 'TRUE');
  else
    block.WriteRTWParam('string','HAL_USE_ICU', 'FALSE');
  end

  if (block.DialogPrm(11).Data)
    block.WriteRTWParam('string','HAL_USE_MAC', 'TRUE');
  else
    block.WriteRTWParam('string','HAL_USE_MAC', 'FALSE');
  end

  if (block.DialogPrm(12).Data)
    block.WriteRTWParam('string','HAL_USE_MMC_SPI', 'TRUE');
  else
    block.WriteRTWParam('string','HAL_USE_MMC_SPI', 'FALSE');
  end

  if (block.DialogPrm(13).Data)
    block.WriteRTWParam('string','HAL_USE_PWM', 'TRUE');
  else
    block.WriteRTWParam('string','HAL_USE_PWM', 'FALSE');
  end

  if (block.DialogPrm(14).Data)
    block.WriteRTWParam('string','HAL_USE_RTC', 'TRUE');
  else
    block.WriteRTWParam('string','HAL_USE_RTC', 'FALSE');
  end

  if (block.DialogPrm(15).Data)
    block.WriteRTWParam('string','HAL_USE_SDC', 'TRUE');
  else
    block.WriteRTWParam('string','HAL_USE_SDC', 'FALSE');
  end

  if (block.DialogPrm(16).Data)
    block.WriteRTWParam('string','HAL_USE_SERIAL', 'TRUE');
  else
    block.WriteRTWParam('string','HAL_USE_SERIAL', 'FALSE');
  end

  if (block.DialogPrm(17).Data)
    block.WriteRTWParam('string','HAL_USE_SERIAL_USB', 'TRUE');
  else
    block.WriteRTWParam('string','HAL_USE_SERIAL_USB', 'FALSE');
  end

  if (block.DialogPrm(18).Data)
    block.WriteRTWParam('string','HAL_USE_SIO', 'TRUE');
  else
    block.WriteRTWParam('string','HAL_USE_SIO', 'FALSE');
  end

  if (block.DialogPrm(19).Data)
    block.WriteRTWParam('string','HAL_USE_SPI', 'TRUE');
  else
    block.WriteRTWParam('string','HAL_USE_SPI', 'FALSE');
  end

  if (block.DialogPrm(20).Data)
    block.WriteRTWParam('string','HAL_USE_TRNG', 'TRUE');
  else
    block.WriteRTWParam('string','HAL_USE_TRNG', 'FALSE');
  end

  if (block.DialogPrm(21).Data)
    block.WriteRTWParam('string','HAL_USE_UART', 'TRUE');
  else
    block.WriteRTWParam('string','HAL_USE_UART', 'FALSE');
  end

  if (block.DialogPrm(22).Data)
    block.WriteRTWParam('string','HAL_USE_USB', 'TRUE');
  else
    block.WriteRTWParam('string','HAL_USE_USB', 'FALSE');
  end

  if (block.DialogPrm(23).Data)
    block.WriteRTWParam('string','HAL_USE_WDG', 'TRUE');
  else
    block.WriteRTWParam('string','HAL_USE_WDG', 'FALSE');
  end

  if (block.DialogPrm(24).Data)
    block.WriteRTWParam('string','HAL_USE_WSPI', 'TRUE');
  else
    block.WriteRTWParam('string','HAL_USE_WSPI', 'FALSE');
  end

  if (block.DialogPrm(25).Data)
    block.WriteRTWParam('string','PAL_USE_CALLBACKS', 'TRUE');
  else
    block.WriteRTWParam('string','PAL_USE_CALLBACKS', 'FALSE');
  end

  if (block.DialogPrm(26).Data)
    block.WriteRTWParam('string','PAL_USE_WAIT', 'TRUE');
  else
    block.WriteRTWParam('string','PAL_USE_WAIT', 'FALSE');
  end

  if (block.DialogPrm(27).Data)
    block.WriteRTWParam('string','ADC_USE_WAIT', 'TRUE');
  else
    block.WriteRTWParam('string','ADC_USE_WAIT', 'FALSE');
  end

  if (block.DialogPrm(28).Data)
    block.WriteRTWParam('string','ADC_USE_MUTUAL_EXCLUSION', 'TRUE');
  else
    block.WriteRTWParam('string','ADC_USE_MUTUAL_EXCLUSION', 'FALSE');
  end

  if (block.DialogPrm(29).Data)
    block.WriteRTWParam('string','CAN_USE_SLEEP_MODE', 'TRUE');
  else
    block.WriteRTWParam('string','CAN_USE_SLEEP_MODE', 'FALSE');
  end

  if (block.DialogPrm(30).Data)
    block.WriteRTWParam('string','CAN_ENFORCE_USE_CALLBACKS', 'TRUE');
  else
    block.WriteRTWParam('string','CAN_ENFORCE_USE_CALLBACKS', 'FALSE');
  end

  if (block.DialogPrm(31).Data)
    block.WriteRTWParam('string','HAL_CRY_USE_FALLBACK', 'TRUE');
  else
    block.WriteRTWParam('string','HAL_CRY_USE_FALLBACK', 'FALSE');
  end

  if (block.DialogPrm(32).Data)
    block.WriteRTWParam('string','HAL_CRY_ENFORCE_FALLBACK', 'TRUE');
  else
    block.WriteRTWParam('string','HAL_CRY_ENFORCE_FALLBACK', 'FALSE');
  end

  if (block.DialogPrm(33).Data)
    block.WriteRTWParam('string','DAC_USE_WAIT', 'TRUE');
  else
    block.WriteRTWParam('string','DAC_USE_WAIT', 'FALSE');
  end

  if (block.DialogPrm(34).Data)
    block.WriteRTWParam('string','DAC_USE_MUTUAL_EXCLUSION', 'TRUE');
  else
    block.WriteRTWParam('string','DAC_USE_MUTUAL_EXCLUSION', 'FALSE');
  end

  if (block.DialogPrm(35).Data)
    block.WriteRTWParam('string','I2C_USE_MUTUAL_EXCLUSION', 'TRUE');
  else
    block.WriteRTWParam('string','I2C_USE_MUTUAL_EXCLUSION', 'FALSE');
  end

  if (block.DialogPrm(36).Data)
    block.WriteRTWParam('string','MAC_USE_ZERO_COPY', 'TRUE');
  else
    block.WriteRTWParam('string','MAC_USE_ZERO_COPY', 'FALSE');
  end

  if (block.DialogPrm(37).Data)
    block.WriteRTWParam('string','MAC_USE_EVENTS', 'TRUE');
  else
    block.WriteRTWParam('string','MAC_USE_EVENTS', 'FALSE');
  end

  MMC_IDLE_TIMEOUT_MS=block.DialogPrm(38).Data;
  block.WriteRTWParam('string','MMC_IDLE_TIMEOUT_MS', sprintf('%.0f',MMC_IDLE_TIMEOUT_MS));

  if (block.DialogPrm(39).Data)
    block.WriteRTWParam('string','MMC_USE_MUTUAL_EXCLUSION', 'TRUE');
  else
    block.WriteRTWParam('string','MMC_USE_MUTUAL_EXCLUSION', 'FALSE');
  end

  SDC_INIT_RETRY=block.DialogPrm(40).Data;
  block.WriteRTWParam('string','SDC_INIT_RETRY', sprintf('%.0f',SDC_INIT_RETRY));

  if (block.DialogPrm(41).Data)
    block.WriteRTWParam('string','SDC_MMC_SUPPORT', 'TRUE');
  else
    block.WriteRTWParam('string','SDC_MMC_SUPPORT', 'FALSE');
  end

  if (block.DialogPrm(42).Data)
    block.WriteRTWParam('string','SDC_NICE_WAITING', 'TRUE');
  else
    block.WriteRTWParam('string','SDC_NICE_WAITING', 'FALSE');
  end

  SDC_INIT_OCR_V20=block.DialogPrm(43).Data;
  block.WriteRTWParam('string','SDC_INIT_OCR_V20', sprintf('%.0f',SDC_INIT_OCR_V20));
  
  SDC_INIT_OCR=block.DialogPrm(44).Data;
  block.WriteRTWParam('string','SDC_INIT_OCR', sprintf('%.0f',SDC_INIT_OCR));
  
  SERIAL_DEFAULT_BITRATE=block.DialogPrm(45).Data;
  block.WriteRTWParam('string','SERIAL_DEFAULT_BITRATE', sprintf('%.0f',SERIAL_DEFAULT_BITRATE));
  
  SERIAL_BUFFERS_SIZE=block.DialogPrm(46).Data;
  block.WriteRTWParam('string','SERIAL_BUFFERS_SIZE', sprintf('%.0f',SERIAL_BUFFERS_SIZE));
  
  SIO_DEFAULT_BITRATE=block.DialogPrm(47).Data;
  block.WriteRTWParam('string','SIO_DEFAULT_BITRATE', sprintf('%.0f',SIO_DEFAULT_BITRATE));

  if (block.DialogPrm(48).Data)
    block.WriteRTWParam('string','SIO_USE_SYNCHRONIZATION', 'TRUE');
  else
    block.WriteRTWParam('string','SIO_USE_SYNCHRONIZATION', 'FALSE');
  end

  SERIAL_USB_BUFFERS_SIZE=block.DialogPrm(49).Data;
  block.WriteRTWParam('string','SERIAL_USB_BUFFERS_SIZE', sprintf('%.0f',SERIAL_USB_BUFFERS_SIZE));

  SERIAL_USB_BUFFERS_NUMBER=block.DialogPrm(50).Data;
  block.WriteRTWParam('string','SERIAL_USB_BUFFERS_NUMBER', sprintf('%.0f',SERIAL_USB_BUFFERS_NUMBER));

  if (block.DialogPrm(51).Data)
    block.WriteRTWParam('string','SPI_USE_WAIT', 'TRUE');
  else
    block.WriteRTWParam('string','SPI_USE_WAIT', 'FALSE');
  end

  if (block.DialogPrm(52).Data)
    block.WriteRTWParam('string','SPI_USE_ASSERT_ON_ERROR', 'TRUE');
  else
    block.WriteRTWParam('string','SPI_USE_ASSERT_ON_ERROR', 'FALSE');
  end

  if (block.DialogPrm(53).Data)
    block.WriteRTWParam('string','SPI_USE_MUTUAL_EXCLUSION', 'TRUE');
  else
    block.WriteRTWParam('string','SPI_USE_MUTUAL_EXCLUSION', 'FALSE');
  end

  SPI_SELECT_MODE=block.DialogPrm(54).Data;
  block.WriteRTWParam('string','SPI_SELECT_MODE', sprintf('%.0f',SPI_SELECT_MODE));

  if (block.DialogPrm(55).Data)
    block.WriteRTWParam('string','UART_USE_WAIT', 'TRUE');
  else
    block.WriteRTWParam('string','UART_USE_WAIT', 'FALSE');
  end

  if (block.DialogPrm(56).Data)
    block.WriteRTWParam('string','UART_USE_MUTUAL_EXCLUSION', 'TRUE');
  else
    block.WriteRTWParam('string','UART_USE_MUTUAL_EXCLUSION', 'FALSE');
  end

  if (block.DialogPrm(57).Data)
    block.WriteRTWParam('string','USB_USE_WAIT', 'TRUE');
  else
    block.WriteRTWParam('string','USB_USE_WAIT', 'FALSE');
  end

  if (block.DialogPrm(58).Data)
    block.WriteRTWParam('string','WSPI_USE_WAIT', 'TRUE');
  else
    block.WriteRTWParam('string','WSPI_USE_WAIT', 'FALSE');
  end

  if (block.DialogPrm(59).Data)
    block.WriteRTWParam('string','WSPI_USE_MUTUAL_EXCLUSION', 'TRUE');
  else
    block.WriteRTWParam('string','WSPI_USE_MUTUAL_EXCLUSION', 'FALSE');
  end
   
%endfunction
