# GameBase
Start your Game by branching off this project.

Group Members (2)
Kevin C. Garland
Eric Thompson

Game proposal:
    Blocus from Google Play store.
    Brick-breaker game with heavy particle-effects.
    This is a game that already exists, but I’d like to make my own version, very similar, but not identical.  To the best of my knowledge I do not have access to the source code of this game.  Turns out there is a Git repository with the java version of my game in it, it can be found at https://github.com/JulienBe/Blocus  I'm not going to look at it, I'd rather try to make the game myself.

You tap the screen wherever you want to put your paddle, it stays at the bottom of the screen.  One or more balls bounce off your paddle and off of the bricks in the level and off of both sides and the top of the screen.  If they fall off the bottom of the screen, they are lost.  If there are no more balls on the screen, you lose a life.  Balls and bricks have different strength states, bricks decrease in strength when they are hit by a ball until they disappear, balls increase in strength when they clear a column by breaking the last brick in that column.  Different strengths of balls travel at different speeds.  Also, if the player keeps their finger on the screen, the whole game plays faster and balls become very hard to track.  The paddle never changes in size, but its sections glow according to balls that have recently bounced off that section, when the glow gets strong enough, that section fires block-shaped missiles directly up at the blocks which damage blocks.
