# Hey welcome to the Simple MM2 Autofarm (SMA) github!

This is an open source MM2 Autofarm without a gui (skids love that)

# Step by Step tutorial on how to set it up!

So first we need to initialize it you can use the code below!

```local autofarm = loadstring(game:HttpGet("https://raw.githubusercontent.com/Blitzedzz-2/SimpleMM2Autofarm/main/source.lua"))()```

Next on a NEW line add your options

```
autofarm.options.Fling = true
```

There are many options such as Fling, UnlockFPS, and TweenTime

If you don't define the options, it will use the default

Last on a NEW line add this to start the Autofarm **If you don't include it, it won't start**
```
autofarm.Init()
```

# All of the options you can use!

```
autofarm.options.Fling = true
autofarm.options.TweenTime = 3
autofarm.options.UnlockFPS = true
```
This will be updated!
