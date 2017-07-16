process_chain
=============

## Description

Thousands of processes arranged in a loop passing messages around the loop. Demonstrates the efficiency of the Erlang VM’s ligtweight process creation and message passing.

## Dependencies

Erlang 19.2
Rebar 3.4.1

## Usage

Start up an erl session:

    rebar3 shell

Then start a loop in the iex session:

    > Processes = 100 % Number of processes in chain
    > Loops = 10 % Number of times the message should be sent around the chain
    > Message = test % The messsage to send
    > process_chain:start(Processes, Loops, Message).

`start_timed` does the same thing but times how long the looping function takes:

    > process_chain:start_timed(Processes, Loops, Message).

You should see something like this printed out after you run the start function:

    Sending message `test`!
    Got message `test`!
    ok
