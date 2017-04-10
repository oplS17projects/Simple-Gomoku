# Simple-Gomoku

### Statement
Our project is to create a **simple Gomoku game**. Gomoku is a 15 by 15 strategic board game which is popular in Asian countries. We believe it would be nice if we can implement one via Scheme. We plans to implement a Gomoku game that allows two game modes: two players play against each others (PvP) and one player play against an AI (PvE). Currently, we have several pieces done (created several classes via racket/class, drew board, stones and on-click buttons via racket/gui, etc.). 

### Analysis
>We use data structure matrix in our project. To be specific, we have a matrix named *Board* in our Board class, each element in the >matrix is a piece object representing one location that we can place a stone on. By using matrix, there’s no need to refer to each >piece and we can easily get access and manipulate. Another example of data abstraction is a point structure that we used for >representing x and y coordinates. 

>We will make a *Piece* class, which contains the occupied status, coordinates. The *Board* class which holds 15 by 15 stones in the >form of matrix with procedures allows manipulations; and a *Game* class where the game takes place on. It basically creates an abstract >interface that allows the manipulation of stones. It lets the players place stones in turns, updates boards, and evaluates each >positions based on current board for PvE mode. 

>Since we have a matrix of stones, it would be extremely helpful to use filter to manipulate the stones in matrix. One usage we are >thinking about is to use filter to filter out the isolated stones.We keep the same-color stones in a new matrix and use recursive >function to detect if the same color stones are 4-in-a-row, 3-in-a-row in horizontal, vertical or diagonal directions while making >decision about where the computer should draw the next stone. We are also planning to use filter to find stones that satisfies certain >features.

>Even though mostly our program is constructed based on classes/imperative programming approaches. We will use functional approaches, >for instance, to start the game or do simple calculations that does not hold any states. We will use state-modification approaches. >This is a game, so we need to record game process via states. Specifically, the state-modifications will happen in our classes (for >instance, the updates of board/piece informations). Our classes contain member variables (fields) that will be modified via set! as the >game state proceed. 

>We will use lazy evaluation in our PVE AI and winning algorithm. Our recursion function would test from 5-in-a-row then decreasing each >time by 1. Once we find 5-in-a-row in either horizontal, vertical or diagonal direction, we won’t continue testing the rest.

### External Technologies

**Generate or process sound**

We plan to add **sound effect** in GUI part. For instance, the program will generate sound when placing a stone on the board or when a player wins the game.


### Data Sets or other Source Materials

Currently, we don't have any plan on using data sets or source materials. 
We might refer to resources on algorithms when we implement our PvE mode. If we do this later on, we will update the references.

### Deliverable and Demonstration

>We will have a 2-D Gomoku game by the end of this project. The demo will show that users can play the game in two modes.

>Our program will be interactive. Player can set stones on the board, depending on the gaming mode, it could be two players interact >with each other or one player interacts with an AI. 

### Evaluation of Results


The game should be able to allow correct interactions (placing stones by clicking on the board), precisely evaluate win or lose and give correct prompts.


**PvP mode**

Two users can play the game and blocking/winning algorithms works.
Two playesr will be able to place stones in turn.

**PvE mode**

We plan to implement a non-trivial algorithm that is able to choose better positions to place stones. 
The boot can draw the stones in a smart way and can win at a ok percentage.

## Architecture Diagram

![ArchitectureDiagramUpdate](https://github.com/oplS17projects/Simple-Gomoku/blob/master/ArchitectureDiagramUpdate.png?raw=true)

>Our program has two major components: **Game control and Game UI**.

>**Game UI**: its an interface that allows player(s) to control the program via **mouse click**. 

>After the UI receives mouse click, our program will process the on-click event and sent to **Game Control**. This part could be >converting board frame coordinates into board class coordnates by scaling.

>**Check states status** will validate the data we get from the mouse-click (for instance, if the player clicks on an invalid piece (the >piece is occupied by another stone already), this will send an error feed back to UI). 

>After validating the data, the program will **update the game states**. For instance, update board and change the occupied status for >the selected piece object.

>After updating the game states (based on the player's input), the program will test if this player wins the game or not (**goal >test**). 

>If the game is in **PvP** mode, it will send goal test result and board information back to UI. 

>If the game is in **PvE** mode, it will send the same information only if the goal test is true. If the goal test for player is false, >the program will run algorithm to select best location to place stone and update states again. Then it will do a goal test for our AI >and send back informations to UI for display.

>As shown in the **states** box on the upper right corner. The program holds states informations (we plan to store it as fields in class >(racket/class)). **Mode** stores either the game is PvP mode or PvE mode. This depends on what the player choose in the beginning of >the game. **Board** stores 15 by 15 **Piece** objects via Matrix. **White-Stones []** and **Black-Stones []** are lists of placed >stones coordinates for easy reference. 

>We might change our architecture diagram dramatically as we go on implementing the project. 

>Notes: we use piece to represent each location to place the stone. There are 15 by 15 pieces on a board;
>       we use stone to represent a stone to be placed (there are black and white stones). 
       

## Schedule
### First Milestone (Sun Apr 9)

Users can draw the stones on our program and **winning algorithm (goal test)**.

Finish the classes and procedures for the game flow and basic operations (take turns, place object, goal test...)

### Second Milestone (Sun Apr 16)

The project would prevent user from drawing on the same block(which is taken).

Finish PvP mode. Start PvE mode.

### Public Presentation (Mon Apr 24, Wed Apr 26, or Fri Apr 28 [your date to be determined later])

Finish PvE mode AI. 

UI Improvenment.  

## Group Responsibilities

### Xiaoling Zheng @xlzhen
- [x] Create the stone (piece), board, (possibly player if necessary) and game classes with member procedures and fields that allows interactions (manipulations) with board, updates informations. The game class would be served as a frame that controls game flow.
- [x] Winning algorithm (Goal test) design.
- [ ] I’ll be focus on the internal structure, might add other stuffs if needed.

### Ruowei Zhang @rz999
- [x] GUI/base Create the frame, draw the board on canvas, draw the stones using icon. 
- [x] Mode option and start/stop options. Any other frame work.
- [x] Use GUI mouseevent draw the stone
- [ ] make connection with Xiaoling’s classes.
- [ ] Music or sound effects during the game or at the end(winning).


### Together
- [ ] PVE AI
 
