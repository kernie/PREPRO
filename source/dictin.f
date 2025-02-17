C This file is part of PREPRO.
C
C    Author: Dermott (Red) Cullen
C Copyright: (C) International Atomic Energy Agency
C
C PREPRO is free software; you can redistribute it and/or modify it
C under the terms of the MIT License; see LICENSE file for more details.


C=======================================================================
C
C     PROGRAM DICTIN (Renamed from DICTION to eliminate conflict with
C                     UNIX diction command - 12/22/02)
C     ==============
C     VERSION 81-1 (SEPTEMBER 1981)
C     VERSION 82-1 (JANUARY 1982)
C     VERSION 83-1 (JANUARY 1983)  *KEEP ORIGINAL MOD. NUMBER
C                                  *NEW, MORE COMPATIBLE I/O UNITS.
C     VERSION 84-1 (SEPTEMBER 1984)*UPDATED TO HANDLE ENDF/B-VI FORMAT.
C                                   (PROGRAM WILL NOW WORK ON ALL
C                                    VERSIONS OF THE ENDF/B FORMAT).
C     VERSION 85-1 (AUGUST 1985)   *FORTRAN-77/H VERSION
C     VERSION 86-1 (JANUARY 1986)  *MAT ORDER CHECK.
C                                  *IF NO HOLLERITH SECTION COPY MAT.
C     VERSION 88-1 (JULY 1988)     *OPTION...INTERNALLY DEFINE ALL I/O
C                                   FILE NAMES (SEE, SUBROUTINE FILEIO
C                                   FOR DETAILS).
C                                  *IMPROVED BASED ON USER COMMENTS.
C     VERSION 89-1 (JANUARY 1989)  *PSYCHOANALYZED BY PROGRAM FREUD TO
C                                   INSURE PROGRAM WILL NOT DO ANYTHING
C                                   CRAZY.
C                                  *IMPROVED BASED ON USER COMMENTS.
C                                  *ADDED LIVERMORE CIVIC COMPILER
C                                   CONVENTIONS.
C                                  *UPDATED TO USE NEW PROGRAM CONVERT
C                                   KEYWORDS.
C     VERSION 92-1 (JANUARY 1992)  *UPDATED BASED ON USER COMMENTS.
C                                  *UP TO 6000 SECTIONS PER TAPE.
C                                  *CHANGED DEFAULT MOD NUMBER FOR NEW
C                                   SECTIONS FROM 0 TO 1
C     VERSION 94-1 (JANUARY 1994)  *VARIABLE ENDF/B DATA FILENAMES
C                                   TO ALLOW ACCESS TO FILE STRUCTURES
C                                   (WARNING - INPUT PARAMETER FORMAT
C                                   HAS BEEN CHANGED)
C                                  *CLOSE ALL FILES BEFORE TERMINATING
C                                   (SEE, SUBROUTINE ENDIT)
C                                  *ADDED FORTRAN SAVE OPTION
C     VERSION 96-1 (JANUARY 1996) *COMPLETE RE-WRITE
C                                 *IMPROVED COMPUTER INDEPENDENCE
C                                 *ALL DOUBLE PRECISION
C                                 *ON SCREEN OUTPUT
C                                 *UNIFORM TREATMENT OF ENDF/B I/O
C                                 *IMPROVED OUTPUT PRECISION
C     VERSION 99-1 (MARCH 1999)   *CORRECTED CHARACTER TO FLOATING
C                                  POINT READ FOR MORE DIGITS
C                                 *UPDATED TEST FOR ENDF/B FORMAT
C                                  VERSION BASED ON RECENT FORMAT CHANGE
C                                 *GENERAL IMPROVEMENTS BASED ON
C                                  USER FEEDBACK
C     VERS. 2000-1 (FEBRUARY 2000)*GENERAL IMPROVEMENTS BASED ON
C                                  USER FEEDBACK
C     VERS. 2002-1 (MAY 2002)     *OPTIONAL INPUT PARAMETERS
C                                 *RENAMED dictin TO ELIMINATE CONFLICT
C                                  WITH UNIX diction COMMAND.
C                                 *ADDED DOCUMENTATION LINE TO COMMENTS.
C     VERS. 2004-1 (JAN. 2004)    *GENERAL UPDATE BASED ON USER FEEDBACK
C                                 *UP TO 100,000 SECTIONS PER TAPE.
C     VERS. 2007-1 (JAN. 2007)    *CHECKED AGAINST ALL ENDF/B-VII.
C                                 *UP TO 500,000 SECTIONS PER TAPE.
C     VERS. 2007-2 (DEC. 2007)    *72 CHARACTER FILE NAMES.
C     VERS. 2010-1 (Apr. 2010)    *General update based on user feedback
C     VERS. 2012-1 (Aug. 2012)    *Added CODENAME
C                                 *32 and 64 bit Compatible
C                                 *Added ERROR stops
C     VERS. 2015-1 (Jan. 2015)    *Corrected END = it was saying ERROR.
C                                 *Replaced ALL 3 way IF Statements.
C     VERS. 2015-2 (Mar. 2015)    *Corrected Seqence Numbers
C                                  1) Restart at 1 for each MAT/MF/MT.
C                                  2) 99999 on section end, MT=0
C                                  3)     0 on MF = 0
C     VERS. 2017-1 (May  2017)    *Updated based on user feedback.
C     VERS. 2018-1 (Jan. 2018)    *Added on-line output for ALL ENDERROR
C     VERS. 2020-1 (Feb. 2020)    *Identical to 2018-1.
C
C     2015-2 Acknowledgment
C     =====================
C     I thank Jean-Christophe Sublet (UKAEA) for contributing MAC
C     executables and Bojan Zefran (IJS, Slovenia) for contributing
C     LINUX (32 or 64 bit) executables. And most of all I must thank
C     Andrej Trkov (NDS, IAEA) for overseeing the entire PREPRO project
C     at IAEA, Vienna. This was a truly International team who worked
C     together to produce PREPRO 2015-2.
C
C     OWNED, MAINTAINED AND DISTRIBUTED BY
C     ------------------------------------
C     THE NUCLEAR DATA SECTION
C     INTERNATIONAL ATOMIC ENERGY AGENCY
C     P.O. BOX 100
C     A-1400, VIENNA, AUSTRIA
C     EUROPE
C
C     ORIGINALLY WRITTEN BY
C     ------------------------------------
C     Dermott E. Cullen
C
C     PRESENT CONTACT INFORMATION
C     ---------------------------
C     Dermott E. Cullen
C     1466 Hudson Way
C     Livermore, CA 94550
C     U.S.A.
C     Telephone  925-443-1911
C     E. Mail    RedCullen1@Comcast.net
C     Website    RedCullen1.net/HOMEPAGE.NEW
C
C     AUTHORS MESSAGE
C     ---------------
C     THE COMMENTS BELOW SHOULD BE CONSIDERED THE LATEST DOCUMENATION
C     FOR THIS PROGRAM INCLUDING ALL RECENT IMPROVEMENTS. PLEASE READ
C     ALL OF THESE COMMENTS BEFORE IMPLEMENTATION.
C
C     AT THE PRESENT TIME WE ARE ATTEMPTING TO DEVELOP A SET OF COMPUTER
C     INDEPENDENT PROGRAMS THAT CAN EASILY BE IMPLEMENTED ON ANY ONE
C     OF A WIDE VARIETY OF COMPUTERS. IN ORDER TO ASSIST IN THIS PROJECT
C     IT WOULD BE APPECIATED IF YOU WOULD NOTIFY THE AUTHOR OF ANY
C     COMPILER DIAGNOSTICS, OPERATING PROBLEMS OR SUGGESTIONS ON HOW TO
C     IMPROVE THIS PROGRAM. HOPEFULLY, IN THIS WAY FUTURE VERSIONS OF
C     THIS PROGRAM WILL BE COMPLETELY COMPATIBLE FOR USE ON YOUR
C     COMPUTER.
C
C     PURPOSE
C     -------
C     THIS PROGRAM IS DESIGNED TO CREATE A REACTION INDEX FOR EACH
C     MATERIAL ON AN ENDF/B FORMATTED TAPE AND TO INSERT THIS REACTION
C     INDEX IN FILE 1, SECTION 451 OF EACH MATERIAL.
C
C     IN THE DESCRIPTION THAT FOLLOWS FOR SIMPLICITY THE ENDF/B
C     TERMINOLOGY---ENDF/B TAPE---WILL BE USED. IN FACT THE ACTUAL
C     MEDIUM MAY BE TAPE, CARDS, DISK, OR ANY OTHER MEDIUM.
C
C     ENDF/B FORMAT
C     -------------
C     THIS PROGRAM ONLY USES THE ENDF/B BCD OR CARD IMAGE FORMAT (AS
C     OPPOSED TO THE BINARY FORMAT) AND CAN HANDLE DATA IN ANY VERSION
C     OF THE ENDF/B FORMAT (I.E., ENDF/B-I, II,III, IV, V OR VI FORMAT).
C
C     THIS PROGRAM WILL AUTOMATICALLY DETERMINE WHICH VERSION OF THE
C     ENDF/B FORMAT EACH MAT IS IN AND WILL THEN PROPERLY REPLACE THE
C     REACTION INDEX FOR EACH MAT. DIFFERENT MATS ON THE SAME TAPE MAY
C     EVEN BE IN DIFFERENT VERSIONS OF THE ENDF/B FORMAT.
C
C     IT IS ASSUMED THAT THE DATA IS CORRECTLY CODED IN THE ENDF/B
C     FORMAT AND NO ERROR CHECKING IS PERFORMED. IN PARTICULAR IT IS
C     ASSUMED THAT THE MAT, MF AND MT ON EACH LINE IS CORRECT. SEQUENCE
C     NUMBERS (COLUMNS 76-80) NEED NOT BE PRESENT ON INPUT, BUT WILL BE
C     CORRECTLY OUTPUT ON ALL LINES.
C
C     ENDF/B FORMAT VERSION
C     ---------------------
C     THE ENDF/B FORMAT CAN BE DETERMINED FROM THE SECOND LINE OF
C     THE HOLLERITH SECTION (MF=1, MT=451).
C     ENDF/B-IV = N1 - LINE COUNT (POSITIVE)
C     ENDFB/-V  = N1 = N2 =0
C     ENDF/B-VI = N1 =0, N2= VERSION NUMBER (6 OR MORE)
C
C     SECTION SIZE
C     ------------
C     SINCE THIS PROGRAM ONLY READS THE DATA ONE LINE AT A TIME THERE
C     IS NO LIMIT TO THE SIZE OF ANY GIVEN SECTION, E.G. THE TOTAL
C     CROSS SECTION MAY BE DESCRIBED BY 200,000 DATA POINTS.
C
C     NUMBER OF SECTIONS PER TAPE
C     ---------------------------
C     IT IS ASSUMED THAT THE ENDF/B TAPE CONTAINS 100,000 OR FEWER
C     SECTIONS = 100,000 OR FEWER MAT,MF,MT COMBINATIONS. IF THIS LIMIT
C     IS EXCEEDED THIS PROGRAM WILL TERMINATE EXECUTION. IF NEED BE THIS
C     LIMIT CAN EASILY BE CHANGED BY CHANGING THE DIMENSION STATEMENT
C     BELOW AND RE-DEFINING THE VARIABLE MAXTAB IN THE BELOW DATA
C     STATEMENT. ALTERNATIVELY THE ENDF/B TAPE MAY BE DIVIDED INTO A
C     NUMBER SMALLER TAPES EACH CONTAINING 100,000 OR FEWER SECTIONS.
C     EACH ENDF/B TAPE CAN THEN RUN THROUGH THIS PROGRAM AND THE OUTPUT
C     FOR EACH ENDF/B TAPE CAN THEN BE RE-COMBINED (I.E., MERGED BACK
C     TOGETHER).
C
C     HOLLERITH SECTION
C     -----------------
C     IF ANY MATERIAL DOES NOT INITIALLY CONATIN A SECTION MF=1, MT=451
C     A WARNING MESSAGE WILL BE PRINTED AND THE MATERIAL WILL BE COPIED.
C
C     IF ANY MATERIAL INITIALLY CONTAINS A SECTION MF=1, MT=451 A NEW
C     REACTION INDEX WILL BE CREATED AND INSERTED. THE INITIAL SECTION
C     MF=1, MT=451 MAY OR MAY NOT CONTAIN A REACTION INDEX.
C
C     IF THE MATERIAL INITIALLY CONTAINS A REACTION INDEX IT WILL BE
C     USED TO DEFINE THE MOD NUMBER FOR CORRESPONDING SECTIONS IN THE
C     NEW REACTION INDEX (I.E. IF A SECTION FROM THE ORIGINAL REACTION
C     INDEX HAS THE SAME MF/MT NUMBERS AS A SECTION IN THE NEW REACTION
C     INDEX THE MOD NUMBER FROM THE ORIGINAL REACTION INDEX WILL BE USED
C     IN THE NEW REACTION INDEX). OTHERWISE THE MOD NUMBER IN THE NEW
C     REACTION INDEX WILL BE SET EQUAL TO ZERO.
C
C     PROGRAM OPERATION
C     -----------------
C     THE ENTIRE ENDF/B TAPE IS FIRST READ AND A DICTIONARY ENTRY IS
C     CREATED FOR EACH SECTION OF THE TAPE. THE ENDF/B TAPE IS THEN
C     REWOUND AND READ A SECOND TIME. DURING THIS SECOND PASS THE
C     DICTIONARY OF EACH MAT IS REPLACED. THIS VERSION OF DICTIN
C     DOES NOT USE SCRATCH FILES AND IS MORE EFFICIENT THAN EARLIER
C     VERSIONS OF DICTIN.
C
C     INPUT LINES
C     -----------
C       LINE   COLS.  DESCRIPTION
C       ----   -----  ------------------------------
C          1   1-60   ENDF/B INPUT DATA FILENAME
C                     (STANDARD OPTION = ENDFB.IN)
C          2   1-60   ENDF/B OUTPUT DATA FILENAME
C                     (STANDARD OPTION = ENDFB.OUT)
C
C     EXAMPLE INPUT NO. 1
C     -------------------
C     READ \ENDFB6\K300\ENDFB.IN AND WRITE \ENDFB\K300\ENDFB.OUT. THE
C     FOLLOWING 2 INPUT LINES ARE REQUIRED,
C
C \ENDFB6\K300\ENDFB.IN
C \ENDFB6\K300\ENDFB.OUT
C
C     EXAMPLE INPUT NO. 2
C     -------------------
C     USE THE DEFAULT FILENAMES TO READ ENDFB.IN AND WRITE ENDFB.OUT.
C     2 BLANK INPUT LINES ARE REQUIRED
C
C     INPUT FILES
C     -----------
C     UNIT  DESCRIPTION
C     ----  -----------
C        2  INPUT PARAMETERS (BCD - 80 CHARACTERS/RECORD)
C       10  ORIGINAL TAPE OF ENDF/B DATA (BCD - 80 CHARACTERS/RECORD)
C
C     OUTPUT FILES
C     ------------
C     UNIT  DESCRIPTION
C     ----  -----------
C        3  OUTPUT REPORT (BCD - 120 CHARACTERS/RECORD)
C       11  FINAL TAPE OF ENDF/B DATA (BCD - 80 CHARACTERS/RECORD)
C
C     OPTIONAL STANDARD FILE NAMES (SEE SUBROUTINE FILIO1 AND FILIO2)
C     ---------------------------------------------------------------
C     UNIT  FILE NAME
C     ----  ----------
C       2   DICTIN.INP
C       3   DICTIN.LST
C      10   ENDFB.IN
C      11   ENDFB.OUT
C
C=======================================================================
      INCLUDE 'implicit.h'
C-----08/08/2012 DEFINE CODE NAME
      CHARACTER*8 CODENAME
      COMMON/NAMECODE/CODENAME
      CHARACTER*4 CARD1,CARD2,CARD3,CARD4,CARD5,FMTHOL
      INTEGER*4 OTAPE,OUTP,OCARD
      COMMON/ENDFIO/INP,OUTP,ITAPE,OTAPE
      COMMON/HEADER/C1H,C2H,L1H,L2H,N1H,N2H,MATH,MFH,MTH,NOSEQ
      COMMON/LEADER/C1,C2,L1,L2,N1,N2,MAT,MF,MT
      INCLUDE 'dictin.h'
      DIMENSION CARD1(20),CARD2(14),CARD3(11),CARD4(11),
     1 CARD5(17),FMTHOL(3)
C-----DEFINE FIXED POINT ZERO.
      DATA IZERO/0/
C-----DEFINE MT OF ZERO TO FILL OUT SEND LINE.
      DATA MTZERO/0/
C-----DEFINE ENDF/B FORMAT VERSIONS.
      DATA FMTHOL/'IV',' V','VI'/
C-----08/08/2012 DEFINE CODE NAME
      CODENAME = 'DICTIN  '
C-----INITIALIZE TIMER
      CALL TIMER
c-----------------------------------------------------------------------
C
C     DEFINE I/O UNITS AND OPTIONALLY DEFINE FILE NAMES.
C
c-----------------------------------------------------------------------
      CALL FILIO1
c-----------------------------------------------------------------------
C
C     IDENTIFY PROGRAM
C
c-----------------------------------------------------------------------
      WRITE(OUTP,480)
      WRITE(*   ,480)
c-----------------------------------------------------------------------
C
C     READ INPUT PARAMETERS
C
c-----------------------------------------------------------------------
      CALL READIN
c-----------------------------------------------------------------------
C
C     DURING FIRST PASS READ ENTIRE ENBF/B TAPE AND DEFINE CONTENTS OF
C     EACH SECTION FOR INDEX SECTION.
C
c-----------------------------------------------------------------------
C-----INITIALIZE LAST MAT READ.
      LASMAT=-99999
C-----WRITE TITLE FOR OUTPUT LISTING.
      WRITE(OUTP,490)
      WRITE(*   ,490)
C-----INITIALIZE SECTION COUNT.
      INDEX=0
C-----SKIP TAPE LABEL RECORD.
      READ(ITAPE,380) CARD1
c-----------------------------------------------------------------------
C
C     FIND BEGINNING OF NEXT SECTION (SKIP INTERVENING SEND, FEND AND
C     MEND LINES). IF FIRST SECTION OF MAT IS NOT MF=1, MT=451
C     TERMINATE EXECUTION. OTHERWISE, INCREMENT SECTION COUNT, SAVE MAT,
C     MF AND MT. THEN SKIP TO END OF SECTION WHILE COUNTING THE NUMBER
C     OF LINES IN THE SECTION. AT THE END OF THE SECTION SAVE THE COUNT
C     OF THE NUMBER OF LINES IN THE SECTION.
C
c-----------------------------------------------------------------------
C-----SKIP TO FIRST LINE OF NEXT SECTION.
   10 READ(ITAPE,390) MAT,MF,MT
      IF(MT.gt.0) go to 20
      IF(MAT.lt.0) go to 130
      go to 10
C-----BEGINNING OF SECTION FOUND. IF THIS IS A NEW MAT FIRST SECTION
C-----MUST BE MF=1, MT=451.
   20 IF(MAT.EQ.LASMAT) GO TO 90
C-----IF MATERIAL DOES NOT CONTAIN HOLLERITH SECTION COPY IT.
      IF(MF.EQ.1.AND.MT.EQ.451) GO TO 60
C-----NO HOLLERITH SECTION. CHECK MAT ORDER.
      IF(MAT.GT.LASMAT) GO TO 30
C-----NO HOLLERITH SECTION AND MAT IS NOT IN ASCENDING ORDER.
      WRITE(OUTP,580) MAT
      WRITE(*   ,580) MAT
      GO TO 40
C-----NO HOLLERITH SECTION.
   30 WRITE(OUTP,560) MAT
      WRITE(*   ,560) MAT
   40 LASMAT=MAT
   50 READ(ITAPE,390) MAT,MF,MT
      IF(MAT.le.0) go to 10
      go to 50
C-----NEW MAT FOUND. CHECK MAT ORDER.
   60 IF(MAT.GT.LASMAT) GO TO 70
C-----MAT IS NOT IN ASCENDING ORDER.
      WRITE(OUTP,570) MAT
      WRITE(*   ,570) MAT
      GO TO 80
C-----MAT ORDER O.K.
   70 WRITE(OUTP,550) MAT
      WRITE(*   ,550) MAT
   80 LASMAT=MAT
C-----INCREMENT SECTION COUNT AND SAVE MAT, MF AND MT. INITIALIZE COUNT
C-----OF LINES IN SECTION.
   90 INDEX=INDEX+1
      IF(INDEX.LE.MAXTAB) GO TO 110
c-----------------------------------------------------------------------
C
C     ERROR END OF RUN = too many sections.
C
c-----------------------------------------------------------------------
      WRITE(OUTP,470) MAXTAB
      WRITE(*   ,470) MAXTAB
c-----------------------------------------------------------------------
C
C     NORMAL END OF RUN
C
c-----------------------------------------------------------------------
  100 CALL ENDIT
c-----------------------------------------------------------------------
C
C     CONTINUE WITH NEXT SECTION.
C
c-----------------------------------------------------------------------
  110 MATTAB(INDEX)=MAT
      MFTAB(INDEX)=MF
      MTTAB(INDEX)=MT
      KCARD=0
C-----SKIP TO END OF SECTION WHILE COUNTING LINES IN SECTION.
  120 READ(ITAPE,400) MT
      KCARD=KCARD+1
      IF(MT.gt.0) go to 120
C-----SAVE COUNT OF THE NUMBER OF LINES IN SECTION.
      NCARD(INDEX)=KCARD
      GO TO 10
c-----------------------------------------------------------------------
C
C     THE ENTIRE ENDF/B TAPE HAS BEEN READ. IF NO HOLLERITH SECTIONS
C     TERMINATE EXECUTION. OTHERWISE REWIND ENDF/B TAPE AND READ A
C     SECOND TIME. DURING THIS SECOND PASS WRITE UPDATED ENDF/B TAPE
C     REMOVING OLD SECTION INDEX (IF ANY) AND INSERTING A NEW ONE.
C
c-----------------------------------------------------------------------
  130 IF(INDEX.GT.0) GO TO 140
      WRITE(OUTP,590)
      WRITE(*   ,590)
      CALL ENDERROR
C-----RE-POSITION ORIGINAL TAPE TO READ IT AGAIN AND INITIALIZE INDEX
C-----TO POINT IN FIRST ENTRY IN SECTION TABLE.
  140 NDEX=1
      REWIND ITAPE
      WRITE(OUTP,500)
      WRITE(*   ,500)
C-----COPY TAPE LABEL LINE.
      READ(ITAPE,380) CARD1
      ICARD=1
      WRITE(OTAPE,380) CARD1
      OCARD=1
C-----INITIALIZE SEQUENCE NUMBER AT BEGINNING OF EACH MAT.
  150 NOSEQ=0
c-----------------------------------------------------------------------
C
C     COPY TO BEGINNING OF NEXT SECTION (COPY INTERVENING SEND, FEND
C     AND MEND LINES). WHEN BEGINNING OF SECTION IS FOUND IF SECTION
C     IS MF=1, MT=451 (HOLLERITH AND SECTION INDEX) REMOVE OLD SECTION
C     INDEX (IF ANY) AND INSERT THE NEW ONE. IF SECTION IS NOT MF=1,
C     MT=451 SIMPLY COPY IT.
C
c-----------------------------------------------------------------------
C-----COPY TO BEGINNING OF NEXT SECTION.
  160 READ(ITAPE,410) CARD2,N2,MAT,MF,MT
      ICARD=ICARD+1
      NOSEQ=NXTSEQ(NOSEQ)
      IF(MT.gt.0) go to 170
C-----SET SEQUENCE NUMBER TO ZERO ON TAPE END (TEND) LINE.
C-----2015-2: Corrected Sequence Number.
      NOSEQ = 99999
      IF(MF.le.0) NOSEQ = 0
      WRITE(OTAPE,420) MAT,MF,MT,NOSEQ
      OCARD=OCARD+1
      IF(MAT.lt.0) go to 370
      IF(MAT.eq.0) go to 150
      go to 160
C-----BEGINNING OF SECTION FOUND. IF IT IS MF=1, MT=451 REMOVE OLD
C-----AND INSERT NEW SECTION INDEX. IF NOT MF=1, MT=451 JUST COPY
C-----SECTION.
  170 IF(MF.NE.1.OR.MT.NE.451) GO TO 340
      NXCOLD=N2
C-----DETERMINE NUMBER OF LINES IN SECTION INDEX FOR CURRENT EVALUATION.
      DO 180 ITOP=NDEX,INDEX
      IF(MAT.NE.MATTAB(ITOP)) GO TO 190
  180 CONTINUE
      ITOP=INDEX+1
  190 NXC=ITOP-NDEX
      ITOP=ITOP-1
C-----------------------------------------------------------------------
C
C     DETERMINE IF THIS IS ENDF/B-IV, V OR VI FORMAT.
C
C-----------------------------------------------------------------------
      READ(ITAPE,430) CARD3,NWD,N3,MAT,MF,MT
      ICARD=ICARD+1
C-----IV IF N1 > 0, N2 = 0
      IF(NWD.GT.0.AND.N3.EQ.0) GO TO 210
C-----ENDF/B-V OR VI FORMAT.
C     V IF N2 = 0
      IF(N3.LE.0) GO TO 200
c-----------------------------------------------------------------------
C
C     ENDF/B-VI FORMAT (READ THIRD AND FOURTH LINES, OUTPUT 4 LINES
C     WITH NEW REACTION INDEX SECTION COUNT).
C
c-----------------------------------------------------------------------
      READ(ITAPE,430) CARD4,NWD,NXCOLD,MAT,MF,MT
      ICARD=ICARD+1
      WRITE(OTAPE,410) CARD2,N2,MAT,MF,MT,NOSEQ
      OCARD=OCARD+1
      NOSEQ=NXTSEQ(NOSEQ)
      WRITE(OTAPE,430) CARD3,IZERO,N3,MAT,MF,MT,NOSEQ
      OCARD=OCARD+1
      NOSEQ=NXTSEQ(NOSEQ)
      WRITE(OTAPE,430) CARD4,NWD,NXCOLD,MAT,MF,MT,NOSEQ
      OCARD=OCARD+1
      NOSEQ=NXTSEQ(NOSEQ)
      READ(ITAPE,430) CARD4,NWD,NXCOLD,MAT,MF,MT
      ICARD=ICARD+1
C-----INCREMENT LINE COUNT FOR ADDED DOCUMENTATION LINE
      WRITE(OTAPE,430) CARD4,NWD+1,NXC,MAT,MF,MT,NOSEQ
      OCARD=OCARD+1
      IVERSE=3
      GO TO 220
c-----------------------------------------------------------------------
C
C     ENDF/B-V FORMAT (READ THIRD LINE, OUTPUT 3 LINES WITH NEW
C     REACTION INDEX SECTION COUNT).
C
c-----------------------------------------------------------------------
  200 READ(ITAPE,430) CARD4,NWD,NXCOLD,MAT,MF,MT
      ICARD=ICARD+1
      WRITE(OTAPE,410) CARD2,N2,MAT,MF,MT,NOSEQ
      OCARD=OCARD+1
      NOSEQ=NXTSEQ(NOSEQ)
      WRITE(OTAPE,430) CARD3,IZERO,N3,MAT,MF,MT,NOSEQ
      OCARD=OCARD+1
      NOSEQ=NXTSEQ(NOSEQ)
C-----INCREMENT LINE COUNT FOR ADDED DOCUMENTATION LINE
      WRITE(OTAPE,430) CARD4,NWD+1,NXC,MAT,MF,MT,NOSEQ
      OCARD=OCARD+1
      IVERSE=2
      GO TO 220
c-----------------------------------------------------------------------
C
C     ENDF/B-IV FORMAT (OUTPUT 2 LINES WITH NEW REACTION INDEX SECTION
C     COUNT).
C
c-----------------------------------------------------------------------
  210 WRITE(OTAPE,410) CARD2,NXC,MAT,MF,MT,NOSEQ
      OCARD=OCARD+1
      NOSEQ=NXTSEQ(NOSEQ)
C-----INCREMENT LINE COUNT FOR ADDED DOCUMENTATION LINE
      WRITE(OTAPE,430) CARD3,NWD+1,N3,MAT,MF,MT,NOSEQ
      OCARD=OCARD+1
      IVERSE=1
c-----------------------------------------------------------------------
C
C     ALL FORMATS - COPY COMMENT LINES.
C
c-----------------------------------------------------------------------
C-----COPY COMMENT LINES.
  220 WRITE(OUTP,530)
      WRITE(*   ,530)
      DO 230 J=1,NWD
      READ(ITAPE,440) CARD5
      ICARD=ICARD+1
      NOSEQ=NXTSEQ(NOSEQ)
      WRITE(OTAPE,440) CARD5,MAT,MF,MT,NOSEQ
      OCARD=OCARD+1
  230 CONTINUE
c-----------------------------------------------------------------------
C
C     ADD 1 DOCUMENTATION LINE.
C
c-----------------------------------------------------------------------
      NOSEQ=NXTSEQ(NOSEQ)
      WRITE(OTAPE,240) MAT,MF,MT,NOSEQ
  240 FORMAT(' **************** Program DICTIN (VERSION 2020-1) ',
     1       '****************',I4,I2,I3,I5)
      OCARD=OCARD+1
C-----IF THERE IS AN OLD REACTION INDEX READ THE FIRST ENTRY TO
C-----INITIALIZE.
      I=1
      IF(NXCOLD.LE.0) GO TO 250
      READ(ITAPE,460) MFOLD,MTOLD,MODOLD
      ICARD=ICARD+1
C-----INSERT NEW REACTION INDEX. READ OLD REACTION INDEX (IF ANY) AND
C-----USE THE OLD MOD NUMBER IN CORRESPONDING SECTION OF NEW REACTION
C-----INDEX.
  250 DO 320 J=NDEX,ITOP
      NOSEQ=NXTSEQ(NOSEQ)
C-----CORRECT MF=1, MT=451 LINE COUNT FOR REMOVAL OF OLD SECTION
C-----INDEX AND INSERTION OF NEW ONE.
      IF(MFTAB(J).EQ.1.AND.MTTAB(J).EQ.451) NCARD(J)=NCARD(J)+NXC-NXCOLD
C-----INITIALIZE MOD NUMBER AND THEN SEARCH OLD REACTION INDEX (IF ANY)
C-----FOR A SECTION WITH THE SAME MF/MT.
      MOD=1
      IF(I.GT.NXCOLD) GO TO 290
  260 IF(MFOLD.lt.MFTAB(J)) go to 270
      IF(MFOLD.gt.MFTAB(J)) go to 290
      IF(MTOLD.eq.MTTAB(J)) go to 280
      IF(MTOLD.gt.MTTAB(J)) go to 290
  270 I=I+1
      IF(I.GT.NXCOLD) GO TO 290
      READ(ITAPE,460) MFOLD,MTOLD,MODOLD
      ICARD=ICARD+1
      GO TO 260
C-----CORRESPONDING SECTION FOUND (SAME MF/MT). USE MOD NUMBER.
  280 MOD=MODOLD
C-----LIST AND WRITE NEXT REACTION INDEX ENTRY. INDICATE ENDF/B
C-----VERSION WITH MF=1, MT=451.
  290 IF(MFTAB(J).EQ.1.AND.MTTAB(J).EQ.451) GO TO 300
      WRITE(OUTP,520) MATTAB(J),MFTAB(J),MTTAB(J),NCARD(J),MOD
      WRITE(*   ,520) MATTAB(J),MFTAB(J),MTTAB(J),NCARD(J),MOD
      GO TO 310
C-----INCREMENT MF/MT=1/451 LINE COUNT FOR ADDED DOCUMENTATION LINE
  300 NCARD(J) = NCARD(J) + 1
      WRITE(OUTP,510) FMTHOL(IVERSE),MATTAB(J),MFTAB(J),MTTAB(J),
     1 NCARD(J),MOD
      WRITE(*   ,510) FMTHOL(IVERSE),MATTAB(J),MFTAB(J),MTTAB(J),
     1 NCARD(J),MOD
  310 WRITE(OTAPE,450) MFTAB(J),MTTAB(J),NCARD(J),MOD,
     1 MAT,MF,MT,NOSEQ
      OCARD=OCARD+1
  320 CONTINUE
      NDEX=ITOP+1
C-----WRITE SECTION END (SEND) LINE.
C-----2015-2: Corrected Sequence Number.
      NOSEQ=99999
      IF(MF.le.0) NOSEQ = 0
      WRITE(OTAPE,420) MAT,MF,MTZERO,NOSEQ
      OCARD=OCARD+1
C-----SKIP TO SEND LINE IN ORDER TO DELETE OLD SECTION INDEX, IF ANY.
  330 READ(ITAPE,400) MT
      ICARD=ICARD+1
      IF(MT.le.0) go to 160
      go to 330
C-----SECTION IS NOT MF=1, MT=451. COPY SECTION.
C-----2015-2: Corrected Sequence Number.
  340 if(MT.le.0) NOSEQ = 99999
      if(MF.le.0) NOSEQ = 0
      WRITE(OTAPE,410) CARD2,N2,MAT,MF,MT,NOSEQ
      OCARD=OCARD+1
  350 READ(ITAPE,440) CARD5,MAT,MF,MT
      ICARD=ICARD+1
      NOSEQ=NXTSEQ(NOSEQ)
      IF(MT.le.0) go to 360
      WRITE(OTAPE,440) CARD5,MAT,MF,MT,NOSEQ
      OCARD=OCARD+1
      GO TO 350
C-----2015-2: Corrected Sequence Number.
  360 NOSEQ = 99999
      if(MF.le.0) NOSEQ = 0
      WRITE(OTAPE,420) MAT,MF,MT,NOSEQ
      OCARD=OCARD+1
      GO TO 160
c-----------------------------------------------------------------------
C
C     END OF SECOND PASS. SECTION INDEX HAS BEEEN REPLACED FOR ALL MATS.
C     END ENDF/B FORMATTED OUTPUT ENDF/B FORMATTED FILE.
C
c-----------------------------------------------------------------------
  370 CONTINUE
      WRITE(OUTP,540) ICARD,OCARD
      WRITE(*   ,540) ICARD,OCARD
      CALL ENDIT
      GO TO 100   ! Some compilers do not like to end routine on CALL
  380 FORMAT(20A4)
  390 FORMAT(66X,I4,I2,I3)
  400 FORMAT(72X,I3)
  410 FORMAT(13A4,A3,I11,I4,I2,I3,I5)
  420 FORMAT(66X,I4,I2,I3,I5)
  430 FORMAT(11A4,2I11,I4,I2,I3,I5)
  440 FORMAT(16A4,A2,I4,I2,I3,I5)
  450 FORMAT(22X,4I11,I4,I2,I3,I5)
  460 FORMAT(22X,2I11,11X,I11,I4,I2,I3,I5)
  470 FORMAT(///'Over ',I5,' Sections---Execution Terminated')
  480 FORMAT(' Create New Section Index (DICTIN 2020-1)'/1X,60('-'))
  490 FORMAT(1X,60('-')/
     1 ' First Pass. Reading ENDF/B Data'/1X,60('-')/
     2 '  MAT   Messages'/1X,60('-'))
  500 FORMAT(1X,60('-')/' Second Pass. Creating New Index'/1X,60('-')/
     1 ' ENDF/B  MAT MF  MT  Lines  Mod'/' Format')
  510 FORMAT(2X,A2,3X,I5,I3,I4,I7,I5)
  520 FORMAT(7X,I5,I3,I4,I7,I5)
  530 FORMAT(1X,60('-'))
  540 FORMAT(1X,60('-')/
     1 ' Original Line Count',I7/
     2 ' Final Line Count   ',I7/1X,60('-'))
  550 FORMAT(I5)
  560 FORMAT(I5,2X,' No Section MF=1, MT=451...Material Copied')
  570 FORMAT(I5,2X,' WARNING Material is not in MAT Order')
  580 FORMAT(I5,2X,' WARNING Material is not in MAT Order'/
     1 7X,' No Section MF=1, MT=451...Material Copied')
  590 FORMAT(1X,60('-')/
     1 ' No Section MF=1, MT=451 on Tape...Execution Terminated')
      END
      SUBROUTINE READIN
C=======================================================================
C
C     READ FILENAMES - IF BLANK USE STANDARD FILENAMES
C
C=======================================================================
      INCLUDE 'implicit.h'
      INTEGER*4 OUTP,OTAPE
      CHARACTER*72 NAMEIN,NAMEOUT
      COMMON/ENDFIO/INP,OUTP,ITAPE,OTAPE
      COMMON/IOSTATUS/ISTAT1,ISTAT2
      COMMON/NAMEX/NAMEIN,NAMEOUT
C-----USE DEFAULTS IF ERROR OPENING OLD INPUT FILE
      IF(ISTAT1.EQ.1) GO TO 20
C-----INPUT DATA.
      READ(INP,10,END=20,ERR=20) NAMEIN
   10 FORMAT(A72)
      IF(NAMEIN.EQ.' ') NAMEIN = 'ENDFIN.IN'
C-----OUTPUT DATA.
      READ(INP,10,END=30,ERR=30) NAMEOUT
      IF(NAMEOUT.EQ.' ') NAMEOUT = 'ENDFIN.OUT'
      GO TO 40
C-----END OF INPUT - DEFINE DEFAULT NAMES
   20 NAMEIN = 'ENDFB.IN'
   30 NAMEOUT = 'ENDFB.OUT'
      ISTAT1 = 1
C-----PRINT FINAL NAMES
   40 WRITE(OUTP,50) NAMEIN,NAMEOUT
      WRITE(*   ,50) NAMEIN,NAMEOUT
   50 FORMAT(
     1 ' ENDF/B Input and Output Data Filenames'/1X,60('-')/1X,A72/
     2 1X,A72)
c-----------------------------------------------------------------------
C
C     OPEN ENDF/B DATA FILES
C
c-----------------------------------------------------------------------
      CALL FILIO2
c-----------------------------------------------------------------------
C
C     TERMINATE IF ERROR OPENING OLD FILE
C
c-----------------------------------------------------------------------
      IF(ISTAT2.EQ.1) THEN
      WRITE(OUTP,60) NAMEIN
      WRITE(   *,60) NAMEIN
   60 FORMAT(//' ERROR - Opening Old file'/1X,A72//)
      CALL ENDERROR
      ENDIF
      RETURN
      END
      SUBROUTINE FILIO1
C=======================================================================
C
C     DEFINE ALL I/O UNITS AND FILE NAMES
C
C=======================================================================
      INCLUDE 'implicit.h'
      INTEGER*4 OUTP,OTAPE
      CHARACTER*72 NAMEIN,NAMEOUT
      COMMON/ENDFIO/INP,OUTP,ITAPE,OTAPE
      COMMON/IOSTATUS/ISTAT1,ISTAT2
      COMMON/NAMEX/NAMEIN,NAMEOUT
C-----DEFINE ALL I/O UNITS.
      INP=2
      OUTP=3
      ITAPE=10
      OTAPE=11
C-----DEFINE FILE NAME.
      OPEN(OUTP,FILE='DICTIN.LST',STATUS='UNKNOWN')
      OPEN(INP,FILE='DICTIN.INP',STATUS='OLD',ERR=10)
      ISTAT1 = 0
      RETURN
   10 ISTAT1 = 1
      RETURN
      ENTRY FILIO2
      OPEN(OTAPE,FILE=NAMEOUT,STATUS='UNKNOWN')
      OPEN(ITAPE,FILE=NAMEIN,STATUS='OLD',ERR=20)
      ISTAT2 = 0
      RETURN
   20 ISTAT2 = 1
      RETURN
      END
