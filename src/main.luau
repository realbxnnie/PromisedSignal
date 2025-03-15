-- PromisedSignal
-- @realbxnnie

-- 03/15/2025

local Promise = require(script.Parent.Promise)

local Signal = {
	_listener = nil,
	_once = false,
	_fired = false
}
Signal.__index = Signal

function Signal.new()
	local self = setmetatable({}, Signal)
	
	return self
end

function Signal:Connect(func: (any) -> (any), ...: any)
	self._listener = func
end

function Signal:Disconnect()
	self._listener = nil
end

function Signal:FireAsync(...)
	local arguments = ...
	self._fired = true
	do
		local promisedListener = Promise.new(function()
			self._listener(arguments)
		end)
		promisedListener:andThen(function()
			return true
		end)
		promisedListener:catch(function(err)
			return err
		end)
	end
	self._fired = false
	if self._once then
		self._listener = nil
	end
end

function Signal:Once(func: (any) -> (any), ...: any)
	self._listener = func
	self._once = true
end

function Signal:Destroy()
	self:Disconnect()
	setmetatable(self, nil)
end

return table.freeze({
	new = Signal.new
})
