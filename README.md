# Simple-Gomoku

### Statement
Describe your project. Why is it interesting? Why is it interesting to you personally? What do you hope to learn? 

### Analysis
We use data structure matrix in our project. To be specific, we have a matrix named *Board* in our Board class, each element in the matrix is a stone object. By using matrix, there’s no need to refer to each stone and we can easily get access and manipulate. Another example of data abstraction is a point structure that we used for representing x and y coordinates. 

We will make a *Stone* class, which contains the color, coordinates, if taken about the stones. The *Board* class which holds 15 by 15 stones in the form of matrix with procedures allows manipulations; and a *Game* class where the game takes place on. It basically creates an abstract interface that allows the manipulation of stones. It lets the players place stones in turns, updates boards, and evaluates each positions based on current board for PvE mode. 

Since we have a matrix of stones, it would be extremely helpful to use filter to manipulate the stones in matrix. One usage we are thinking about is to use filter to filter out the isolated stones.We keep the same-color stones in a new matrix and use recursive function to detect if the same color stones are 4-in-a-row, 3-in-a-row in horizontal, vertical or diagonal directions while making decision about where the computer should draw the next stone. We are also planning to use filter to find stones that satisfies certain features.

Even though mostly our program is constructed based on classes/imperative programming approaches. We will use functional approaches, for instance, to start the game or do simple calculations that does not hold any states. We will use state-modification approaches. This is a game, so we need to record game process via states. Specifically, the state-modifications will happen in our classes (for instance, the updates of board/piece informations). Our classes contain member variables (fields) that will be modified via set! as the game state proceed. 

We will use lazy evaluation in our PVE AI and winning algorithm. Our recursion function would test from 5-in-a-row then decreasing each time by 1. Once we find 5-in-a-row in either horizontal, vertical or diagonal direction, we won’t continue testing the rest.

### External Technologies
You are encouraged to develop a project that connects to external systems. For example, this includes systems that:

- retrieve information or publish data to the web
- generate or process sound
- control robots or other physical systems
- interact with databases

If your project will do anything in this category (not only the things listed above!), include this section and discuss.

### Data Sets or other Source Materials
If you will be working with existing data, where will you get those data from? (Dowload from a website? Access in a database? Create in a simulation you will build? ...)

How will you convert your data into a form usable for your project?  

If you are pulling data from somewhere, actually go download it and look at it before writing the proposal. Explain in some detail what your plan is for accomplishing the necessary processing.

If you are using some other starting materials, explain what they are. Basically: anything you plan to use that isn't code.

### Deliverable and Demonstration
Explain exactly what you'll have at the end. What will it be able to do at the live demo?

What exactly will you produce at the end of the project? A piece of software, yes, but what will it do? Here are some questions to think about (and answer depending on your application).

Will it run on some data, like batch mode? Will you present some analytical results of the processing? How can it be re-run on different source data?

Will it be interactive? Can you show it working? This project involves a live demo, so interactivity is good.

### Evaluation of Results
How will you know if you are successful? 
If you include some kind of _quantitative analysis,_ that would be good.

## Architecture Diagram
Upload the architecture diagram you made for your slide presentation to your repository, and include it in-line here.

Create several paragraphs of narrative to explain the pieces and how they interoperate.

## Schedule
Explain how you will go from proposal to finished product. 

There are three deliverable milestones to explicitly define, below.

The nature of deliverables depend on your project, but may include things like processed data ready for import, core algorithms implemented, interface design prototyped, etc. 

You will be expected to turn in code, documentation, and data (as appropriate) at each of these stages.

Write concrete steps for your schedule to move from concept to working system. 

### First Milestone (Sun Apr 9)
Which portion of the work will be completed (and committed to Github) by this day? 

### Second Milestone (Sun Apr 16)
Which portion of the work will be completed (and committed to Github) by this day?  

### Public Presentation (Mon Apr 24, Wed Apr 26, or Fri Apr 28 [your date to be determined later])
What additionally will be completed before the public presentation?

## Group Responsibilities
Here each group member gets a section where they, as an individual, detail what they are responsible for in this project. Each group member writes their own Responsibility section. Include the milestones and final deliverable.

Please use Github properly: each individual must make the edits to this file representing their own section of work.

**Additional instructions for teams of three:** 
* Remember that you must have prior written permission to work in groups of three (specifically, an approved `FP3` team declaration submission).
* The team must nominate a lead. This person is primarily responsible for code integration. This work may be shared, but the team lead has default responsibility.
* The team lead has full partner implementation responsibilities also.
* Identify who is team lead.

In the headings below, replace the silly names and GitHub handles with your actual ones.

### Xiaoling Zheng @xlzhen
will write the....

### Ruowei Zhang @rz999
will work on...
 
