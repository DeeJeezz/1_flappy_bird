# Flappy bird

![GitHub Actions Workflow Status](https://img.shields.io/github/actions/workflow/status/deejeezz/1_flappy_bird/deploy-itch.yml)
![GitHub Tag](https://img.shields.io/github/v/tag/deejeezz/1_flappy_bird)

https://20_games_challenge.gitlab.io/games/flappy/

## Where to play

Itch.io - https://deejeezz.itch.io/flappy-bird

Flappy bird was a mobile game from 2013. It was a sleeper hit, gaining sudden and massive popularity in 2014, likely due to attention from a popular YouTuber at that time. The game was removed from the App store after it’s sudden popularity due to negative media attention.

The game is extremely simple, and was designed to mimic the feeling of bouncing a ping pong ball on a paddle for as long as possible.
Flappy Bird is a popular first game for new developers, and is featured in many “first game” tutorials.

## Goals:
* Create a game world with a floor.
* Add an object that represents the main character. Apply a constant force to the character so it falls to the floor.
* Add obstacles on the right of the game area. The obstacles should slide across the screen toward the left. The obstacles will appear in pairs, with a vertical gap between them.

> You could create a really long level and hope that the player never gets to the end of it, but it would make more sense if you used code to create obstacles when you need them.
> The game obstacles (pipes) will move off of the screen and never be used again. You might want to delete them once they are no longer useful. Or, better yet, re-use them by moving them to the right side of the screen once they move off of the left side!

* Detect when the character collides with the floor or obstacles, and reset the game when a collision occurs.
* Accumulate one point for each obstacle that the player passes. Display the score.

## Stretch goals:

* Add some sounds that will play each time the player gains a point, and when the player loses.
* Add a basic game-over screen to display the player’s score.
* Track the high-score between play sessions and display the high score alongside the current score.
* Add some background art! Try layering the background and scrolling at a different rate to the foreground obstacles. This is called Parallax scrolling.
