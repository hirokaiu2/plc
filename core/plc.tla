------------------------------- MODULE plc -------------------------------
EXTENDS Naturals, TLC

(* --algorithm plc
variables 0_startButton = FALSE, 1_wpPresent = FALSE, 2_fwLimit = FALSE, 3_bwLimit = FALSE, 4_openComplete = FALSE,
          5_opLamp = FALSE, 6_moveFw = FALSE, 7_moveBw = FALSE, 8_pushFw = FALSE, 9_pushBw = FALSE,
          plc_state = 0, state = 0;

fair process plc = 1
begin
PLC_LOOP:
while TRUE do
  if plc_state = 0 then
    either
      0_startButton := FALSE; 1_wpPresent := FALSE; 2_fwLimit := FALSE; 3_bwLimit := TRUE; 4_openComplete := TRUE; 
      or 0_startButton := TRUE; 1_wpPresent := FALSE; 2_fwLimit := FALSE; 3_bwLimit := TRUE; 4_openComplete := TRUE; 
      or 0_startButton := FALSE; 1_wpPresent := FALSE; 2_fwLimit := FALSE; 3_bwLimit := TRUE; 4_openComplete := TRUE; 
      or 0_startButton := FALSE; 1_wpPresent := TRUE; 2_fwLimit := FALSE; 3_bwLimit := TRUE; 4_openComplete := TRUE; 
      or 0_startButton := FALSE; 1_wpPresent := TRUE; 2_fwLimit := FALSE; 3_bwLimit := FALSE; 4_openComplete := TRUE; 
      or 0_startButton := FALSE; 1_wpPresent := TRUE; 2_fwLimit := TRUE; 3_bwLimit := FALSE; 4_openComplete := FALSE; 
      or 0_startButton := FALSE; 1_wpPresent := FALSE; 2_fwLimit := TRUE; 3_bwLimit := FALSE; 4_openComplete := FALSE; 
      or 0_startButton := FALSE; 1_wpPresent := FALSE; 2_fwLimit := TRUE; 3_bwLimit := FALSE; 4_openComplete := FALSE; 
      or 0_startButton := FALSE; 1_wpPresent := FALSE; 2_fwLimit := TRUE; 3_bwLimit := FALSE; 4_openComplete := TRUE; 
      or 0_startButton := FALSE; 1_wpPresent := FALSE; 2_fwLimit := FALSE; 3_bwLimit := FALSE; 4_openComplete := TRUE; 
      or 0_startButton := FALSE; 1_wpPresent := FALSE; 2_fwLimit := FALSE; 3_bwLimit := TRUE; 4_openComplete := TRUE; 
    end either;
    plc_state := 1;
  elsif plc_state = 1 then
    if state = 0 /\ 0_startButton = TRUE /\ 1_wpPresent = FALSE /\ 2_fwLimit = FALSE /\ 3_bwLimit = TRUE /\ 4_openComplete = TRUE then
      5_opLamp := TRUE;
      state := 1;
    elsif state = 1 /\ 0_startButton = FALSE /\ 1_wpPresent = TRUE /\ 2_fwLimit = FALSE /\ 3_bwLimit = TRUE /\ 4_openComplete = TRUE then
      6_moveFw := TRUE;
      state := 2;
    elsif state = 2 /\ 0_startButton = FALSE /\ 1_wpPresent = TRUE /\ 2_fwLimit = TRUE /\ 3_bwLimit = FALSE /\ 4_openComplete = FALSE then
      6_moveFw := FALSE;
      8_pushFw := TRUE;
      state := 3;
    elsif state = 3 /\ 0_startButton = FALSE /\ 1_wpPresent = FALSE /\ 2_fwLimit = TRUE /\ 3_bwLimit = FALSE /\ 4_openComplete = FALSE then
      8_pushFw := FALSE;
      9_pushBw := TRUE;
      state := 4;
    elsif state = 4 /\ 0_startButton = FALSE /\ 1_wpPresent = FALSE /\ 2_fwLimit = TRUE /\ 3_bwLimit = FALSE /\ 4_openComplete = TRUE then
      7_moveBw := TRUE;
      9_pushBw := FALSE;
      state := 5;
    elsif state = 5 /\ 0_startButton = FALSE /\ 1_wpPresent = FALSE /\ 2_fwLimit = FALSE /\ 3_bwLimit = TRUE /\ 4_openComplete = TRUE then
      5_opLamp := FALSE;
      7_moveBw := FALSE;
      state := 0;
    end if;
    plc_state := 2;
  elsif plc_state = 2 then
    0_startButton := FALSE;
    1_wpPresent := FALSE;
    2_fwLimit := FALSE;
    3_bwLimit := FALSE;
    4_openComplete := FALSE;
    plc_state := 0;
  end if;
end while;
end process

end algorithm *)
\* BEGIN TRANSLATION - the hash of the PCal code: PCal-2d121224224c71e06ed094098fa6a129
VARIABLES 0_startButton, 1_wpPresent, 2_fwLimit, 3_bwLimit, 4_openComplete, 
          5_opLamp, 6_moveFw, 7_moveBw, 8_pushFw, 9_pushBw, plc_state, state

vars == << 0_startButton, 1_wpPresent, 2_fwLimit, 3_bwLimit, 4_openComplete, 
           5_opLamp, 6_moveFw, 7_moveBw, 8_pushFw, 9_pushBw, plc_state, state
        >>

ProcSet == {1}

Init == (* Global variables *)
        /\ 0_startButton = FALSE
        /\ 1_wpPresent = FALSE
        /\ 2_fwLimit = FALSE
        /\ 3_bwLimit = FALSE
        /\ 4_openComplete = FALSE
        /\ 5_opLamp = FALSE
        /\ 6_moveFw = FALSE
        /\ 7_moveBw = FALSE
        /\ 8_pushFw = FALSE
        /\ 9_pushBw = FALSE
        /\ plc_state = 0
        /\ state = 0

plc == IF plc_state = 0
          THEN /\ \/ /\ 0_startButton' = FALSE
                     /\ 1_wpPresent' = FALSE
                     /\ 2_fwLimit' = FALSE
                     /\ 3_bwLimit' = TRUE
                     /\ 4_openComplete' = TRUE
                  \/ /\ 0_startButton' = TRUE
                     /\ 1_wpPresent' = FALSE
                     /\ 2_fwLimit' = FALSE
                     /\ 3_bwLimit' = TRUE
                     /\ 4_openComplete' = TRUE
                  \/ /\ 0_startButton' = FALSE
                     /\ 1_wpPresent' = FALSE
                     /\ 2_fwLimit' = FALSE
                     /\ 3_bwLimit' = TRUE
                     /\ 4_openComplete' = TRUE
                  \/ /\ 0_startButton' = FALSE
                     /\ 1_wpPresent' = TRUE
                     /\ 2_fwLimit' = FALSE
                     /\ 3_bwLimit' = TRUE
                     /\ 4_openComplete' = TRUE
                  \/ /\ 0_startButton' = FALSE
                     /\ 1_wpPresent' = TRUE
                     /\ 2_fwLimit' = FALSE
                     /\ 3_bwLimit' = FALSE
                     /\ 4_openComplete' = TRUE
                  \/ /\ 0_startButton' = FALSE
                     /\ 1_wpPresent' = TRUE
                     /\ 2_fwLimit' = TRUE
                     /\ 3_bwLimit' = FALSE
                     /\ 4_openComplete' = FALSE
                  \/ /\ 0_startButton' = FALSE
                     /\ 1_wpPresent' = FALSE
                     /\ 2_fwLimit' = TRUE
                     /\ 3_bwLimit' = FALSE
                     /\ 4_openComplete' = FALSE
                  \/ /\ 0_startButton' = FALSE
                     /\ 1_wpPresent' = FALSE
                     /\ 2_fwLimit' = TRUE
                     /\ 3_bwLimit' = FALSE
                     /\ 4_openComplete' = FALSE
                  \/ /\ 0_startButton' = FALSE
                     /\ 1_wpPresent' = FALSE
                     /\ 2_fwLimit' = TRUE
                     /\ 3_bwLimit' = FALSE
                     /\ 4_openComplete' = TRUE
                  \/ /\ 0_startButton' = FALSE
                     /\ 1_wpPresent' = FALSE
                     /\ 2_fwLimit' = FALSE
                     /\ 3_bwLimit' = FALSE
                     /\ 4_openComplete' = TRUE
                  \/ /\ 0_startButton' = FALSE
                     /\ 1_wpPresent' = FALSE
                     /\ 2_fwLimit' = FALSE
                     /\ 3_bwLimit' = TRUE
                     /\ 4_openComplete' = TRUE
               /\ plc_state' = 1
               /\ UNCHANGED << 5_opLamp, 6_moveFw, 7_moveBw, 8_pushFw, 
                               9_pushBw, state >>
          ELSE /\ IF plc_state = 1
                     THEN /\ IF state = 0 /\ 0_startButton = TRUE /\ 1_wpPresent = FALSE /\ 2_fwLimit = FALSE /\ 3_bwLimit = TRUE /\ 4_openComplete = TRUE
                                THEN /\ 5_opLamp' = TRUE
                                     /\ state' = 1
                                     /\ UNCHANGED << 6_moveFw, 7_moveBw, 
                                                     8_pushFw, 9_pushBw >>
                                ELSE /\ IF state = 1 /\ 0_startButton = FALSE /\ 1_wpPresent = TRUE /\ 2_fwLimit = FALSE /\ 3_bwLimit = TRUE /\ 4_openComplete = TRUE
                                           THEN /\ 6_moveFw' = TRUE
                                                /\ state' = 2
                                                /\ UNCHANGED << 5_opLamp, 
                                                                7_moveBw, 
                                                                8_pushFw, 
                                                                9_pushBw >>
                                           ELSE /\ IF state = 2 /\ 0_startButton = FALSE /\ 1_wpPresent = TRUE /\ 2_fwLimit = TRUE /\ 3_bwLimit = FALSE /\ 4_openComplete = FALSE
                                                      THEN /\ 6_moveFw' = FALSE
                                                           /\ 8_pushFw' = TRUE
                                                           /\ state' = 3
                                                           /\ UNCHANGED << 5_opLamp, 
                                                                           7_moveBw, 
                                                                           9_pushBw >>
                                                      ELSE /\ IF state = 3 /\ 0_startButton = FALSE /\ 1_wpPresent = FALSE /\ 2_fwLimit = TRUE /\ 3_bwLimit = FALSE /\ 4_openComplete = FALSE
                                                                 THEN /\ 8_pushFw' = FALSE
                                                                      /\ 9_pushBw' = TRUE
                                                                      /\ state' = 4
                                                                      /\ UNCHANGED << 5_opLamp, 
                                                                                      7_moveBw >>
                                                                 ELSE /\ IF state = 4 /\ 0_startButton = FALSE /\ 1_wpPresent = FALSE /\ 2_fwLimit = TRUE /\ 3_bwLimit = FALSE /\ 4_openComplete = TRUE
                                                                            THEN /\ 7_moveBw' = TRUE
                                                                                 /\ 9_pushBw' = FALSE
                                                                                 /\ state' = 5
                                                                                 /\ UNCHANGED 5_opLamp
                                                                            ELSE /\ IF state = 5 /\ 0_startButton = FALSE /\ 1_wpPresent = FALSE /\ 2_fwLimit = FALSE /\ 3_bwLimit = TRUE /\ 4_openComplete = TRUE
                                                                                       THEN /\ 5_opLamp' = FALSE
                                                                                            /\ 7_moveBw' = FALSE
                                                                                            /\ state' = 0
                                                                                       ELSE /\ TRUE
                                                                                            /\ UNCHANGED << 5_opLamp, 
                                                                                                            7_moveBw, 
                                                                                                            state >>
                                                                                 /\ UNCHANGED 9_pushBw
                                                                      /\ UNCHANGED 8_pushFw
                                                           /\ UNCHANGED 6_moveFw
                          /\ plc_state' = 2
                          /\ UNCHANGED << 0_startButton, 1_wpPresent, 
                                          2_fwLimit, 3_bwLimit, 
                                          4_openComplete >>
                     ELSE /\ IF plc_state = 2
                                THEN /\ 0_startButton' = FALSE
                                     /\ 1_wpPresent' = FALSE
                                     /\ 2_fwLimit' = FALSE
                                     /\ 3_bwLimit' = FALSE
                                     /\ 4_openComplete' = FALSE
                                     /\ plc_state' = 0
                                ELSE /\ TRUE
                                     /\ UNCHANGED << 0_startButton, 
                                                     1_wpPresent, 2_fwLimit, 
                                                     3_bwLimit, 
                                                     4_openComplete, 
                                                     plc_state >>
                          /\ UNCHANGED << 5_opLamp, 6_moveFw, 7_moveBw, 
                                          8_pushFw, 9_pushBw, state >>

Next == plc

Spec == /\ Init /\ [][Next]_vars
        /\ WF_vars(plc)

\* END TRANSLATION - the hash of the generated TLA code (remove to silence divergence warnings): TLA-04e8e9ef3d254f88b9e8c7f9d24d09b6
DollySpec == [] ~((6_moveFw = TRUE) /\ (7_moveBw = TRUE))
ArmSpec == [] ~((8_pushFw = TRUE) /\ (9_pushBw = TRUE))
ExtSpec == [] ((0_startButton = TRUE) ~> (6_moveFw = TRUE))
=============================================================================
