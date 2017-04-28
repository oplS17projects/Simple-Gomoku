# Simple-Gomoku

### Statement
Our project creates a **simple Gomoku game**. Gomoku is a 15 by 15 strategic board game which is popular in Asian countries. The Gomoku game allows two game modes: two players play against each others (PVP) and one player plays against an AI (PVE).

### Analysis
We have used data structure list in our project. To be specific, we have a list named *Board* in our Board class. Each element in the list is a piece object representing one block that the player can place a stone on. By using list, there’s no need to refer to each piece and we can easily get access and manipulate. Another example of data abstraction is a point structure that we used for representing x and y coordinates. 

We have created a *Piece* class, which contains the occupied status, and coordinates. The *Board* class which holds 15 by 15 stones in the form of list with procedures allows manipulations; and a *Game* class where the game takes place on. It basically creates an abstract interface that allows the manipulation of stones. It lets the players place stones in turns, updates boards, and evaluates each positions based on current board for PVE mode. 

Since we have a list of stones' coordinates, we decided to use filter to manipulate the stones. We used filter to find stones that satisfies certain features.One usage we have done is to use filter to get all coordinates which are not occupied. We keep the same-color stones in a new list and use recursive function to detect if the same-color stones are 5-in-a-row in horizontal, vertical or diagonal directions while making decision about which side wins the game.

Even though mostly our program is constructed based on classes/imperative programming approaches. We have used functional approaches, for instance, starting the game or doing simple calculations that does not hold any states. We have also used state-modification approaches. This is a game, so we need to record game process via states. Specifically, the state-modifications happened in our classes (for instance, the updates of board/piece informations). Our classes contain member variables (fields) that were modified via set! as the game state proceed. 

We have used evaluation in our PVE AI and goal test. Our recursion function would test from 5-in-a-row. Once we find 5-in-a-row in either horizontal, vertical or diagonal direction, we won’t continue testing the rest.


### Deliverable and Demonstration

We currently have a 2-D Gomoku game. It has two modes: PVP and PVE. Users can change the mode easily and make a new game whenever they want.

Our program is interactive. Player can set stones on the board, depending on the game mode. It could be two players interact with each other or one player interacts with an AI. 


### Evaluation of Results

For both modes, the game allows correct interactions (placing stones by clicking on the board, changing modes and making new games using buttons), precisely evaluate win or lose and give correct prompts.

For PVE mode, our AI can automaticly draw stones but not in a smart way.


**PvP mode**

Two users can play the game and blocking/winning algorithms works.
Two playesr will be able to place stones in turns.

**PvE mode**

The boot can draw the stones.
We implemented a non-trivial algorithm that can choose better positions to place stones. 


## Architecture Diagram

![ArchitectureDiagramUpdate](https://github.com/oplS17projects/Simple-Gomoku/blob/master/ArchitectureDiagramUpdate.png?raw=true)

Our program has two major components: **Game control and Game UI**.

**Game UI**: its an interface that allows player(s) to control the program via **mouse click**. 

**Game Logic**: controls the game flows (with several components as shown in the diagram).

After the UI receives mouse click, our program will process the on-click event and sent to **Game Control**. This part could be converting board frame coordinates into board class coordnates by scaling.


**Check states status** will validate the data we get from the mouse-click (for instance, if the player clicks on an invalid piece (the piece is occupied by another stone already), this will send an error feed back to UI). 

After validating the data, the program will **update the game states**. For instance, update board and change the occupied status for the selected piece object.

After updating the game states (based on the player's input), the program will test if this player wins the game or not (**goal test**). 

If the game is in **PvP** mode, it sends goal test result and board information back to UI. 

If the game is in **PvE** mode, it sends the same information only if the goal test is true. If the goal test for player is false, the program will run algorithm to select best location to place stone and update states again. Then it will do a goal test for our AI and send back informations to UI for display.

As shown in the **states** box on the upper right corner. The program holds states informations (we have stored it as fields in class (racket/class)). **Mode** stores either the game is PvP mode or PvE mode. This depends on what the player choose in the beginning of the game. **Board** stores 15 by 15 **Piece** objects via Matrix. **White-Stones []** and **Black-Stones []** are lists of placed stones coordinates for easy reference. 
 

Notes: we use block to represent each location to place the stone. There are 15 by 15 blocks on a board;
       we use stone to represent a stone to be placed (there are black and white stones). 
       

## Schedule
### First Milestone (Sun Apr 9)

Users can draw the stones on our program and **winning algorithm (goal test)**.

Finish the classes and procedures for the game flow and basic operations (take turns, place object, goal test...)

### Second Milestone (Sun Apr 16)

The project would prevent user from drawing on the same block(which is taken).

Finish PvP mode. Start PvE mode.

### Public Presentation (Fri Apr 28)

Our AI mode is not finished.

UI Improvenment.  

## Group Responsibilities

### Xiaoling Zheng @xlzhen

- [x] Architecture diagram 
- [x] Create and updated the point, board, player and game classes with member procedures and fields that allows interactions (manipulations) with board, updates informations, procedures return values that help control game flow. (classes.rkt)
- [x] Winning algorithm (Goal test) embedded in game class (goal-test.rkt)
- [x] make-game (dispatch for game class) provide object to main (make-game.rkt)
- [ ] working on creating fork patterns - for pve mode searching optimal position

### Ruowei Zhang @rz999

- [x] GUI design: Create the frame, draw the board on canvas, draw the stones using bitmap, create all buttons. 
- [x] Button implementation: Implemented 'Mode option' and 'New Game' buttons, have call-back functions done, and control the game. Any other frame work.
- [x] Mouseevent implementation: highlight the block while mouse-move, draw the stone while mouse-click. Refresh the canvas after each mouse-event.
- [x] Useful methods for PVP and PVE modes: set-stone, reset, draw-stone, highlight-boarder, calc-stone and ect.
- [x] Make connection with Xiaoling’s classes and goal test. Add PVE mode mouse-events.
- [x] Show the winning figure and disable call-back functions after one side wins. Finish PVP mode.

### Together

- [x] We have disccussed together about how we would implement our project.
- [x] We seperated the work into several parts, and at the first week, Ruowei focused on designing the GUI, Xiaoling focused on implementing on the logic.
- [x] Start from the second week, we started to connect the GUI with the game control.
- [x] We have finished the PVP mode together on the third week and started to disccuss about how we should design our PVE mode.
- [ ] Our PVE AI was created but not good enough.
 
