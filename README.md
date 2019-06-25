# Computer-Science-Solar-System
A dynamic model I made to represent visually the field of Computer Science

The project was built for a college homework and the input was given by a team of colleagues.

The program reads the input and builds a tree like structure for every big domain from the input. Then for every node, it constructs the planet system and creates its revolving satellites. Every domain is made such that it rotates around the center of the system, while every other planet rotates around its parent with a higher speed.

## Controls

To move around the solar system W,A,S,D keys are used. L for resetting the view and scroll wheel for zooming in and out.

![1](https://user-images.githubusercontent.com/50552606/60095965-78233400-9758-11e9-89ec-da614781c015.png)

## Functionality

The core of the project is in **game.lua**. The planet structure is defined in **assets/Objects/Corp.lua** and **assets/Objects/MainCorp.lua**. As mentioned previously, all the program does is parse the input and construct the data structure. Then, the data structure created is used to display a grpahic representation of the field. 

Other functionalities I added were:
* Increasing/Decreasing the speed of the universe using the buttons from the top left view
* Pausing the system
* Getting additional information by selecting a given planet
* Auto-zooming on the big subdomains of the field when selected

Images with the finished product:
![2](https://user-images.githubusercontent.com/50552606/60095967-78bbca80-9758-11e9-87b8-f8ad33c0deeb.png)
