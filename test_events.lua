local Events = require("events")

local eventCount = 0

Events:subscribe("food_eaten", function(data)
    eventCount = eventCount + 1
    print("Food eaten! Score:", data.score)
end)

Events:emit("food_eaten", {score = 10})

assert(eventCount == 1, "Listener did not run")

print("Event System Test: PASSED")