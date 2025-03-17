-- PromisedSignal
-- @realbxnnie

-- 03/15/2025

local Promise = require(script.Parent.Promise)

local Signal = {
	_listeners = {},
	_once = false,
	_fired = false
}
Signal.__index = Signal

function Signal.new()
	local self = setmetatable({}, Signal)
	
	return self
end

function Signal:Connect(func: (any) -> (any), ...: any)
	local listener = {
		once = false,
		callback = func
	}
	table.insert(self._listeners, { once = false, callback = func })
	
	return listener
end

function Signal:DisconnectAll()
	table.clear(self._listeners)
end

function Signal:Disconnect(connection)
	table.remove(self._listeners, table.find(self._listeners, connection))
end

function Signal:FireAsync(...)
	local arguments = ...
	local listenerToRemove
	self._fired = true
	do
		local promisedListener = Promise.new(function()
			for _, listener in next, self._listeners do
				if listener.once then
					listenerToRemove = listener
				end
				listener.callback(arguments)
			end
		end)
		promisedListener:andThen(function()
			return true
		end)
		promisedListener:catch(function(err)
			return err
		end)
	end
	if listenerToRemove then
		table.remove(self._listeners, table.find(self._listeners, listenerToRemove))
	end
	self._fired = false
end

function Signal:Once(func)
	table.insert(self._listeners, { once = true, callback = func })
end

function Signal:Destroy()
	self:Disconnect()
	setmetatable(self, nil)
end

return table.freeze({
	new = Signal.new
})
