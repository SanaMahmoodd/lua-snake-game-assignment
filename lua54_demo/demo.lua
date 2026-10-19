local HighScore = require("highscore54")

print("Before:", HighScore:load())

HighScore:save(12)
print("After score 12:", HighScore:load())

HighScore:save(8)
print("After score 8:", HighScore:load())

HighScore:save(15)
print("After score 15:", HighScore:load())