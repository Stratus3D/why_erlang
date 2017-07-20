math_server
===========

## Description

A simple math server that handles requests for arithmetic operations. API functions send requests to the registered name and then the server sends a message back to the caller with the result.

## Dependencies

Erlang 19.2
Rebar 3.4.1

## Usage

Compile and then start up an erl console session:

    erlc math_server.erl; erl

Then start the server:

    math_server:start().

Then make a request:

    math_server:add(1,2).

Don't divide by zero!:

    math_server:divide(10, 0).
