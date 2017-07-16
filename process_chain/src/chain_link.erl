-module(chain_link).

-export([loop/1]).

loop(NextPid) ->
  receive
    shutdown ->
      NextPid ! shutdown;
    {Msg, Num} ->
      case Num of
        % Uncomment to test error handling
        %Num when Num rem 77 =:= 0 ->
        %  error('bam!');
        _ ->
          NextPid ! {Msg, Num+1}
      end,
      loop(NextPid)
  end.
