# PromisedSignal
An implementation of RBXScriptSignal with Promise.

**Why PromisedSignal?**
* Asynchronous Signals
* Performs almost all the functions that RBXScriptSignal does
* Simple and comfortable

**How to use it?**
```luau
local PromisedSignal = require(game.Path.To.PromisedSignal)
local HelloPlayer = Signal.new()

HelloPlayer:Connect(function(Player)
    print("Hello, " .. Player.Name .. "!")
end)

game.Players.PlayerAdded:Connect(function(Player)
    HelloPlayer:FireAsync(Player)
end)
```
