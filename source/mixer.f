C This file is part of PREPRO.
C
C    Author: Dermott (Red) Cullen
C Copyright: (C) International Atomic Energy Agency
C
C PREPRO is free software; you can redistribute it and/or modify it
C under the terms of the MIT License; see LICENSE file for more details.


C=======================================================================
C
C     PROGRAM MIXER
C     =============
C     VERSION 76-1 (NOVEMBER 1976)
C     VERSION 81-1 (APRIL 1981)  *IBM VERSION
C     VERSION 82-1 (AUGUST 1982) *COMPUTER INDEPENDENT VERSION
C     VERSION 84-1 (JUNE 1984)   *SPECIAL I/O ROUTINES TO GUARANTEE
C                                 ACCURACY OF ENERGY.
C                                *DOUBLE PRECISION TREATMENT OF ENERGY
C                                 (REQUIRED FOR NARROW RESONANCES).
C     VERSION 86-1 (JANUARY 1986)*FORTRAN-77/H VERSION
C     VERSION 88-1 (JULY 1988)   *OPTION...INTERNALLY DEFINE ALL I/O
C                                 FILE NAMES (SEE, SUBROUTINE FILIO1
C                                 AND FILIO2 FOR DETAILS).
C                                *IMPROVED BASED ON USER COMMENTS.
C     VERSION 89-1 (JANUARY 1989)*PSYCHOANALYZED BY PROGRAM FREUD TO
C                                 INSURE PROGRAM WILL NOT DO ANYTHING
C                                 CRAZY.
C                                *UPDATED TO USE NEW PROGRAM CONVERT
C                                 KEYWORDS.
C                                *ADDED LIVERMORE CIVIC COMPILER
C                                 CONVENTIONS.
C     VERSION 92-1 (JANUARY 1992)*UPDATED BASED ON USER COMMENTS
C                                *ADDED PHOTON CROSS SECTIONS
C                                *ADDED FORTRAN SAVE OPTION
C                                *OUTPUT IN ENDF/B-VI FORMAT
C                                *COMPLETELY CONSISTENT I/O ROUTINES -
C                                 TO MINIMIZE COMPUTER DEPENDENCE.
C                                *NOTE, CHANGE IN INPUT PARAMETER
C                                 FORMAT.
C     VERSION 94-1 (JANUARY 1994)*VARIABLE ENDF/B DATA FILENAMES
C                                 TO ALLOW ACCESS TO FILE STRUCTURES
C                                 (WARNING - INPUT PARAMETER FORMAT
C                                 HAS BEEN CHANGED)
C                                *CLOSE ALL FILES BEFORE TERMINATING
C                                 (SEE, SUBROUTINE ENDIT)
C                                *INCREASED INCORE PAGE SIZE FROM
C                                 1002 TO 4008.
C     VERSION 96-1 (JANUARY 1996) *COMPLETE RE-WRITE
C                                 *IMPROVED COMPUTER INDEPENDENCE
C                                 *ALL DOUBLE PRECISION
C                                 *ON SCREEN OUTPUT
C                                 *UNIFORM TREATMENT OF ENDF/B I/O
C                                 *IMPROVED OUTPUT PRECISION
C                                 *DEFINED SCRATCH FILE NAMES
C                                 *INCREASED INCORE PAGE SIZE FROM
C                                  4008 TO 12000.
C     VERSION 99-1 (MARCH 1999)   *CORRECTED CHARACTER TO FLOATING
C                                  POINT READ FOR MORE DIGITS
C                                 *UPDATED TEST FOR ENDF/B FORMAT
C                                  VERSION BASED ON RECENT FORMAT CHANGE
C                                 *GENERAL IMPROVEMENTS BASED ON
C                                  USER FEEDBACK
C     VERSION 99-2 (JUNE 1999)    *ASSUME ENDF/B-VI, NOT V, IF MISSING
C                                  MF=1, MT-451.
C     VERS. 2000-1 (FEBRUARY 2000)*GENERAL IMPROVEMENTS BASED ON
C                                  USER FEEDBACK
C     VERS. 2002-1 (MAY 2002)     *OPTIONAL INPUT PARAMETERS
C     VERS. 2004-1 (MARCH 2004)   *ADDED INCLUDE FOR COMMON
C                                 *INCREASED INCORE PAGE SIZE FROM
C                                  12000 TO 60000.
C     VERS. 2005-1 (OCT. 2005)    *CORRECTED MERGE ERROR
C     VERS. 2007-1 (JAN. 2007)    *CHECKED AGAINST ALL ENDF/B-VII
C                                 *INCREASED INCORE PAGE SIZE FROM
C                                  60,000 TO 240,000.
C     VERS. 2007-2 (DEC. 2007)    *72 CHARACTER FILE NAMES.
C     VERS. 2008-1 (JUNE 2008)    *ADDED GRAMS OR ATOMS INPUT
C     VERS. 2010-1 (Apr. 2010)    *General update based on user feedback
C     VERS. 2012-1 (Aug. 2012)    *Added CODENAME
C                                 *32 and 64 bit Compatible
C                                 *Added ERROR stop
C     VERS. 2015-1 (Jan. 2015)    *Extended OUT9.
C                                 *Replaced ALL 3 way IF Statements.
C     VERS. 2017-1 (May  2017)    *Increse max. points to 1,200,000
C                                 *updated based on user feedbsck.
C                                 *All floating input parameters changed
C                                  to character input + IN9 conversion.
C     VERS. 2018-1 (Jan. 2018)    *Added on-line output for ALL ENDERROR
C     VERS. 2019-1 (June 2019)    *Additional Interpolation Law Tests
C                                 *Added WARNING if ANY MT ends below
C                                  Maximum Tabulated Energy of ANY other
C                                  MT = the ENDF Data is NOT uniquely
C                                  defined above this energy.
C                                 *Corrected ERROR that could set last
C                                  (highest energy) cross section = 0.0
C                                 *No longer automatically extend cross
C                                  sections as constant above tabulated
C                                  energy range.
C     VERS. 2020-1 (June 2020)    *Complete Re-write to allow some
C                                  reactions to be missing, e.g.,
C                                  define (n,t) for natural abundant
C                                  element by summing over isotopes,
C                                  where only some isotopes have (n,t).
C                                 *Additional Interpolation Law Tests
C                                 *Min 1 File allowed,e.g. select MT
C                                  Previously assumed 2 or more files
C                                  needed for MIX.
C     VERS. 2021-1 (Jan. 2021)    *Updated for FORTRAN 2018
C
C     Acknowledgement 2019
C     --------------------
C     I thank Daniel Lopez Aldama (Agency of Nuclear Energy and Advanced
C     Technologies, Havana, Cuba), for finding and fixing an ERROR in
C     MIXER that could result in the last MIXED energy point (highest
C     energy output) ERROREOUSLY setting the  cross section = 0.0. This
C     problem has been corrected in 2019-1.
C
C     Defining High Energy Data
C     -------------------------
C     Starting with MIXER (2019-1), it will no longer automatically
C     extend MTs as CONSTANT above the energy range where they are
C     tabulated to the Maximum Tabulated Energy of any other MT in MIX.
C     Above this energy the ENDF MIX is not UNIQUELY defined - in this
C     case it was potentially TOTALLY MISLEADING users of MIXER in that
C     it was doing "invisiable evaluation"  - starting with 2019-1
C     MIXER will,
C     1) Extend the cross section = 0.
C     2) Print WARNING messages idenifying the Maximum Tabulated Energy
C        of ANY MT - and which MTs stop below this energy.
C     3) Print a final WARNING that the MIX is NO UNIQUELY defined
C        above the LOWEST common tabulated energy fot any MT.
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
C     PURPOSE
C     -------
C     THIS PROGRAM IS DESIGNED TO CALCULATE THE ENERGY DEPENDENT CROSS
C     SECTION FOR A COMPOSITE MIXTURE OF UP TO 10 DIFFERENT MATERIALS.
C
C     THE PRESENT VERSION WILL ONLY CALCULATE THE CROSS SECTION FOR ONE
C     FINAL REACTION (ENDF/B SECTION), E.G. TOTAL CROSS SECTION, BUT NOT
C     ANY OTHER REACTION.
C
C     NOTE, THIS PROGRAM WILL NOT COMBINE ALL REACTIONS FOR A MIXTURE
C     OF MATERIALS DURING A SINGLE RUN - ONLY ONE REACTION WILL BE
C     CREATED PER RUN.
C
C     EVALUATED DATA FORMAT
C     ---------------------
C     THE CROSS SECTIONS ARE READ FROM THE ENDF/B FORMAT AND THE
C     COMPOSITE CROSS SECTION IS CONVERTED TO AN EQUIVALENT BARNS/ATOM
C     FORM AND OUTPUT IN THE ENDF/B FORMAT WITH AN EQUIVALENT ATOMIC
C     WEIGHT. THE USER MUST SPECIFY THE COMPOSITION BY GIVING THE ZA,
C     MT AND GRAMS OR ATOMS OF EACH CONSTITUENT. IN ADDITION THE USER
C     IDENTIFY THE COMPOSITE CROSS SECTION BY SPECIFYING THE ZA, MAT
C     AND MT TO BE USED IN THE ENDF/B FORMATTED OUTPUT.
C
C     SINCE ONLY THE CROSS SECTIONS IN FILE 3 AND 23 ARE USED, AND THE
C     FORMAT FOR FILE 3/23 IS THE SAME IN ALL VERSIONS ON ENDF/B, THIS
C     PROGRAM MAY BE USED WITH ANY VERSION OF ENDF/B DATA (I.E.,
C     ENDF/B-I, II, III, IV, V OR VI). DURING A SINGLE RUN IT MAY EVEN
C     BE USED TO READ AND COMBINE EVALUATIONS WHICH ARE IN DIFFERENT
C     VERSIONS OF THE ENDF/B FORMAT.
C
C     ENDF/B FORMATTED OUTPUT WILL BE IN THE ENDF/B-VI FORMAT REGARDLESS
C     OF THE FORMAT OF THE INPUT ENDF/B DATA. THIS WILL ONLY EFFECT THE
C     HOLLERITH SECTION (MF=1, MT=451). THE FORMAT OF CROSS SECTIONS
C     (MF=3) IS THE SAME IN ALL VERSION OF THE ENDF/B FORMAT.
C
C     IN ORDER TO GUARANTEE PROPER OPERATION OF THIS PROGRAM THE DATA
C     MUST BE PROPERLY CODED IN THE ENDF/B FORMAT. NO ERROR CHECKING IS
C     PERFORMED. IT IS PARTICULARLY IMPORTANT THAT THE FOLLOWING DATA
C     BE CORRECT
C
C     (1) ZA, MF, MT - MUST BE CORRECT IN ORDER TO ALLOW PROGRAM TO
C         SELECT THE APPROPRIATE SECTIONS TO BE COMBINED.
C     (2) AWRE - ATOMIC WEIGHT RATIO MUST BE CORRECT TO ALLOW PROGRAM
C         TO CONVERT THE USER SPECIFIED GRAMS INTO ATOMS FOR
C         PROPER ATOM RATIO MIXING.
C     (3) (ENERGIES, CROSS SECTIONS) - MUST BE CORRECT, LINEARLY
C                                                       ========
C         INTERPOLABLE, IN ASCENDING ENERGY ORDER OF (E, BARNS).
C         ============
C
C         TO CONVERT ENDF/B FORMATTED DATA TO THE REQUIRED INPUT FORM
C         THE FOLLOWING PROGRAMS MAY BE USED,
C         LINEAR - CONVERT TABULATED CROSS SECTIONS TO LINEARLY
C                  INTERPOLABLE FORM.
C         RECENT - RECONSTRUCT RESONANCE CONTRIBUTION, ADD TO BACKGROUND
C                  CROSS SECTION AND OUTPUT THE COMBINATION IN LINEARLY
C                  INTERPOLABLE FORM.
C         SIGMA1 - DOPPLER BROADEN CROSS SECTIONS TO ANY TEMPERATURE AND
C                  OUTPUT THE RESULT IN LINEARLY INTERPOLABLE FORM.
C
C     DOCUMENTATION
C     -------------
C     THE FACT THAT THIS PROGRAM HAS COMBINED THE DATA IS DOCUMENTED
C     IN THE OUTPUT ENDF/B FORMAT IN THE HOLLERITH SECTION BY FIRST
C     IDENTIFYING THE VERSION OF THIS PROGRAM THAT WAS USED, IN THE FORM
C
C     ********************( PROGRAM MIXER 2021-1) **********************
C
C     THIS IS FOLLOWED BY THE TWO LINE IDENTIFICATION INPUT BY THE USER.
C     THIS IS FOLLOWED BY COMPOSITION INPUT BY THE USER.
C
C     NEUTRON OR PHOTON DATA
C     ----------------------
C     THIS PROGRAM WILL ALLOW YOU TO PROCESS EITHER NEUTRON OR PHOTON
C     CROSS SECTIONS - BUT YOU CANNOT MIX THE TWO TYPES TOGETHER. BY
C     INPUT YOU CAN SPECIFY THE OUTPUT MF = 3 (NEUTRONS) OR 23 (PHOTONS)
C     WHATEVER TYPE YOU SPECIFIED FOR OUTPUT IS THE ONLY TYPE OF DATA
C     WHICH WILL BE PROCESSED BY THIS PROGRAM.
C
C     DEFINING THE COMPOSITION
C     ------------------------
C     THE USER MAY SPECIFY UP TO 10 DIFFERENT SECTIONS OF DATA TO BE
C     COMBINED, EACH SECTION IDENTIFIED BY ZA AND MT NUMBER. THE
C     AMOUNT OF EACH MATERIAL IS SPECIFIED BY DEFINING THE NUMBER OF
C     GRAMS OF EACH MATERIAL IN THE COMPOSITE MIXTURE. THIS CAN BE
C     DERIVED FROM THE VOLUME FRACTION SIMPLY BY MULTIPLYING THE STP
C     DENSITY OF EACH MATERIAL BY ITS VOLUME FRACTION. NOTE, DO NOT
C     INPUT ATOM FRACTIONS.
C
C     THE LIST OF SECTIONS TO BE COMBINED MAY BE SPECIFIED IN ANY
C     ORDER, I.E. THEY NEED NOT BE IN ZA ORDER OR THE ORDER THAT THE
C     EVALUATED DATA APPEARS ON THE ENDF/B FORMATTED TAPE.
C
C     IF ANY REQUESTED SECTION OF DATA IS NOT FOUND ON THE ORIGINAL
C     ENDF/B FORMATTED FILE, THE PROGRAM WILL PRINT A LIST OF THE
C     MISSING SECTIONS AND TERMINATE. IF ALL REQUESTED SECTIONS ARE
C     FOUND THE PROGRAM WILL PRODUCE A COMPOSITE SECTION USING THE
C     UNION OF ALL ENERGIES FOUND IN ANY SECTION. THE COMPOSITE SECTION
C     WILL NOT BE THINNED.
C
C     PRIOR TO LATER USE IN ANY APPLICATION THE NUMBER OF ENERGY POINTS
C     IN THE COMPOSITE CROSS SECTION MAY BE MINIMIZED BY USING PROGRAM
C     LINEAR, UCRL-50400, VOL. 17, PART B TO THIN THE DATA.
C
C     ONLY LINEARLY INTERPOLABLE DATA
C     -------------------------------
C     THE CROSS SECTIONS TO BE COMBINED MUST BE IN LINEARLY INTERPOLABLE
C     TABULATED FORM (I. E., FILE 3 OR 23, INTERPOLATION LAW 2).
C
C     TO CONVERT TABULATED CROSS SECTIONS TO LINEARLY INTERPOLABLE FORM
C     SEE, PROGRAM LINEAR, UCRL-50400, VOL. 17, PART A.
C
C     TO CONVERT RESONANCE PARAMETERS TO LINEARLY INTERPOLABLE FORM SEE,
C     PROGRAM RECENT, UCRL-50400, VOL. 17, PART C.
C
C     TO DOPPLER BROADEN LINEARLY INTERPOLABLE DATA TO ANY TEMPERATURE
C     SEE PROGRAM SIGMA1, UCRL-50400, VOL. 17, PART B.
C
C     PAGING SYSTEM
C     -------------
C     THERE IS NO LIMIT TO THE THE NUMBER OF DATA POINTS IN EACH OF THE
C     SECTIONS TO BE COMBINED, NOR IS THERE A LIMIT TO THE NUMBER OF
C     DATA POINTS IN THE COMPOSITE MIXTURE CROSS SECTION.
C
C     ALL REQUIRED SECTIONS OF DATA ARE READ FROM THE ORIGINAL ENDF/B
C     FORMATTED FILE. ANY SECTION OF 60000 OR FEWER POINTS WILL BE
C     TOTALLY CORE RESIDENT. LARGER SECTIONS ARE LOADED INTO A PAGING
C     SYSTEM USING A SCRATCH FILE WITH ONLY 60000 POINTS PER SECTION
C     CORE RESIDENT AT ANY ONE TIME. SIMILARLY THE COMPOSITE SECTION
C     WILL BE TOTALLY CORE RESIDENT IF IT CONTAINS 60000 OR FEWER POINTS
C     AND LARGER COMPOSITE SECTIONS WILL BE LOADED INTO A PAGING
C     SYSTEM WHERE ONLY 60000 POINTS ARE CORE RESIDENT AT ANY TIME. SINC
C     A PAGING SYSTEM MAY BE USED BY ANY SECTION OF DATA THERE IS NO
C     LIMIT TO THE SIZE OF EITHER THE ORIGINAL SECTIONS, NOR TO THE
C     COMPOSITE SECTION, E.G. A SECTION MAY CONTAIN 100,000 ENERGIES
C     AND CROSS SECTIONS TO DESCRIBE A GIVEN REACTION.
C
C     PAGE SIZE
C     ---------
C     THE PAGE SIZE USED IN THIS PROGRAM IS DEFINED BY THE PARAMETER
C     NPAGE AND THE DIMENSIONS OF THE ARRAYS XTAB AND YTAB. IN ORDER
C     TO ADAPT THIS PROGRAM FOR USE ON ANY COMPUTER THE PAGE SIZE MAY
C     BE INCREASED OR DECREASED BUT THE FOLLOWING RULES MUST BE FOLLOWED
C                                                       ====
C
C     (1) NPAGE - MUST BE A MULTIPLE OF 3 IN ORDER TO ALLOW THE PROGRAM
C         TO READ FULL CARDS OF ENDF/B DATA (3 POINTS PER LINE). FAILURE
C         TO FOLLOW THIS RULE CAN LEAD TO LOSS OF DATA AND/OR PROGRAM
C         ERRORS DURING EXECUTION.
C     (3) YTAB  - THE DIMENSION OF YTAB MUST BE (NPAGE,11).
C     (4) XTAB  - THE DIMENSION OF XTAB MUST BE (NPAGE,11).
C
C     DOPPLER BROADENING
C     ------------------
C     THE COMPOSITE CROSS SECTION OUTPUT FROM THIS PROGRAM SHOULD NOT
C     BE DOPPLER BROADENED USING PROGRAM SIGMA1, OR THE EQUIVALENT. THE
C     ATOMIC WEIGHT USED TO IDENTIFY THE COMPOSITE MIXTURE IS BASED ON
C     THE ATOM FRACTION OF EACH CONSTITUENT AND CANNOT BE USED TO
C     CHARACTERIZE THE BROADENING OF ANY GIVEN RESONANCE IN THE MIXTURE
C     DUE TO THE CONTRIBUTION OF ONE CONSTITUENT. IN ORDER TO CONSIDER
C     DOPPLER BROADENING FIRST USE PROGRAM SIGMA1 TO BROADEN THE CROSS
C     SECTION FOR EACH OF THE CONSTITUENTS AND THEN COMBINE THE
C     BROADENED DATA USING PROGRAM MIXER.
C
C     EXAMPLE USE
C     -----------
C     THE OUTPUT FROM THIS PROGRAM HAS BEEN FOUND TO BE EXTREMELY
C     USEFUL IN THE FOLLOWING APPLICATIONS...
C
C     (1) CALCULATE A COMPOSITE TOTAL CROSS SECTON FOR LATER USE AS
C         A WEIGHTING FUNCTION IN SELF-SHIELDING THE CROSS SECTIONS
C         OF EACH CONSTITUENT OF THE MIXTURE SEPARATELY.
C
C         PROGRAM GROUPIE CAN USE THE CALCULATED COMPOSITE TOTAL CROSS
C         SECTION AS THE TOTAL CROSS SECTION FOR EACH CONSTITUENT OF
C         THE MIXTURE IN ORDER TO CALCULATE  SELF-SHIELDED CROSS SECTION
C         FOR EACH CONSTITUENT OF THE MIXTURE.
C
C     (2) CALCULATE COMPOSITE TOTAL AND FISSION CROSS SECTIONS IN
C         ORDER TO CALCULATE THE TRANSMISSION AND SELF-INDICATION
C         THROUGH COMPOSITE MATERIALS. GENERALLY IN THIS CASE THE
C         TOTAL CROSS SECTION WILL BE CALCULATED FOR THE COMPOSITION
C         OF THE SAMPLE AND THE FISSION CROSS SECTION WILL BE
C         CALCULATED FOR THE COMPOSITION OF THE FISSION CHAMBER
C         (WHICH GENERALLY WILL HAVE A DIFFERENT COMPOSITION THAN THE
C         SAMPLE).
C
C         PROGRAM VIRGIN CAN USE THE OUTPUT FROM THIS PROGRAM TO
C         PERFORM TRANSMISSION AND SELF-INDICATION CALCULATIONS.
C         PROGRAM VIRGIN WILL ANALYTICALLY CALCULATE THE UNCOLLIDED
C         (I.E. VIRGIN) FLUX TRANSMITTED AND REACTION RATE DUE TO ANY
C         TABULATED LINEARLY INTERPOLABLE INCIDENT SPECTRUM. RESULTS
C         WILL BE PRESENTLY FOR UP TO 10 DIFFERENT SAMPLE THICKNESSES
C         AND BINNED INTO ENERGY GROUPS IN ORDER TO SIMULATE AN
C         EXPERIMENTAL MEASUREMENT.
C
C     (3) THE OUTPUT FROM THIS PROGRAM IS VERY USEFUL TO PLOT IN ORDER
C         TO SEE THE IMPORTANCE OF SPECIFIC CROSS SECTION FEATURES IN
C         THE COMPOSITE CROSS SECTION.
C
C         PROGRAM COMPLOT CAN BE USED TO PLOT THE OUTPUT FROM THIS
C         PROGRAM AND IF REQUIRED EXAMINE ANY PARTICULAR ENERGY RANGE
C         IN DETAIL. IN ORDER TO DO THIS THE (ZA, MT) EQUIVALENCE OPTION
C         OF PROGRAM COMPLOT SHOULD BE USED. TO COMPARE ANY CONSTITUENT
C         CROSS SECTION TO THE COMPOSITE CROSS SECTION THE INPUT TO
C         COMPLOT SHOULD EQUATE THE (ZA,MT) OF THE COMPOSITE TO THE
C         (ZA,MT) OF ONE CONSTITUENT AND THE MULTIPLIER INPUT TO
C         COMPLOT SHOULD BE THE ATOM FRACTION FOR THE CONSTITUENT (THE
C         ATOM FRACTIONS ARE DEFINED IN THE OUTPUT LISTING FROM PROGRAM
C         MIXER).
C
C     INPUT FILES
C     -----------
C     UNIT  DESCRIPTION
C     ----  -----------
C       2   INPUT CARDS (BCD - 80 CHARACTERS/RECORD)
C      10   ORIGINAL EVALUATED DATA IN ENDF/B FORMAT
C                       (BCD - 80 CHARACTERS/RECORD)
C
C     OUTPUT FILES
C     ------------
C     UNIT  DESCRIPTION
C     ----  -----------
C       3   OUTPUT LISTING (BCD - 120 CHARACTERS/RECORD)
C      11   COMPOSITE EVALUATED DATA IN ENDF/B FORMAT
C                     (BCD - 80 CHARACTERS/RECORD)
C
C     SCRATCH FILES
C     -------------
C     UNIT  DESCRIPTION
C     ----  -----------
C      12   SCRATCH FILE FOR EACH OF THE 10 SECTIONS WHICH
C      13   WILL BE ADDED TOGETHER TO DEFINE THE FINAL
C       .   SECTION (BINARY - 60000 AND 480000 WORDS/RECORD)
C       . .
C       . .
C      20 .
C      21 .
C      22   SCRATCH FILE FOR COMBINED SECTION.
C           (BINARY - 2004 WORDS/RECORD)
C
C     STANDARD FILE NAMES (SEE SUBROUTINES FILIO1 AND FILIO2)
C     ----------------------------------------------------------------
C     UNIT  FILE NAME
C     ----  ----------
C       2   MIXER.INP
C       3   MIXER.LST
C      10   ENDFB.IN
C      11   ENDFB.OUT
C    12-22  (SCRATCH)
C
C     INPUT CARDS
C     -----------
C     LINE  COLS.  FORMAT  NAME    DESCRIPTION
C     ----  -----  ------  ------- ----------
C      1-2   1-66 16A4,A2  TITLE   TWO LINE TITLE DESCRIBING PROBLEM
C                                  (THIS TITLE IS USED TO IDENTIFY THE
C                                  OUTPUT LISTING AND IS ALSO WRITTEN
C                                  IN MF=1, MT=451 (HOLLERITH SECTION)
C                                  OF THE ENDF/B FORMATTED OUTPUT TO
C                                  IDENTIFY THE COMPOSITE MIXTURE).
C        3   1-72                  ENDF/B INPUT DATA FILENAME
C                                  (STANDARD OPTION = ENDFB.IN)
C        4   1-72                  ENDF/B OUTPUT DATA FILENAME
C                                  (STANDARD OPTION = ENDFB.OUT)
C        5   1-11    I11   IZAOUT  ZA IDENTIFICATION FOR COMBINATION
C        5  12-17    I6    MATOUT  MAT IDENTIFICATION FOR COMBINATION
C        5  18-19    I2    MFOUT   MF IDENTIFICATION FOR COMBINATION
C        5  20-22    I3    MTOUT   MT IDENTIFICATION FOR COMBINATION
C        5  23-33    I11   DEFINE INPUT DENSITY
C                          = 0 = GRAMS = BACKWARDS COMPATIBLE
C                          > 0 = ATOMS = NEW IN 2008
C      6-N   1-11    I11   IZAGET  ZA (1000*Z+A) OF MATERIAL
C      6-N  12-22    I11   MTGET   MT OF REACTION
C      6-N  23-33  E11.4   DENSE   MATERIAL DENSITY (ATOMS OR GRAMS)
C
C     THE SIXTH LINE IS REPEATED FOR EACH SECTION (FROM 2 TO 10).
C     SINCE THE ENDF/B FORMATTED OUTPUT IS IN BARNS/ATOM FORM A MINIMUM
C     OF TWO SECTIONS MUST BE COMBINED (I.E., IF ONLY ONE SECTION IS
C     SPECIFIED THE OUTPUT WOULD BE IDENTICAL TO THE INPUT AND AS SUCH
C     THE PROGRAM WILL CONSIDER THIS TO BE AN ERROR AND NOT PERFORM THE
C     CALCULATION). THE LIST OF SECTIONS IS TERMINATED BY A BLANK LINE.
C
C     THE LIST OF SECTIONS TO BE COMBINED MAY BE SPECIFIED IN ANY
C     ORDER, I.E. THEY NEED NOT BE IN ZA ORDER OR THE ORDER THAT THE
C     EVALUATED DATA APPEARS ON THE ENDF/B FORMATTED TAPE.
C
C     EXAMPLE INPUT NO. 1
C     -------------------
C     CREATE THE TOTAL CROSS SECTION (MT=1) FOR STAINLESS STEEL AND
C     IDENTIFY THE COMBINED MATERIAL WITH ZA=26800 AND MAT=4000,
C     THE COMPOSITION BY VOLUME OF THE STEEL WILL BE...
C
C     THE DATA FROM \ENDFB6\K300\LIBRARY.DAT AND WRITE DATA TO
C     \MIXER\STEEL.DAT
C
C     IRON      - 74.8 PER-CENT
C     CHROMIUM  - 16.0
C     NICKEL    -  6.0
C     MANGANESE -  2.0
C     SILICON   -  1.0
C     CARBON    -  0.2
C
C     THE INPUT MUST SPECIFY THE COMPOSITION BY GRAMS OR ATOMS. THIS IS
C     DEFINED AS THE PRODUCT OF THE STANDARD DENSITY (GRAMS)
C     TIMES THE VOLUME FRACTION. FOR THIS EXAMPLE THE FOLLOWING 12
C     INPUT CARDS ARE REQUIRED....
C
C     STAINLESS STEEL. COMPOSITION BY PER-CENT VOLUME IS 74.8-IRON,
C     16-CHROME, 6-NICKEL, 2-MANGANESE, 1-SILICON, 0.2-CARBON
C     \ENDFB6\K300\LIBRARY.DAT
C     \MIXER\STEEL.DAT
C          26800  4000 3  1          0
C          26000          1 5.88676    (NOTE, GRAMS INPUT FOR EACH
C          24000          1 1.150448    CONSTITUENT, E.G. FOR IRON THE
C          28000          1 0.533928    STP DENSITY IS 7.87 GRAMS.
C          25055          1 0.1486      THE INPUT VALUE OF 5.88676 IS
C          14000          1 0.0233      0.748 X 7.87,I.E.  VOLUME
C           6012          1 0.0044958   FRACTION TIMES STP DENSITY).
C                                     (BLANK LINE TERMINATES INPUT LIST)
C
C     EXAMPLE INPUT NO. 2
C     -------------------
C     THE SAME EXAMPLE AS THE ABOVE PROBLEM, ONLY USE THE STANDARD
C     ENDF/B DATA FILENAMES - ENDFB.IN AND ENDFB.OUT (THIS CAN BE
C     DONE BY LEAVING THE THIRD AND FOURTH INPUT LINES BLANK).
C     FOR THIS EXAMPLE THE FOLLOWING 12 INPUT CARDS ARE REQUIRED....
C
C     STAINLESS STEEL. COMPOSITION BY PER-CENT VOLUME IS 74.8-IRON,
C     16-CHROME, 6-NICKEL, 2-MANGANESE, 1-SILICON, 0.2-CARBON
C     (NOTE - THIS LINE IS REALLY BLANK)
C     (NOTE - THIS LINE IS REALLY BLANK)
C          26800  4000 3  1
C          26000          1 5.88676    (NOTE, GRAMS INPUT FOR EACH
C          24000          1 1.150448    CONSTITUENT, E.G. FOR IRON THE
C          28000          1 0.533928    STP DENSITY IS 7.87 GRAMS.
C          25055          1 0.1486      THE INPUT VALUE OF 5.88676 IS
C          14000          1 0.0233      0.748 X 7.87,I.E.  VOLUME
C           6012          1 0.0044958   FRACTION TIMES STP DENSITY).
C                                     (BLANK LINE TERMINATES INPUT LIST)
C
C=======================================================================
      INCLUDE 'implicit.h'
C-----08/08/2012 DEFINE CODE NAME
      CHARACTER*8 CODENAME
      COMMON/NAMECODE/CODENAME
      CHARACTER*72 NAMEIN,NAMEOUT
      INTEGER*4 OUTP,OTAPE
      COMMON/GOOFIE/IGOOF
      COMMON/ENDFIO/INP,OUTP,ITAPE,OTAPE
      COMMON/IOSTATUS/ISTAT1,ISTAT2
      COMMON/NAMEX/NAMEIN,NAMEOUT
      INCLUDE 'mixer.h'
C-----08/08/2012 DEFINE CODE NAME
      CODENAME = 'MIXER   '
C-----INITIALIZE TIMER
      CALL TIMER
c-----------------------------------------------------------------------
C
C     DEFINE INPUT AND FILES AND OPTIONALLY DEFINE FILENAMES.
C
c-----------------------------------------------------------------------
      CALL FILIO1
C-----IDENTIFY CODE
      WRITE(OUTP,50)
      WRITE(   *,50)
c-----------------------------------------------------------------------
C
C     TERMINATE IF ERROR OPENING INPUT FILE
C
c-----------------------------------------------------------------------
      IF(ISTAT1.EQ.1) THEN
      WRITE(OUTP,10)
      WRITE(   *,10)
   10 FORMAT(//' ERROR - Opening MIXER.INP input parameter file'//)
      CALL ENDERROR
      ENDIF
c-----------------------------------------------------------------------
C
C     DEFINE SCRATCH PAGE SIZE.
C
c-----------------------------------------------------------------------
      NPAGE=MAXPOINT
      NPAGEM=NPAGE-1
C-----READ ALL INPUT PARAMETERS.
      CALL READIN
      IF(IGOOF.LE.0) GO TO 20
      CALL ENDERROR
c-----------------------------------------------------------------------
C
C     DEFINE ENDFB DATA AND ALL SCRATCH FILE UNITS AND OPTIONALLY DEFINE
C     FILENAMES.
C
c-----------------------------------------------------------------------
   20 CALL FILIO2
c-----------------------------------------------------------------------
C
C     TERMINATE IF ERROR OPENING FILE
C
c-----------------------------------------------------------------------
      IF(ISTAT2.EQ.1) THEN
      WRITE(OUTP,30) NAMEIN
      WRITE(   *,30) NAMEIN
   30 FORMAT(//' ERROR - Opening ENDF/B formatted file'/1X,A72//)
      CALL ENDERROR
      ENDIF
c-----------------------------------------------------------------------
C
C     OTHERWISE, START RUN
C
c-----------------------------------------------------------------------
C-----FIND EVALUATED DATA IN ENDF/B FORMAT.
      CALL GETIT
C-----COMBINE CROSS SECTIONS.
      CALL MIXIT
C-----WRITE OUT CROSS SECTIONS IN ENDF/B FORMAT.
      CALL OUTIT
c-----------------------------------------------------------------------
C
C     END OF RUN.
C
c-----------------------------------------------------------------------
   40 call maxie4(1)
      CALL ENDIT
      GO TO 40    ! CANNOT GET TO HERE
   50 FORMAT(' Mix Energy Dependent ENDF/B Cross Sections',
     1 ' (MIXER 2021-1)'/1X,78('-'))
      END
      SUBROUTINE READIN
C=======================================================================
C
C     READ INPUT PARAMETERS.
C
C=======================================================================
      INCLUDE 'implicit.h'
      INTEGER*4 OUTP,OTAPE
      CHARACTER*1 FIELD6
      CHARACTER*4 TITLE
      CHARACTER*72 NAMEIN,NAMEOUT
      COMMON/ENDFIO/INP,OUTP,ITAPE,OTAPE
      COMMON/OUTMEI/IZAOUT,MATOUT,MFOUT,MTOUT,MYTYPE
      COMMON/OUTMEF/DENOUT,ATOMBC,AWROUT
      COMMON/GOOFIE/IGOOF
      COMMON/TELLIT/TITLE(34)
      COMMON/NAMEX/NAMEIN,NAMEOUT
      COMMON/FIELDC/FIELD6(11,6)
      INCLUDE 'mixer.h'
C-----INITIALIZE INPUT ERROR FLAG.
      IGOOF=0
C-----READ TWO LINE IDENTIFICATION FOR PROBLEM.
      READ(INP,10,END=130,ERR=130) TITLE
   10 FORMAT(17A4)                     ! 66 Columns for ENDF Format
C-----PRINT TITLE FOR OUTPUT REPORT.
      WRITE(OUTP,160) TITLE
      WRITE(*   ,160) TITLE
c-----------------------------------------------------------------------
C
C     READ ENDF/B FILE NAMES AND USE DEFAULT IF BLANK.
C
c-----------------------------------------------------------------------
C-----INPUT DATA.
      READ(INP,20,END=130,ERR=130) NAMEIN
   20 FORMAT(A72)
      IF(NAMEIN.EQ.' ') NAMEIN = 'ENDFB.IN'
C-----OUTPUT DATA.
      READ(INP,20,END=130,ERR=130) NAMEOUT
      IF(NAMEOUT.EQ.' ') NAMEOUT = 'ENDFB.OUT'
C-----PRINT FINAL FILENAMES
      WRITE(OUTP,30) NAMEIN,NAMEOUT
      WRITE(*   ,30) NAMEIN,NAMEOUT
   30 FORMAT(
     1 ' ENDF/B Input and Output Data Filenames'/1x,78('-')/1X,A72/
     2 1X,A72)
c-----------------------------------------------------------------------
C
C     READ IDENTIFICATION FOR COMBINED MATERIAL.
C
c-----------------------------------------------------------------------
      WRITE(OUTP,170)
      WRITE(*   ,170)
      READ(INP,40,END=130,ERR=130) IZAOUT,MATOUT,MFOUT,MTOUT,MYTYPE
   40 FORMAT(I11,I6,I2,I3,I11)
c             11 17 19 22  33
C-----ASSUME STANDARD VALUES IF NOT DEFINED.
      IF(IZAOUT.LE.0) IZAOUT=1
      IF(MATOUT.LE.0) MATOUT=1
      IF(MFOUT.NE.3.AND.MFOUT.NE.23) MFOUT=3
      IF(MTOUT.LE.0) MTOUT=1
C-----READ, CHECK MATERIALS LIST AND CALCULATE OUTPUT DENSITY.
      SUMIN=0.0d0
      DO 80 NMAT=1,10
c-----2017/5/6 - Changed all floating point to character
      READ(INP,50,END=100,ERR=100) IZAGET(NMAT),MTGET(NMAT),
     1 (FIELD6(j,1),j=1,11)
   50 FORMAT(I11,7X,I4,11A1)
      CALL IN9(DENSE(NMAT),FIELD6(1,1))
c-----2017/5/6 - ss Read Changed all floating point to character
C-----TREAT BLANK (OR ZERO) LINE AS END OF MATERIAL LIST.
      IF(IZAGET(NMAT).EQ.0.AND.MTGET(NMAT).EQ.0.AND.
     1 DENSE(NMAT).EQ.0.0d0) GO TO 100
C-----TREAT NON-POSITIVE ZA, MT OR DENSITY AS ERROR.
      IF(IZAGET(NMAT).GT.0.AND.MTGET(NMAT).GT.0.AND.
     1 DENSE(NMAT).GT.0.0d0) GO TO 60
      IGOOF=1
      CALL OUT9(DENSE(NMAT),FIELD6(1,1))
      WRITE(OUTP,200) IZAGET(NMAT),MFOUT,MTGET(NMAT),
     1 (FIELD6(M,1),M=1,11)
      WRITE(*   ,200) IZAGET(NMAT),MFOUT,MTGET(NMAT),
     1 (FIELD6(M,1),M=1,11)
      GO TO 70
   60 CALL OUT9(DENSE(NMAT),FIELD6(1,1))
      IF(MYTYPE.EQ.0) THEN
C-----GRAMS
      WRITE(OUTP,180) IZAGET(NMAT),MFOUT,MTGET(NMAT),
     1 (FIELD6(M,1),M=1,11)
      WRITE(*   ,180) IZAGET(NMAT),MFOUT,MTGET(NMAT),
     1 (FIELD6(M,1),M=1,11)
      ELSE
C-----ATOMS
      WRITE(OUTP,190) IZAGET(NMAT),MFOUT,MTGET(NMAT),
     1 (FIELD6(M,1),M=1,11)
      WRITE(*   ,190) IZAGET(NMAT),MFOUT,MTGET(NMAT),
     1 (FIELD6(M,1),M=1,11)
      ENDIF
   70 SUMIN=SUMIN+DENSE(NMAT)
   80 CONTINUE
C-----10 MATERIALS READ. NEXT LINE MUST BE BLANK, OR ELSE THERE IS AN
C-----ERROR.
c-----2017/5/6 - Changed all floating point to character
      READ(INP,50,END=90,ERR=90) IZADUM,MTDUM,(FIELD6(j,1),j=1,11)
      CALL IN9(DENDUM,FIELD6(1,1))
c-----2017/5/6 - Changed all floating point to character
      IF(IZADUM.LE.0.AND.MTDUM.LE.0.AND.DENDUM.LE.0.0d0) GO TO 90
      WRITE(OUTP,230)
      WRITE(*   ,230)
      IGOOF=1
      GO TO 120
   90 NMAT=11
  100 IF(IGOOF.GT.0) GO TO 120
C-----DEFINE NUMBER OF MATERIALS. STOP IF LESS THAN ONE.
      NMAT=NMAT-1
c-----2020/6/12 - Decreased from 2 to 1
      IF(NMAT.GE.1) GO TO 110
      WRITE(OUTP,150) NMAT
      WRITE(*   ,150) NMAT
      IGOOF=1
      GO TO 120
C-----PRINT TITLE FOR OUTPUT REPORT.
  110 CALL OUT9(SUMIN,FIELD6(1,1))
      IF(MYTYPE.EQ.0) THEN
      WRITE(OUTP,210) IZAOUT,MFOUT,MTOUT,(FIELD6(M,1),M=1,11)
      WRITE(*   ,210) IZAOUT,MFOUT,MTOUT,(FIELD6(M,1),M=1,11)
      ELSE
      WRITE(OUTP,220) IZAOUT,MFOUT,MTOUT,(FIELD6(M,1),M=1,11)
      WRITE(*   ,220) IZAOUT,MFOUT,MTOUT,(FIELD6(M,1),M=1,11)
      ENDIF
  120 RETURN
C-----------------------------------------------------------------------
C
C     END OF FILE WHILE READING INPUT
C
C-----------------------------------------------------------------------
  130 WRITE(OUTP,140)
      WRITE(   *,140)
  140 FORMAT(//' ERROR - End of file reading MIXER.INP'//)
      CALL ENDERROR
      RETURN
  150 FORMAT(' Material Count=',I2,' (MUST be at Least 1)')
  160 FORMAT(' Problem Identification'/
     2 1X,78('-')/1X,17A4/1X,17A4/1X,78('-'))
  170 FORMAT(1X,78('-')/
     1 ' Requested Composition (Input Parameters)'/1X,78('-')/
     2 '     ZA MF  MT'/1X,78('-'))
  180 FORMAT(I7,I3,I4,11A1,' Grams')
  190 FORMAT(I7,I3,I4,11A1,' Atoms')
  200 FORMAT(I7,I3,I4,11A1,
     1 ' (ERROR in Data - All MUST be Positive)')
  210 FORMAT(1X,78('-')/I7,I3,I4,11A1,' Grams'/1X,78('-')/
     1 ' Processing ENDF Input Data'/1X,78('-')/
     2 '     ZA  MAT MF  MT     Kelvin     Q-Value Points AMU-Weight',
     3 ' Atoms/b-cm *'/40X,'eV'/1X,78('-'))
  220 FORMAT(1X,78('-')/I7,I3,I4,11A1,' Atoms'/1X,78('-')/
     1 ' Processing ENDF Input Data'/1X,78('-')/
     2 '     ZA  MAT MF  MT     Kelvin     Q-Value Points AMU-Weight',
     3 ' Atoms/b-cm *'/40X,'eV'/1X,78('-'))
  230 FORMAT(///' Over 10 Materials in Composition - ',
     1 'Execution Terminated.')
      END
      SUBROUTINE GETIT
C=======================================================================
C
C     READ ALL REQUESTED REACTIONS AND LOAD INTO CORE (60000 OR FEWER
C     POINTS) OR SCRATCH FILE (MORE THAN 60000 POINTS).
C
C     IF ALL REQUESTED REACTIONS ARE FOUND CONTROL WILL BE RETURNED TO
C     THE MAIN PROGRAM. OTHERWISE AN ERROR MESSAGE WILL BE PRINTED AND
C     EXECUTION WILL BE TERMINATED.
C
C=======================================================================
      INCLUDE 'implicit.h'
      INTEGER*4 OUTP,OTAPE
      CHARACTER*1 FIELD6
      COMMON/ENDFIO/INP,OUTP,ITAPE,OTAPE
      COMMON/HEADER/ZA,AWRIN,L1H,L2H,N1H,N2H,MATH,MFH,MTH,NOSEQ
      COMMON/LEADER/C1,C2,L1,L2,N1,N2,MAT,MF,MT
      COMMON/OUTMEI/IZAOUT,MATOUT,MFOUT,MTOUT,MYTYPE
      COMMON/OUTMEF/DENOUT,ATOMBC,AWROUT
      COMMON/GOOFIE/IGOOF
      COMMON/WHATZA/IZA
      COMMON/FIELDC/FIELD6(11,6)
      INCLUDE 'mixer.h'
c-----2019/3/1 - Initialize MT count
      call maxie0
c-----------------------------------------------------------------------
C
C     INITIALIZE ALL POINT COUNTS AND MIXED ATOMIC WEIGHT.
C
c-----------------------------------------------------------------------
C-----INITIALIZE ERROR FLAG OFF.
      IGOOF=0
C-----INITIALIZE INPUT DATA PARAMETERS.
      DO 10 IMAT=1,NMAT
      NPTAB(IMAT)   = 0
      MATGET(IMAT)  = 0
      IVERSE(IMAT)  = 6
      QVALUE1(IMAT) = 0.0d0
      QVALUE2(IMAT) = 0.0d0
      TEMPK(IMAT)   = 0.0d0
      ATOM10(IMAT)  = 0.0d0
      AWRE(IMAT)    = 0.0d0
   10 CONTINUE
C-----INITIALIZE OUTPUT DATA PARAMETERS.
      ATOMBC        = 0.0d0
      DENOUT        = 0.0d0
C-----SKIP ENDF/B TAPE LABEL.
      CALL SKIP1
c-----------------------------------------------------------------------
C
C     FIND NEXT REQUESTED SECTION Based on ZA
C
c-----------------------------------------------------------------------
C-----READ SECTION HEAD LINE OR END LINE (SEND,FEND,MEND,TEND)
   20 CALL CONTI
      IF(MTH.GT.0) GO TO 30   ! Skip to section (MT>0) or TEND
      IF(MATH.lt.0) go to 120 ! TEND?
      go to 20
C-----SECTION HEAD LINE. IF NOT ONE OF THE REQUESTED ZA SKIP ENTIRE MAT.
   30 IZA=ZA
      DO 40 IMAT=1,NMAT
      IF(IZA.eq.IZAGET(IMAT)) go to 50
   40 CONTINUE
C-----SKIP MATERIAL.
      CALL SKIPM
      GO TO 20
c-----------------------------------------------------------------------
C
C     REQUESTED ZA FOUND. LOCATE FILE 3 OR 23 DATA - WHICHEVER WAS
C     REQUESTED.
C
c-----------------------------------------------------------------------
c-----Allow more than 1 request with same ZA - define MAT for ALL
   50 DO I=1,NMAT
      IF(IZA.eq.IZAGET(I)) then
c-----Only define and add DENSITY & AWRE
      IF(MATGET(I).le.0) then
C-----DEFINE ATOMIC WEIGHT RATIO IN ATOMIC MASS UNITS
C-----(INSTEAD OF ENDF/B CONVENTION OF NEUTRON MASS UNITS).
      AWRE(I)=1.008665d0*AWRIN
      IF(MYTYPE.EQ.0) THEN
C-----INPUT IS GRAMS - DERIVE ATOMS
      ATOM10(I)=0.60247d0*DENSE(I)/AWRE(I)
      ELSE
C-----INPUT IS ATOMS - DERIVE GRAMS
      ATOM10(I)= DENSE(I)
      DENSE(I) = AWRE(I)*ATOM10(I)/0.60247d0
      ENDIF
      ATOMBC = ATOMBC + ATOM10(IMAT)
      DENOUT = DENOUT + DENSE(IMAT)
      endif
      MATGET(I) = MATH
      endif
      ENDDO
C-----FOR NEUTRONS READ FILE 1 TO DEFINE TEMPERATURE & ENDF Format
      IF(MFOUT.NE.3) GO TO 60
      IF(MFH.NE.1) GO TO 60
      CALL FILE1IN(IMAT)
c-----Allow more than 1 request with same ZA - design MAT for ALL
      DO I=1,NMAT
      IF(IZA.eq.IZAGET(I)) then
      IVERSE(I) = IVERSE(IMAT)
      TEMPK(I)  = TEMPK(IMAT)
      ENDIF
      ENDDO
      CALL SKIPF
      go to 20
c-----Not MF=1 - Position to requested MFOUT
   60 IF(MFH.lt.MFOUT) go to 70
      IF(MFH.eq.MFOUT) go to 80
C-----SKIP MATERIAL.
      CALL SKIPM
      GO TO 20
C-----SKIP FILE.
   70 CALL SKIPF
      go to 20
c-----------------------------------------------------------------------
C
C     FILE 3 OR 23 FOUND. LOCATE REQUIRED REACTION.
C
c-----------------------------------------------------------------------
C-----CHECK FOR REQUESTED ZA, MT.
   80 DO 90 IMAT=1,NMAT
      IF(IZAGET(IMAT).NE.IZA.OR.MTGET(IMAT).NE.MTH) GO TO 90
      IF(NPTAB(IMAT).LE.0) GO TO 100
   90 CONTINUE
C-----SECTION NOT REQUESTED - or Already Found = Skip it.
      CALL SKIPS
      go to 20
C-----SECTION REQUESTED. READ AND CHECK IT.
  100 CALL CARDI(QVALUE1(IMAT),QVALUE2(IMAT),L1,L2,N1,N2)
c-----Allow more than 1 request with same ZA - design MAT for ALL
      CALL TERPI(NBT,INT,N1)
c-----2019/1/3 - Additional Interpolation Law Tests
      CALL TERPTEST(NBT,INT,N1,N2,3) ! MUST be INT = 2
      NPTAB(IMAT)=N2
      CALL OUT9(TEMPK (IMAT),FIELD6(1,1))
      CALL OUT9(QVALUE2(IMAT),FIELD6(1,2))
      CALL OUT9(AWRE  (IMAT),FIELD6(1,3))
      CALL OUT9(ATOM10(IMAT),FIELD6(1,4))
      MATGET(IMAT)=MATH
      WRITE(OUTP,210) IZAGET(IMAT),MATGET(IMAT),MFOUT,MTGET(IMAT),
     1 ((FIELD6(M,I),M=1,11),I=1,2),NPTAB(IMAT),
     2 ((FIELD6(M,I),M=1,11),I=3,4)
      WRITE(*   ,210) IZAGET(IMAT),MATGET(IMAT),MFOUT,MTGET(IMAT),
     1 ((FIELD6(M,I),M=1,11),I=1,2),NPTAB(IMAT),
     2 ((FIELD6(M,I),M=1,11),I=3,4)
c-----2019/3/1 - Save MA, MF, MT
      call maxie1(MATH,MFH,MTH)
C-----READ REACTION DATA.
      CALL IPAG10(IMAT)
c-----------------------------------------------------------------------
C
C     DETERMINE IF THERE ARE ANYMORE SECTIONS FROM CURRENT MATERIAL
C     OR ANY MORE SECTIONS FROM ANY OTHER MATERIAL.
C
c-----------------------------------------------------------------------
      DO 110 I=1,NMAT
      IF(NPTAB(I).LE.0) THEN
      CALL SKIPS
      go to 20
      ENDIF
  110 CONTINUE
c-----------------------------------------------------------------------
C
C     ALL ENDF DATA READ. TERMINATE IF ANY ERROR IN EVALUATED DATA.
C     IF DATA IS O.K. DEFINE AVERAGE ATOMIC WEIGHT RATIO BASED ON
C     DENSITY AND ATOMS
C
c-----------------------------------------------------------------------
      IF(IGOOF.NE.0) GO TO 140
      AWROUT=0.60247d0*DENOUT/ATOMBC
      RETURN
c-----------------------------------------------------------------------
C
C     TEND = Check Data.
C
c-----------------------------------------------------------------------
c
C     CANNOT LOCATE ALL DATA TO BE MIXED.
c
  120 IGOOF  = 0
      IFOUND = 0
      DO 130 IMAT=1,NMAT
      IF(NPTAB(IMAT).GT.0) then
      IFOUND = IFOUND + 1                       ! Count those found
      go to 130
      ELSE
      CALL OUT9(TEMPK (IMAT),FIELD6(1,1))       ! Data not found
      CALL OUT9(QVALUE2(IMAT),FIELD6(1,2))
      CALL OUT9(AWRE  (IMAT),FIELD6(1,3))
      CALL OUT9(ATOM10(IMAT),FIELD6(1,4))
      WRITE(OUTP,210) IZAGET(IMAT),MATGET(IMAT),MFOUT,MTGET(IMAT),
     1 ((FIELD6(M,I),M=1,11),I=1,2),NPTAB(IMAT),
     2 ((FIELD6(M,I),M=1,11),I=3,4)
      WRITE(*   ,210) IZAGET(IMAT),MATGET(IMAT),MFOUT,MTGET(IMAT),
     1 ((FIELD6(M,I),M=1,11),I=1,2),NPTAB(IMAT),
     2 ((FIELD6(M,I),M=1,11),I=3,4)
      if(MATGET(IMAT).le.0) then
c-----Missing ZA
      WRITE(OUTP,190) IZAGET(IMAT),IZAGET(IMAT)
      WRITE(*   ,190) IZAGET(IMAT),IZAGET(IMAT)
      IGOOF = IGOOF + 1
      else
c-----Missing MF/MT
      WRITE(OUTP,200) IZAGET(IMAT),MATGET(IMAT),IZAGET(IMAT),MFOUT,
     1 MTGET(IMAT)
      WRITE(*   ,200) IZAGET(IMAT),MATGET(IMAT),IZAGET(IMAT),MFOUT,
     1 MTGET(IMAT)
      endif
      endif
  130 CONTINUE
c
c     TERMINATE IF ANY ZA MISSING
c
      if(IGOOF.gt.0) then
      WRITE(OUTP,170)
      WRITE(*   ,170)
      CALL ENDERROR
      endif
c-----All ZA found - If any data found, use it
      if(IFOUND.gt.0) go to 150
c
C     Terminate if NO DATA FOUND.
c
      WRITE(OUTP,180)
      WRITE(*   ,180)
      CALL ENDERROR
c
C     TERMINATED DUE TO ERROR IN EVALUATED DAT (IGOOF)
c
  140 WRITE(OUTP,220)
      WRITE(*   ,220)
      CALL ENDERROR
c
c     Use the data that was found
c
  150 AWROUT=0.60247d0*DENOUT/ATOMBC
      if(IFOUND.lt.NMAT) then
      write(outp,160)
      write(*   ,160)
      endif
      RETURN
  160 format(1x,78('-')/' WARNING - Output includes ONLY data found')
  170 format(1x,78('-')/' ERROR - Missing ZA - Check ENDF Data')
  180 FORMAT(1X,78('-')/' ERROR - NO data found to MIX')
  190 FORMAT(I7,9X,   ' ERROR - ENDF Data Does not include ZA=',I7)
  200 FORMAT(I7,I5,4X,' WARNING - ZA=',I7,' Does not include',
     1 ' MF/MT=',i2'/',i3)
  210 FORMAT(I7,I5,I3,I4,11A1,1x,11A,I7,22A1)
  220 FORMAT(1X,78('-')/' Execution Terminated due to ERROR in',
     1 ' Evaluated Data')
      END
      SUBROUTINE FILE1IN(IMAT)
C=======================================================================
C
C     DEFINE ENDF/B FORMAT VERSION AND TEMPERATURE
C
C=======================================================================
      INCLUDE 'implicit.h'
      COMMON/LEADER/C1,C2,L1,L2,N1,N2,MAT,MF,MT
      INCLUDE 'mixer.h'
C-----FIRST LINE HAS BEEN READ - READ SECOND LINE
      CALL CARDI(C1,C2,L1,L2,N1,N2)
      IVERSE(IMAT)=4
C-----CHECK FOR ENDF/B-IV
      IF(N1.GT.0) RETURN
      N2X=N2
      CALL CARDI(C1,C2,L1,L2,N1,N2)
      IVERSE(IMAT)=5
C-----CHECK FOR ENDF/B-V
      IF(N2X.LE.0) RETURN
C-----ENDF/B-VI FORMAT
      CALL CARDI(C1,C2,L1,L2,N1,N2)
      IVERSE(IMAT)=6
      TEMPK(IMAT)=C1
      RETURN
      END
      SUBROUTINE IPAG10(ITYPE)
C=======================================================================
C
C     READ ONE SECTION OF DATA. IF 60000 OR FEWER POINTS IT WILL BE
C     TOTALLY CORE RESIDENT. IF OVER 60000 POINTS IT WILL BE WRITTEN TO
C     A SRATCH FILE. AFTER THE ENTIRE SECTION HAS BEEN WRITTEN TO
C     SCRATCH THE FIRST PAGE (FIRST 60000 POINTS) WILL BE READ BACK INTO
C     CORE.
C
C=======================================================================
      INCLUDE 'implicit.h'
      COMMON/LASTE/ELAST
      INCLUDE 'mixer.h'
C-----DEFINE CONVERSION FACTOR TO ATOM FRACTION
C-----2008/5/12 - CHANGED TO ALLOW GRAMS OR ATOM INPUT
      FACTOR=ATOM10(ITYPE)
C-----DEFINE SCRATCH UNIT NUMBER.
      NSCR=ISCR(ITYPE)
C-----INITIALIZE LAST ENERGY (FOR ENERGY ORDER TEST).
      ELAST=0.0d0
C-----SET UP LOOP OVER PAGES.
      N2IN=NPTAB(ITYPE)
      DO 20 NPT=1,N2IN,NPAGE
C-----READ NEXT PAGE.
      NNPT=NPT+NPAGEM
      IF(NNPT.GT.N2IN) NNPT=N2IN
      IHIGH=NNPT-NPT+1
      CALL POINTI(XTAB(1,ITYPE),YTAB(1,ITYPE),IHIGH)
C-----CONVERT CROSS SECTION TO MACROSCOPIC FORM.
      DO 10 I=1,IHIGH
      YTAB(I,ITYPE)=FACTOR*YTAB(I,ITYPE)
   10 CONTINUE
C-----IF OVER ONE PAGE OF DATA MOVE IT TO SCRATCH FILE.
      IF(N2IN.LE.NPAGE) GO TO 20
      IF(NPT.EQ.1) REWIND NSCR
      CALL ODUMP(NSCR,XTAB(1,ITYPE),YTAB(1,ITYPE),NPAGE)
   20 CONTINUE
c-----------------------------------------------------------------------
C
C     2019/2/17 - save highest energy and value
C
c-----------------------------------------------------------------------
      call maxie2(XTAB(IHIGH,ITYPE),YTAB(IHIGH,ITYPE))
c-----------------------------------------------------------------------
c
c     IS CROSS SECTION IN CORE OR ON SCRATCH.
c
c-----------------------------------------------------------------------
      IF(N2IN.GT.NPAGE) GO TO 30
C-----IN CORE.
      IXYLOW(ITYPE)=0
      IXYHI(ITYPE)=N2IN
      RETURN
C-----ON SCRATCH. LOAD FIRST PAGE.
   30 END FILE NSCR
      REWIND NSCR
      CALL IDUMP(NSCR,XTAB(1,ITYPE),YTAB(1,ITYPE),NPAGE)
      IXYLOW(ITYPE)=0
      IXYHI(ITYPE)=NPAGE
      RETURN
      END
      SUBROUTINE MIXIT
C=======================================================================
C
C     THIS SUBROUTINE IS DESIGNED TO ADD TOGETHER UP TO TEN DIFFERENT
C     CROSS SECTIONS USING LINEAR INTERPOLATION BETWEEN TABULATED
C     VALUES. FOR ENERGIES BELOW THE FIRST POINT OF EACH CROSS SECTION
C     IT WILL BE CONTINUED AS 0.0. FOR ENERGIES ABOVE THE LAST POINT
C     OF EACH CROSS SECTION IT WILL BE CONTINUED AS ZERO.
C
C=======================================================================
      INCLUDE 'implicit.h'
      INTEGER*4 OUTP,OTAPE
      CHARACTER*1 FIELD6
      COMMON/ENDFIO/INP,OUTP,ITAPE,OTAPE
      COMMON/FIELDC/FIELD6(11,6)
c-----2019/3/1 = MT table
      COMMON/MAXIECOM/XMAXIE(999),YMAXIE(999),MATMAXIE(999),
     1 MFMAXIE(999),MTMAXIE(999)
      COMMON/EMAXCOM/XMAXIMUM
c-----2019/3/3 - Flag to extend to XMAXIMUM
      DIMENSION IXTEND(10)
      INCLUDE 'mixer.h'
      DATA XNOW/0.0d0/
c-----------------------------------------------------------------------
c
c     2019/2/17 - Check high energy cutoff, in case ALL = 0 upper limit.
c                 If so, use highest tabulated energy.
c
c-----------------------------------------------------------------------
      call maxie3(1)
c-----2019/3/3 - Flag to extend to XMAXIMUM as = 0.
c-----2020/6/14 - First first read data (NPTAB > 0)
      IMFIRST = 0
      do 10 IMAT=1,NMAT
      IXTEND(IMAT) = 0
      if(NPTAB(IMAT).le.0) go to 10
      if(IMFIRST.le.0) IMFIRST = IMAT          ! Define FIRST real data
      if(XMAXIE(IMAT).lt.XMAXIMUM) then
      if(YMAXIE(IMAT).gt.0.0d0) IXTEND(IMAT) = 1
      endif
   10 continue
c-----------------------------------------------------------------------
c
c     Process ENDF Output MIX
c
c-----------------------------------------------------------------------
      write(outp,20)
      write(*   ,20)
   20 format(1x,78('-')/' Processing ENDF Output MIX'/1X,78('-')/
     2 '     ZA  MAT MF  MT     Kelvin     Q-Value Points AMU-Weight',
     3 ' Atoms/b-cm *'/40X,'eV')
c-----------------------------------------------------------------------
C
C     INITIALIZE INDICES AND DEFINE FIRST VALUES.
C
c-----------------------------------------------------------------------
      NPTAB(IUSEN)=0
      IXYLOW(IUSEN)=0
      IXYHI(IUSEN)=0
      IPTN=0
      NSCR=ISCR(IUSEN)
      DO 30 IMAT=1,NMAT
      IPTAB(IMAT)=1
      if(NPTAB(IMAT).le.0) go to 30
      CALL OPAG10(1,IUSE(IMAT),XA(IMAT),YA(IMAT))
   30 CONTINUE
c-----------------------------------------------------------------------
C
C     SELECT LOWEST ENERGY.
C
c-----------------------------------------------------------------------
   40 XLAST=XNOW
      XNOW=XA(IMFIRST)
      DO 50 IMAT=1,NMAT
      if(NPTAB(IMAT).le.0) go to 50
      IF(XA(IMAT).LT.XNOW) XNOW=XA(IMAT)
   50 CONTINUE
c-----------------------------------------------------------------------
C
C     INTERPOLATE TO REQUIRED VALUES. ADVANCE TO NEXT INTERVAL
C     IF CURRENT ONE HAS BEEN USED UP.
C
c-----------------------------------------------------------------------
      DO 100 IMAT=1,NMAT
      if(NPTAB(IMAT).le.0) go to 100
      IF(XA(IMAT).gt.XNOW) go to 70
      YB(IMAT)=YA(IMAT)
      IPTAB(IMAT)=IPTAB(IMAT)+1
      IF(IPTAB(IMAT).LE.NPTAB(IMAT)) GO TO 60
C-----2019/3/3 - EXTEND TO JUMP AT END (ONLY ONCE) OR MAXIMUM ENERGY
      if(IXTEND(IMAT).ne.0) then
      XA(IMAT) = XMAXIE(IMAT)     ! Jump at end
      IXTEND(IMAT) = 0
      ELSE
      XA(IMAT)=XMAXIMUM           ! extend to Maximum
      endif
      YA(IMAT)=0.0d0              ! Both have cross section = 0
c-----2019/2/17 - Do not set YB(IMAT) = 0
      GO TO 100
   60 CALL OPAG10(IPTAB(IMAT),IUSE(IMAT),XA(IMAT),YA(IMAT))
      GO TO 100
c-----05/10/10 - corrected - was IPTAB(1), not IPTAB(IMAT)
   70 IF(IPTAB(IMAT).GT.1) GO TO 80
      YB(IMAT)=0.0d0
      GO TO 100
   80 IF(XA(IMAT).GT.XLAST) GO TO 90
      YB(IMAT)=YA(IMAT)
      GO TO 100
   90 YB(IMAT)=((XNOW-XLAST)*YA(IMAT)+(XA(IMAT)-XNOW)*YB(IMAT))/
     1 (XA(IMAT)-XLAST)
  100 CONTINUE
c-----------------------------------------------------------------------
C
C     IF PAGE IS FULL UNLOAD IT TO SCRATCH.
C
c-----------------------------------------------------------------------
      IF(IPTN.LT.NPAGE) GO TO 110
      IF(NPTAB(IUSEN).EQ.0) REWIND NSCR
      CALL ODUMP(NSCR,XTAB(1,IUSEN),YTAB(1,IUSEN),NPAGE)
      NPTAB(IUSEN)=NPTAB(IUSEN)+IPTN
      IPTN=0
c-----------------------------------------------------------------------
C
C     ADD CONTRIBUTIONS TOGETHER TO DEFINE NEXT COMBINED POINT.
C     CHECK ENERGY ORDER.
C
c-----------------------------------------------------------------------
  110 IPTN=IPTN+1
      IMTHRU=0
      SUM=0.0d0
      DO 120 IMAT=1,NMAT
      if(NPTAB(IMAT).le.0) go to 120
      SUM=SUM+YB(IMAT)
      IF(IPTAB(IMAT).LE.NPTAB(IMAT)) IMTHRU=1
  120 CONTINUE
      XTAB(IPTN,IUSEN)=XNOW
      YTAB(IPTN,IUSEN)=SUM
      IF(XNOW.GE.XLAST) GO TO 130
      II=IPTN+NPTAB(IUSEN)
      CALL OUT9(XNOW,FIELD6(1,1))
      WRITE(OUTP,150) II,(FIELD6(M,1),M=1,11)
      WRITE(*   ,150) II,(FIELD6(M,1),M=1,11)
  130 IF(IMTHRU.GT.0) GO TO 40
c-----------------------------------------------------------------------
C
C     END OF TABLE. IF DATA IS NOT CORE RESIDENT MOVE LAST PAGE
C     TO SCRATCH, LOAD FIRST PAGE BACK INTO CORE AND SET INDICES TO
C     FIRST PAGE. IF CORE RESIDENT SET INDICES TO LIMITS OF CORE DATA.
C
c-----------------------------------------------------------------------
      NPTAB(IUSEN)=NPTAB(IUSEN)+IPTN
      IXYLOW(IUSEN)=0
      IF(NPTAB(IUSEN).GT.NPAGE) GO TO 140
      IXYHI(IUSEN)=NPTAB(IUSEN)
      RETURN
  140 CALL ODUMP(NSCR,XTAB(1,IUSEN),YTAB(1,IUSEN),NPAGE)
      IXYHI(IUSEN)=NPAGE
      END FILE NSCR
      REWIND NSCR
      CALL IDUMP(NSCR,XTAB(1,IUSEN),YTAB(1,IUSEN),NPAGE)
      RETURN
  150 FORMAT(16X,' Mixed Energy NOT in Ascending Energy Order',
     1 I6,11A1)
      END
      SUBROUTINE OUTIT
C=======================================================================
C
C     NORMALIZE COMBINED TABLE TO BARNS/ATOM AND OUTPUT IN THE
C     ENDF/B-V FORMAT.
C
C=======================================================================
      INCLUDE 'implicit.h'
      INTEGER*4 OUTP,OTAPE
      CHARACTER*1 FIELD6,PROGDOC1
      CHARACTER*4 TITLE
      CHARACTER*66 TLABEL,PROGDOC
      COMMON/ENDFIO/INP,OUTP,ITAPE,OTAPE
      COMMON/HEADER/ZA,AWRIN,L1H,L2H,N1H,N2H,MATH,MFH,MTH,NOSEQ
      COMMON/OUTMEI/IZAOUT,MATOUT,MFOUT,MTOUT,MYTYPE
      COMMON/OUTMEF/DENOUT,ATOMBC,AWROUT
      COMMON/TELLIT/TITLE(34)
      COMMON/FIELDC/FIELD6(11,6)
c-----2019/3/1 = Maximum Tabulated Energy
      COMMON/EMAXCOM/XMAXIMUM
      INCLUDE 'mixer.h'
      DIMENSION NBTX(1),INTX(1),PROGDOC(9),PROGDOC1(66,9)
      EQUIVALENCE (PROGDOC(1),PROGDOC1(1,1))
      DATA IZERO/0/
      DATA NFOR/6/
      DATA LDRV/1/
      DATA ZERO/0.0d0/
      DATA MF1/1/
      DATA MT451/451/
      DATA IONE/1/
      DATA ITWO/2/
      DATA INTX/2/
C-----DEFINE NSUB ZA FOR NEUTRONS AND PHOTONS.
      DATA NSUBN/10/
      DATA NSUBP/0/
      DATA TLABEL/
     1 ' Composite Material in ENDF/B-6 Format                        '/
c-----------------------------------------------------------------------
c
C     DOCUMENTATION TO ADD TO ENDF/B OUTPUT - EACH LINE IS 66
C     CHARACTERS LONG - FIELDS 12345678901 ARE FILLED IN WITH
C     11 CHARACTERS DURING EXECUTION.
c
c-----------------------------------------------------------------------
C                1         2         3         4         5         6
C       12345678901234567890123456789012345678901234567890123456789012
C       3456
      DATA PROGDOC/
     1 ' ***************** Program MIXER (VERSION 2021-1) ************',
     2 ' ----------------------------------------                     ',
     3 ' Composition                                                  ',
     4 ' ----------------------------------------                     ',
     5 ' Isotope MF   MT  Atom-Fract   Gram-Fract                     ',
     6 ' ----------------------------------------                     ',
     7 '   12345 12  123 12345678901  12345678901                     ',
     8 '                                1        451                  ',
     9 '                                                              '/
C-----FILL IN REMAINDER OF FIRST LINE
      PROGDOC1(63,1) = '*'
      PROGDOC1(64,1) = '*'
      PROGDOC1(65,1) = '*'
      PROGDOC1(66,1) = '*'
c-----------------------------------------------------------------------
C
C     HOLLERITH (MF=1, MT=451) OUTPUT.
C
c-----------------------------------------------------------------------
c-----2020/6/12 - Use lowest defined Q-Values & Temperature
      QVALOUT1 = 1.0d12
      QVALOUT2 = 1.0d12
      TEMPKOUT = 1.0d12
      do i=1,nmat
      if(NPTAB(i).gt.0) then
      if(QVALUE1(i).lt.QVALOUT1) QVALOUT1 = QVALUE1(i)
      if(QVALUE2(i).lt.QVALOUT2) QVALOUT2 = QVALUE2(i)
      if(TEMPK  (i).lt.TEMPKOUT) TEMPKOUT = TEMPK  (i)
      endif
      enddo
      CALL OUT9(TEMPKOUT ,FIELD6(1,1))
      CALL OUT9(QVALOUT2 ,FIELD6(1,2))
      CALL OUT9(AWROUT   ,FIELD6(1,3))
      CALL OUT9(ATOMBC   ,FIELD6(1,4))
      WRITE(OUTP,50) IZAOUT,MATOUT,MFOUT,MTOUT,
     1 ((FIELD6(M,I),M=1,11),I=1,2),
     2 NPTAB(IUSEN),((FIELD6(M,I),M=1,11),I=3,4)
      WRITE(*   ,50) IZAOUT,MATOUT,MFOUT,MTOUT,
     1 ((FIELD6(M,I),M=1,11),I=1,2),
     2 NPTAB(IUSEN),((FIELD6(M,I),M=1,11),I=3,4)
C-----PRINT FRACTIONS.
      WRITE(OUTP,60)
      WRITE(*   ,60)
      DO 10 I=1,NMAT
      FRACTA(I)=ATOM10(I)/ATOMBC
      FRACTG(I)=DENSE(I) /DENOUT
      WRITE(OUTP,70) IZAGET(I),MATGET(I),MFOUT,MTGET(I),
     1 FRACTA(I),FRACTG(I)
      WRITE(*   ,70) IZAGET(I),MATGET(I),MFOUT,MTGET(I),
     1 FRACTA(I),FRACTG(I)
   10 CONTINUE
      SUMA=1.0d0
      SUMG=1.0d0
      WRITE(OUTP,80) IZAOUT,MATOUT,MFOUT,MTOUT,SUMA,SUMG
      WRITE(*   ,80) IZAOUT,MATOUT,MFOUT,MTOUT,SUMA,SUMG
C-----DEFINE WEIGHT IN NEUTRON MASS UNITS FOR OUTPUT.
      ARWMIX=AWROUT/1.008665d0
C-----DEFINE NUMBER OF POINTS IN MIXER CROSS SECTION.
      KPT=NPTAB(IUSEN)
c-----------------------------------------------------------------------
C
C     OUTPUT TAPE LABEL.
C
c-----------------------------------------------------------------------
      MATH=MATOUT
      MFH=0
      MTH=0
      NOSEQ=0
      CALL HOLLYO(TLABEL)
c-----------------------------------------------------------------------
C
C     OUTPUT HOLLERITH DESCRIPTION OF PROBLEM.
C
c-----------------------------------------------------------------------
      NWD=11+NMAT
      ZAOUT=IZAOUT
      MATH=MATOUT
      MFH=MF1
      MTH=MT451
      NOSEQ=1
      NSUB=NSUBN
      IF(MFOUT.EQ.23) NSUB=NSUBP
      CALL CARDO(ZAOUT,ARWMIX,IZERO,IZERO,IZERO,IZERO)
      CALL CARDO(ZERO,ZERO,IZERO,IZERO,IZERO,NFOR)
      XMASS=0.0d0
      IF(MFOUT.EQ.3) XMASS=1.0d0
c-----2019/2/17 - Added ESMALL = upper energy limit
c-----2019/3/1 - Define Maximum Tabulated Cross Section
      CALL CARDO(XMASS,XMAXIMUM,IZERO,IZERO,NSUB,NFOR)
      CALL CARDO(TEMPKOUT,ZERO,LDRV,IZERO,NWD,ITWO)
      CALL HOLLYO(PROGDOC1(1,1))
      CALL HOLLYO(TITLE( 1))
      CALL HOLLYO(TITLE(18))
      CALL HOLLYO(PROGDOC1(1,2))
      CALL HOLLYO(PROGDOC1(1,3))
      CALL HOLLYO(PROGDOC1(1,4))
      CALL HOLLYO(PROGDOC1(1,5))
      CALL HOLLYO(PROGDOC1(1,6))
      DO 20 LMAT=1,NMAT
      FRACTA(LMAT)=ATOM10(LMAT)/ATOMBC
      FRACTG(LMAT)=DENSE (LMAT)/DENOUT
      CALL INTOUT(IZAGET(LMAT),PROGDOC1( 4,7),5)
      CALL INTOUT(MFOUT       ,PROGDOC1(10,7),2)
      CALL INTOUT(MTGET(LMAT) ,PROGDOC1(14,7),3)
      CALL OUT9(FRACTA(LMAT)  ,PROGDOC1(18,7))
      CALL OUT9(FRACTG(LMAT)  ,PROGDOC1(31,7))
      CALL HOLLYO(PROGDOC1(1,7))
   20 CONTINUE
      CALL HOLLYO(PROGDOC1(1,6))
C-----COMPOSITE
      SUMA=1.0d0
      SUMG=1.0d0
      CALL INTOUT(IZAOUT,PROGDOC1( 4,7),5)
      CALL INTOUT(MFOUT ,PROGDOC1(10,7),2)
      CALL INTOUT(MTOUT ,PROGDOC1(14,7),3)
      CALL OUT9(SUMA    ,PROGDOC1(18,7))
      CALL OUT9(SUMG    ,PROGDOC1(31,7))
      CALL HOLLYO(PROGDOC1(1,7))
      CALL HOLLYO(PROGDOC1(1,6))
C-----SECTION DIRECTORY
      CALL INTOUT(NWD+6,PROGDOC1(45,8),11)
      CALL INTOUT(    0,PROGDOC1(56,8),11)
      CALL HOLLYO(PROGDOC1(1,8))
      NLINE=(KPT+11)/3
      CALL INTOUT(MFOUT,PROGDOC1(23,9),11)
      CALL INTOUT(MTOUT,PROGDOC1(34,9),11)
      CALL INTOUT(NLINE,PROGDOC1(45,9),11)
      CALL INTOUT(    0,PROGDOC1(56,9),11)
      CALL HOLLYO(PROGDOC1(1, 9))
C-----OUTPUT SEND AND FEND RECORDS.
      CALL OUTS(MATOUT,MF1)
      CALL OUTF(MATOUT)
c-----------------------------------------------------------------------
C
C     CROSS SECTIONS (MF=3 OR 23).
C
c-----------------------------------------------------------------------
c-----Use
C-----WRITE DATA TABLE.
      MFH=MFOUT
      MTH=MTOUT
      CALL CARDO(ZAOUT,ARWMIX,IZERO,IZERO,IZERO,IZERO)
      CALL CARDO(QVALOUT1  ,QVALOUT2  ,IZERO,IZERO,IONE,KPT)
      NBTX(1)=KPT
      CALL TERPO(NBTX,INTX,1)
C-----DEFINE NORMALIZATION FOR BARNS/ATOM BASED ON EQUIVALENT
C-----ATOMIC WEIGHT AND DENSITY.
      FACTOR=1.0d0/ATOMBC
C-----LOAD AND OUTPUT POINTS ONE PAGE AT A TIME.
      DO 40 LPT=1,KPT,NPAGE
      LPTP2=LPT+NPAGEM
      IF(LPTP2.GT.KPT) LPTP2=KPT
      LX=0
      DO 30 L3=LPT,LPTP2
      LX=LX+1
      CALL OPAG10(L3,IUSEN,XTAB(LX,1),YTAB(LX,1))
      YTAB(LX,1)=FACTOR*YTAB(LX,1)
   30 CONTINUE
      CALL POINTO(XTAB,YTAB,LX)
   40 CONTINUE
C-----OUTPUT SEND, FEND, MEND AND TEND RECORDS.
      CALL OUTS(MATOUT,MFOUT)
      CALL OUTF(MATOUT)
      CALL OUTM
      CALL OUTT
      RETURN
   50 FORMAT(1X,78('-')/I7,I5,I3,I4,11A1,1x,11A1,I7,22A1/1X,78('-')/
     2 ' * - Note b-cm = 1.0E-24 Cubic Centimeters'/1X,78('-'))
   60 FORMAT(' Atom and Gram Fractions'/1X,78('-')/
     1 '     ZA  MAT MF  MT     Atom        Gram'/
     1 22X,'Fraction    Fraction'/1X,78('-'))
   70 FORMAT(I7,I5,I3,I4,2F12.8)
   80 FORMAT(1X,78('-')/I7,I5,I3,I4,2F12.8/1X,78('-'))
      END
      SUBROUTINE OPAG10(I,ITYPE,X,Y)
C=======================================================================
C
C     RETRIEVE NEXT ENERGY POINT.
C
C=======================================================================
      INCLUDE 'implicit.h'
      INTEGER*4 OUTP,OTAPE
      COMMON/ENDFIO/INP,OUTP,ITAPE,OTAPE
      INCLUDE 'mixer.h'
C-----INSURE POINT INDEX IS IN LEGAL RANGE.
      IF(I.GT.0.AND.I.LE.NPTAB(ITYPE)) GO TO 10
C-----ILLEGAL POINT INDEX.
      WRITE(OUTP,60) I,NPTAB(ITYPE)
      GO TO 20
C-----CHECK FOR PAGING ERROR (ATTEMPT TO BACKUP THROUGH SCRATCH).
   10 IF(I.GT.IXYLOW(ITYPE)) GO TO 30
      WRITE(OUTP,50) ITYPE,I,IXYLOW(ITYPE)
   20 X=0.0d0
      Y=0.0d0
      RETURN
C-----IF DATA IS NOT IN CORE LOAD CORRECT PAGE.
   30 IF(I.LE.IXYHI(ITYPE)) GO TO 40
      IXYLOW(ITYPE)=IXYHI(ITYPE)
      IXYHI(ITYPE)=IXYHI(ITYPE)+NPAGE
      CALL IDUMP(ISCR(ITYPE),XTAB(1,ITYPE),YTAB(1,ITYPE),NPAGE)
      GO TO 30
C-----DEFINE REQUIRED POINT.
   40 ICORE=I-IXYLOW(ITYPE)
      X=XTAB(ICORE,ITYPE)
      Y=YTAB(ICORE,ITYPE)
      RETURN
   50 FORMAT(' OPAG10..Index=',I6,' Less Than',I6,
     1 ' on Scratch',I3)
   60 FORMAT(' OPAG10..Index=',I6,' (MUST be 1 to',I6,')')
      END
      SUBROUTINE IDUMP(ISCR,X,Y,IPOINT)
C=======================================================================
C
C     READ A PAGE OF DATA FROM SCRATCH FILE.
C
C     SINCE PAGES ARE ALL THE SAME SIZE READING THE ENTIRE ARRAY IN
C     THIS SUBROUTINE WITH A READ OF THE FORM....
C     READ(ISCR) X
C     IS MORE EFFICIENT THAN USING
C     READ(ISCR) (X(I),I=1,IPOINT)
C     IN THE CALLING ROUTINE.
C
C=======================================================================
      INCLUDE 'implicit.h'
      DIMENSION X(IPOINT),Y(IPOINT)
      READ(ISCR) X,Y
      RETURN
      END
      SUBROUTINE ODUMP(ISCR,X,Y,IPOINT)
C=======================================================================
C
C     WRITE A PAGE OF DATA TO SCRATCH FILE.
C
C     SINCE PAGES ARE ALL THE SAME SIZE WRITING THE ENTIRE ARRAY IN
C     THIS SUBROUTINE WITH A WRITE OF THE FORM....
C     WRITE(ISCR) X
C     IS MORE EFFICIENT THAN USING
C     WRITE(ISCR) (X(I),I=1,IPOINT)
C     IN THE CALLING ROUTINE.
C
C=======================================================================
      INCLUDE 'implicit.h'
      DIMENSION X(IPOINT),Y(IPOINT)
      WRITE(ISCR) X,Y
      RETURN
      END
      SUBROUTINE INTOUT(INT,FIELD,LENGTH)
C=======================================================================
C
C     CONVERT INTEGER TO CHARACTERS FOR OUTPUT
C
C     WARNING - ONLY CONSIDERS POSITIVE INTEGERS
C
C=======================================================================
      INCLUDE 'implicit.h'
      CHARACTER*1 DIGITS,FIELD
      DIMENSION DIGITS(0:9),FIELD(LENGTH)
      DATA DIGITS/'0','1','2','3','4','5','6','7','8','9'/
C-----INITIALIZE TO BLANK
      DO 10 I=1,LENGTH
      FIELD(I)=' '
   10 CONTINUE
C-----FILL IN LAST DIGIT TO FIRST
      II=INT
      DO 20 I=LENGTH,1,-1
      KK=II/10
      LL=II-10*KK
      FIELD(I)=DIGITS(LL)
      II=KK
      IF(II.LE.0) GO TO 30
   20 CONTINUE
   30 RETURN
      END
      SUBROUTINE FILIO1
C=======================================================================
C
C     DEFINE INPUT AND FILES AND OPTIONALLY DEFINE FILENAMES.
C
C=======================================================================
      INCLUDE 'implicit.h'
      INTEGER*4 OUTP,OTAPE
      CHARACTER*12 FILSCR,FILSCR1
      CHARACTER*72 NAMEIN,NAMEOUT
      COMMON/NAMEX/NAMEIN,NAMEOUT
      COMMON/ENDFIO/INP,OUTP,ITAPE,OTAPE
      COMMON/IOSTATUS/ISTAT1,ISTAT2
      INCLUDE 'mixer.h'
      DIMENSION FILSCR(11)
      DATA FILSCR/
     1 'MIXER.001   ','MIXER.002   ',
     2 'MIXER.003   ','MIXER.004   ',
     3 'MIXER.005   ','MIXER.006   ',
     4 'MIXER.007   ','MIXER.008   ',
     5 'MIXER.009   ','MIXER,010   ',
     6 'MIXER.011   '/
C-----DEFINE ALL I/O UNITS.
      INP=2
      OUTP=3
      ITAPE=10
      OTAPE=11
C-----DEFINE ALL FILE NAMES.
      OPEN(OUTP,FILE='MIXER.LST',STATUS='UNKNOWN')
      OPEN(INP,FILE='MIXER.INP',STATUS='OLD',ERR=10)
      ISTAT1 = 0
      RETURN
   10 ISTAT1 = 1
      RETURN
      ENTRY FILIO2
C=======================================================================
C
C     DEFINE ENDFB DATA AND ALL SCRATCH FILE UNITS AND OPTIONALLY DEFINE
C     FILENAMES.
C
C=======================================================================
C-----DEFINE UNIT NUMBER AND INDICES TO PAGED ARRAYS (EACH CONSTITUENT
C-----CROSS SECTION WILL BE PUT ON A DIFFERENT SCRATCH FILE).
      DO 20 I=1,NMAT
      ISCR(I)=I+11
      IUSE(I)=I
   20 CONTINUE
      ISCR(11)=22
      IUSEN=11
      OPEN(OTAPE,FILE=NAMEOUT,STATUS='UNKNOWN')
      OPEN(ITAPE,FILE=NAMEIN,STATUS='OLD',ERR=30)
      ISTAT2 = 0
      GO TO 40
   30 ISTAT2 = 1
C-----CONSTITUENTS
   40 DO 50 I=1,NMAT
      NSCR=ISCR(I)
      FILSCR1=FILSCR(I)
      CALL SCRATCH1(NSCR,FILSCR1)
   50 CONTINUE
C-----COMBINED FILE
      CALL SCRATCH1(ISCR(11),'MIXER.000   ')
      RETURN
      END
