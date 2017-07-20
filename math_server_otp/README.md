math_server_otp
==============

## Description

An OTP math server that handles requests for arithmetic operations. Supervisor starts the math server. Math server is a gen server that's linked to the supervisor. API functions in the `math_server_otp` send requests to the registered name and then the server sends a message back to the caller with the result.

## Dependencies

Erlang 19.2
Rebar 3.4.1

## Usage

Compile and start an erl shell:

    rebar3 shell

Then start the application:

    application:start(math_server_opt).

Then make a request:

    math_server_otp:add(1,2).

Don't divide by zero!:

    math_server_otp:divide(10, 0).
