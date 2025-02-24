---------------------- MODULE ufquickunion ----------------------
EXTENDS Naturals, TLC, Sequences

CONSTANT N

(* --algorithm UFQuickUnion {

variables
id = [j \in 0..N-1 |-> j];

define {
root(p) == IF p = id[p] THEN p
                        ELSE root(id[p]) 
isConnected(p,q) == root(p) = root(q)
}

procedure union(p, q)
variables i = 0; pid; qid;
{
    union1:proot := root(p);
    union2:qroot := root(q);

    id[proot] = qroot;

    unionassert1:assert isConnected(p,q);
    unionassert2:assert isConnected(q,p);
    return;
}
    
process (Thread = 1)
variables i = 0; 
{
    init:while(i < N)
    {
        id[i] := i;
        i := i + 1;
    };
    
    union00:call union(0, 5);
    union01:call union(5, 6);
    
    assert1:assert isConnected(0,5);
    assert2:assert isConnected(5,0);
    assert3:assert isConnected(0,6);
    assert4:assert isConnected(6,0);
    assert5:assert isConnected(5,6);
    assert6:assert isConnected(6,5);
}

}*)
\* BEGIN TRANSLATION
\* Process variable i of process Thread at line 34 col 11 changed to i_
CONSTANT defaultInitValue
VARIABLES id, pc, stack

(* define statement *)
isConnected(p,q) == id[p] = id[q]

VARIABLES p, q, i, pid, qid, i_

vars == << id, pc, stack, p, q, i, pid, qid, i_ >>

ProcSet == {1}

Init == (* Global variables *)
        /\ id = [j \in 0..N-1 |-> j]
        (* Procedure union *)
        /\ p = [ self \in ProcSet |-> defaultInitValue]
        /\ q = [ self \in ProcSet |-> defaultInitValue]
        /\ i = [ self \in ProcSet |-> 0]
        /\ pid = [ self \in ProcSet |-> defaultInitValue]
        /\ qid = [ self \in ProcSet |-> defaultInitValue]
        (* Process Thread *)
        /\ i_ = 0
        /\ stack = [self \in ProcSet |-> << >>]
        /\ pc = [self \in ProcSet |-> "init"]

union1(self) == /\ pc[self] = "union1"
                /\ pid' = [pid EXCEPT ![self] = id[p[self]]]
                /\ pc' = [pc EXCEPT ![self] = "union2"]
                /\ UNCHANGED << id, stack, p, q, i, qid, i_ >>

union2(self) == /\ pc[self] = "union2"
                /\ qid' = [qid EXCEPT ![self] = id[q[self]]]
                /\ pc' = [pc EXCEPT ![self] = "unionchange"]
                /\ UNCHANGED << id, stack, p, q, i, pid, i_ >>

unionchange(self) == /\ pc[self] = "unionchange"
                     /\ IF i[self] < N
                           THEN /\ IF id[i[self]] = pid[self]
                                      THEN /\ id' = [id EXCEPT ![i[self]] = qid[self]]
                                      ELSE /\ TRUE
                                           /\ id' = id
                                /\ i' = [i EXCEPT ![self] = i[self] + 1]
                                /\ pc' = [pc EXCEPT ![self] = "unionchange"]
                           ELSE /\ pc' = [pc EXCEPT ![self] = "unionassert1"]
                                /\ UNCHANGED << id, i >>
                     /\ UNCHANGED << stack, p, q, pid, qid, i_ >>

unionassert1(self) == /\ pc[self] = "unionassert1"
                      /\ Assert(isConnected(p[self],q[self]), 
                                "Failure of assertion at line 28, column 18.")
                      /\ pc' = [pc EXCEPT ![self] = "unionassert2"]
                      /\ UNCHANGED << id, stack, p, q, i, pid, qid, i_ >>

unionassert2(self) == /\ pc[self] = "unionassert2"
                      /\ Assert(isConnected(q[self],p[self]), 
                                "Failure of assertion at line 29, column 18.")
                      /\ pc' = [pc EXCEPT ![self] = Head(stack[self]).pc]
                      /\ i' = [i EXCEPT ![self] = Head(stack[self]).i]
                      /\ pid' = [pid EXCEPT ![self] = Head(stack[self]).pid]
                      /\ qid' = [qid EXCEPT ![self] = Head(stack[self]).qid]
                      /\ p' = [p EXCEPT ![self] = Head(stack[self]).p]
                      /\ q' = [q EXCEPT ![self] = Head(stack[self]).q]
                      /\ stack' = [stack EXCEPT ![self] = Tail(stack[self])]
                      /\ UNCHANGED << id, i_ >>

union(self) == union1(self) \/ union2(self) \/ unionchange(self)
                  \/ unionassert1(self) \/ unionassert2(self)

init == /\ pc[1] = "init"
        /\ IF i_ < N
              THEN /\ id' = [id EXCEPT ![i_] = i_]
                   /\ i_' = i_ + 1
                   /\ pc' = [pc EXCEPT ![1] = "init"]
              ELSE /\ pc' = [pc EXCEPT ![1] = "union00"]
                   /\ UNCHANGED << id, i_ >>
        /\ UNCHANGED << stack, p, q, i, pid, qid >>

union00 == /\ pc[1] = "union00"
           /\ /\ p' = [p EXCEPT ![1] = 0]
              /\ q' = [q EXCEPT ![1] = 5]
              /\ stack' = [stack EXCEPT ![1] = << [ procedure |->  "union",
                                                    pc        |->  "union01",
                                                    i         |->  i[1],
                                                    pid       |->  pid[1],
                                                    qid       |->  qid[1],
                                                    p         |->  p[1],
                                                    q         |->  q[1] ] >>
                                                \o stack[1]]
           /\ i' = [i EXCEPT ![1] = 0]
           /\ pid' = [pid EXCEPT ![1] = defaultInitValue]
           /\ qid' = [qid EXCEPT ![1] = defaultInitValue]
           /\ pc' = [pc EXCEPT ![1] = "union1"]
           /\ UNCHANGED << id, i_ >>

union01 == /\ pc[1] = "union01"
           /\ /\ p' = [p EXCEPT ![1] = 5]
              /\ q' = [q EXCEPT ![1] = 6]
              /\ stack' = [stack EXCEPT ![1] = << [ procedure |->  "union",
                                                    pc        |->  "assert1",
                                                    i         |->  i[1],
                                                    pid       |->  pid[1],
                                                    qid       |->  qid[1],
                                                    p         |->  p[1],
                                                    q         |->  q[1] ] >>
                                                \o stack[1]]
           /\ i' = [i EXCEPT ![1] = 0]
           /\ pid' = [pid EXCEPT ![1] = defaultInitValue]
           /\ qid' = [qid EXCEPT ![1] = defaultInitValue]
           /\ pc' = [pc EXCEPT ![1] = "union1"]
           /\ UNCHANGED << id, i_ >>

assert1 == /\ pc[1] = "assert1"
           /\ Assert(isConnected(0,5), 
                     "Failure of assertion at line 45, column 13.")
           /\ pc' = [pc EXCEPT ![1] = "assert2"]
           /\ UNCHANGED << id, stack, p, q, i, pid, qid, i_ >>

assert2 == /\ pc[1] = "assert2"
           /\ Assert(isConnected(5,0), 
                     "Failure of assertion at line 46, column 13.")
           /\ pc' = [pc EXCEPT ![1] = "assert3"]
           /\ UNCHANGED << id, stack, p, q, i, pid, qid, i_ >>

assert3 == /\ pc[1] = "assert3"
           /\ Assert(isConnected(0,6), 
                     "Failure of assertion at line 47, column 13.")
           /\ pc' = [pc EXCEPT ![1] = "assert4"]
           /\ UNCHANGED << id, stack, p, q, i, pid, qid, i_ >>

assert4 == /\ pc[1] = "assert4"
           /\ Assert(isConnected(6,0), 
                     "Failure of assertion at line 48, column 13.")
           /\ pc' = [pc EXCEPT ![1] = "assert5"]
           /\ UNCHANGED << id, stack, p, q, i, pid, qid, i_ >>

assert5 == /\ pc[1] = "assert5"
           /\ Assert(isConnected(5,6), 
                     "Failure of assertion at line 49, column 13.")
           /\ pc' = [pc EXCEPT ![1] = "assert6"]
           /\ UNCHANGED << id, stack, p, q, i, pid, qid, i_ >>

assert6 == /\ pc[1] = "assert6"
           /\ Assert(isConnected(6,5), 
                     "Failure of assertion at line 50, column 13.")
           /\ pc' = [pc EXCEPT ![1] = "Done"]
           /\ UNCHANGED << id, stack, p, q, i, pid, qid, i_ >>

Thread == init \/ union00 \/ union01 \/ assert1 \/ assert2 \/ assert3
             \/ assert4 \/ assert5 \/ assert6

Next == Thread
           \/ (\E self \in ProcSet: union(self))
           \/ (* Disjunct to prevent deadlock on termination *)
              ((\A self \in ProcSet: pc[self] = "Done") /\ UNCHANGED vars)

Spec == Init /\ [][Next]_vars

Termination == <>(\A self \in ProcSet: pc[self] = "Done")

\* END TRANSLATION
===================================================================
