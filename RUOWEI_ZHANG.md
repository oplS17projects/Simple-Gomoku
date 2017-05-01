# Simple Gomoku via Sheme

## Ruowei Zhang
### April 30, 2017

# Overview
This set of code creates the Gomoku game. 

Gomoku is a popular board game, and the goal is to make five-in-a-row in either horizontal, vertical or diagnal direction.

Usually there are two players against each other. Players use mouse-click to draw black or white stones on the board.

The code has two main componets: GUI and Game Logic. 

The game has two modes: PVP and PVE.

**Authorship note:** All of the code described here was written by myself.

# Libraries Used
The code uses four libraries:
```
(require racket/gui)
(require racket/draw)
(require pict images/icons/control images/icons/style)
(require images/icons/symbol)
```

* The ```racket/gui``` library provides the ability to design all the game user interface (frame, canvas, button, mouse-events) and excute the call-back functions. It is one of the most important libraries for me to implement the game GUI.


* The ```racket/draw``` library is used to draw and redraw the canvas. It is also used in other small functions, for instance, change font, draw borders and the winning figures. 
* The ```pict images/icons/control images/icons/style``` library is used to design the texture of the stones.
*  The ```(require images/icons/symbol)``` library is used to design the texture of the buttons.

# Key Code Excerpts

Here is a discussion of the most essential procedures, including a description of how they embody ideas from 
UMass Lowell's COMP.3010 Organization of Programming languages course.



