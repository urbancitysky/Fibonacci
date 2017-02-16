-module(lab7).
-export([fib/1,fib3/1,loop/0,con/1]).

% a recursive method computes fibonacci Nth number 
fib(0)->1;
fib(1)->1;
fib(N) when N>1 ->fib(N-1)+fib(N-2).

% f3 returns a tuple contained fib(N) computed 3 times
fib3(N)-> {fib(N),fib(N),fib(N)}.

% loop() is an entry point for a process. 
loop()->
    receive
        {Pid,N}-> Pid!{self(),fib(N)}
    end.
% con(N) spawns three processes
con(N) -> 
    Pid1=spawn(fun loop/0),
    Pid2=spawn(fun loop/0),
    Pid3=spawn(fun loop/0),
    Pid1!{self(),N},
    Pid2!{self(),N},
    Pid3!{self(),N},
    receive
        {Pid1,V1} -> V1 
    end,
    receive
        {Pid2,V2} -> V2		
    end,
    receive
        {Pid3,V3} -> V3
    end,
    {V1,V2,V3}.
