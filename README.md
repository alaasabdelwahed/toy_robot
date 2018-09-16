# ToyRobot

## Overview
When I read the Toy Robot problem, I was thinking about a few things:
1. How to handle state (it seemed to me like a state machine problem)
2. How to read input

The answers to the above questions were as follows:
1. In order to handle state, I decided to use the Agent module, which is an Elixir built in module
that acts as a server to handle state. I didn't want to use something like a GenServer which had a lot
of boiler plate functions that I woudn't be needing, so I decided to go with the Agent module.
2. I thought about reading the input from a file, but given the amount time provided, I thought
it would be faster to use an interactive command line tool which we use a lot during our development in Elixir. 
Elixir uses iex as a command line tool, so this is going to be the source of input in this project

If I had gone with reading the commands from an input file, I wouldn't have needed to handle state
since I could read all commands at once and implement them in a sequential order where I would pass the result of the
previous command to the next. However, I felt that using an Agent to store state is a way to reduce the errors
that could result from reading input from files, and it would also allow me to focus on the problem at hand without
having to go into the details of parsing files.

## Contents of project
Under /lib, there are 2 modules:
1. server.ex: This is the module used to handle the server and states
2. toy_robot.ex: This is the module used to handle all commands related to the Toy Robot

Under /test, there is 1 file:
1. toy_robot_test.exs: This is a unit test file for the Toy Robot functions
2. toy_robot_integration_test.exs: This is a test file to test the code examples sent in the coding test. 
It tests how the commands work together to produce the expected results.

## Installation
If you don't already have Elixir installed on your machine, you can use the following command for Mac:

``` brew install elixir ```

You will also need to install Erlang. You can do so by visiting this website: 

https://www.erlang-solutions.com/resources/download.html

## Running the application

In your command line tool, navigate to the project directory, then type:

``` iex -S mix ```

This will start a command line interface to run the Elixir code.

In order to start using the Toy Robot application, you will need to type the following command:

``` 
iex> Server.start
```

This will start the Agent that will store state.

Then you can play around with the Toy Robot commands:

```
iex> ToyRobot.place(1, 2, "NORTH")
iex> ToyRobot.left
iex> ToyRobot.right
iex> ToyRobot.move
iex> ToyRobot.report
```

In order to run the test file, you can type the following command:

``` mix test ```

This will run all the tests under /test folder.

## Test data

INPUT
```
MOVE
```
OUTPUT
```
"Robot must be placed on the table first"
```

INPUT
```
Place 0, 0, "WEST"
Move
Report
```
OUTPUT
```
"Robot will fall if moved in this direction"
```

INPUT
```
Place 0, 3, "NORTH"
MOVE
RIGHT
MOVE
MOVE
Report
```
OUTPUT
```
"2, 4, EAST"
```