# Simple-Gomoku

### Statement
Our project is to create a simple Gomoku game. Gomoku is a 15 by 15 strategic board game which is popular in Asian countries. We believe it would be nice if we can implement one via Scheme. We plans to implement a Gomoku game that allows two game modes: two players play against each others (PvP) and one player play against an AI (PvE). Currently, we have several pieces done (created several classes via racket/class, drew board, stones and on-click buttons via racket/gui, etc.). 

### Analysis
We use data structure matrix in our project. To be specific, we have a matrix named *Board* in our Board class, each element in the matrix is a stone object. By using matrix, there’s no need to refer to each stone and we can easily get access and manipulate. Another example of data abstraction is a point structure that we used for representing x and y coordinates. 

We will make a *Stone* class, which contains the color, coordinates, if taken about the stones. The *Board* class which holds 15 by 15 stones in the form of matrix with procedures allows manipulations; and a *Game* class where the game takes place on. It basically creates an abstract interface that allows the manipulation of stones. It lets the players place stones in turns, updates boards, and evaluates each positions based on current board for PvE mode. 

Since we have a matrix of stones, it would be extremely helpful to use filter to manipulate the stones in matrix. One usage we are thinking about is to use filter to filter out the isolated stones.We keep the same-color stones in a new matrix and use recursive function to detect if the same color stones are 4-in-a-row, 3-in-a-row in horizontal, vertical or diagonal directions while making decision about where the computer should draw the next stone. We are also planning to use filter to find stones that satisfies certain features.

Even though mostly our program is constructed based on classes/imperative programming approaches. We will use functional approaches, for instance, to start the game or do simple calculations that does not hold any states. We will use state-modification approaches. This is a game, so we need to record game process via states. Specifically, the state-modifications will happen in our classes (for instance, the updates of board/piece informations). Our classes contain member variables (fields) that will be modified via set! as the game state proceed. 

We will use lazy evaluation in our PVE AI and winning algorithm. Our recursion function would test from 5-in-a-row then decreasing each time by 1. Once we find 5-in-a-row in either horizontal, vertical or diagonal direction, we won’t continue testing the rest.

### External Technologies

- generate or process sound
We plans to add sound effect in GUI part. For instance, sound when placing a stone or when a player wins the game.


### Data Sets or other Source Materials

Currently, we don't have plan on using data sets or source materials. 
We might refer to resources on algorithms when we implement our PvE mod. If we do later on, we will update the references.

### Deliverable and Demonstration

We will have a 2-D Gomoku game by the end of this project. The demo would show that users can play the game in two modes.

Our program will be interactive. Player can set pieces on the board, depending on the gaming mode, it could be two players interacts with each other or one player interact with an AI. 

### Evaluation of Results

The game should be able to allow correct interactions (placing pieces by clicking on the board), precisely evaluates win or lose and give correct prompts.

PvP mode

Two users can play the game and blocking/winning algorithms works.

PvE mode

The boot can draw the stones in a smart way and can win at a ok percentage.

## Architecture Diagram
Upload the architecture diagram you made for your slide presentation to your repository, and include it in-line here.

![ArchitectureDiagram](https://github.com/oplS17projects/Simple-Gomoku/blob/master/ArchitectureDiagram.png?raw=true)

Create several paragraphs of narrative to explain the pieces and how they interoperate.

## Schedule
Explain how you will go from proposal to finished product. 

There are three deliverable milestones to explicitly define, below.

The nature of deliverables depend on your project, but may include things like processed data ready for import, core algorithms implemented, interface design prototyped, etc. 

You will be expected to turn in code, documentation, and data (as appropriate) at each of these stages.

Write concrete steps for your schedule to move from concept to working system. 

### First Milestone (Sun Apr 9)

Users can draw the stones on our program and **winning algorithm**.

### Second Milestone (Sun Apr 16)
Finihs PvP mode. Start PvE mode.

The project would prevent user from drawing on the same block(which is taken).

### Public Presentation (Mon Apr 24, Wed Apr 26, or Fri Apr 28 [your date to be determined later])

Finish PvE mode. 
UI  

## Group Responsibilities

### Xiaoling Zheng @xlzhen
- [x] Create the stone (piece), board, (possibly player if necessary) and game classes with member procedures and fields that allows interactions (manipulations) with board, updates informations. The game class would be served as a frame that controls game flow. 
- [ ] I’ll be focus on the internal structure, might add other stuffs if needed.

### Ruowei Zhang @rz999
- [x] GUI/base Create the frame, draw the board on canvas, pict draw the stones. 
- [ ] Mode option and start stop options. Any other frame work.
- [ ] GUI mouseevent draw the stone connected with Xiaoling’s board class 
- [ ] Music or sound effects during the game or at the end(winning)


### Together
- [ ] Winning algorithm design.
- [ ] PVE AI
 
