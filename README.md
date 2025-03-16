# PromisedSignal
An implementation of RBXScriptSignal with Promise.

**Why PromisedSignal?**
* Asynchronous Connections
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

**Download**\
[GitHub](https://github.com/realbxnnie/PromisedSignal/releases)\
[Roblox](https://create.roblox.com/store/asset/74983621869370)

_Inspired by stravant's GoodSignal._
