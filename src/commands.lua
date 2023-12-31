-- Required ST provided libraries
local log = require('log')


-- local imports
local client = require('client')
local config = require('config')


-----------------------------------------------------------------
-- Capability Handlers
-----------------------------------------------------------------

local commands = {}

-- Switch command
function commands.handle_onoff(driver, device, command)
   -- Prepare the payload
  local onoff = command.command
  local payload =  "SET,"..config.AC_NUMBER..":onoff,"..onoff.."\r"

  -- Send the payload to Intesis device
  log.trace("Sending payload: "..payload)
  client.sendCommand(driver, device, payload)
end


-- Setpoint temperature command
function commands.handle_setCoolingSetpoint(driver, device, command)
  -- Prepare the payload
  local setptemp = command.args.setpoint * 10
  local payload =  "SET,"..config.AC_NUMBER..":setptemp,"..setptemp.."\r"
  
  -- Send the payload to Intesis device
  log.trace("Sending payload: "..payload)
  client.sendCommand(driver, device, payload)
end 


-- Fanspeed command
function commands.handle_setFanSpeed(driver, device, command)
  -- Prepare the payload
  local speed = command.args.speed
  if speed == '0' then
    speed = "AUTO"
  end
  local payload =  "SET,"..config.AC_NUMBER..":fansp,"..speed.."\r"
  
  -- Send the payload to Intesis device
  log.trace("Sending payload: "..payload)
  client.sendCommand(driver, device, payload)
end 


-- Thermostat mode command
function commands.handle_setThermostatMode(driver, device, command)
  -- Prepare the payload
  local mode = command.args.mode
  if mode == 'dryair' then
    mode = "DRY"
  elseif mode == 'fanonly' then
    mode = "FAN"
  end
  local payload =  "SET,"..config.AC_NUMBER..":mode,"..mode.."\r"
  
  -- Send the payload to Intesis device
  log.trace("sending payload: "..payload)
  client.sendCommand(driver, device, payload)
end 


-- Refresh command
function commands.handle_refresh(driver, device)

  client.sendCommand(driver, device, "GET,1:ONOFF\r")
  client.sendCommand(driver, device, "GET,1:MODE\r")
  client.sendCommand(driver, device,"GET,1:AMBTEMP\r")
  client.sendCommand(driver, device, "GET,1:SETPTEMP\r")
  client.sendCommand(driver, device,"GET,1:FANSP\r")
  
end 

return commands
