C This file is part of PREPRO.
C
C    Author: Dermott (Red) Cullen
C Copyright: (C) International Atomic Energy Agency
C
C PREPRO is free software; you can redistribute it and/or modify it
C under the terms of the MIT License; see LICENSE file for more details.

C=======================================================================
C
C     PROGRAM GROUPIE
C     ===============
C     VERSION 76-1 (NOVEMBER 1976)
C     VERSION 79-1 (OCTOBER 1979) CDC-7600 AND CRAY-1 VERSION.
C     VERSION 80-1 (MAY 1980) IBM, CDC AND CRAY VERSION
C     VERSION 81-1 (JANUARY 1981) EXTENSION TO 3000 GROUPS
C     VERSION 81-2 (MARCH 1981) IMPROVED SPEED
C     VERSION 81-3 (AUGUST 1981) BUILT-IN 1/E WEIGHTING SPECTRUM
C     VERSION 82-1 (JANUARY 1982) IMPROVED COMPUTER COMPATIBILITY
C     VERSION 83-1 (JANUARY 1983)*MAJOR RE-DESIGN.
C                                *ELIMINATED COMPUTER DEPENDENT CODING.
C                                *NEW, MORE COMPATIBLE I/O UNIT NUMBERS.
C                                *NEW MULTI-BAND LIBRARY BINARY FORMAT.
C     VERSION 83-2 (OCTOBER 1983) ADDED OPTION TO ALLOW SIGMA-0 TO BE
C                                 DEFINED EITHER AS MULTIPLES OF
C                                 UNSHIELDED TOTAL CROSS SECTION IN EACH
C                                 GROUP, OR POWERS OF 10 IN ALL GROUPS.
C     VERSION 84-1 (APRIL 1984)   ADDED MORE BUILT IN MULTIGROUP ENERGY
C                                 STRUCTURES.
C     VERSION 85-1 (APRIL 1985)  *UPDATED FOR ENDF/B-VI FORMATS.
C                                *SPECIAL I/O ROUTINES TO GUARANTEE
C                                 ACCURACY OF ENERGY.
C                                *DOUBLE PRECISION TREATMENT OF ENERGY
C                                 (REQUIRED FOR NARROW RESONANCES).
C                                *MINIMUM TOTAL CROSS SECTION TREATMENT
C     VERSION 85-2 (AUGUST 1985) *FORTRAN-77/H VERSION
C     VERSION 86-1 (JANUARY 1986)*ENDF/B-VI FORMAT
C     VERSION 86-2 (JUNE 1986)   *BUILT-IN MAXWELLIAN, 1/E AND FISSION
C                                 WEIGHTING SPECTRUM.
C     VERSION 88-1 (JULY 1988)   *OPTION...INTERNALLY DEFINE ALL I/O
C                                 FILE NAMES (SEE, SUBROUTINES FILIO1
C                                 FILIO2 FOR DETAILS).
C                                *IMPROVED BASED ON USER COMMENTS.
C     VERSION 89-1 (JANUARY 1989)*PSYCHOANALYZED BY PROGRAM FREUD TO
C                                 INSURE PROGRAM WILL NOT DO ANYTHING
C                                 CRAZY.
C                                *UPDATED TO USE NEW PROGRAM CONVERT
C                                 KEYWORDS.
C                                *ADDED LIVERMORE CIVIC COMPILER
C                                 CONVENTIONS.
C     VERSION 91-1 (JUNE 1991)   *INCREASED PAGE SIZE FROM 1002 TO 5010
C                                 POINTS
C                                *UPDATED BASED ON USER COMMENTS
C                                *ADDED FORTRAN SAVE OPTION
C                                *COMPLETELY CONSISTENT ROUTINE TO READ
C                                 FLOATING POINT NUMBERS.
C     VERSION 92-1 (JANUARY 1992)*ADDED RESONANCE INTEGRAL CALCULATION -
C                                 UNSHIELDED AND/OR SHIELDED - FOR
C                                 DETAILS SEE BELOW
C                                *INCREASED NUMBER OF ENERGY POINTS
C                                 IN BUILT-IN SPECTRA - TO IMPROVE
C                                 ACCURACY.
C                                *ALLOW SELECTION OF ZA/MF/MT OR
C                                 MAT/MF/MT RANGES - ALL DATA NOT
C                                 SELECTED IS SKIPPED ON INPUT AND
C                                 NOT WRITTEN AS OUTPUT.
C                                *COMPLETELY CONSISTENT I/O ROUTINES -
C                                 TO MINIMIZE COMPUTER DEPENDENCE.
C                                *NOTE, CHANGES IN INPUT PARAMETER
C                                 FORMAT - FOR ZA/MF/MT OR MAT/MF/MT
C                                 RANGES.
C     VERSION 92-2 (JUNE 1992)   *MULTIBAND PARAMETERS OUTOUT AS
C                                 CHARACTER (RATHER THAN BINARY) FILE.
C     VERSION 93-1 (APRIL 1993)  *INCREASED PAGE SIZE FROM 5010 TO
C                                 30000 POINTS
C                                *ELIMINATED COMPUTER DEPENDENCE.
C     VERSION 94-1 (JANUARY 1994)*VARIABLE ENDF/B DATA FILENAMES
C                                 TO ALLOW ACCESS TO FILE STRUCTURES
C                                 (WARNING - INPUT PARAMETER FORMAT
C                                 HAS BEEN CHANGED)
C                                *CLOSE ALL FILES BEFORE TERMINATING
C                                 (SEE, SUBROUTINE ENDIT)
C     VERSION 95-1 (JANUARY 1994)*CORRECTED MAXWELLIAN WEIGHTING
C                                *CHANGING WEIGHTING SPECTRUM FROM
C                                 0.1 TO 0.001 % UNCERTAINTY
C     VERSION 96-1 (JANUARY 1996) *COMPLETE RE-WRITE
C                                 *IMPROVED COMPUTER INDEPENDENCE
C                                 *ALL DOUBLE PRECISION
C                                 *ON SCREEN OUTPUT
C                                 *UNIFORM TREATMENT OF ENDF/B I/O
C                                 *IMPROVED OUTPUT PRECISION
C                                 *DEFINED SCRATCH FILE NAMES
C                                 *UP TO 1000 GROUP MULTI-BAND
C                                  CALCULATION (PREVIOUSLY 175)
C                                 *MAXIMUM NUMBER OF GROUPS REDUCED
C                                  FROM 3,000 TO 1,000
C                                 *UP TO 1000 MATERIALS
C                                  (PREVIOUSLY 100)
C                                 *CORRECTED USE OF MAXWELLIAN +
C                                  1/E + FISSION SPECTRUM
C                                 *ONLY 2 BAND VERSION DISTRIBUTED
C                                  (CONTACT AUTHOR FOR DETAILS)
C                                 *DEFINED SCRATCH FILE NAMES
C     VERSION 99-1 (MARCH 1999)   *CORRECTED CHARACTER TO FLOATING
C                                  POINT READ FOR MORE DIGITS
C                                 *UPDATED TEST FOR ENDF/B FORMAT
C                                  VERSION BASED ON RECENT FORMAT CHANGE
C                                 *GENERAL IMPROVEMENTS BASED ON
C                                  USER FEEDBACK
C     VERSION 99-2 (JUNE 1999)    *ASSUME ENDF/B-VI, NOT V, IF MISSING
C                                  MF=1, MT-451.
C     VERS. 2000-1 (FEBRUARY 2000)*ADDED MF=10, ACTIVATION CROSS SECTION
C                                  PROCESSING.
C                                 *GENERAL IMPROVEMENTS BASED ON
C                                  USER FEEDBACK
C     VERS. 2002-1 (FEBRUARY 2002)*ADDED TART 700 GROUP STRUCTURE
C                                 *ADDED VARIABLE SIGMA0 INPUT OPTION
C                  (MAY 2002)     *OPTIONAL INPUT PARAMETERS
C                  (NOV. 2002)    *ADDED SAND-II EXTENDED DOWN TO
C                                  1.0D-5 EV.
C                  (JUNE 2003)    *CORRECTED SAND-II 620 AND 640 GROUP
C                                  ENERGY BOUNDARIES DEFINITIONS.
C     VERS. 2004-1 (SEPT. 2004)  *INCREASED PAGE SIZE FROM 30000 TO
C                                 120000 POINTS
C                                *ADDED "OTHER" AS ADDITIONAL REACTION
C                                 TO IMPROVE MULTI-BAND FITTING
C                                *ADDED ITERATION FOR "BEST" PARTIAL
C                                 PARAMETERS.
C                                *DO NOT SKIP LOW TOTAL ENERGY RANGES
C                                 WHEN DEFINING AVERAGE CROSS SECTIONS -
C                                 THIS MAKES OUTPUT COMPATIBLE WITH
C                                 ANY STANDARD AVERAGING PROCEDURE
C     VERS. 2005-1 (JAN. 2005)   *ADDED OPTION TO CHANGE TEMPERATURE OF
C                                 BUILT-IN STANDARD SPECTRUM.
C     VERS. 2007-1 (JAN. 2007)   *CHECKED AGAINST ALL ENDF/B-VII.
C                                *INCREASED PAGE SIZE FROM 120,000 TO
C                                 600,000 POINTS
C     VERS. 2008-1 (JAN. 2008)   *72 CHARACTER FILE NAMES.
C                                *GENERAL UPDATES
C     VERS. 2010-1 (Apr. 2010)   *INCREASED WEIGHTING SPECTRUM TO 30,000
C                                 FROM 3,000 ENERGY POINTS.
C                                *ADDED OUTPUT TO PLOT/COMPARE SHIELDED
C                                 AND UNSHIELDED CROSS SECTIONS.
C     VERS. 2011-1 (June 2011)   *Corrected TART 700 groups to extend up
C                                 to 1 GeV (1,000 MeV) - previously it
C                                 was ERRONEOUSLY cutoff at 20 MeV.
C     VERS. 2011-2 (Nov. 2011)   *Corrected TART 616 groups lowest
C                                 energy from 1.0D-4 eV to 1.0D-5 eV.
C                                *Added TART 666 to 200 MeV (for TENDL).
C                                *Optional high energy cross section
C                                 extension above tabulated energy range
C                                 (either = 0 = standard, or constant)
C                                 WARNING - ENDF/B standard convention
C                                 is that the cross section = 0 where it
C                                 is not explicitly defined - extension
C                                 = 0 is standard, constant is NOT, so
C                                 constant extension is NOT RECOMMENDED.
C     VERS. 2012-1 (Aug. 2012)   *Added CODENAME
C                                *32 and 64 bit Compatible
C                                *Added ERROR stop.
C     VERS. 2013-1 (Nov. 2013)   *Extended OUT9.
C                                *Uses OUTG, not OUT10 for energies.
C     VERS. 2015-1 (Jan. 2015)   *Corrected SPECTM - handle ALL included
C                                 group structures, i.e., even those
C                                 that start above thremal range by
C                                 ALWAYS constructing weigthing spectrum
C                                 to be AT LEAST 1.0D-5 eV to 20 MeV.
C                                *Extended OUTG
C                                *Replaced ALL 3 way IF Statements.
C                                *Generalized TART Group Strructures.
C                                *Generalized SAND-II Group Structures.
C                                *Extended SAND-II to 60, 150, 200 MeV.
C     VERS. 2015-2 (Mar. 2015)   *Deleted 1P from formats reading input
C                                 parameters, causing incorrect scaling
C                                *Changed ALL data to "D" instead of
C                                 "E" to insure it is REAL*8 and avoid
C                                 Truncation ERRORS.
C     VERS. 2015-3 (July 2015)   *Insure no 10 digit output - not
C                                 needed for multi-group and this makes
C                                 listings simpler.
C                                *Corrected High Energy Extension =
C                                 Can effect highest energy group.
C     VERS. 2016-1 (July 2016)   *Added UKAEA 1102 Group Structure.
C                                *Increased storage to accommodate
C                                 much larger group structures =
C                                 up to 20,000 Groups.
C                                *Added output listing of the complete
C                                 input parameters for URRFIT, including
C                                 the NJOY parameters LSSF and ICOMP.
C                                *Changed multiple IF statements to
C                                 accommodate compiler optimizer
C                                *Cosmetic changes based on FREUD
C                                 psychoanalysis.
C                                *Updated multi-band treatment to
C                                 explcitly handle small shielding
C                                 limit - without this update the small
C                                 limit becomes numerically unstable.
C     VERS. 2017-1 (May  2017)   *Increased max. points to 3,000,000.
C                                *METHODB was incorrecctly named
C                                 METHOD  in one routine = corrected.
C                                *Default multi-band is method #2 =
C                                 conserve <x>, <1/(x+<x>>, <1/x>.
C                                *Definition of built-in group structure
C                                 using SUBROUTINE GROPE is identical
C                                 for GROUPIE and VIRGIN.
C                                *All floating input parameters changed
C                                 to character input + IN9 conversion.
C                                *Output report identfies MF now that
C                                 this code does more than just MF=3.
C                                *Added NRO = energy dependent scatter
C                                 radius to copying FILE2 parameters
C                                 to define unresolved energy range.
C                                *Corrected energy dependent scatter
C                                 for all resonance types (see, above
C                                 comments) = for multi-band output
C     VERS. 2018-1 (Jan. 2018)   *Added on-line output for ALL ENDERROR
C     VERS. 2019-1 (June 2019)   *Major re-write to re-order output to
C                                 include Unresolved Resonance Region
C                                 self-shielding.
C                                *Added Unresolved self-shielding by
C                                 Extrapolating cross section moments
C                                 from Resolved (supersedes URRDO and
C                                 URRFIT codes).
C                                *Added entire self-shielding array to
C                                 memory - previously only one group
C                                 results were in memory - saving ALL
C                                 greatly simplifies the logic.
C                                *Additional Interpolation Law Tests
C                                *Check maximum Tabulated Energy of MTs
C                                 to insure they ALL end at the same
C                                 energy.
C                                *Multi-band = 1 no longer allowed.
C                                 The only allowed values are,
C                                 0 = no multi-band calculations, or,
C                                 2 = Conserve 1/[total + <total>]
C                                *Unresolved Resonance Region
C                                 Self-Shielding Requires all of these,
C                                 1) Unresolved data with ENDF input
C                                 2) 616 TART Groups (input -11)
C                                 3) Define Sigma0 standard (input = 0)
C                                *Unresolved Resonance Region
C                                 Self-Shielding Always Outputs,
C                                 1) LSSF   = 0 = Output cross sections
C                                 2) INTUNR = 2 = Interpolation law
C                                *Added ZAzzzaaa to filenames.
C     VERS. 2020-1 (Aug. 2020)   *Major re-write to update for new URR
C                                 self-shielding, MF/MT=2/152 and 2/153.
C                                *Corrected BOTH ends of unresolved
C                                 for MF/MT=2/152 and 2/153 output.
C                                *Unresolved extrapolation ONLY to
C                                 groups completely inside the URR +
C                                 per ends for MF/MT=2/152 & 153 output.
C                                *Small shielding < 0.1 % = accuracy
C                                 of reconstructed data.
C                                *Forced no self-shielding at upper end
C                                 of unresolved = match high energy
C                                 tabulated.
C                                *Corrected PLOTTAB output if no URR
C                                 fit - it was outputting EMPTY tables
C                                 for original and fit moments, which
C                                 in this case did not exist.
C                                *Only 2 band, Method#2 [sigt + <sigt>]
C                                 alloed for multi-band calculation.
C                                *WARNING - if input Requested MF range
C                                 prevents unresolved region calculation
C                                *Added Target Isomer Flag
C                                *Correct MULTBAND.LST output format.
C     VERS. 2021-1 (Jan. 2021)   *Updated for FORTRAN 2018
C
C     2020-1 Acknowledgment
C     =====================
C     I Thank Jean-Christophe Sublet (NDS, IAEA, Vienna, Austria) for
C     reporting the ERROR in GROUPIE (2019-1) that led to the update in
C     GROUPIE (2020-1) to correctly define the PLOTTAB output, whether
C     or not Unresolved Resonance Region (URR) fit was performed.
C
C     2015-2 Acknowledgment
C     =====================
C     I thank Chuck Whitmer (TerraPower,WA) and Andrej Trkov (NDS,IAEA)
C     for reporting the errors that led to the 2015-2 Improvements in
C     this code.
C
C     I thank Jean-Christophe Sublet (UKAEA) for contributing MAC
C     executables and Bojan Zefran (IJS, Slovenia) for contributing
C     LINUX (32 or 63 bit) executables. And most of all I must thank
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
C     THE REPORT DESCRIBED ABOVE IS THE LATEST PUBLISHED DOCUMENTATION
C     FOR THIS PROGRAM. HOWEVER, THE COMMENTS BELOW SHOULD BE CONSIDERED
C     THE LATEST DOCUMENTATION INCLUDING ALL RECENT IMPROVEMENTS. PLEASE
C     READ ALL OF THESE COMMENTS BEFORE IMPLEMENTATION, PARTICULARLY
C     THE COMMENTS CONCERNING MACHINE DEPENDENT CODING.
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
C     THIS PROGRAM IS DESIGNED TO CALCULATE ANY COMBINATION OF
C     THE FOLLOWING QUANTITIES FROM LINEARLY INTERPOLABLE TABULATED
C     CROSS SECTIONS IN THE ENDF/B FORMAT
C
C     (1) UNSHIELDED GROUP AVERAGED CROSS SECTIONS
C     (2) BONDARENKO SELF-SHIELDED GROUP AVERAGED CROSS SECTIONS
C     (3) MULTI-BAND PARAMETERS
C
C     IN THE FOLLOWING FOR SIMPLICITY THE ENDF/B TERMINOLOGY--ENDF/B
C     TAPE--WILL BE USED. IN FACT THE ACTUAL MEDIUM MAY BE TAPE, CARDS,
C     DISK OR ANY OTHER MEDIUM.
C
C     ENDF/B FORMAT
C     -------------
C     THIS PROGRAM ONLY USES THE ENDF/B BCD OR CARD IMAGE FORMAT (AS
C     OPPOSED TO THE BINARY FORMAT) AND CAN HANDLE DATA IN ANY VERSION
C     OF THE ENDF/B FORMAT (I.E., ENDF/B-I, II,III, IV OR V FORMAT).
C
C     IT IS ASSUMED THAT THE DATA IS CORRECTLY CODED IN THE ENDF/B
C     FORMAT AND NO ERROR CHECKING IS PERFORMED. IN PARTICULAR IT IS
C     ASSUMED THAT THE MAT, MF AND MT ON EACH CARD IS CORRECT. SEQUENCE
C     NUMBERS (COLUMNS 76-80) ARE IGNORED ON INPUT, BUT WILL BE
C     CORRECTLY OUTPUT ON ALL CARDS. THE FORMAT OF SECTION MF=1, MT=451
C     AND ALL SECTIONS OF MF= 3 MUST BE CORRECT. THE PROGRAM COPIES ALL
C     OTHER SECTION OF DATA AS HOLLERITH AND AS SUCH IS INSENSITIVE TO
C     THE CORRECTNESS OR INCORRECTNESS OF ALL OTHER SECTIONS.
C
C     ALL FILE 3 CROSS SECTIONS THAT ARE USED BY THIS PROGRAM MUST BE
C     LINEARLY INTERPOLABLE IN ENERGY AND CROSS SECTION (ENDF/B
C     INTERPOLATION LAW 2). FILE 3 BACKGROUND CROSS SECTIONS MAY BE MADE
C     LINEARLY INTERPOLABLE USING PROGRAM LINEAR (UCRL-50400, VOL. 17,
C     PART A). THE RESONANCE CONTRIBUTION MAY BE ADDED TO THE BACKGROUND
C     CROSS SECTIONS USING PROGRAM RECENT (UCRL-50400, VOL. 17, PART B).
C     IF THIS PROGRAM FINDS THAT THE FILE 3 CROSS SECTIONS ARE NOT
C     LINEARLY INTERPOLABLE THIS PROGRAM WILL TERMINATE EXECUTION.
C
C     CONTENTS OF OUTPUT
C     ------------------
C     IF ENDF/B FORMATTED OUTPUT IS REQUESTED ENTIRE EVALUATIONS ARE
C     OUTPUT, NOT JUST THE MULTI-GROUPED FILE 3 CROSS SECTIONS, E.G.
C     ANGULAR AND ENERGY DISTRIBUTIONS ARE ALSO INCLUDED.
C
C     DOCUMENTATION
C     -------------
C     THE FACT THAT THIS PROGRAM HAS OPERATED ON THE DATA IS DOCUMENTED
C     BY THE ADDITION OF THREE COMMENT CARDS AT THE END OF EACH
C     HOLLERITH SECTION TO DESCRIBE THE GROUP STRUCTURE AND WEIGHTING
C     SPECTRUM, E.G.
C
C     ********************** PROGRAM GROUPIE (2021-1) ***************
C     UNSHIELDED GROUP AVERAGES USING   69 GROUPS (WIMS)
C     MAXWELLIAN, 1/E, FISSION TO CONSTANT WEIGHTING SPECTRUM
C
C     THE ORDER OF ALL SIMILAR COMMENTS (FROM LINEAR, RECENT AND SIGMA1)
C     REPRESENTS A COMPLETE HISTORY OF ALL OPERATIONS PERFORMED ON
C     THE DATA.
C
C     THESE COMMENT CARDS ARE ONLY ADDED TO EXISTING HOLLERITH SECTIONS,
C     I.E., THIS PROGRAM WILL NOT CREATE A HOLLERITH SECTION. THE FORMAT
C     OF THE HOLLERITH SECTION IN ENDF/B-V DIFFERS FROM THE THAT OF
C     EARLIER VERSIONS OF ENDF/B. BY READING AN EXISTING MF=1, MT=451
C     IT IS POSSIBLE FOR THIS PROGRAM TO DETERMINE WHICH VERSION OF
C     THE ENDF/B FORMAT THE DATA IS IN. WITHOUT HAVING A SECTION OF
C     MF=1, MT=451 PRESENT IT IS IMPOSSIBLE FOR THIS PROGRAM TO
C     DETERMINE WHICH VERSION OF THE ENDF/B FORMAT THE DATA IS IN, AND
C     AS SUCH IT IS IMPOSSIBLE FOR THE PROGRAM TO DETERMINE WHAT FORMAT
C     SHOULD BE USED TO CREATE A HOLLERITH SECTION.
C
C     REACTION INDEX
C     --------------
C     THIS PROGRAM DOES NOT USE THE REACTION INDEX WHICH IS GIVEN IN
C     SECTION MF=1, MT=451 OF EACH EVALUATION.
C
C     THIS PROGRAM DOES NOT UPDATE THE REACTION INDEX IN MF=1, MT=451.
C     THIS CONVENTION HAS BEEN ADOPTED BECAUSE MOST USERS DO NOT
C     REQUIRE A CORRECT REACTION INDEX FOR THEIR APPLICATIONS AND IT WAS
C     NOT CONSIDERED WORTHWHILE TO INCLUDE THE OVERHEAD OF CONSTRUCTING
C     A CORRECT REACTION INDEX IN THIS PROGRAM. HOWEVER, IF YOU REQUIRE
C     A REACTION INDEX FOR YOUR APPLICATIONS, AFTER RUNNING THIS PROGRAM
C     YOU MAY USE PROGRAM DICTIN TO CREATE A CORRECT REACTION INDEX.
C
C     SECTION SIZE
C     ------------
C     SINCE THIS PROGRAM USES A LOGICAL PAGING SYSTEM THERE IS NO LIMIT
C     TO THE NUMBER OF POINTS IN ANY SECTION, E.G., THE TOTAL CROSS
C     SECTION MAY BE REPRESENTED BY 200,000 DATA POINTS.
C
C     SELECTION OF DATA
C     -----------------
C     THE PROGRAM SELECTS MATERIALS TO BE PROCESSED BASED EITHER ON
C     MAT (ENDF/B MAT NO.) OR ZA. THE PROGRAM ALLOWS UP TO 100 MAT OR
C     ZA RANGES TO BE SPECIFIED. THE PROGRAM WILL ASSUME THAT THE
C     ENDF/B TAPE IS IN EITHER MAT OR ZA ORDER, WHICHEVER CRITERIA IS
C     USED TO SELECT MATERIALS, AND WILL TERMINATE WHEN A MAT OR ZA
C     IS FOUND THAT IS ABOVE THE RANGE OF ALL REQUESTS.
C
C     ENERGY ORDER AND UNITS
C     ----------------------
C     ALL ENERGIES (FOR CROSS SECTIONS, WEIGHTING SPECTRUM OR GROUP
C     BOUNDARIES) MUST BE IN UNITS OF EV AND MUST BE IN ASCENDING
C     NUMERICAL ORDER.
C
C     ENERGY GRID
C     -----------
C     ALTHOUGH ALL REACTIONS MUST TO LINEARLY INTERPOLABLE, THEY DO NOT
C     ALL HAVE TO USE THE SAME ENERGY GRID. EACH REACTION CAN BE GIVEN
C     BY AN INDEPENDENT ENERGY GRID. THIS PROGRAM WILL PROCEED FROM
C     THE LOWEST TO HIGHEST ENERGY SELECTING EACH ENERGY INTERVAL OVER
C     WHICH ALL DATA, FOR ANY GIVEN CALCULATION, ARE ALL LINEARLY
C     INTERPOLABLE.
C
C     GROUP STRUCTURE
C     ---------------
C     THIS PROGRAM IS DESIGNED TO USE AN ARBITRARY ENERGY GROUP
C     STRUCTURE WHERE THE ENERGIES ARE IN EV AND ARE IN INCREASING
C     ENERGY ORDER. THE MAXIMUM NUMBER OF GROUPS IS 20,000.
C
C     THE USER MAY INPUT AN ARBITRARY GROUP STRUCTURE OR THE USER MAY
C     USE USE ONE OF THE BUILT-IN GROUP STRUCTURES.
C     (0) 175 GROUP (TART STRUCTURE)
C     (1)  50 GROUP (ORNL STRUCTURE)
C     (2) 126 GROUP (ORNL STRUCTURE)
C     (3) 171 GROUP (ORNL STRUCTURE)
C     (4) 620 GROUP (SAND-II STRUCTURE, UP TO 18 MEV)
C     (5) 640 GROUP (SAND-II STRUCTURE, UP TO 20 MEV)
C     (6)  69 GROUP (WIMS STRUCTURE)
C     (7)  68 GROUP (GAM-I STRUCTURE)
C     (8)  99 GROUP (GAM-II STRUCTURE)
C     (9)  54 GROUP (MUFT STRUCTURE)
C    (10)  28 GROUP (ABBN STRUCTURE)
C    (11) 616 GROUP (TART STRUCTURE TO 20 MeV)
C    (12) 700 GROUP (TART STRUCTURE TO 1 GEV)
C    (13) 665 GROUP (SAND-II STRUCTURE, 1.0D-5 eV, UP TO 18 MEV)
C    (14) 685 GROUP (SAND-II STRUCTURE, 1.0D-5 eV, UP TO 20 MEV)
C    (15) 666 GROUP (TART STRUCTURE TO 200 MeV)
C    (16) 725 GROUP (SAND-II STRUCTURE, 1.0D-5 eV, UP TO  60 MEV)
C    (17) 755 GROUP (SAND-II STRUCTURE, 1.0D-5 eV, UP TO 150 MEV)
C    (18) 765 GROUP (SAND-II STRUCTURE, 1.0D-5 eV, UP TO 200 MEV)
C    (19)1102 GROUP (UKAEA   STRUCTURE, 1.0D-5 eV, UP TO   1 GeV)
C
C     GROUP AVERAGES
C     --------------
C     THIS PROGRAM DEFINES GROUP AVERAGED CROSS SECTIONS AS...
C
C               (INTEGRAL E1 TO E2) (SIGMA(E)*S(E)*WT(E)*DE)
C     AVERAGE = -----------------------------------------
C               (INTEGRAL E1 TO E2) (S(E)*WT(E)*DE)
C     WHERE...
C
C     AVERAGE  = GROUP AVERAGED CROSS SECTION
C     E1, E2   = ENERGY LIMITS OF THE GROUP
C     SIGMA(E) = ENERGY DEPENDENT CROSS SECTION FOR ANY GIVEN REACTION
C     S(E)     = ENERGY DEPENDENT WEIGHTING SPECTRUM
C     WT(E)    = ENERGY DEPENDENT SELF-SHIELDING FACTOR.
C
C     ENERGY DEPENDENT WEIGHTING SPECTRUM
C     -----------------------------------
C     THE ENERGY DEPENDENT WEIGHTING SPECTRUM IS GIVEN BY AN ARBITRARY
C     TABULATED LINERLY INTERPOLABLE FUNCTION WHICH CAN BE DESCRIBED
C     BY AN ARBITRARY NUMBER OF POINTS. THIS ALLOWS THE USER TO
C     SPECIFY ANY DESIRED WEIGHTING SPECTRUM TO ANY GIVEN DEGREE OF
C     ACCURACY. REMEMBER THAT THE PROGRAM WILL ASSUME THAT THE SPECTRUM
C     IS LINEARLY INTERPOLABLE BETWEEN TABULATED POINTS. THEREFORE THE
C     USER SHOULD USE ENOUGH POINTS TO INSURE AN ADEQUATE REPRESENTATION
C     OF THE SPECTRUM BETWEEN TABULATED DATA POINTS.
C
C     THE PRESENT VERSION OF THE CODE HAS THREE BUILT-IN WEIGHTING
C     SPECTRA,
C
C     (1) CONSTANT
C     (2) 1/E
C     (3) MAXWELLIAN = E*EXP(-E/KT)/KT                (0.0 TO 4*KT)
C         1/E        = C1/E                           (4*KT TO 67 KeV)
C         FISSION    = C2*EXP(-E/WA)*SINH(SQRT(E*WB)) (67 KeV, 10 MeV)
C         CONSTANT   = Equal to Fission at 10 MeV     (above 10 MeV)
C
C         KT     = 0.253 EV (293 KELVIN)
C         WA     = 9.65D+5
C         WB     = 2.29D-6
C         C1, C2 = DEFINED TO MAKE SPECTRUM CONTINUOUS
C
C         FISSION SPECTRUM CONSTANTS FROM
C         A.F.HENRY, NUCLEAR REACTOR ANALYSIS, P. 11, MIT PRESS (1975)
C
C     UNSHIELDED GROUP AVERAGES
C     -------------------------
C     FOR UNSHIELDED AVERAGES THE SELF-SHIELDING FACTOR (WT(E)) IS SET
C     TO UNITY. THIS PROGRAM ALLOWS UP TO 20,000 GROUPS.
C
C     SELF-SHIELDED GROUP AVERAGES
C     ----------------------------
C     IF SELF-SHIELDED AVERAGES AND/OR MULTI-BAND PARAMETERS ARE
C     CALCULATED THIS PROGRAM ALLOWS UP TO 20,000 GROUPS. SELF-SHIELDED
C     AVERAGES AND/OR MULTI-BAND PARAMETERS ARE CALCULATED FOR THE
C     TOTAL, ELASTIC, CAPTURE AND FISSION.
C
C     FOR THE TOTAL, ELASTIC, CAPTURE AND FISSION THE PROGRAM USES A
C     WEIGHTING FUNCTION THAT IS A PRODUCT OF THE ENERGY DEPENDENT
C     WEIGHTING SPECTRUM TIMES A BONDERENKO TYPE SELF-SHIELDING FACTOR.
C
C     WT(E) = S(E)/(TOTAL(E)+SIGMA0)**N
C
C     WHERE...
C
C     S(E)     - ENERGY DEPENDENT WEIGHTING SPECTRUM (DEFINED BY
C                TABULATED VALUES AND LINEAR INTERPOLATION BETWEEN
C                TABULATED VALUES).
C     TOTAL(E) - ENERGY DEPENDENT TOTAL CROSS SECTION FOR ONE MATERIAL
C                (DEFINED BY TABULATED VALUES AND LINEAR INTERPOLATION
C                BETWEEN TABULATED VALUES).
C     SIGMA0   - CROSS SECTION TO REPRESENT THE EFFECT OF ALL OTHER
C                MATERIALS AND LEAKAGE (DEFINED WITHIN EACH GROUP TO BE
C                A MULTIPLE OF THE UNSHIELDED TOTAL CROSS SECTION WITHIN
C                THAT GROUP OR POWERS OF 10 - INPUT OPTION).
C     N        - A POSITIVE INTEGER (0, 1, 2 OR 3).
C
C     THE PROGRAM WILL USE ONE ENERGY DEPENDENT WEIGHTING SPECTRUM S(E)
C     AND 25 DIFFERENT BONDERENKO TYPE SELF-SHIELDING FACTORS (25 SIGMA0
C     AND N COMBINATIONS) TO DEFINE 25 DIFFERENT AVERAGE CROSS SECTIONS,
C     FOR EACH REACTION, WITHIN EACH GROUP.
C
C     THE 25 WEIGHTING FUNCTIONS USED ARE....
C     (1)   - UNSHIELDED CROSS SECTIONS (N=0)
C     (2-22)- PARTIALLY SHIELDED CROSS SECTIONS (N=1 ,VARIOUS SIGMA0)
C             THE VALUES OF SIGMA0 USED WILL BE EITHER,
C             (A) THE VALUES OF SIGMA0 THAT ARE USED VARY FROM 1024
C             TIMES THE UNSHIELDED TOTAL CROSS SECTIONS IN STEPS OF 1/2
C             DOWN TO 1/1024 TIMES THE UNSHIELDED TOTAL CROSS SECTION
C             (A RANGE OF OVER 1 MILLION, CENTERED ON THE UNSHIELDED
C             TOTAL CROSS SECTION WITHIN EACH GROUP).
C             (B) THE SAME CONSTANT VALUES OF SIGMA0 IN EACH GROUP. THE
C             VALUES OF SIGMA0 USED INCLUDE 40000, 20000, 10000, 7000,
C             4000, 2000, 1000, 700, 400, 200, 100, 70, 40, 20, 10, 7,
C             4, 2, 1, 0.7, 0.4 (A RANGE OF 100,000 SPANNING MORE THAN
C             THE RANGE OF SIGMA0 VALUES THAT MAY BE ENCOUNTERED IN
C             ACTUAL APPLICATIONS)
C     (23)  - TOTALLY SHIELDED FLUX WEIGHTED CROSS SECTION
C             (N=1, SIGMA0=0)
C     (24)  - TOTALLY SHIELDED CURRENT WEIGHTED CROSS SECTION
C             (N=2, SIGMA0=0)
C     (25)  - TOTALLY SHIELDED COSINE SQUARED WEIGHTED CROSS SECTION
C             (N=3, SIGMA0=0)
C
C     FOR ALL OTHER REACTIONS (EXCEPT TOTAL, ELASTIC, CAPTURE AND
C     FISSION) THE PROGRAM WILL USE THE ENERGY DEPENDENT WEIGHTING
C     SPECTRUM S(E) TO DEFINE THE UNSHIELDED (BONDERENKO N=0)
C     AVERAGED CROSS SECTION WITHIN EACH GROUP.
C
C     CALCULATION OF RESONANCE INTEGRALS
C     ----------------------------------
C     IN A PURE ELASTIC ISOTROPICALLY SCATTERING MATERIAL WITH A
C     CONSTANT CROSS SECTION THE SPECTRUM WILL BE 1/E AND THERE WILL
C     BE NO SELF-SHIELDING.
C
C     IN THIS CASE IF THE CROSS SECTION VARIES WITH ENERGY THE
C     SPECTRUM WILL STILL BE 1/E AND THE SELF-SHIELDING FACTOR WILL
C     BE EXACTLY 1/SIG-TOT(E) - WHERE SIG-TOT(E) = SIG-EL(E), SINCE
C     THERE IS ONLY SCATTERING.
C
C     IF WE HAVE AN INFINITELY DILUTE AMOUNT OF A MATERIAL UNIFORMLY
C     MIXED WITH A PURE ELASTIC ISOTROPICALLY SCATTERING MATERIAL WITH
C     A CONSTANT CROSS SECTION THE STANDARD DEFINITION OF THE RESONANCE
C     INTEGRAL CAN BE USED TO DEFINE REACTION RATES FOR EACH REACTION.
C
C     THE RESONANCE INTEGRAL IS DEFINED AS,
C
C     RI      = (INTEGRAL E1 TO E2) (SIGMA(E)*S(E)*WT(E)*DE)
C
C     WHERE NORMALLY,
C     S(E)    = 1/E
C     WT(E)   = 1    - NO SELF-SHIELDING
C
C     FROM THE ABOVE DEFINITION OF GROUP AVERAGED CROSS SECTIONS THE
C     RESONANCE INTEGRAL IS,
C
C     RI      = AVERAGE * (INTEGRAL E1 TO E2) (S(E)*WT(E)*DE)
C
C     FOR A 1/E SPECTRUM AND NO SELF-SHIELDING THIS REDUCES TO,
C
C     RI      = AVERAGE* LOG(E2/E1)
C
C     IN ANY OTHER SITUATION, INCLUDING ABSORPTION AND/OR ENERGY
C     DEPENDENT CROSS SECTIONS, THE SPECTRUM WILL NOT BE 1/E -
C     ABSORPTION WILL TEND TO DECREASE THE SPECTRUM PROGRESSIVELY
C     MORE AT LOWER ENERGIES - ENERGY DEPENDENCE OF THE CROSS SECTION
C     WILL LEAD TO SELF-SHIELDING.
C
C     HERE WE WILL NOT ATTEMPT TO PERFORM A DETAILED SPECTRUM
C     CALCULATION TO ACCOUNT FOR ABSORPTION.
C
C     HOWEVER, WE WILL EXTEND THE DEFINITION OF THE RESONANCE INTEGRAL
C     TO ACCOUNT FOR SELF-SHIELDING EFFECTS BY ALLOWING FOR INCLUSION
C     OF SELF-SHIELDING EFFECTS IN THE DEFINITION OF GROUP AVERAGES
C     AND THEN DEFINING THE RESONANCE INTEGRAL AS,
C
C     RI      = AVERAGE* LOG(E2/E1)
C
C     IN ORDER TO CALCULATE RESONANCE INTEGRALS YOU MUST FOLLOW THESE
C     STEPS,
C
C     1) SELECT A 1/E SPECTRUM - ON FIRST LINE OF INPUT PARAMETERS.
C     2) SELECT THE ENERGY BOUNDARIES - NORMALLY ONLY 1 GROUP FROM
C        0.5 EV UP TO 20 MEV - HOWEVER, YOU ARE FREE TO SELECT ANY
C        ENERGY RANGE THAT YOU WISH - YOU MAY EVEN SELECT MORE THAN
C        1 GROUP MERELY BY SPECIFYING MORE THAN 1 GROUP AS INPUT -
C        THIS CAN BE USED TO DEFINE THE CONTRIBUTIONS TO THE RESONANCE
C        INTEGRAL FROM INDIVIDUAL ENERGY RANGES.
C     3) SELECT THIS OPTION FOR THE UNSHIELDED AND/OR SHIELDED OUTPUT
C        LISTING - ON THE SECOND LINE OF INPUT PARAMETERS.
C
C     WHEN THIS OPTION IS USED THE PROGRAM WILL CALCULATE GROUP AVERAGED
C     CROSS SECTIONS - AS DEFINED ABOVE - PRIOR TO OUTPUT THE RESULTS
C     WILL MERELY BE MULTIPLIED BY THE WIDTH OF THE GROUP ASSUMING YOU
C     HAVE SELECTED A 1/E SPECTRUM - THERE IS NO CHECK ON THIS - THE
C     PROGRAM MERELY MULTIPLIES THE GROUP AVERAGED CROSS SECTIONS BY,
C
C     LOG(E2/E1) - WHERE E2 AND E1 ARE THE GROUP ENERGY BOUNDARIES.
C
C     WARNING - IT IS UP TO YOU TO INSURE THAT YOU FOLLOW EXACTLY THE
C               STEPS OUTLINED ABOVE IF YOU WISH TO OBTAIN MEANINGFUL
C               RESULTS.
C
C     NOTE - OUTPUT IN THE ENDF/B FORMAT IS ALWAYS GROUP AVERAGED CROSS
C            SECTIONS, REGARDLESS OF WHETHER YOU ASK FOR AVERAGED CROSS
C            SECTIONS OR RESONANCE INTEGRALS - THIS IS BECAUSE DATA IN
C            THE ENDF/B FORMAT IS EXPLICITLY DEFINED TO BE CROSS
C            SECTIONS.
C
C            RESONANCE INTEGRAL OUTPUT CAN ONLY BE OBTAINED IN THE
C            LISTING FORMATS.
C
C     MINIMUM TOTAL CROSS SECTION TREATMENT
C     -------------------------------------
C     SINCE THE BONDARENKO SELF-SHIELDING DEPENDS ON 1/TOTAL CROSS
C     SECTION, THE ALGORITHM WILL BECOME NUMERICALLY UNSTABLE IF THE
C     TOTAL CROSS SECTION IS NEGATIVE (AS OCCURS IN MANY ENDF/B
C     EVALUATIONS). IF THE TOTAL IS LESS THAN SOME MINIMUM ALLOWABLE
C     VALUE (DEFINE BY OKMIN, PRESENTLY 1 MILLI-BARN) AN ERROR MESSAGE
C     WILL BE PRINTED AND FOR THE SELF-SHIELDING CALCULATION ALL ENERGY
C     INTERVALS IN WHICH THE TOTAL IS LESS THAN THE MINIMUM WILL BE
C     IGNORED.
C
C     NOTE, FOR THE UNSHIELDED CALCULATIONS ALL CROSS SECTIONS WILL BE
C     CONSIDERED WHETHER THEY ARE POSITIVE OR NEGATIVE. THEREFORE IF
C     THE TOTAL CROSS SECTION IS NEGATIVE OR LESS THAN THE MINIMUM
C     VALUE THERE MAY BE AN INCONSISTENCY BETWEEN THE UNSHIELDED AND
C     THE SELF-SHIELDED CROSS SECTIONS. IF THE TOTAL CROSS SECTION IS
C     NEGATIVE AND SELF-SHIELDED CROSS SECTIONS ARE CALCULATED THE
C     PROGRAM WILL PRINT AN ERROR MESSAGE INDICATING THAT THE SELF-
C     SHIELDED RESULTS ARE UNRELIABLE AND SHOULD NOT BE USED. THEREFORE
C     IN THIS CASE THE PROGRAM WILL NOT ATTEMPT TO MODIFY THE UNSHIELDED
C     RESULTS TO ELIMINATE THE EFFECT OF NEGATIVE CROSS SECTIONS, SINCE
C     THE UNSHIELDED RESULTS ARE THE ONLY ONES WHICH TRULY REFLECT THE
C     ACTUAL INPUT.
C
C     RESOLVED RESONANCE REGION
C     -------------------------
C     IN THE RESOLVED RESONANCE REGION (ACTUALLY EVERYWHERE BUT IN THE
C     UNRESOLVED RESONANCE REGION) THE CROSS SECTIONS OUTPUT BY LINEAR-
C     RECENT-SIGMA1 WILL BE ACTUAL ENERGY DEPENDENT CROSS SECTIONS AND
C     THE CALCULATIONS BY THIS PROGRAM WILL YIELD ACTUAL SHIELDED AND
C     UNSHIELDED CROSS SECTIONS.
C
C     UNRESOLVED RESONANCE REGION
C     ---------------------------
C     IN THE UNRESOLVED RESONANCE REGION PROGRAM RECENT USES THE
C     UNRESOLVED RESONANCE PARAMETERS TO CALCULATE INFINITELY DILUTE
C     AVERAGE CROSS SECTIONS. THIS PROGRAM WILL MERELY READ THIS
C     INFINITELY DILUTE DATA AS IF IT WERE ENERGY DEPENDENT DATA AND
C     GROUP AVERAGE IT. AS SUCH THIS PROGRAM WILL PRODUCE THE CORRECT
C     UNSHIELDED CROSS SECTION IN THE UNRESOLVED RESONANCE REGION, BUT
C     IT WILL NOT PRODUCE THE CORRECT SELF-SHIELDING EFFECTS.
C
C     ACCURACY OF RESULTS
C     -------------------
C     ALL INTEGRALS ARE PERFORMED ANALYTICALLY. THEREFORE NO ERROR IS
C     INTRODUCED DUE TO THE USE OF TRAPAZOIDAL OR OTHER INTEGRATION
C     SCHEME. THE TOTAL ERROR THAT CAN BE ASSIGNED TO THE RESULTING
C     AVERAGES IS JUST THAT DUE TO THE ERROR IN THE CROSS SECTIONS
C     AND ENERGY DEPENDENT WEIGHTING SPECTRUM. GENERALLY SINCE THE
C     THE ENERGY DEPENDENT WEIGHTING SPECTRUM APPEARS IN BOTH THE
C     NUMERATOR AND THE DENOMINATOR THE AVERAGES RAPIDLY BECOME
C     INSENSITIVE TO THE WEIGHTING SPECTRUM AS MORE GROUPS ARE USED.
C     SINCE THE WEIGHTING SPECTRUM IS LOADED IN THE PAGING SYSTEM THE
C     USER CAN DESCRIBE THE SPECTRUM TO ANY REQUIRED ACCURACY USING
C     ANY NUMBER OF ENERGY VS. SPECTRUM PAIRS.
C
C     MULTI-BAND PARAMETERS
C     ---------------------
C     MULTI-BAND PARAMETERS ARE CALCULATED FOR THE TOTAL, ELASTIC,
C     CAPTURE AND FISSION REACTIONS. WITH THE NUMBER OF GROUPS THAT
C     ARE NORMALLY USED (SEE BUILT IN GROUP STRUCTURES) ALL OTHER
C     REACTIONS RESULT IN A NEGLIGABLE AMOUNT OF SELF-SHIELDING. AS
C     SUCH THEIR EQUIVALENT BAND CROSS SECTION WILL MERELY BE THEIR
C     UNSHIELDED VALUE WITHIN EACH BAND.
C
C     FOR ANY GIVEN EVALUATION, WITHIN ANY GIVEN GROUP THIS PROGRAM
C     WILL GENERATE THE MINIMUM NUMBER OF BANDS REQUIRED WITHIN THAT
C     GROUP. AS OUTPUT TO THE COMPUTER READABLE DISK FILE THE BAND
C     PARAMETERS FOR EACH EVALUATION WILL BE FORMATTED TO HAVE THE
C     SAME NUMBER OF BANDS IN ALL GROUPS (WITH ZERO WEIGHT FOR SOME
C     BANDS WITHIN ANY GROUP). THE USER MAY DECIDE TO HAVE OUTPUT
C     EITHER WITH THE MINIMUM NUMBER OF BANDS REQUIRED FOR EACH
C     EVALUATION (E.G. 2 BANDS FOR HYDROGEN AND 4 BANDS FOR U-233) OR
C     THE SAME NUMBER OF BANDS FOR ALL EVALUATIONS (E.G. 4 BANDS FOR
C     BOTH HYDROGEN AND U-233).
C
C     FOR 2 OR FEWER BANDS THE PROGRAM USES AN ANALYTIC EXPRESSION
C     TO DEFINE ALL MULTI-BAND PARAMETERS. FOR MORE THAN 2 BANDS THE
C     PROGRAM PERFORMS A NON-LINEAR FIT TO SELECT THE MULTI-BAND
C     PARAMETERS THAT MINIMIZE THE MAXIMUM FRACTIONAL ERROR AT ANY
C     POINT ALONG THE ENTIRE SELF-SHIELDING CURVE. THE NUMBER OF BANDS
C     REQUIRED WITHIN ANY GIVEN GROUP IS DEFINED BY INSURING THAT THE
C     MULTI-BAND PARAMETERS CAN BE USED TO ACCURATELY DEFINE SELF-
C     SHIELDED CROSS SECTIONS ALONG THE ENTIRE SELF-SHIELDING CURVE
C     FROM SIGMA0 = 0 TO INFINITY. THE USER MAY DEFINE THE ACCURACY
C     REQUIRED.
C
C     ENDF/B FORMATTED UNSHIELDED AVERAGES
C     ------------------------------------
C     UNSHIELDED MULTI-GROUP AVERAGED CROSS SECTIONS FOR ALL REACTIONS
C     MAY BE OBTAINED IN THE ENDF/B FORTRAN IN EITHER HISTOGRAM
C     (INTERPOLATION LAW 1) OR LINEARLY INTERPOLABLE (INTERPOLATION
C     LAW 2) FORM. SEE INPUT BELOW FOR DETAILS.
C
C     MIXTURES OF MATERIALS AND RESONANCE OVERLAP
C     -------------------------------------------
C     THE SELF-SHIELDED CROSS SECTIONS FOR THE INDIVIDUAL CONSTITUENTS
C     OF ANY MIXTURE CAN BE CALCULATED BY THIS PROGRAM BY REALIZING THAT
C     THIS PROGRAM ESSENTIALLY ONLY USES THE TOTAL CROSS SECTION AS A
C     WEIGHTING FUNCTION TO ACCOUNT FOR SELF-SHIELDING EFFECTS. FOR A
C     MIXTURE IT IS THEREFORE ONLY NECESSARY TO USE THE TOTAL CROSS
C     SECTION FOR THE MIXTURE IN PLACE OF THE ACTUAL TOTAL CROSS SECTION
C     FOR EACH CONSTITUENT AND TO RUN THIS PROGRAM. THIS CAN BE DONE BY
C     FIRST RUNNING PROGRAM MIXER TO CALCULATE THE ENERGY DEPENDENT
C     TOTAL CROSS SECTION FOR ANY COMPOSITE MIXTURE. NEXT, SUBSTITUTE
C     THIS COMPOSITE TOTAL CROSS SECTION FOR THE ACTUAL TOTAL CROSS
C     SECTION OF EACH CONSTITUENT (IN EACH ENDF/B FORMATTED EVALUATION).
C     FINALLY, RUN THIS PROGRAM TO CALCULATE THE SELF-SHIELDED CROSS
C     SECTION FOR EACH CONSTITUENT, PROPERLY ACCOUNTING FOR RESONANCE
C     OVERLAP BETWEEN THE RESONANCES OF ALL OF THE CONSTITUENTS OF THE
C     MIXTURE. DURING THE SAME RUN THESE SELF-SHIELDED CROSS SECTIONS
C     CAN IN TURN BE USED TO CALCULATE FULLY CORRELATED MULT-BAND
C
C     MULTI-BAND PARAMETER OUTPUT FORMAT
C     ----------------------------------
C     FOR VERSIONS 92-2 AND LATER VERSIONS THE MULTI-BAND PARAMETERS
C     ARE OUTPUT IN A SIMPLE CHARACTER FORMAT, THAT CAN BE TRANSFERRED
C     AND USED ON VIRTUALLY ANY COMPUTER.
C
C     THE BINARY FORMAT USED IN EARLIER VERSIONS OF THIS CODE IS NO
C     LONGER USED.
C
C     CONTACT THE AUTHOR IF YOU WOULD LIKE TO RECEIVE A SIMPLE PROGRAM
C     TO READ THE CHARACTER FORMATTED MULTI-BAND PARAMETER FILE AND
C     CREATE A BINARY, RANDOM ACCESS FILE FOR USE ON VIRTUALLY ANY
C     COMPUTER.
C
C     THE FORMAT OF THE CHARACTER FILE IS,
C
C     RECORD   COLUMNS   FORMAT   DESCRIPTION
C        1       1-72     18A4    LIBRARY DESCRIPTION (AS READ)
C        2       1-11      I11    MATERIAL ZA
C               12-22      I11    NUMBER GROUPS
C               23-33      I11    NUMBER OF BANDS
C               34-44     E11.4   TEMPERATURE (KELVIN)
C               45-57    1X,12A1  HOLLERITH DESCRIPTION OF ZA
C        3       1-11     E11.4   ENERGY (EV) - GROUP BOUNDARY.
C               12-22     E11.4   TOTAL      (FIRST BAND)
C               23-33     E11.4   ELASTIC
C               34-44     E11.4   CAPTURE
C               35-55     E11.4   FISSION
C        4       1-11     -----   BLANK
C               12-22     E11.4   TOTAL      (SECOND BAND)
C               23-33     E11.4   ELASTIC
C               34-44     E11.4   CAPTURE
C               35-55     E11.4   FISSION
C
C     LINES 3 AND 4 ARE REPEATED FOR EACH GROUP. THE LAST LINE FOR EACH
C     MATERIAL (ZA) IS,
C
C        N       1-11     E11.4   ENERGY (EV) - UPPER ENERGY LIMIT OF
C                                               LAST GROUP.
C
C     FOR EXAMPLE, A 175 GROUP, 2 BAND FILE, FOR EACH MATERIAL WILL
C     CONTAIN 352 LINES = 1 HEADER LINE, 175 * 2 LINES OF PARAMETERS,
C                         AND 1 FINAL LINE WITH THE UPPER ENERGY LIMIT
C                         OF THE LAST GROUP.
C
C     INPUT FILES
C     -----------
C     UNIT  DESCRIPTION
C     ----  -----------
C       2   INPUT DATA (BCD - 80 CHARACTERS/RECORD)
C      10   ORIGINAL ENDF/B DATA (BCD - 80 CHARACTERS/RECORD)
C
C     OUTPUT FILES
C     ------------
C     UNIT  DESCRIPTION
C     ----  -----------
C       3   OUTPUT REPORT (BCD - 80 CHARACTERS/RECORD)
C      11   MULTI-GROUP ENDF/B DATA - OPTIONAL
C           (BCD - 80 CHARACTERS/RECORD)
C      16   PLOTTAB FORMATTED SELF-SHIELDING RESULTS
C           (BCD - 80 CHARACTERS/RECORD)
C      31   MULTI-BAND PARAMETERS CHARACTER FILE - OPTIONAL
C           (BCD - 80 CHARACTERS/RECORD)
C      32   UNRESOLVED FSELF-SHIELDED PSEUDO ENDF FORMAT - OPTIONAL
C           (BCD - 120 CHARACTERS/RECORD)
C      33   SELF-SHIELDED CROSS SECTION LISTING - OPTIONAL
C           (BCD - 120 CHARACTERS/RECORD)
C      34   MULTI-BAND PARAMETER LISTING - OPTIONAL
C           (BCD - 120 CHARACTERS/RECORD)
C      35   UNSHIELDED CROSS SECTION LISTING - OPTION
C           (BCD - 120 CHARACTERS/RECORD)
C
C     SCRATCH FILES
C     -------------
C     UNIT  FILENAME  DESCRIPTION
C     ----  --------  -----------
C       8   ENERGY DEPENDENT WEIGHTING SPECTRUM
C           (BINARY - 40080 WORDS/BLOCK)
C       9   TOTAL CROSS SECTION
C           (BINARY - 40080 WORDS/BLOCK)
C      12   ELASTIC CROSS SECTION - ONLY FOR SELF-SHIELDING CALCULATION
C           (BINARY - 40080 WORDS/BLOCK)
C      13   CAPTURE CROSS SECTION - ONLY FOR SELF-SHIELDING CALCULATION
C           (BINARY - 40080 WORDS/BLOCK)
C      14   FISSION CROSS SECTION - ONLY FOR SELF-SHIELDING CALCULATION
C           (BINARY - 40080 WORDS/BLOCK)
C
C     OPTIONAL STANDARD FILE NAMES (SEE SUBROUTINES FILIO1 AND FILIO2)
C     ----------------------------------------------------------------
C     UNIT  FILE NAME
C     ----  ----------
C       2   GROUPIE.INP
C       3   GROUPIE.LST
C----------------------
C       8   (SCRATCH)
C       9   (SCRATCH)
C      10   ENDFB.IN
C      11   ENDFB.OUT
C      12   (SCRATCH)
C      13   (SCRATCH)
C      14   (SCRATCH)
C-----2019/6/23 - New Filenames (added ZAzzzaaa at Beginning)-----------
C-----------(OLD)-------------(NEW)-------------------------------------
C      16   PLOTTAB.CUR     ZAzzzaaa.PLOT.CUR
C      31   MULTBAND.TAB    ZAzzzaaa.MULTBAND.TAB
C      32                   ZAzzzaaa.URR.ENDF
C      33   SHIELD.LST      ZAzzzaaa.SHIELD.LST
C      34   MULTBAND.LST    ZAzzzaaa.MULTBAND.LST
C      35   UNSHIELD.LST    ZAzzzaaa.UNSHIELD.LST
C
C      I/O UNITS USED
C      --------------
C      UNITS 2, 3 8, 9 AND 10 WILL ALWAYS BE USED.
C      UNITS 31 THROUGH 35, 11 AND 16 ARE OPTIONALLY USED DEPENDING
C      ON THE OUTPUT REQUESTED.
C      UNITS 12, 13 AND 14 WILL ONLY BE USED IF SELF-SHIELDED OR
C      MULTIBAND OUTPUT IS REQUESTED.
C
C     INPUT CARDS
C     -----------
C     CARD  COLS.  FORMAT  DESCRIPTION
C     ----  -----  ------  -----------
C       1    1-11    I11   SELECTION CRITERIA (0=MAT, 1=ZA)
C       1   12-22    I11   NUMBER OF GROUPS.
C--------------------------2019/6/23 -11 (TART 616 groups) required for
C                          Unresolved Resonance Region Self-Shielding
C                          calculation.
C                          =.GT.0 - ARBITRARY GROUP BOUNDARIES ARE READ
C                                   FROM INPUT FILE (N GROUPS REQUIRE
C                                   N+1 GROUP BOUNDARIES). CURRENT
C                                   PROGRAM MAXIMUM IS 20,000 GROUPS.
C                                   BUILT-IN OPTIONS INCLUDE....
C                          =  0   - TART    175 GROUPS
C                          = -1   - ORNL     50 GROUPS
C                          = -2   - ORNL    126 GROUPS
C                          = -3   - ORNL    171 GROUPS
C                          = -4   - SAND-II 620 (665) GROUPS TO 18 MEV
C                          = -5   - SAND-II 640 (685) GROUPS TO 20 MEV
C                          = -6   - WIMS     69 GROUPS
C                          = -7   - GAM-I    68 GROUPS
C                          = -8   - GAM-II   99 GROUPS
C                          = -9   - MUFT     54 GROUPS
C                          =-10   - ABBN     28 GROUPS
C    Current TART Standard =-11   - TART    616 GROUPS TO 20 MEV
C    (-11 is required for  =-12   - TART    700 GROUPS TO 1 GEV
C     unresolved resonance =-13   - SAND-II 665 GROUPS TO 18 MEV
C     region self-shielding=-14   - SAND-II 685 GROUPS TO 20 MEV
C     calculations)        =-15   - TART    666 GROUPS TO 200 MEV
C                          =-16   - SAND-II 725 GROUPS TO 60 MEV
C                          =-17   - SAND-II 755 GROUPS TO 150 MEV
C                          =-18   - SAND-II 765 GROUPS TO 200 MEV
C                          =-19   - UKAEA  1102 GROUPS TO   1 GeV
C       1   23-33    I11   MULTI-BAND SELECTOR
C--------------------------2019/6/23 - ONLY 0 or 2 allowed = the = 1
C                          option has proven to give very poor results,
C                          and therefore is no longer allowed.
C                          =  0 - NO MULTI-BAND CALCULATIONS
C      No longer allowed   =  1 - 2 BAND. CONSERVE AV(TOT), AV(1/TOT)
C                                 AND AV(1/TOT**2)
C                          =  2 - 2 BAND. CONSERVE AV(TOT), AV(1/TOT)
C                                 AND AV(1/(TOT+SIGMA0)) WHERE
C                                 SIGMA0 = AV(TOT) IN EACH GROUP
C      No longer allowed   = 3-5- MULTI-BAND FIT. CONSERVE AV(TOT) AND
C                                 MINIMIZE FRACTIONAL ERROR FOR ENTIRE
C                                 SELF-SHIELDING CURVE (SIGMA0 = 0 TO
C                                 INFINITY)
C                          IF THE SELECTOR IS POSITIVE (1 TO 5) THE
C                          MINIMUM NUMBER OF BANDS WILL BE OUTPUT FOR
C                          EACH ISOTOPE INDEPENDENTLY. IF THE SELECTOR
C                          IS NEGATIVE (-1 TO -5) THE SAME NUMBER OF
C                          BANDS (ABS(SELECTOR)) WILL BE OUTPUT FOR
C                          ALL ISOTOPES.
C       1   34-44    I11   NUMBER OF POINTS USED TO DESCRIBE ENERGY
C                          DEPENDENT WEIGHTING SPECTRUM S(E).
C                          = 0 or 1 - Flat (Constant)
C                          = -1     - 1/E at ALL energies
C                          = -2     - MAXWELLIAN - UP TO 0.1 eV
C                                     1/E        - 0.1 eV TO 67 KeV
C                                     FISSION    - 67 KeV to 10 MeV
c                                     CONSTANT   - Above 10 MeV
C                          = > 1    - Read input table
C 2005/01/20---------------ADDED OPTION TO ALLOW TEMPERATURE OF THE
C                          MAXWELLIAN TO BE CHANGED - SEE INPUT LINE 4,
C                          COLUMNS 55 - 66.
C                          = -1    - 1/E
C                          = 0 OR 1- ENERGY INDEPENDENT (SO CALLED FLAT
C                                    WEIGHTING SPECTRUM).
C                          = .GT.1 - READ THIS MANY POINTS FROM INPUT
C                                    TO DESCRIBE WEIGHTING SPECTRUM.
C                                    NO LIMIT TO THE NUMBER OF POINTS
C                                    USED TO DESCRIBE WEIGHTING.
C       1   45-55   E11.4  MULTI-BAND CONVERGENCE CRITERIA.
C--------------------------2019/6/23 - No longer used now that code
C                          is restricted to no more than 2 bands.
C                          ONLY USED FOR 3 OR MORE BANDS. THE NUMBER OF
C                          BANDS IN EACH GROUPS IS SELECTED TO INSURE
C                          THAT THE ENTIRE SELF-SHIELDING CURVE CAN BE
C                          REPRODUCED TO WITHIN THIS FRACTIONAL ERROR.
C                          = .LT. 0.0001 - USE STANDARD 0.001
C                                          (0.1 PER-CENT)
C                          = .GE. 0.0001 - USE AS CONVERGENCE CRITERIA
C       1   56-66    I11   SIGMA-0 DEFINITION SELECTOR.
C--------------------------2019/6/23 - For multi-band calculations
C                          only 0 is alllowed = mulriples of unshielded
C                          total in each group = This is required for
C                          the BEST self-shielding results.
C                          < 0 - 21 VALUES OF SIGMA0 ARE READ INPUT AND
C                                INTERPRETED AS FIXED VALUES = SAME AS
C                                = 1 DESCRIPTION BELOW
C                                INPUT VALUES MUST ALL BE,
C                                1) GREATER THAN 0
C                                2) IN DESCENDING VALUE ORDER
C                          = 0 - SIGMA-0 WILL BE DEFINED AS A MULTIPLE
C                                OF THE UNSHIELDED TOTAL CROSS SECTION
C                                IN EACH GROUP (VALUES OF 1/1024 TO
C                                1024 IN STEPS OF A FACTOR OF 2 WILL
C                                BE USED AS THE MULTIPLIER).
C                          = 1 - SIGMA-0 WILL BE DEFINED AS THE SAME
C                                NUMBER OF BARNS IN EACH GROUP (VALUES
C                                40000 TO 0.4 BARNS WILL BE USED. WITHIN
C                                EACH DECADE VALUES OF 10, 7, 4, 2, 1
C                                BARNS WILL BE USED).
C       1   67-70    I4    High energy extension = definition of cross
C                          section above highest tabulated energy.
C--------------------------2019/6/23 - Ignored - will always use ENDF
C                          Standard Definition = 0.
C                          = 0 = cross section = 0 (standard ENDF/B)
C                          = 1 = cross section = constant (equal to
C                                value at highest tabulated energy).
C     2-4    1-66 6E11.4   SIGMA-0 Definition
C--------------------------2019/6/23 - Only the GROUPIE standard = 0
C                          in allowed for Unresolved Resonance Region
C                          Self-Shielding calculation
C                          IF SIGMA-0 DEFINITION SELECTOR < 0, THE NEXT
C                          4 LINES OF INPUT ARE THE 22 VALUES OF SIGMA0,
C                          6 PER LINE.
C       2    1-72    A72   ENDF/B INPUT DATA FILENAME
C                          (STANDARD OPTION = ENDFB.IN)
C       3    1-72    A72   ENDF/B OUTPUT DATA FILENAME
C                          (STANDARD OPTION = ENDFB.OUT)
C
C     THE FOURTH INPUT CARD IS USED TO SELECT ALL DESIRED OUTPUT MODES.
C     EACH OUTPUT DEVICE MAY BE TURNED OFF (0) OR ON (1). THEREFORE
C     THEREFORE EACH OF THE FOLLOWING INPUT PARAMETERS MAY BE EITHER
C     ZERO TO INDICATE NO OUTPUT OR NON-ZERO TO INDICATE OUTPUT.
C
C       4     1-11   I11   SELF-SHIELDED CROSS SECTION LISTING
C                          = 1 - CROSS SECTIONS
C                          = 2 - RESONANCE INTEGRALS
C       4    12-22   I11   MULTI-BAND PARAMETER LISTING
C       4    23-33   I11   MULTI-BAND PARAMETERS COMPUTER READABLE
C       4    34-44   I11   UNSHIELDED CROSS SECTIONS IN ENDF/B FORMAT
C                          = 1 - HISTOGRAM FORMAT (INTERPOLATION LAW 1)
C                          = 2 - LINEAR-LINEAR (INTERPOLATION LAW 2)
C       4    45-55   I11   UNSHIELDED CROSS SECTIONS LISTING
C                          = 1 - CROSS SECTIONS
C                          = 2 - RESONANCE INTEGRALS
C 05/01/20 - ADDED THE BELOW OPTION
C       4    56-66   E11.4 IF THE STANDARD BUILT-IN SPECTRA IS USED,
C                          INPUT LINE 1, COLUMNS 34-44 = 2, THIS FIELD
C                          CAN BE USED TO OPTIONALLY CHANGE TEMPERATURE
C                          OF THE MAXWELLIAN.
C                          INPUT IS IN EV (0.0253 EV = ROOM TEMPERATURE)
C                          = 0 - USE DEFAULT 0.0253 EV, ROOM TEMPERATURE
C                          > 0 - USE THIS AS THE TEMPERATURE
C                          RESTRICTION - TEMPERATURE CANNOT EXCEED
C                          1000 EV.
C
C       5     1-80   18A4  LIBRARY IDENTIFICATION. ANY TEXT THAT THE
C                          USER WISHES TO IDENTIFY THE MULTI-BAND
C                          PARAMETERS. THIS LIBRARY IDENTIFICATION IS
C                          WRITTEN INTO THE COMPUTER READABLE MULTI-BAND
C                          DATA FILE.
C
C      6-N    1- 6    I6   LOWER MAT OR ZA LIMIT
C             7- 8    I2   LOWER MF LIMIT
C             9-11    I3   LOWER MT LIMIT
C            12-17   I11   UPPER MAT OR ZA LIMIT
C            18-19    I2   UPPER MF LIMIT
C            20-22    I3   UPPER MT LIMIT
C                          UP TO 100 RANGES MAY BE SPECIFIED, ONE RANGE
C                          PER LINE. THE LIST OF RANGES IS TERMINATED
C                          BY A BLANK CARD. IF THE UPPER MAT OR ZA
C                          LIMIT IS LESS THAN THE LOWER LIMIT THE UPPER
C                          IS SET EQUAL TO THE LOWER LIMIT. IF THE UPPER
C                          MF OR MT LIMIT IS ZERO IT WILL BE SET EQUAL
C                          TO ITS MAXIMUM VALUE, 99 OR 999, RESPECTIVELY
C                          IF THE FIRST REQUEST LINE IS BLANK IT WILL
C                          TERMINATE THE LIST OF REQUESTS AND CAUSE ALL
C                          DATA TO BE RETRIEVED (SEE EXAMPLE INPUT).
C
C      VARY   1-66  6E11.4 ENERGY GROUP BOUNDARIES. ONLY REQUIRED IF
C                          THE NUMBER OF GROUPS INDICATED ON THE FIRST
C                          INPUT CARD IS POSITIVE. ALL ENERGIES MUST
C                          BE IN ASCENDING ENERGY IN EV. THE PRESENT
C                          LIMITS ARE 1 TO 20,000 GROUPS. FOR N GROUPS
C                          N+1 BOUNDARIES WILL BE READ FROM THE
C                          INPUT FILE, E.G. IF THE FIRST INPUT CARD
C                          INDICATES 20 GROUPS, 21 ENERGY BOUNDARIES
C                          WILL BE READ FROM THE INPUT FILE.
C
C      VARY   1-66  6E11.4 ENERGY DEPENDENT WEIGHTING SPECTRUM. ONLY
C                          REQUIRED IF THE NUMBER OF POINTS INDICATED
C                          ON FIRST CARD IS MORE THAN ONE. DATA IS
C                          GIVEN IN (ENERGY, WEIGHT) PAIRS, UP TO 3
C                          PAIRS PER CARD, USING ANY NUMBER OF CARDS
C                          REQUIRED. ENERGIES MUST BE IN ASCENDING
C                          ORDER IN EV. THE SPECTRUM VALUES MUST BE
C                          NON-NEGATIVE. THE ENERGY RANGE OF SPECTRUM
C                          MUST AT LEAST SPAN THE ENERGY RANGE OF THE
C                          ENERGY GROUPS. SINCE SPECTRUM IS STORED IN
C                          PAGING SYSTEM THERE IS NO LIMIT TO NUMBER
C                          OF POINTS THAT CAN BE USED TO DESCRIBE THE
C                          WEIGHTING SPECTRUM.
C
C     EXAMPLE INPUT NO. 1
C     -------------------
C     REQUEST DATA BY MAT AND PROCESS ALL DATA (ALL MAT BETWEEN 1 AND
C     9999). USE THE TART 175 GROUP STRUCTURE, GENERATE 2 BAND
C     PARAMETERS (THE FOR ALL ISOTOPES) TO 0.1 PER-CENT ACCURACY
C     IN THE SELF-SHIELDING CURVE. OUTPUT ALL  LISTING, COMPUTER
C     READABLE AND ENDF/B FORMAT GROUP AVERAGES.
C
C     EXPLICITLY SPECIFY THE STANDARD FILENAMES.
C
C     THE FOLLOWING 7 INPUT LINES ARE REQUIRED.
C
C          0          0         -2          0 1.00000-03          0
C ENDFB.IN
C ENDFB.OUT
C          1          1          1          1          1
C TART 175 GROUP, 2 BAND LIBRARY TO 0.1 PER-CENT ACCURACY
C     1 1  1  9999 0  0
C                       (BLANK CARD TERMINATES REQUEST LIST)
C
C     EXAMPLE INPUT NO. 2
C     -------------------
C     THE SAME EXAMPLE 1, AS ABOVE, ONLY THE ENDF/B DATA WILL BE READ
C     FROM \ENDFB6\SIGMA1\K300\ZA092238 (U-238 AT 300 KELVIN) AND
C     WRITTEN TO \ENDFB6\GROUPIE\K300\ZA092238
C
C     THE FOLLOWING 7 INPUT LINES ARE REQUIRED.
C
C          0          0         -2          0 1.00000-03          0
C \ENDFB6\SIGMA1\K300\ZA092238
C \ENDFB6\GROUPIE\K300\ZA092238
C          1          1          1          1          1
C TART 175 GROUP, 2 BAND LIBRARY TO 0.1 PER-CENT ACCURACY
C     1 1  1  9999 0  0
C                       (BLANK CARD TERMINATES REQUEST LIST)
C
C     EXAMPLE INPUT NO. 3
C     -------------------
C     PROCESS ALL DATA. USE 1/E WEIGHTING IN ORDER TO CALCULATE
C     UNSHIELDED ONE GROUP CROSS SECTIONS OVER THE ENERGY RANGE 0.5 EV
C     TO 1 MEV (NOTE THAT THE RESULTS ARE SIMPLY PROPORTIONAL TO THE
C     RESONANCE INTEGRAL FOR EACH REACTION). OUTPUT UNSHIELDED LISTING.
C
C     LEAVE THE DEFINITION OF THE FILENAMES BLANK - THE PROGRAM WILL
C     THEN USE STANDARD FILENAMES.
C
C     THE FOLLOWING 7 INPUT CARDS ARE REQUIRED.
C
C          0          0          1         -1                     0
C                       (USE STANDARD FILENAME = ENDFB.IN)
C                       (USE STANDARD FILENAME = ENDFB.OUT)
C          0          0          0          0          1
C RESONANCE INTEGRAL CALCULATION (FROM 0.5 EV TO 1 MEV)
C                       (RETRIEVE ALL DATA, TERMINATE REQUEST LIST)
C 5.00000-01 1.00000+06
C
C     EXAMPLE INPUT NO. 4
C     -------------------
C     THIS EXAMPLE USES A USER DEFINED GROUP STRUCTURE AND WEIGHTING
C     FUNCTION - THESE ARE NOT REALISTIC IN TERMS OF ACTUAL ENERGIES
C     AND WEIGHTS - THEY ARE ONLY INTENDED TO ILLUSTRATE THE ORDER OF
C     THE INPUT PARAMETERS.
C
C          0         11          0          6                     0
C RECENT.OUT
C GROUPIE.OUT
C          1          1          1          1          1
C Example with users defined groupus and spectrum weighting
C     1 1  1  999999999
C                       (blabk line terminates request list)
C 1.00000-05 1.00000-04 1.00000-03 1.00000-02 1.00000-01 1.00000+00 grou
C 1.00000+01 1.00000+02 1.00000+03 1.00000+04 1.00000+05 1.00000+06 grou
C 1.00000-05 1.0        1.00000-02 0.1        1.00000+00 0.01       weig
C 1.00000+02 0.001      1.00000+04 0.0001     1.00000+06 0.000001   weig
C
C=======================================================================
      INCLUDE 'implicit.h'
C-----08/08/2012 DEFINE CODE NAME
      CHARACTER*8 CODENAME
      COMMON/NAMECODE/CODENAME
      CHARACTER*1 ZABCD,FIELDX
      CHARACTER*4 FMTHOL,TUNITS,TMPHOL,CARD
      INTEGER*4 OUTP,OTAPE,OTAPE2
      COMMON/UNITS/OTAPE2,NTAPE,LIST1,LIST2,LIST3,IPLOT
      COMMON/ENDFIO/INP,OUTP,ITAPE,OTAPE
      COMMON/HEADER/C1H,C2H,L1H,L2H,N1H,N2H,MATH,MFH,MTH,NOSEQ
      COMMON/REALLY/XE,XA(5),YA(5),YB(5),YC(5),NPTAB(5),IPTAB(5),NSECT
      COMMON/FILLER/ISECT
      COMMON/COPC/CARD(17)
      COMMON/LEADER/TEMP,Q,L1,L2,N1,N2,MAT,MF,MT
      COMMON/WHATZA/ATWT,IZA,MATNOW,MFNOW
      COMMON/TEMPO/TMPTAB(3),TEMP1,NTEMP
      COMMON/TEMPC/TINOUT(4)
      COMMON/TRASH/ERROK,ER10PC,MGROUP,METHODB,NBAND,NBMAX,
     1 NBNEED,MYSIGMA0
      COMMON/ELPASD/TUNITS(2,4),TMPHOL(3)
      COMMON/ELPASZ/ZABCD(12)
      COMMON/ELPAS2/EGB,TMPK
      COMMON/PAGER/NPAGE,NPAGM1
      COMMON/COPI/MFIELD(3)
      COMMON/GRABER/NOSELF,LSECT
      COMMON/HOLFMT/FMTHOL
      COMMON/MINOK/OKMIN(5),REDMIN(5)
      COMMON/TYPER/NTYPE
      COMMON/VERSES/TEMP3,IVERSE
      COMMON/FIELDC/FIELDX(11,22)
      COMMON/LOGCOM/MYLOG(8)
      COMMON/LISCOM/LISO
      COMMON/RESCOM/RES1,RES2,URES1,URES2,LSSF,ICOMP,INTUNR,INPART
      INCLUDE 'groupie.h'
c-----2016/5/21 - Increased NBT and INT dimension from 20 to 100
      DIMENSION NPTUSE(5),NPTTOT(5),NBT(100),INT(100),MTNEED(5,3)
C-----DEFINE REQUIRED REACTIONS FOR NEUTRONS AND PHOTONS.
      DATA MTNEED/0,  1  ,2,102, 18,
     1            0,501,522,502,504,
     1            0,  0,  0,  0,  0/
C-----DEFINE LAST ZA READ FROM ENDF/B FORMAT FILE.
      DATA LASTZA/0/
c-----2019/3/9 - Initialize last requested MAT
      MATNOW = 0
c-----------------------------------------------------------------------
C
C     INITIALIZATION.
C
c-----------------------------------------------------------------------
C-----08/08/2012 DEFINE CODE NAME
      CODENAME = 'GROUPIE '
C-----INITIALIZE TIME
      CALL TIMER
C-----DEFINE ALL I/O UNITS AND OPTIONALLY DEFINE FILE NAMES.
      CALL FILIO1
C-----LOAD ALL DATA INTO COMMON
      CALL BLOCK
C-----DEFINE PAGE SIZE.
      NPAGE=MAXPOINT
      NPAGM1=NPAGE-1
C-----DEFINE MINIMUM ACCEPTABLE SPECTRUM AND CROSS SECTION VALUES AND
C-----INITIALIZE POINT COUNTS FOR ALL REACTIONS.
      DO 10 ISECT=1,5
      OKMIN(ISECT)=0.0d0
      NPTTOT(ISECT)=0
   10 CONTINUE
C-----INITIALIZE COUNT OF SECTIONS
      DO I=1,8
      MYLOG(I) = 0
      ENDDO
C-----DEFINE MINIMUM ALLOWABLE CROSS SECTION FOR TOTAL AND ELASTIC
      OKMIN(2)=0.001d0
      OKMIN(3)=0.001d0
C-----INITIALIZE COUNT OF EVALUATIONS FOR WHICH MULTIBAND PARAMETERS
C-----HAVE BEEN GENERATED.
      LZA=0
C-----Initialize Resonance Region Boundaries.
      INPART= 1     ! Initialize to neutron (in case not ENDF6 format)
      RES1  = 0.0d0
      RES2  = 0.0d0
      URES1 = 0.0d0
      URES2 = 0.0d0
      LSSF  = 0
      ICOMP = 0
      LISO  = 0
c-----2020/8/5 - Initialize ends of URR, inside URR
      do k=1,2
      do j=1,5
      XCURRLIM(k,j) = 0.0d0
      enddo
      enddo
c-----------------------------------------------------------------------
C
C     READ AND CHECK ALL INPUT PARAMETERS AND COPY TAPE LABEL.
C
c-----------------------------------------------------------------------
      CALL READIN
C-----READ ENDF/B TAPE LABEL AND IF THERE IS MULTI-GROUP OUTPUT IN THE
C-----ENDF/B FORMAT WRITE LABEL TO MULTI-GROUP OUTPUT FILE.
      CALL COPYL
C-----LIST TAPE LABEL.
      WRITE(OUTP,580) CARD,MFIELD(1)
      WRITE(*   ,580) CARD,MFIELD(1)
c-----------------------------------------------------------------------
C
C     SEARCH FOR NEXT REQUESTED MATERIAL. TEST FOR END OF DATA.
C
c-----------------------------------------------------------------------
   20 CALL NXTMAT
      IF(MATH.LE.0) GO TO 380
c-----------------------------------------------------------------------
C
C     SECTION HEAD CARD FOUND. LOCATE FILE 1, SECTION 451 OR FILE 3.
C
c-----------------------------------------------------------------------
      IF(MFH.NE.1.OR.MTH.NE.451) GO TO 30
C-----FILE 1 , SECTION 451. ADD COMMENTS AND COPY REMAINDER OF FILE 1.
      CALL FILE1
      GO TO 20
c-----------------------------------------------------------------------
C
C     FILE2 - Define Resonance Region Boundaries
C
c-----------------------------------------------------------------------
   30 IF(MFH.NE.2.OR.MTH.NE.151) GO TO 40
      CALL FILE2
      GO TO 20
c-----------------------------------------------------------------------
C
C     SEARCH FOR MF = 3, 10 OR 23 - OTHERWISE COPY.
C
c-----------------------------------------------------------------------
   40 IF(MFH.eq. 3) go to 50   ! Neutron Data
      IF(MFH.eq.10) go to 50   ! Activation Data
      IF(MFH.eq.23) go to 50   ! Photon data
C-----NOT FILE 1, 2, 3 OR 23. COPY SECTION (MT).
      CALL CONTOG
      CALL COPYSG    ! Copy to end of Section (MT=0)
      GO TO 20
c-----------------------------------------------------------------------
C
C     FILE 3, 10 OR 23 FOUND. LOCATE REQUIRED REACTIONS.
C
c-----------------------------------------------------------------------
C-----SAVE MF FOR OUTPUT REPORT.
   50 MFHOUT = MFH
C-----DEFINE TEMPERATURE FROM FIRST SECTION OF EACH MAT.
      IF(IZA.EQ.LASTZA) GO TO 60
      LASTZA=IZA
C-----DEFINE CHEMICAL SYMBOL FOR THIS MAT.
c-----2020/3/21 - Add isomeric flag
      CALL ZAHOLM(IZA,LISO,ZABCD)
C-----SET FLAG TO INDICATE NEW MAT...SELECT TEMPERATURE FROM FIRST
C-----SECTION USED, WHEN NEXT CARD IS READ.
   60 MPASS=0
C-----INITIALIZE POINT COUNTS FOR NEXT MATERIAL.
      DO 70 ISECT=2,5
      NPTUSE(ISECT)=0
      NPTAB(ISECT)=0
   70 CONTINUE
      NPTUSE(1)=0
C-----INITIALIZE MINIMUM VALUES CROSS SECTIONS READ.
      DO 80 I=1,5
      REDMIN(I)=2.0d0*OKMIN(I)
   80 CONTINUE
C-----SET FLAG TO INDICATE IF SELF-SHIELDING CALCULATION MUST BE
C-----PERFORMED AND HAS NOT YET BEEN DONE ( 0 -YES, 1 -NO).
      IMDONE=0
      IF(NOSELF.NE.0) IMDONE=1
c-----------------------------------------------------------------------
C
C     BEGINNING OF REACTION LOOP.
C
c-----------------------------------------------------------------------
C-----IS SECTION REQUIRED FOR SELF-SHIELDING CALCULATION.
   90 MYTYPE=1
      IF(MFNOW.EQ.23) MYTYPE=2
      IF(MFNOW.EQ.10) MYTYPE=3
      DO 100 ISECT=2,5
      IF(MTH.eq.MTNEED(ISECT,MYTYPE)) go to 130
  100 CONTINUE
C-----THIS IS NOT TOTAL, ELASTIC, CAPTURE OR FISSION. SET POINT
C-----COUNT INDEX.
      NTYPE=1
C-----IF UNSHIELDING OUTPUT PERFORM CALCULATION. OTHERWISE SKIP SECTION.
      IF(OTAPE.GT.0.OR.LIST3.GT.0) GO TO 140
c-----------------------------------------------------------------------
C
C     REACTION LOOP
C
c-----------------------------------------------------------------------
C-----SKIP TO BEGINNING OF NEXT SECTION.
  110 CALL SKIPS
  120 CALL CONTIG
      IF(MTH.gt.0) go to 90
C-----CHECK FOR END OF FILE 3, 10 OR 23.
      IF(MFH.le.0) go to 200
      go to 120
c-----------------------------------------------------------------------
C
C     REQUIRED REACTION FOUND. DEFINE INDEX TO SAVE POINT COUNT
C     OF THIS SECTION (NTYPE). IF ONLY DOING UNSHIELDED CALCULATION
C     SET INDEX (ISECT) TO LOAD DATA INTO PAGE 2.
C
c-----------------------------------------------------------------------
  130 NTYPE=ISECT
      IF(NOSELF.le.0) go to 150
C-----LOAD DATA INTO DEFAULT PAGE (2 - IF NO SELF-SHIELDING,
C----- 4 - OTHERWISE).
  140 ISECT=LSECT
c-----------------------------------------------------------------------
C
C     LOOP OVER TABLES = 1 TABLE, EXCEPT FOR MF=10
C
c-----------------------------------------------------------------------
  150 NS=1
      IF(MFH.EQ.10) NS = N1H
C-----04/11/00 - MOVED CONTOG OUTPUT HERE - FROM TAB1
      IF(OTAPE.GT.0) CALL CONTOG
      DO 190 LOOP=1,NS
c-----------------------------------------------------------------------
C
C     READ AND CHECK INTERPOLATION LAW. THEN LOAD SECTION INTO PAGING
C     SECTION.
C
c-----------------------------------------------------------------------
      CALL CARDI(TEMP,Q,L1,L2,N1,N2)
C-----DEFINE TEMPERATURE FROM FIRST SECTION READ, OR FILE 1 IF ENDF/B-VI
C-----FORMAT.
      IF(MPASS.GT.0) GO TO 180
      MPASS=1
      TEMP1=TEMP
      IF(IVERSE.GE.6) TEMP1=TEMP3
C-----SELECT OUTPUT TEMPERATURE UNITS.
      DO 160 NTEMP=1,3
      IF(TEMP1.LE.TMPTAB(NTEMP)) GO TO 170
  160 CONTINUE
      NTEMP=4
  170 TMPK=TEMP1*TINOUT(NTEMP)
      TMPHOL(2)=TUNITS(1,NTEMP)
      TMPHOL(3)=TUNITS(2,NTEMP)
  180 CALL TERPI(NBT,INT,N1)
c-----2019/1/3 - Additional Interpolation Law Tests
      CALL TERPTEST(NBT,INT,N1,N2,3)   ! MUST be INT = 2
      NPTAB(ISECT)=N2
C-----FOR TOTAL, ELASTIC, CAPTURE OR FISSION SAVE POINT COUNT. FOR ALL
C-----OTHERS ADD UP THE TOTAL NUMBER OF POINTS.
      IF(NTYPE.NE.1) then
      NPTUSE(NTYPE)=N2               ! elastic, capture, fission
      else
      NPTUSE(NTYPE)=NPTUSE(NTYPE)+N2 ! all others
      endif
C-----READ SECTION AND LOAD INTO PAGING SYSTEM.
      CALL PAGIN5(ITAPE,ISECT,NTYPE)
c-----------------------------------------------------------------------
C
C     UNSHIELDED CROSS SECTION CALCULATION.
C
c-----------------------------------------------------------------------
C-----UNSHIELDED TOTAL AVERAGES ARE ALWAYS PERFORMED. IF ENDF/B OR LIST
C-----FORMATTED OUTPUT IS REQUESTED UNSHIELDED AVERAGES WILL ALSO BE
C-----PERFORMED FOR ALL OTHER REACTIONS.
      IF(MTH.NE.1.AND.OTAPE.LE.0.AND.LIST3.LE.0) GO TO 190
C-----CALCULATE UNSHIELDED GROUP AVERAGES.
      CALL GROUPU
C-----IF NOT TOTAL, ELASTIC, CAPTURE OR FISSION RESET SAVED POINT
C-----COUNT TO ZERO.
      IF(MTH.NE.MTNEED(ISECT,MYTYPE)) NPTAB(ISECT)=0
c-----------------------------------------------------------------------
C
C     END OF TABLE LOOP.
C
c-----------------------------------------------------------------------
  190 CONTINUE
C-----04/11/00 - MOVED SEND HERE FROM TAB1.
      IF(OTAPE.GT.0) CALL OUTS(MATH,MFH)
C-----IF ALL REQUIRED SECTIONS READ PERFORM SELF-SHIELDING AND
C-----MULTI-BAND CALCULATION (LAST SECTION REQUIRED FOR SELF-SHIELDING
C-----CALCULATION IS CAPTURE, MT=102).
      IF(MTH.lt.102) go to 110
c-----------------------------------------------------------------------
C
C     SELF-SHIELDING AND MULTI-BAND CALCULATIONS.
C
c-----------------------------------------------------------------------
C-----IF SELF-SHIELDING CALCULATION ALREADY DONE OR NOT REQUIRED SKIP
C-----THIS SECTION.
  200 IF(IMDONE.GT.0) GO TO 220
      IMDONE=1
C-----DEFINE NUMBER OF SECTIONS ACTUALLY READ.
      DO NSECT=5,2,-1
      if(NPTAB(NSECT).gt.0) GO TO 210
      ENDDO
      NSECT=2
C-----PERFORM SELF-SHIELDING AND MULTI-BAND CALCULATIONS.
  210 CALL GROUPS
C-----IF STILL IN FILE 3, 10 OR 23 BRANCH BACK TO PROCESS NEXT SECTION.
  220 IF(MFH.GT.0) GO TO 110
c-----------------------------------------------------------------------
C
C     END OF MF - IF END MF=3 PRINT RESONANCE REGION SUMMARY.
C
c-----------------------------------------------------------------------
c-----Only for MF=3 data (no MF=10, etc. data)
      IF(MFHOUT.eq.3) then
c-----Resolved region
      if(RES2.gt.0.0d0) then
      CALL OUT9G( RES1,FIELDX(1,1))
      CALL OUT9G( RES2,FIELDX(1,2))
      WRITE(3,230) ZABCD,((FIELDX(k,kk),k=1,11),kk=1,2)
      WRITE(*,230) ZABCD,((FIELDX(k,kk),k=1,11),kk=1,2)
  230 format(1x,78('-')/' Resonance Region for ',12A1/
     1 ' Resolved Resonance Region.....',11A1,' to ',11A1, ' eV')
      else
      WRITE(3,240) ZABCD
      WRITE(*,240) ZABCD
  240 format(1x,78('-')/' Resonance Region for ',12A1/
     1 ' Resolved Resonance Region..... NONE')
      endif
c-----Unresolved
      if(URES2.gt.0.0d0) then
      CALL OUT9G(URES1,FIELDX(1,5))
      CALL OUT9G(URES2,FIELDX(1,6))
      WRITE(3,250) ((FIELDX(k,kk),k=1,11),kk=5,6)
      WRITE(*,250) ((FIELDX(k,kk),k=1,11),kk=5,6)
  250 format(
     1 ' Unresolved Resonance Region...',11A1,' to ',11A1, ' eV')
c-----WARN wheather or not Unresolved self-shielding will be performed.
c-----2019/6/08 - Only allow for TART 616 groups
c-----2019/6/23 - Only allow for standaard Sigma0 definition
      if(NGR.eq.616.and.MYSIGMA0.eq.0) then
      write(3,260)
      write(*,260)
  260 format(
     1 ' WARNING - Unresolved Self-Shielding ENDF data is included.'/
     2 '           ENDF Format MF=2/152 and 2/153 Unresolved Region'/
     3 '           Output is ALWAYS Cross sections - not F-Factors')
      else
      write(3,270)
      write(*,270)
  270 format(
     1 ' WARNING - Unresolved Self-Shielding ENDF data NOT included.'/
     2 '           This would require that you use as your input'/
     3 '           1) TART 616 groups'/
     4 '           2) GROUPIE Standard definition of Sigma0'/
     5 '              (multiples of total cross section in each group)')
      endif
      else
c-----There is no defined Unresolved Resonance Region.
      WRITE(3,280)
      WRITE(*,280)
  280 format(
     1 ' Unresolved Resonance Region... NONE'/
     1 ' WARNING - NO Unresolved Self-Shielding'/
     2       1x,78('-'))
      endif
      endif
      write(3,290)
      write(*,290)
  290 format(1x,78('-'))
c-----------------------------------------------------------------------
C
C     END OF MAT. PRINT SUMMARY OF MATERIAL AND ERROR MESSAGES.
C
c-----------------------------------------------------------------------
C-----SUMMARY OF MATERIAL.
      CALL OUT9G(TEMP1,FIELDX(1,1))
      WRITE(OUTP,570) ZABCD,MATNOW,MFHOUT,FMTHOL,(FIELDX(M,1),M=1,11),
     1 (NPTUSE(I),I=2,5),NPTUSE(1)
      WRITE(*   ,570) ZABCD,MATNOW,MFHOUT,FMTHOL,(FIELDX(M,1),M=1,11),
     1 (NPTUSE(I),I=2,5),NPTUSE(1)
C-----PRINT WARNING MESSAGE IF SELF-SHIELDING CALCULATION WAS REQUESTED
C-----AND THE TOTAL CROSS SECTION IS NOT PRESENT.
      IF(MFHOUT.NE.3.OR.NPTUSE(2).GT.0.OR.NOSELF.NE.0) GO TO 300
      WRITE(OUTP,550)
      WRITE(*   ,550)
C-----PRINT WARNING IF MINIMUM IS LESS THAN ALLOWABLE VALUE FOR ANY
C-----CROSS SECTION.
  300 DO 360 I=1,NSECT
      IF(REDMIN(I).GE.OKMIN(I)) GO TO 360
      CALL OUT9G(REDMIN(I),FIELDX(1,1))
      IF(I.lt.2) go to 310
      IF(I.eq.2) go to 320
      IF(I.lt.4) go to 330
      IF(I.eq.4) go to 340
      go to 350
C-----OTHER.
  310 WRITE(OUTP,500) (FIELDX(M,1),M=1,11)
      GO TO 360
C-----TOTAL.
  320 WRITE(OUTP,510) (FIELDX(M,1),M=1,11)
      GO TO 360
C-----ELASTIC.
  330 WRITE(OUTP,520) (FIELDX(M,1),M=1,11)
      GO TO 360
C-----CAPTURE.
  340 WRITE(OUTP,530) (FIELDX(M,1),M=1,11)
      GO TO 360
C-----FISSION.
  350 WRITE(OUTP,540) (FIELDX(M,1),M=1,11)
  360 CONTINUE
C-----INCREMENT POINT COUNTS FOR ENTIRE FILE.
      DO 370 I=1,5
      NPTTOT(I)=NPTTOT(I)+NPTUSE(I)
  370 CONTINUE
C-----BRANCH BACK TO START NEXT MATERIAL.
      GO TO 20
c-----------------------------------------------------------------------
C
C     END OF RUN. IF MULTIBAND PARAMETERS WERE GENERATED WRITE REPORT
C     FOR EACH EVALUATION INDICATING THE MAXIMUM ERROR IN ANY GROUP
C     THAT WILL RESULT IF MULTIBAND PARAMETERS ARE USED TO DEFINE
C     SELF-SHIELDED CROSS SECTIONS AT ANY POINT ALONG THE ENTIRE
C     SELF-SHIELDED CURVE FOR SIGMA0=0 TO INFINITY. ALSO WRITE SUMMARY
C     OF MAXIMUM ERROR FOR ANY NUMBER OF BANDS, FOR EACH COMBINATION
C     OF (SIGMAO,N).
C
c-----------------------------------------------------------------------
C-----PRINT WARNING MESSAGE IF NO DATA SATISFIED REQUESTS.
  380 IF(LASTZA.GT.0) GO TO 390
      WRITE(OUTP,680)
      WRITE(*   ,680)
      GO TO 490
C-----OUTPUT TOTAL POINT COUNTS.
  390 WRITE(OUTP,590) (NPTTOT(I),I=2,5),NPTTOT(1)
      WRITE(*   ,590) (NPTTOT(I),I=2,5),NPTTOT(1)
C-----NO MULTIBAND LIBRARY SUMMARY IF MULTIBAND PARAMETERS WERE
C-----NOT GENERATED.
      IF(LZA.LE.0) GO TO 490
C-----FOR EACH EVALUATION LIST ERROR VS. BANDS TABLE.
      WRITE(OUTP,620)
      DO 450 LLZA=1,LZA
      NBNEED=NBNTAB(LLZA)
      GO TO (400,410,420,430,440),NBNEED
  400 WRITE(OUTP,670) IZATAB(LLZA),ERBTAB(1,LLZA)
      GO TO 450
  410 WRITE(OUTP,630) IZATAB(LLZA),(ERBTAB(I,LLZA),I=1,NBNEED)
      GO TO 450
  420 WRITE(OUTP,640) IZATAB(LLZA),(ERBTAB(I,LLZA),I=1,NBNEED)
      GO TO 450
  430 WRITE(OUTP,650) IZATAB(LLZA),(ERBTAB(I,LLZA),I=1,NBNEED)
      GO TO 450
  440 WRITE(OUTP,660) IZATAB(LLZA),(ERBTAB(I,LLZA),I=1,NBNEED)
  450 CONTINUE
C-----LIST MAXIMUM ERROR VS. SIGMA0 FOR THE ENTIRE FILE.
      WRITE(OUTP,600)
      DO 470 I=1,25
      DO 460 NB=1,NBMAX
      ERLIB(I,NB)=100.0d0*ERLIB(I,NB)
  460 CONTINUE
      WRITE(OUTP,610) I,(ERLIB(I,J),J=1,NBMAX)
  470 CONTINUE
C-----------------------------------------------------------------------
C
C     PRINT SUMMARY OF TYPES OF CONVERGENCE FOR MULTI-BAND PARAMETERS
C
C-----------------------------------------------------------------------
      MYLOGSUM =0
      do k=1,8
      MYLOGSUM = MYLOGSUM + MYLOG(k)
      enddo
      WRITE(*,480) MYLOG,MYLOGSUM,LZA*NGR
      WRITE(3,480) MYLOG,MYLOGSUM,LZA*NGR
  480 FORMAT(1X,78('-')/' Summary of Multi-Band Results'/1X,78('-')/
     1 ' No Self-Shielding (Conserve 1 Moment)..........',I11/
     2 ' Little Self-Shielding (Conserve 2 Moments).....',I11/
     3 ' General Self-Shielding (Conserve 3 Moments)....',I11/
     4 ' Strict Convergence.............................',I11/
     5 ' Not Strict Convergence.........................',I11/
     6 ' Soft Convergence...............................',I11/
     7 ' Very Soft Convergence..........................',I11/
     8 ' No Convergence.................................',I11/
     9 ' Sum............................................',I11/
     9 ' Check (Evaluations x Groups)...................',I11)
C-----IF ENDF/B FORMAT OUTPUT, OUTPUT FEND. MEND AND TEND LINES, AS
C-----REQUIRED.
  490 MATH=-1
      MFH=0
      MTH=0
      NOSEQ=0
      CALL CONTOG
C-----END ENDF/B FORMATTED FILE AND LISTING FILES.
      WRITE(OUTP,560)
      WRITE(*   ,560)
      OTAPE = 11        ! FORCE ON-LINE RUNING TIME REPORT.
c-----2019/3/9 - Final WARNING if inconsitent maximum tabulated energy
      CALL MAXIE4(1)
      CALL ENDIT
      GO TO 380    ! cannot get to here.
  500 FORMAT(' WARNING....Minimum Other   in Above',
     1 ' Material is',
     2 1X,11A1,' barns.')
  510 FORMAT(' WARNING....Minimum Total   in Above',
     1 ' Material is',
     2 1X,11A1,' barns.')
  520 FORMAT(' WARNING....Minimum Elastic in Above',
     1 ' Material is',
     2 1X,11A1,' barns.')
  530 FORMAT(' WARNING....Minimum Capture in Above',
     1 ' Material is',
     2 1X,11A1,' barns.')
  540 FORMAT(' WARNING....Minimum Fission in Above',
     1 ' Material is',
     2 1X,11A1,' barns.')
  550 FORMAT(' WARNING...Total Cross Section is Not Given for Above',
     1 ' Material.'/
     2 ' Self-Shielding and Multiband Calculation Skipped',
     3 ' (i.e. Impossible)')
  560 FORMAT(1X,78('-')/' Other Points = Points Other Than Total,',
     1 ' Elastic, Capture or Fission.'/
     3 ' This Will Always be Zero Unless Unshielded Output is',
     4 ' Requested.'/1X,78('-'))
  570 FORMAT(12A1,I5,I3,2X,A1,11A1,5I8)
  580 FORMAT(1X,78('-')/' ENDF/B Tape Label'/1X,78('-')/1X,16A4,A2,I4/
     1 1X,78('-')/' Isotope      MAT MF Fmt Kelvin   ',
     2 '   Total Elastic Capture Fission   Other'/15X,'     ',14X,
     3 '  Points  Points  Points  Points  Points'/1X,78('-'))
  590 FORMAT(1X,78('-')/27X,'Totals ',5I8)
  600 FORMAT(///8X,'Maximum per-cent Error vs. Sigma-0 for Entire',
     1 ' FILE'/1X,78('-')/' Index *    1 Band  *  2 Bands  ',
     2 '*  3 Bands  *  4 Bands  *  5 Bands'/1X,78('-'))
  610 FORMAT(I6,1X,'*',F10.2,2X,4('*',F9.2,2X))
  620 FORMAT(///8X,'Maximum per-cent Error During Sigma-0',
     1 ' INTERPOLATION'/1X,78('-')/'    ZA *    1 Band  *  2 Bands  ',
     2 '*  3 Bands  *  4 Bands  *  5 Bands'/1X,78('-'))
  630 FORMAT(I6,1X,'*',F10.2,2X,'*',F9.2,2X,3('*',11X))
  640 FORMAT(I6,1X,'*',F10.2,2X,2('*',F9.2,2X),2('*',11X))
  650 FORMAT(I6,1X,'*',F10.2,2X,3('*',F9.2,2X),'*')
  660 FORMAT(I6,1X,'*',F10.2,2X,4('*',F9.2,2X))
  670 FORMAT(I6,1X,'*',F10.2,2X,4('*',11X))
  680 FORMAT(/' WARNING....No Data Found That Satisfied Retrieval',
     1 ' Criteria.'/11X,
     2 ' Therefore No Data was Group Averaged or Written to Output',
     3 'FILE.'/1X,78('-'))
      END
      SUBROUTINE FILE1
C=======================================================================
C
C     ADD COMMENTS AT THE END OF FILE 1, SECTION 451 TO INDICATE
C     THAT THIS MATERIAL HAS BEEN PROCESSED BY PROGRAM GROUPIE AND
C     TO SPECIFY THE NUMBER OF GROUPS USED.
C
C     DEFINE FORMAT TO BE ENDF/B-4, 5 OR 6.
C
C     THE ENDF/B FORMAT CAN BE DETERMINED FROM THE SECOND CARD.
C     ENDF/B-4  = N1 > 0, N2 = 0, CARD COUNT (POSITIVE)
C     ENDF/B-5  = N1 = N2 = 0
C     ENDF/B-6         N2 = VERSION NUMBER (6 OR MORE)
C
C     Firsr line has been read
C
C=======================================================================
      INCLUDE 'implicit.h'
      CHARACTER*1 PROGDOC1
      CHARACTER*4 FMTTAB,FMTHOL
      CHARACTER*66 PROGDOC
      INTEGER*4 OUTP,OTAPE
      COMMON/ENDFIO/INP,OUTP,ITAPE,OTAPE
      COMMON/HEADER/C1H,C2H,L1H,L2H,N1H,N2H,MATH,MFH,MTH,NOSEQ
      COMMON/LEADER/TEMP,Q,L1,L2,N1,N2,MAT,MF,MT
      COMMON/HOLFMT/FMTHOL
      COMMON/SPIM/IMSP
      COMMON/VERSES/TEMP3,IVERSE
      COMMON/LISCOM/LISO
      COMMON/RESCOM/RES1,RES2,URES1,URES2,LSSF,ICOMP,INTUNR,INPART
      INCLUDE 'groupie.h'
      DIMENSION FMTTAB(4),PROGDOC(6),PROGDOC1(66,6)
      EQUIVALENCE (PROGDOC(1),PROGDOC1(1,1))
      DATA FMTTAB/'4','5','6','7'/
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
     1 ' ***************** Program GROUPIE (VERSION 2021-1)***********',
     2 ' Unshielded Group Averages Using 12345 Groups                 ',
     3 ' Weighting Spectrum: Maxwellian,1/E,Fission,Constant Spectrum ',
     4 ' Weighting Spectrum: 1/E Spectrum                             ',
     5 ' Weighting Spectrum: Flat (Constant) Spectrum                 ',
     6 ' Weighting Spectrum: Input Spectrum                           '/
c-----------------------------------------------------------------------
c
C     WARNING - Only 3 of the above 6 lines are OUTPUT.
C
c-----------------------------------------------------------------------
C-----FILL IN REMAINDER OF FIRST LINE.
      PROGDOC1(63,1) = '*'
      PROGDOC1(64,1) = '*'
      PROGDOC1(65,1) = '*'
      PROGDOC1(66,1) = '*'
      INPART= 1     ! Initialize to neutron (in case not ENDF6 format)
C-----HEAD CARD OF SECTION HAS BEEN READ. WRITE IT AND READ NEXT CARD
C-----AND DETERMINE IF THIS IS THE ENDF/B-IV, V OR VI FORMAT.
      CALL CONTOG
c
c     Read Second line
c
      CALL CARDI(C1,C2,L1,L2,N1,N2)
      IVERSE=4
      LISOX = L2          ! Save potential target isomer state number
C-----CHECK FOR ENDF/B-IV.
C-----IV N1 > 0, N2 = 0
      IF(N1.GT.0.AND.N2.EQ.0) GO TO 10
C-----NOT ENDF/B-IV. READ THIRD CARD.
      N2IN=N2
      CALL CARDO(C1,C2,L1,L2,N1,N2)
c
c     Read Third line
c
      CALL CARDI(C1,C2,L1,L2,N1,N2)
      IVERSE=5
C-----CHECK FOR ENDF/B-V FORMAT.
      IF(N2IN.LE.0) GO TO 10
      N1IN = N1
C-----ENDF/B-VI FORMAT. READ FOURTH CARD.
      CALL CARDO(C1,C2,L1,L2,N1,N2)
c
c     Read Third line
c
      CALL CARDI(C1,C2,L1,L2,N1,N2)
      IVERSE=6
      TEMP3=C1
      INPART = N1IN/10
      LISO    = LISOX
C-----SET DERIVED MATERIAL FLAG.
      L1=1
C-----DEFINE ENDF/B FORMAT NUMBER.
   10 FMTHOL=FMTTAB(IVERSE-3)
C-----SKIP OUTPUT IF NO ENDF/B FORMATTED OUTPUT.
      IF(OTAPE.LE.0) GO TO 30
C-----INCREASE COMMENT CARD COUNT AND COPY TO END OF HOLLERITH.
      N1P3=N1+3
      CALL CARDO(C1,C2,L1,L2,N1P3,N2)
      DO 20 N=1,N1
      CALL COPY1G
   20 CONTINUE
c-----------------------------------------------------------------------
C
C     ADD THREE COMMENT LINES.
C
c-----------------------------------------------------------------------
C-----PROGRAM NAME AND VERSION
      CALL HOLLYO(PROGDOC1(1,1))
C-----NUMBER OF GROUPS
      CALL INTOUT(NGR,PROGDOC1(34,2),5)
      CALL HOLLYO(PROGDOC1(1,2))
C-----WEIGHTING SPECTRUM.
      IF(IMSP.EQ.1) CALL HOLLYO(PROGDOC1(1,3))
      IF(IMSP.EQ.2) CALL HOLLYO(PROGDOC1(1,4))
      IF(IMSP.EQ.3) CALL HOLLYO(PROGDOC1(1,5))
      IF(IMSP.EQ.4) CALL HOLLYO(PROGDOC1(1,6))
C-----COPY TO END OF FILE (MF=0)
   30 CALL COPYFG    ! Copy to end of FILE (MF=0)
      RETURN
      END
      SUBROUTINE FILE2
C=======================================================================
C
C     SIGMA1 FILE2 ADAPTED FOR USE BY GROUPIE.
C     ========================================
C     READ RESONANCE PARAMETERS IN ORDER TO DEFINE THE ENERGY RANGE
C     OF THE RESOLVED AND UNRESOLVED RESONANCE REGION.
C
C     NO TESTS FOR INCONSISTENCY = STOP ON ERROR
C
C     RES1    = Lower Energy limit of Resolved.
C     RES2    = Upper Energy limit of Resolved.
C     URES1   = Lower Energy limit of Unresolved.
C     URES2   = Upper Energy limit of Unresolved.
C
C=======================================================================
      INCLUDE 'implicit.h'
      CHARACTER*4 FMTHOL
      INTEGER*4 OUTP,OTAPE
      COMMON/HEADER/C1H,C2H,L1H,L2H,N1H,N2H,MATH,MFH,MTH,NOSEQ
      COMMON/LEADER/C1,C2,L1,L2,N1,N2,MAT,MF,MT
      COMMON/ENDFIO/INP,OUTP,ITAPE,OTAPE
      COMMON/RESCOM/RES1,RES2,URES1,URES2,LSSF,ICOMP,INTUNR,INPART
      COMMON/WHATZA/ATWT,IZA,MATNOW,MFNOW
      COMMON/HOLFMT/FMTHOL
C-----Initialize
      INPART= 1     ! Initialize to neutron (in case not ENDF6 format)
      RES1  = 0.0d0
      RES2  = 0.0d0
      URES1 = 0.0d0
      URES2 = 0.0d0
c-----GROUPIE/SIGMA1 Differ
      CALL CONTOG
C-----HEAD RECORD ALREADY READ. DEFINE NUMBER OF ISOTOPES.
      NIS=N1H
C-----DO LOOP OVER ALL ISOTOPES
      DO 270 IS=1,NIS
      CALL CARDIO(C1H,C2H,L1H,LFW,NER,N2H)
C-----DO LOOP OVER ALL ENERGY RANGES
      DO 260 JER=1,NER
      CALL CARDIO(EL,EH,LRU,LRF,N1H,N2H)
c-----------------------------------------------------------------------
c
c     2017/5/16 - added NRO - Energy dependent scattering radius
c
c-----------------------------------------------------------------------
      NRO = N1H
      if(NRO.eq.1) then
c-----Energy dependent scattering radius = copy TAB1 record
      CALL CARDIO(C1,C2,L1,L2,N1,N2)
      do i=1,N1,3                  ! Interpolation law (NBT,INT) Pairs
      CALL COPY1G
      enddo
      do I=1,N2,3                  ! Scattering radius (X,Y) Pairs
      CALL COPY1G
      enddo
      endif
C-----DEFINE LRU FOR INTERNAL USE AS ORIGINAL LRU (BEFORE RECENT).
      IF(LRU.GT.3) LRU=LRU-3
C-----Select resolved or unresolved or NONE.
      IF(LRU.eq.1) go to 10    ! Resolved
      IF(LRU.gt.1) go to 20    ! unresolved
c-----------------------------------------------------------------------
C
C     NO RESONANCE PARAMETERS PRESENT
C
c-----------------------------------------------------------------------
C-----COPY SECTION WITH NO RESONANCE PARAMETERS.
      CALL CARDIO(C1H,C2H,L1H,L2H,N1H,N2H)
      GO TO 260
C-----------------------------------------------------------------------
C
C     Resolved.
C
C-----------------------------------------------------------------------
C-----DEFINE UNITED ENERGY RANGE.
   10 IF(RES2.le.0.0d0) then
      RES1 = EL
      RES2 = EH
      else
      IF(EL.lt.RES1) RES1 = EL
      IF(EH.gt.RES2) RES2 = EH
      endif
      go to 30
C-----------------------------------------------------------------------
C
C     Unresolved.
C
C-----------------------------------------------------------------------
C-----DEFINE UNITED ENERGY RANGE.
   20 IF(URES2.le.0.0d0) then
      URES1 = EL
      URES2 = EH
      else
      IF(EL.lt.URES1) URES1 = EL
      IF(EH.gt.URES2) URES2 = EH
      endif
C-----------------------------------------------------------------------
C
C     RESONANCE PARAMETERS PRESENT
C
C-----------------------------------------------------------------------
C
C     LRU= 1 - RESOLVED
C     LRF= 1 - SLBW, = 2 - MLBW, = 3 - REICH-MOORE, = 4 - ADLER-ADLER
C            - NEW REICH-MOORE = 7
C
C     LRU= 2 - UNRESOLVED
C     LRF= 1 - ENERGY INDEPENDENT WIDTHS (EXCEPT POSSIBLY FISSION)
C        = 2 - ENERGY   DEPENDENT WIDTHS
C
C-----------------------------------------------------------------------
   30 IF(LRU.NE.1) GO TO 40    ! Resolved?
      IF(LRF.EQ.1.OR.          ! Single Level Breit-Wigner
     1   LRF.EQ.2.OR.          ! Multi-Level  Breit-Wigner
     2   LRF.EQ.3) GO TO 50    ! Reich=Moore
      IF(LRF.EQ.4) GO TO 80    ! Adler-Adler
      IF(LRF.EQ.7) GO TO 130   ! New Reich-Moore
C-----ILLEGAL - IGNORE REMAINDER OF FILE 2
      GO TO 280
   40 IF(LRU.NE.2) GO TO 280   ! Unresolved?
      IF(LRF.EQ.1) GO TO 150   ! Energy Independent Widths
      IF(LRF.EQ.2) GO TO 220   ! Energy   Dependent Widths
C-----ILLEGAL - IGNORE REMAINDER OF FILE 2
      GO TO 280
C-----------------------------------------------------------------------
C
C     BREIT-WIGNER (SINGLE OR MULTI-LEVEL) OR REICH-MOORE FORMALISM
C
C-----------------------------------------------------------------------
C-----READ NEXT CARD.
   50 CALL CARDIO(C1H,C2H,L1H,L2H,NLS,N2H)
C-----LOOP OVER ALL L STATES
      DO 70 ILS=1,NLS
C-----READ NEXT CARD.
      CALL CARDIO(C1H,C2H,L1H,L2H,NRS6,NRS)
C-----COPY RESONANCE PARAMETERS.
      DO 60 IRS=1,NRS
      CALL COPY1G
   60 CONTINUE
   70 CONTINUE
      GO TO 260
C-----------------------------------------------------------------------
C
C     ADLER-ADLER FORMALISM
C
C-----------------------------------------------------------------------
C-----READ NEXT CARD.
   80 CALL CARDIO(C1H,C2H,L1H,L2H,NLS,N2H)
C-----READ BACKGROUND CORRECTIONS.
      CALL CARDIO(C1H,C2H,L1H,L2H,NX6,N2H)
C-----COPY BACKGROUND CORRECTION CONSTANTS.
      DO 90 I=1,NX6,6
      CALL COPY1G
   90 CONTINUE
C-----LOOP OVER L STATES
      DO 120 I=1,NLS
      CALL CARDIO(C1H,C2H,L1H,L2H,NJS,N2H)
C-----LOOP OVER J STATES
      DO 110 J=1,NJS
      CALL CARDIO(C1H,C2H,L1H,L2H,N1H,NLJ)
C-----COPY ALL RESONANCE DATA
      DO 100 K=1,NLJ
      CALL COPY1G
      CALL COPY1G
  100 CONTINUE
  110 CONTINUE
  120 CONTINUE
      GO TO 260
C-----------------------------------------------------------------------
C
C     NEW REICH-MOORE FORMALISM
C
C-----------------------------------------------------------------------
C-----DEFINE NUMBER OF J STATES
  130 CALL CARDIO(C1,C2,L1,L2,NJS,N2)
C-----DEFINE NUMBER OF PARTICLE-PAIRS
      CALL CARDIO(C1,C2,L1,L2,NPP12,N2)
C-----COPY PARTICLE-PAIR DATA
      DO N=1,NPP12,6
      CALL COPY1G
      ENDDO
C-----LOOP OVER J STATES
      DO 140 IJ=1,NJS
C-----J, PARITY, AND NUMBER OF CHANNELS
      CALL CARDIO(C1,C2,L1,L2,NCH6,N2)
C-----COPY CHANNEL DATA
      DO N=1,NCH6,6
      CALL COPY1G
      ENDDO
C-----DEFINE NUMBER OF RESONANCES
      CALL CARDIO(C1,C2,L1,L2,N1,NRS)
C-----COPY RESONANCE PARAMETERS
      DO N=1,NRS
      CALL COPY1G
      ENDDO
  140 CONTINUE
      GO TO 260
C-----------------------------------------------------------------------
C
C     UNRESOLVED WITH ENERGY INDEPENDENT WIDTHS (LRF = 1)
C
C-----------------------------------------------------------------------
C-----TEST IF FISSION WIDTHS GIVEN
  150 IF(LFW.gt.0) go to 180
c-----------------------------------------------------------------------
C
C     Case A: FISSION WIDTHS NOT GIVEN (LFW = 0/ LRF = 1)
C
c-----------------------------------------------------------------------
      CALL CARDIO(C1H,C2H,L1H,L2H,NLS,N2H)
      LSSF = L1H
C-----LOOP OVER ALL L-STATES
      DO 170 ILS=1,NLS
      CALL CARDIO(C1H,C2H,L1H,L2H,N1H,NJS)
      DO 160 N=1,NJS
      CALL COPY1G
  160 CONTINUE
  170 CONTINUE
      GO TO 260
c-----------------------------------------------------------------------
C
C     Case B: FISSION WIDTHS GIVEN (LFW = 1/ LRF = 1)
C
c-----------------------------------------------------------------------
  180 CALL CARDIO(C1H,C2H,L1H,L2H,NE,NLS)
      LSSF = L1H
C-----COPY FISSION WIDTH ENERGY POINTS
      DO 190 I=1,NE,6
      CALL COPY1G
  190 CONTINUE
C-----LOOP OVER L-STATES
      DO 210 I=1,NLS
      CALL CARDIO(C1H,C2H,L1H,L2H,NJS,N2H)
C-----LOOP OVER J STATES
      DO J=1,NJS
      CALL CARDIO(C1H,C2H,L1H,L2H,NEP6,N2H)
      DO 200 K=1,NEP6,6
      CALL COPY1G
  200 CONTINUE
      ENDDO
  210 CONTINUE
      GO TO 260
C-----------------------------------------------------------------------
C
C     Case C: UNRESOLVED WITH ALL ENERGY DEPENDENT WIDTHS (LRF = 2)
C             Independent of LFW
C
C-----------------------------------------------------------------------
C-----READ NEXT CARD.
  220 CALL CARDIO(C1H,C2H,L1H,L2H,NLS,N2H)
      LSSF = L1H
C-----DO LOOP OVER L-STATES
      DO 250 I=1,NLS
      CALL CARDIO(C1H,C2H,L1H,L2H,NJS,N2H)
      DO 240 J=1,NJS
      CALL CARDIO(C1H,C2H,L1H,L2H,NE6P6,N2H)
C-----COPY NUMBER OF DEGREES OF FREEDOM AND PARAMETERS.
      DO 230 K=1,NE6P6,6
      CALL COPY1G
  230 CONTINUE
  240 CONTINUE
  250 CONTINUE
C-----END OF ENERGY RANGE LOOP
  260 CONTINUE
C-----END OF ISOTOPE LOOP
  270 CONTINUE
C-----------------------------------------------------------------------
C
C     FINISHED O.K.
C
C-----------------------------------------------------------------------
C-----COPY TO END OF FILE (MF=0)
      CALL COPYFG
      RETURN
C-----------------------------------------------------------------------
C
C     ERROR.
C
C-----------------------------------------------------------------------
  280 WRITE(3,290)
      WRITE(*,290)
  290 FORMAT(1x,78('=')/
     1 ' ERROR - Reading MF/MT=2/151 Resonance Parameters.'/
     1 '         Execution Terminated.'/1x,78('='))
      CALL ENDERROR
      RETURN          ! Dummy RETURN to satisfy some compilers.
      END
      SUBROUTINE PAGIN5(KTAPE,ITYPE,NTYPE)
C=======================================================================
C
C     READ TABLE OF DATA IN THE ENDF/B FORMAT AND LOAD IT INTO THE
C     PAGING SYSTEM. THIS ROUTINE IS USED TO READ EITHER THE ENERGY
C     DEPENDENT WEIGHTING SPECTRUM FROM THE INPUT FILE OR A SECTION
C     OF CROSS SECTIONS FROM THE ENDF/B FORMAT FILE. IN EITHER CASE
C     THIS ROUTINE WILL ONLY READ (X,Y) PAIRS IN 6E11.4 FORMAT (I.E.
C     IF READING FROM THE ENDF/B FORMAT THE SECTION HEAD CARDS AND
C     INTERPOLATION LAW MUST BE READ BEFORE CALLING THIS ROUTINE).
C
C     ARGUMENTS
C     ---------
C     KTAPE = LOGICAL NUMBER UNIT OF INPUT FILE.
C     ITYPE = PAGING SYSTEM STORAGE INDEX THAT DEFINES WHERE TO STORE
C             DATA.
C           = 1 ENERGY DEPENDENT WEIGHTING SPECTRUM
C           = 2 TOTAL CROSS SECTION (IF SELF-SHIELDING CALCULATION).
C               ALL CROSS SECTIONS (IF ONLY UNSHIELDED CALCULATION).
C           = 3 ELASTIC CROSS SECTION
C           = 4 CAPTURE CROSS SECTION.
C               ALL CROSS SECTIONS EXCEPT TOTAL, ELASTIC OR FISSION
C               (IF SELF-SHIELDING CALCULATION).
C           = 5 FISSION CROSS SECTION
C     NTYPE = DEFINES THE TYPE OF DATA
C           = 1 ENERGY DEPENDENT WEIGHTING SPECTRUM.
C               ALL CROSS SECTIONS (EXCEPT TOTAL, ELASTIC, CAPTURE
C               OR FISSION).
C           = 2 TOTAL CROSS SECTION
C           = 3 ELASTIC CROSS SECTION
C           = 4 CAPTURE CROSS SECTION
C           = 5 FISSION CROSS SECTION
C
C=======================================================================
      INCLUDE 'implicit.h'
      INTEGER*4 OUTP,OTAPE
      CHARACTER*1 FIELDX
      COMMON/ENDFIO/INP,OUTP,ITAPE,OTAPE
      COMMON/HEADER/ZA,AWRIN,L1H,L2H,N1H,N2H,MATH,MFH,MTH,NOSEQ
      COMMON/PAGER/NPAGE,NPAGM1
      COMMON/REALLY/XE,XA(5),YA(5),YB(5),YC(5),NPTAB(5),IPTAB(5),NSECT
      COMMON/LASTE/ELAST
      COMMON/MINOK/OKMIN(5),REDMIN(5)
      COMMON/TABASE/NPT
      COMMON/RESCOM/RES1,RES2,URES1,URES2,LSSF,ICOMP,INTUNR,INPART
      COMMON/INPAGE/IXYLOW(5),IXYHI(5),ISCR(5)
      COMMON/FIELDC/FIELDX(11,22)
      INCLUDE 'groupie.h'
C-----PRINT TITLE FOR WEIGHTING SPECTRUM.
      IF(ITYPE.EQ.1) then
      WRITE(OUTP,140)
c-----2019/3/9 - Save mat/mf/mt
      CALL MAXIE1(   0,  0,  0)
      else
      CALL MAXIE1(MATH,MFH,MTH)
      endif
C-----DEFINE SCRATCH UNIT.
      NSCR=ISCR(ITYPE)
C-----READ FROM STANDARD FILE NAME.
      ISAVE=ITAPE
      ITAPE=KTAPE
C-----INITIALIZE LAST ENERGY FOR ASCENDING ENERGY TEST.
      ELAST=0.0d0
C-----SET UP LOOP OVER PAGES.
      N2X=NPTAB(ITYPE)
      DO 90 NPT=1,N2X,NPAGE
C-----READ NEXT PAGE.
      NNPT=NPT+NPAGM1
      IF(NNPT.GT.N2X) NNPT=N2X
      IHIGH=NNPT-NPT+1
      CALL POINTI(XPAGE(1,ITYPE),YPAGE(1,ITYPE),IHIGH)
c-----------------------------------------------------------------------
c
c     If there is a URR, Save Cross Section Values at ends of URR
c     Insure something is selected (allow fo NJOY shift)
c
c-----------------------------------------------------------------------
c-----Only MF=3 (neutrons) with unresolved resonance region (URES2 > 0)
      if(MFH.ne.3.or.URES2.le.0.0d0) go to 20
c-----Only self-shielded reactions: total, elastic, capture & fission
      iurr = 0
      if(MTH.eq.  1) iurr = 2         ! Note, the order
      if(MTH.eq.  2) iurr = 3         !       fission last
      if(MTH.eq.102) iurr = 4
      if(MTH.eq. 18) iurr = 5
      if(iurr.le.0) go to 20           ! skip all others
c
c     Search for ends of URR = URES1 to URES2
c
      do 10 k=1,IHIGH
      if(XPAGE(k,itype).lt.URES1) go to 10  ! Skip to start
c
c     keep last value at start (allow for RRR/URR discontinuity)
c
      if(XPAGE(k,itype).eq.URES1) then
      XCURRLIM(1,iurr) = YPAGE(k,itype)
      endif
c-----if none at start, save first above start (allow for NJOY shift)
      if(XPAGE(k,itype).gt.URES1.and.
     1   XCURRLIM(1,iurr).le.0.0d0) then
      XCURRLIM(1,iurr) = YPAGE(k,itype)
      endif
c
c     keep first value at end
c
      if(XPAGE(k,itype).lt.URES2) go to 10
      XCURRLIM(2,iurr) = YPAGE(k,itype)
      go to 20                             ! Finished when value defined
   10 continue
c-----------------------------------------------------------------------
c
c     2019/3/9 - Save maximum tabulated energy and value
c
c-----------------------------------------------------------------------
   20 CALL MAXIE2(XPAGE(IHIGH,ITYPE),YPAGE(IHIGH,ITYPE))
c-----------------------------------------------------------------------
c
c     Define ICOMP for URR Treatment
c     1) Only beginning of table
c     2) Only MF=3
c     3) Ony threshold below URR Max. energy
c     4) MT =  51 to  91 = Competition
c     5) MT = 103 to 107 = Absorption
c
c-----------------------------------------------------------------------
      IF(NPT.ne.1.or.MFH.ne.3) go to 30
      if(XPAGE(1,ITYPE).ge.URES2) go to 30
      if(MTH.ge.51.and.MTH.le.91) then    ! Competition
      ICOMP = MTH
      if(MTH.gt.51) ICOMP = 4             ! More than 1 level = use MT=4
      endif
      if(MTH.ge.103.and.MTH.le.107) then         ! Absorption
      if(ICOMP.lt.1000) ICOMP = 1000*MTH + ICOMP ! Only allow 1
      endif
c-----------------------------------------------------------------------
C
C     CHECK FOR MINIMUM ALLOWABLE VALUE.
C
c-----------------------------------------------------------------------
C-----(ALLOW MU-BAR, XI AND ETA TO BE NEGATIVE).
   30 IF(MTH.GE.251.AND.MTH.LE.253) GO TO 50
      DO 40 I=1,IHIGH
C-----IGNORE POINTS OUTSIDE MULTIGROUP ENERGY RANGE.
      IF(XPAGE(I,ITYPE).LT.EGROUP(    1)) GO TO 40
      IF(XPAGE(I,ITYPE).GT.EGROUP(NGRP1)) GO TO 40
      IF(YPAGE(I,ITYPE).LT.REDMIN(NTYPE)) REDMIN(NTYPE)=YPAGE(I,ITYPE)
   40 CONTINUE
C-----PRINT WEIGHTING SPECTRUM.
   50 IF(ITYPE.NE.1) GO TO 80
      DO 70 I=1,IHIGH,3
      II=I+2
      IF(II.GT.IHIGH) II=IHIGH
      J=0
      DO 60 III=I,II
      J=J+1
      CALL OUT9G(XPAGE(III,1),FIELDX(1,J))
      J=J+1
      CALL OUT9G(YPAGE(III,1),FIELDX(1,J))
   60 CONTINUE
      WRITE(OUTP,150) ((FIELDX(M,JJ),M=1,11),JJ=1,J)
   70 CONTINUE
C-----IF OVER ONE PAGE OF DATA MOVE DATA TO SCRATCH FILE.
   80 IF(N2X.LE.NPAGE) GO TO 90
      IF(NPT.EQ.1) REWIND NSCR
      CALL OBLOCK(NSCR,XPAGE(1,ITYPE),YPAGE(1,ITYPE),NPAGE)
   90 CONTINUE
C-----IS CROSS SECTION IN CORE OR ON SCRATCH.
      IF(N2X.GT.NPAGE) GO TO 100
C-----IN CORE. SET INDICES TO ENTIRE TABLE.
      IXYLOW(ITYPE)=0
      IXYHI(ITYPE)=N2X
      GO TO 110
C-----ON SCRATCH. LOAD FIRST PAGE AND SET INDICES TO FIRST PAGE.
  100 END FILE NSCR
      REWIND NSCR
      CALL IBLOCK(NSCR,XPAGE(1,ITYPE),YPAGE(1,ITYPE),NPAGE)
      IXYLOW(ITYPE)=0
      IXYHI(ITYPE)=NPAGE
C-----IF INPUT WEIGHTING SPECTRUM IS NEGATIVE PRINT MESSAGE AND
C-----TERMINATE.
  110 IF(ITYPE.NE.1.OR.(REDMIN(1).GE.OKMIN(1))) GO TO 120
      CALL OUT9G(REDMIN(1),FIELDX(1,1))
      WRITE(OUTP,130) (FIELDX(M,1),M=1,11)
c-----2018/1/23 - Added on-line output
      WRITE(*   ,130) (FIELDX(M,1),M=1,11)
      CALL ENDERROR
C-----RESTORE STANDARD UNIT NUMBER.
  120 ITAPE=ISAVE
      RETURN
  130 FORMAT(1x,78('=')/
     1 ' ERROR - Minimum Weighting Spectrum Value is',1x,11a1/
     1 '         It MUST be Positive for Calculations.'/
     2 '         Execution Terminated.'/1x,78('='))
  140 FORMAT(1X,78('-')/' Weighting Spectrum (Linearly Interpolable)'/
     1 1X,78('-')/'   Energy-eV   Spectrum',2X,
     2 '  Energy-eV   Spectrum',2X,'  Energy-eV   Spectrum'/
     3 1X,78('-'))
  150 FORMAT(1X,3(22A1,2X))
      END
      SUBROUTINE GROUPU
C=======================================================================
C
C     THIS ROUTINE IS DESIGNED TO COMPUTE UNSHIELDED GROUP
C     AVERAGED CROSS SECTIONS FOR ONE REACTION. BOTH THE ENERGY
C     DEPENDENT WEIGHTING SPECTRUM AND THE CROSS SECTION MUST BE
C     LINEAR INTERPOLABLE BETWEEN ADJACENT TABULATED POINTS. ALL
C     INTEGRALS ARE PERFORMED ANALYTICALLY.
C
C=======================================================================
      INCLUDE 'implicit.h'
      INTEGER*4 OUTP,OTAPE,OTAPE2
      COMMON/HEADER/C1H,C2H,L1H,L2H,N1H,N2H,MATH,MFH,MTH,NOSEQ
      COMMON/REALLY/XE,XA(5),YA(5),YB(5),YC(5),NPTAB(5),IPTAB(5),NSECT
      COMMON/TRASH/ERROK,ER10PC,MGROUP,METHODB,NBAND,NBMAX,
     1 NBNEED,MYSIGMA0
      COMMON/COMXTEND/MYXTEND
      COMMON/ENDFIO/INP,OUTP,ITAPE,OTAPE
      COMMON/UNITS/OTAPE2,NTAPE,LIST1,LIST2,LIST3,IPLOT
      COMMON/FILLER/ISECT
      COMMON/MINOK/OKMIN(5),REDMIN(5)
      COMMON/TYPER/NTYPE
      INCLUDE 'groupie.h'
      DIMENSION JSECT(2),LPTAB(5)
C-----INITIALIZE INDICES TO SOURCE SPECTRUM.
      DATA JSECT/1,0/
      DATA LPTAB/5*1/
c-----------------------------------------------------------------------
C
C     FIND FIRST CROSS SECTION POINT OF INTEREST (EITHER THE FIRST
C     TABULATED POINT OR THE THRESHOLD. THE THRESHOLD IS HEREIN
C     DEFINED TO BE THE HIGHEST ENERGY POINT AT WHICH THE CROSS
C     SECTION IS ZERO. IN ENDF/B THIS IS NOT NECESSARILY THE FIRST
C     TABULATED DATA POINT). DEFINE ENERGY AT THIS POINT. SAVE
C     INDEX TO FIRST POINT OF INTEREST (LPTAB) AND INITIALIZE POINT
C     INDEX TO PRECEEDING POINT (IPTAB).
C
c-----------------------------------------------------------------------
      JJ=NPTAB(ISECT)
      DO 10 JP=1,JJ
      J=JP
      CALL XYPAGE(J,ISECT,XA(2),YA(2))
      IF(YA(2).gt.0.0d0) go to 20
      XALAST=XA(2)
   10 CONTINUE
      GO TO 180
   20 IPTAB(1)=0
      J=J-1
      IF(J.GT.0) XA(2)=XALAST
      IF(J.LT.1) J=1
      LPTAB(ISECT)=J
      IPTAB(ISECT)=J-1
c-----------------------------------------------------------------------
C
C     OUTPUT SHOULD NOT INCLUDE GROUPS WHOLLY OUTSIDE THE ENERGY
C     RANGE OF THE REACTION. SKIP ALL GROUPS THAT PRECEED FIRST
C     CROSS SECTION POINT OF INTEREST (IF ANY). SAVE INDEX TO FIRST
C     GROUP OF INTEREST (IGRLOW) TO DEFINE WHERE OUTPUT BEGINS.
C
c-----------------------------------------------------------------------
      DO 30 IGR=2,NGRP1
      IF(XA(2).LT.EGROUP(IGR)) GO TO 40
   30 CONTINUE
      GO TO 180
   40 IGRLOW=IGR-1
      JSECT(2)=ISECT
c-----------------------------------------------------------------------
C
C     DEFINE CROSS SECTION AND SPECTRUM VALUES OVER FIRST INTERVAL
C     OF FIRST GROUP OF INTEREST (FROM LOWER GROUP BOUNDARY TO FIRST
C     TABULATED POINT ABOVE LOWER GROUP BOUNDARY). IF THRESHOLD IS
C     WITHIN GROUP DEFINE CROSS SECTION BETWEEN LOWER GROUP BOUNDARY
C     AND THRESHOLD TO BE ZERO.
C
c-----------------------------------------------------------------------
      XB=EGROUP(IGRLOW)
      DO 90 I=1,2
      IISECT=JSECT(I)
C-----FIND FIRST DATA POINT ABOVE LOWER ENERGY BOUNDARY OF GROUP.
   50 IF(IPTAB(IISECT).LT.NPTAB(IISECT)) GO TO 60
      XA(I)=2.0D+20
      GO TO 90
   60 IPTAB(IISECT)=IPTAB(IISECT)+1
      CALL XYPAGE(IPTAB(IISECT),IISECT,XA(I),YA(I))
      IF(XA(I).gt.XB) go to 70
C-----POINT IS STILL BELOW ENERGY LIMIT. SAVE ENERGY AND CROSS SECTION
C-----FOR INTERPOLATION.
      XC=XA(I)
      YB(I)=YA(I)
      GO TO 50
C-----POINT IS ABOVE LOWER ENERGY LIMIT. IF THIS IS FIRST POINT OF
C-----INTEREST DEFINE PRECEDING INTERVAL WITH ZERO CROSS SECTION.
C-----OTHERWISE DEFINE CROSS SECTION AT LOWER ENERGY BOUNDARY OF
C-----GROUP BY LINEAR INTERPOLATION BETWEEN LAST TWO POINTS.
   70 IF(IPTAB(IISECT).GT.LPTAB(IISECT)) GO TO 80
      YA(I)=0.0d0
      YB(I)=0.0d0
      IPTAB(IISECT)=LPTAB(IISECT)-1
      GO TO 90
   80 YB(I)=((XB-XC)*YA(I)+(XA(I)-XB)*YB(I))/(XA(I)-XC)
   90 CONTINUE
c-----------------------------------------------------------------------
C
C     GROUP LOOP. DEFINE UPPER ENERGY LIMIT OF GROUP. INITIALIZE
C     INTEGRAL OF CROSS SECTION TIMES SPECTRUM (XCINT1) AND INTEGRAL
C     OF SPECTRUM (XCNRM1).
C
c-----------------------------------------------------------------------
      DO 170 IGR=IGRLOW,NGR
      XE=EGROUP(IGR+1)
      XCINT1=0.0d0
      XCNRM1=0.0d0
c-----------------------------------------------------------------------
C
C     DEFINE BEGINNING OF NEXT INTERVAL TO BE THE SAME AS THE END
C     OF THE LAST INTERVAL. SELECT LONGEST INTERVAL (XC TO XB)
C     WITHIN CURRENT ENERGY GROUP OVER WHICH BOTH SPECTRUM AND
C     CROSS SECTION ARE LINEARLY INTERPOLABLE (THIS IS MINIMUM ENERGY
C     OF XE, XA(1) AND XA(2)).
C
c-----------------------------------------------------------------------
  100 XC=XB
      YC(1)=YB(1)
      YC(2)=YB(2)
      XB=XE
      IF(XA(1).LT.XB) XB=XA(1)
      IF(XA(2).LT.XB) XB=XA(2)
c-----------------------------------------------------------------------
C
C     NEXT CALCULATION WILL BE INTEGRAL BETWEEN ENERGIES XC AND XB.
C     INTERPOLATE OVER THE ENERGY INTERVAL XC TO XA TO DEFINE THE
C     CROSS SECTION AND SPECTRUM AT ENERGY XB. IF THE ENTIRE INTERVAL
C     HAS THEN BEEN USED (I.E. XA.LE.XB) ADVANCE TO THE NEXT ENERGY
C     INTERVAL. SKIP ENERGY INTERVALS WITH NEGATIVE TOTAL CROSS SECTION
C     AND SKIP ALL EMPTY INTERVALS (ZERO LENGTH INTERVALS DUE TO
C     DISCONTINUITIES IN THE CROSS SECTION AND/OR SPECTRUM).
C
c-----------------------------------------------------------------------
      DO 130 I=1,2
      IISECT=JSECT(I)
      IF(XA(I).gt.XB) go to 120
c-----------------------------------------------------------------------
c
C     NEXT INTEGRAL WILL EXTEND TO END OF INTERVAL XC TO XA. DEFINE
C     INTERPOLATED VALUE AS END OF INTERVAL AND THEN SELECT NEXT
C     INTERVAL. IF BEYOND THE TABULATED ENERGY RANGE EXTEND AS CONSTANT
C     (I.E. KEEP SAME YA AND DEFINE NEW ENERGY AT 2.0D+20).
c
c-----------------------------------------------------------------------
      YB(I)=YA(I)
      IF(IPTAB(IISECT).LT.NPTAB(IISECT)) GO TO 110
c-----2015/8/6 - Insert another point at end with either
c-----           same or 0 cross section.
      IF(IPTAB(IISECT).EQ.NPTAB(IISECT)) then
      IPTAB(IISECT)=IPTAB(IISECT)+1
      if(MYXTEND.LE.0) YA(I) = 0.0d0
      go to 130
      ENDIF
C-----Beyond tabulated values.
      XA(I)=2.0D+20           ! DEFINE ENERGY WELL ABOVE GROUPS
      IF(MYXTEND.LE.0) THEN   ! USE LAST TABULATED VALUE OR ZERO?
      YA(I) = 0.0d0
      YB(I) = 0.0d0
      GO TO 130               ! Cross section = 0 - skip calculation
      ENDIF
      GO TO 120               ! Use cross section extension
c-----Next tabulated point.
  110 IPTAB(IISECT)=IPTAB(IISECT)+1
      CALL XYPAGE(IPTAB(IISECT),IISECT,XA(I),YA(I))
      GO TO 130
C-----NEXT INTEGRAL WILL ONLY BE OVER A PORTION OF THE INTERVAL XC TO
C-----XA. INTERPOLATE BETWEEN XC AND XA TO DEFINE VALUE AT XB.
  120 YB(I)=((XB-XC)*YA(I)+(XA(I)-XB)*YC(I))/(XA(I)-XC)
  130 CONTINUE
      DE=XB-XC
      IF(DE.LE.0.0d0) GO TO 140
C-----------------------------------------------------------------------
C
C     04/09/12 - USE ENTIRE ENERGY RANGE EVEN IF TOTAL IS NOT > 0
C
C-----------------------------------------------------------------------
C
C     COMPUTE CONTRIBUTION TO INTEGRAL OF CROSS SECTION TIMES
C     SPECTRUM AND INTEGRAL OF SPECTRUM.
C
c-----------------------------------------------------------------------
      AVSOUR=(YB(1)+YC(1))
      XCNRM1=XCNRM1+DE*AVSOUR
      XCINT1=XCINT1+DE*(AVSOUR*(YB(2)+YC(2))+
     1 (YB(1)-YC(1))*(YB(2)-YC(2))/3.0d0)
c-----------------------------------------------------------------------
C
C     TEST FOR END OF GROUP. END OF INTEGRAL OVER GROUP IF LAST ENERGY
C     INTERVAL (XC TO XB) EXTENDS TO THE UPPER BOUNDARY OF THE GROUP
C     (XE). IF NOT END OF GROUP CONTINUE WITH INTEGRALS. IF END OF
C     GROUP DEFINE AVERAGE VALUE AS RATIO OF INTEGRALS. IF THIS IS THE
C     TOTAL CROSS SECTION SAVE UNSHIELDED GROUP AVERAGE VALUE FOR LATER
C     SELF-SHIELDING CALCULATION (SEE GROUPS).
C
c-----------------------------------------------------------------------
  140 IF(XB.LT.XE) GO TO 100
      IF(XCNRM1.GT.0.0d0) GO TO 150
      AVN(IGR)=0.0d0
      GO TO 160
  150 AVN(IGR)=0.5d0*XCINT1/XCNRM1
  160 IF(NTYPE.EQ.2) TOTAV(IGR)=AVN(IGR)
c-----------------------------------------------------------------------
C
C     END OF GROUP LOOP.
C
c-----------------------------------------------------------------------
  170 CONTINUE
      GO TO 190
c-----------------------------------------------------------------------
C
C     GROUP STRUCTURE AND CROSS SECTION ENERGY RANGES DO NOT OVERLAP.
C     DEFINE ONE GROUP (THE HIGHEST ENERGY GROUP) WITH A CROSS SECTION
C     EQUAL TO ZERO.
C
c-----------------------------------------------------------------------
  180 IGRLOW=NGR
      AVN(NGR)=0.0d0
c-----------------------------------------------------------------------
C
C     SECTION HAS BEEN PROCESSED. PERFORM ALL REQUESTED OUTPUT.
C
c-----------------------------------------------------------------------
C-----OUTPUT IN ENDF/B FORMAT (IF REQUESTED)
  190 IF(OTAPE.GT.0) CALL TAB1(EGROUP,AVN,IGRLOW)
C-----OUTPUT IN LISTING FORMAT (IF REQUESTED)
      IF(LIST3.GT.0) CALL LISTAV(EGROUP,AVN,IGRLOW)
      RETURN
      END
      SUBROUTINE GROUPS
C=======================================================================
C
C     THIS ROUTINE IS DESIGNED TO COMPUTE SHIELDED AND
C     UNSHIELDED GROUP AVERAGED CROSS SECTIONS FOR TOTAL,
C     ELASTIC, CAPTURE AND FISSION CROSS SECTIONS. BOTH THE ENERGY
C     DEPENDENT WEIGHTING SPECTRUM AND ALL CROSS SECTIONS MUST BE LINEAR
C     INTERPOLABLE BETWEEN TABULATED VALUES. ALL INTEGRALS ARE
C     PERFORMED ANALYTICALLY.
C
C     ALTHOUGH ALL INTEGRALS ARE PERFORMED ANALYTICALLY WHEN PERFORMING
C     THE INTEGRAL (E1 TO E2) (SIGMAI(E)*S(E)/(SIGMAT(E)+SIGMAO)**N))
C     SPECIAL CARE MUST BE TAKEN WHEN THE TOTAL CROSS SECTION (SIGMAT)
C     IS CONSTANT OR ALMOST CONSTANT OVER ANY ENERGY INTERVAL OF
C     INTEGRATION. IN THIS CASE THE ANALYTICAL INTERGALS THAT ARE
C     OBTAINED CONTAIN A GREAT DEAL OF CROSS CANCELLATION OF TERMS. IN
C     ORDER TO ACCURATELY HANDLE THIS CASE AN EXPANSION IS USED TO
C     EVALUATE THE EXPRESSION...
C
C     (ALOG((1+R)/(1-R))-2.0*R)/(R**3)
C
C     WHERE R IS THE RATIO OF THE CHANGE IN TOTAL CROSS SECTION ACROSS
C     THE ENERGY INTERVAL TO TWICE THE AVERAGE TOTAL CROSS SECTION IN
C     THE INTERVAL....
C
C     R=(SIGMAT(E2)-SIGMAT(E1))/(SIGMAT(E2)+SIGMAT(E1))
C
C     DEFINING X=R**2 THE APPROPRIATE EXPANSION IS
C
C     2.0*(1/3+X/5+X**2/7+X**3/9+X**4/11+X**5/13+X**6/15+...
C
C     THIS EXPANSION IS TRUNCATED AFTER R**8 (ERROR OF ORDER R**10).
C     THEREFORE FOR ABS(R) LESS THAN 0.01 THIS EXPANSION WILL YIELD
C     16 DIGIT ACCURACY (ERROR OF ORDER 10**(-20)).
C
C=======================================================================
      INCLUDE 'implicit.h'
      INTEGER*4 OTAPE2,OPS
      CHARACTER*1 ZABCD,FIELDX
      CHARACTER*4 TUNITS,TMPHOL
      COMMON/UNITS/OTAPE2,NTAPE,LIST1,LIST2,LIST3,IPLOT
      COMMON/REALLY/XE,XA(5),YA(5),YB(5),YC(5),NPTAB(5),IPTAB(5),NSECT
      COMMON/OPUS/OPS(5)
      COMMON/WHATZA/ATWT,IZA,MATNOW,MFNOW
      COMMON/TRASH/ERROK,ER10PC,MGROUP,METHODB,NBAND,NBMAX,
     1 NBNEED,MYSIGMA0
      COMMON/ELPASD/TUNITS(2,4),TMPHOL(3)
      COMMON/ELPASZ/ZABCD(12)
      COMMON/ELPAS2/EGB,TMPK
      COMMON/MINOK/OKMIN(5),REDMIN(5)
      COMMON/ZABAD/IZABAD
      COMMON/FIELDC/FIELDX(11,22)
      COMMON/COMXTEND/MYXTEND
      COMMON/RESCOM/RES1,RES2,URES1,URES2,LSSF,ICOMP,INTUNR,INPART
c-----2019/11/09 - Added to initialize, in case there is no URR fit.
      COMMON/ERANGES/e1,e2,e3
      common/ACECOM/NUNR1,NUNR2,NUNROUT
      INCLUDE 'groupie.h'
      DIMENSION ERBIG(5),YBB(5),YCC(5)
      DATA IPASS/0/
      DATA ZERO/0.0D+0/
      DATA ONE /1.0D+0/
      DATA TWO /2.0D+0/
c-----------------------------------------------------------------------
C
C     FIRST TIME THROUGH INITIALIZE SECOND HALF OF SIGMA0
C     MULTIPLIER TABLE AND CONSTANTS FOR EXPANSION OF LOG
C     AS DESCRIBED ABOVE.
C
c-----------------------------------------------------------------------
      IF(IPASS.GT.0) GO TO 20
      IPASS=1
C-----DEFINE SECOND HALF OF SIGMA0 TABLE TO BE RECIPROCAL OF FIRST HALF.
      II=22
      DO 10 I=2,11
      SIGMAB(II)=1.0d0/SIGMAB(I)
      II=II-1
   10 CONTINUE
C-----DEFINE CONSTANTS FOR USE IN EXPANSION OF LOG (AS DESCRIBED ABOVE).
      F3 =2.0D+0/3.0D+0
      F5 =2.0D+0/5.0D+0
      F7 =2.0D+0/7.0D+0
      F9 =2.0D+0/9.0D+0
      F11=2.0D+0/11.0D+0
      F13=2.0D+0/13.0D+0
      F15=2.0D+0/15.0D+0
C-----THIS IS MINIMUM R**2 BELOW WHICH THE EXPANSION WILL BE USED.
      RATMIN=1.0D-4
C-----SIGMAB(23) MUST BE ZERO IF AV(1/TOT**2) AND AV(1/TOT**3) ARE TO BE
C-----CALCULATED PROPERLY (WARNING....DO NOT CHANGE)
      SIGMAB(23)=0.0d0
c-----------------------------------------------------------------------
C
c     2019/11/09 - Added to initialize, in case there is no URR fit.
C
c-----------------------------------------------------------------------
   20 NUNR1 = 0
      NUNR2 = 0
      e1 = 0.0d0
      e2 = 0.0d0
      e3 = 0.0d0
c-----------------------------------------------------------------------
C
C     CANNOT PERFORM SELF-SHIELDING AND MULTIBAND CALCULATION IF
C     TOTAL CROSS SECTION IS NOT GIVEN.
C
c-----------------------------------------------------------------------
      IF(NPTAB(2).LE.0) RETURN
c-----------------------------------------------------------------------
C
C     OUTPUT IDENTIFICATION INFORMATION FOR THIS MATERIAL.
C
c-----------------------------------------------------------------------
      IZABAD=0
C-----CONVERT KELVIN TEMPERATURE TO OUTPUT FORM.
      CALL OUT9G(TMPK,FIELDX(1,4))
c-----------------------------------------------------------------------
c
C     INITIALIZE ERROR VECTOR FOR THIS MATERIAL.
c
c-----------------------------------------------------------------------
      IF(NBMAX.LT.1) GO TO 50
      DO 40 NB=1,NBMAX
      DO 30 I=1,25
      ERMAT(I,NB)=0.0d0
   30 CONTINUE
   40 CONTINUE
   50 NBNEED=1
c-----------------------------------------------------------------------
C
C     DEFINE SPECTRUM AND ALL CROSS SECTION VALUES OVER FIRST
C     INTERVAL OF FIRST GROUP. IF CROSS SECTION EXTENDS TO LOWER
C     ENERGY LIMIT OF GROUP DEFINE CROSS SECTION AT LOWER ENERGY
C     GROUP BOUNDARY BY LINEAR INTERPOLATION. IF THRESHOLD OF ANY
C     CROSS SECTION IS ABOVE LOWER ENERGY LIMIT OF FIRST GROUP
C     DEFINE CROSS SECTION TO BE ZERO OVER AN INTERVAL THAT EXTENDS
C     FROM THE LOWER GROUP BOUNDARY TO THE THRESHOLD.
C
c-----------------------------------------------------------------------
      XB=EGROUP(1)
      DO 100 ISECTP=1,NSECT
      KSECT=ISECTP
C-----FIND FIRST DATA POINT ABOVE LOWER ENERGY BOUNDARY OF FIRST GROUP.
      IPTAB(KSECT)=0
   60 IF(IPTAB(KSECT).LT.NPTAB(KSECT)) GO TO 70
      XA(KSECT)=2.0D+20
      GO TO 100
   70 IPTAB(KSECT)=IPTAB(KSECT)+1
      CALL XYPAGE(IPTAB(KSECT),KSECT,XA(KSECT),YA(KSECT))
      IF(XA(KSECT).gt.XB) go to 80
C-----POINT IS STILL BELOW LOWER ENERGY LIMIT. SAVE ENERGY AND CROSS
C-----SECTION FOR INTERPOLATION.
      XC=XA(KSECT)
      YB(KSECT)=YA(KSECT)
      GO TO 60
C-----POINT IS ABOVE LOWER ENERGY LIMIT. IF THIS IS FIRST POINT
C-----DEFINE PRECEEDING INTERVAL WITH ZERO CROSS SECTION. OTHERWISE
C-----DEFINE CROSS SECTION AT LOWER ENERGY LIMIT BY LINEAR
C-----INTERPOLATION BETWEEN LAST TWO POINTS.
   80 IF(IPTAB(KSECT).GT.1) GO TO 90
      YA(KSECT)=0.0d0
      YB(KSECT)=0.0d0
      IPTAB(KSECT)=0
      GO TO 100
   90 YB(KSECT)=((XB-XC)*YA(KSECT)+(XA(KSECT)-XB)*YB(KSECT))/
     1 (XA(KSECT)-XC)
  100 CONTINUE
c-----------------------------------------------------------------------
C
C     GROUP LOOP. DEFINE LOWER AND UPPER ENERGY LIMITS OF GROUP.
C     INITIALIZE INTEGRAL OF CROSS SECTION TIMES SPECTRUM TIMES
C     SELF-SHIELDING FACTOR (XCINT) AND INTEGRAL OF SPECTRUM TIMES
C     SELF-SHIELDING FACTOR (XCNORM). DEFINE SIGMA0 VALUES AS
C     MULTIPLES OF UNSHIELDED TOTAL CROSS SECTION FOR CURRENT
C     GROUP OR THE SAME BARNS VALUES IN EACH GROUP (SHIELD).
C     INITIALIZE CROSS SECTION LIMITS FOR EACH REACTION (YLOW,YHIGH).
C
c-----------------------------------------------------------------------
      DO 420 IGR=1,NGR
C-----INITIALIZE TOTAL OR ELASTIC NOT POSITIVE FLAG
      NOTPLUS = 0
      EGB=XB
      XE=EGROUP(IGR+1)
      DO 110 L=1,25
      XCNORM(L)=0.0d0
  110 CONTINUE
      DO 130 KSECT=2,NSECT
      YLOW(KSECT)=YB(KSECT)
      YHIGH(KSECT)=YB(KSECT)
      DO 120 L=1,25
      XCINT(L,KSECT)=0.0d0
  120 CONTINUE
  130 CONTINUE
c-----------------------------------------------------------------------
C
C     DEFINE SIGMA-0 TO BE EITHER,
C     (1) MULTIPLE OF UNSHIELDED TOTAL IN EACH GROUP, OR,
C     (2) THE SAME NUMBER OF BARNS IN EACH GROUP.
C
C     IN ALL CASES SIGMAB IS THE SIGMA-0 DIVIDED BY THE UNSHIELDED TOTAL
C
c-----------------------------------------------------------------------
      AVXCGP=TOTAV(IGR)
      IF(MYSIGMA0.NE.0) GO TO 150
      DO 140 L=2,23
      SHIELD(L)=SIGMAB(L)*AVXCGP
  140 CONTINUE
      GO TO 190
  150 IF(AVXCGP.GT.0.0d0) GO TO 170
      DO 160 L=2,23
      SIGMAB(L)=0.0d0
  160 CONTINUE
      GO TO 190
  170 DO 180 L=2,23
      SIGMAB(L)=SHIELD(L)/AVXCGP
  180 CONTINUE
c-----------------------------------------------------------------------
C
C     DEFINE BEGINNING OF NEXT INTERVAL TO BE THE SAME AS THE END OF
C     THE LAST INTERVAL. SELECT LONGEST ENERGY INTERVAL (XC TO XB)
C     WITHIN CURRENT GROUP OVER WHICH THE SPECTRUM AND ALL CROSS
C     SECTIONS ARE LINEARLY INTERPOLABLE (THIS IS THE MINIMUM ENERGY
C     OF XE AND THE XA ARRAY).
C
c-----------------------------------------------------------------------
  190 XC=XB
      XB=XE
      DO 200 KSECT=1,NSECT
      YC(KSECT)=YB(KSECT)
      IF(XA(KSECT).LT.XB) XB=XA(KSECT)
  200 CONTINUE
c-----------------------------------------------------------------------
C
C     NEXT CALCULATION WILL BE INTEGRAL BETWEEN ENERGIES XC AND XB.
C     INTERPOLATE OVER THE ENERGY INTERVAL XC TO XA TO DEFINE THE
C     SPECTRUM AND ALL CROSS SECTIONS AT ENERGY XB. IF THE ENTIRE
C     ENERGY INTERVAL HAS BEEN USED UP (XA.LE.XB) ADVANCE TO THE
C     NEXT ENERGY INTERVAL. SKIP ENERGY INTERVALS WITH NEGATIVE CROSS
C     SECTION AND SKIP ALL EMPTY INTERVALS (ZERO LENGTH DUE TO
C     DISCONTINUTY IN THE SPECTRUM AND/OR CROSS SECTIONS).
C
c-----------------------------------------------------------------------
      DO 230 KSECT=1,NSECT
      IF(XA(KSECT).gt.XB) go to 220
c-----------------------------------------------------------------------
c
C     NEXT INTEGRAL WILL EXTEND TO END OF THE ENERGY INTERVAL XC TO
C     XA. DEFINE INTERPOLATED VALUE AS END INTERVAL AND THEN SELECT
C     THE NEXT ENERGY INTERVAL. IF BEYOND TABULATED ENERGY RANGE EXTEND
C     AS CONSTANT (I.E. KEEP SAME VALUE FOR YA AND DEFINE NEW ENERGY
C     XA TO 2.0D+20 EV).
c
c-----------------------------------------------------------------------
      YB(KSECT)=YA(KSECT)
      IF(IPTAB(KSECT).LT.NPTAB(KSECT)) GO TO 210
c-----2015/8/6 - Insert another point at end with either
c-----           same or 0 cross section
      IF(IPTAB(KSECT).eq.NPTAB(KSECT)) then
      IPTAB(KSECT)=IPTAB(KSECT)+1
      IF(MYXTEND.LE.0) YA(KSECT) = 0.0d0
      GO TO 230
      ENDIF
c-----Beyond tabulated data.
      XA(KSECT)=2.0D+20
      IF(MYXTEND.LE.0) THEN
      YA(KSECT) = 0.0d0
      YB(KSECT) = 0.0d0
      GO TO 230           ! Cross section = 0 - skip calculation
      ENDIF
      GO TO 220           ! Use extension
c-----Next tabulated point.
  210 IPTAB(KSECT)=IPTAB(KSECT)+1
      CALL XYPAGE(IPTAB(KSECT),KSECT,XA(KSECT),YA(KSECT))
      GO TO 230
C-----NEXT INTEGRAL WILL ONLY BE OVER A PORTION OF THE ENERGY INTERVAL.
C-----INTERPOLATE BETWEEN XC AND XA TO DEFINE VALUE AT XB.
  220 YB(KSECT)=((XB-XC)*YA(KSECT)+(XA(KSECT)-XB)*YB(KSECT))/
     1 (XA(KSECT)-XC)
  230 CONTINUE
      DE=XB-XC
      IF(DE.LE.0.0d0) GO TO 330
C-----DEFINE ALL END POINTS IN SCRATCH ARRAY.
      DO 240 KSECT=1,NSECT
      YBB(KSECT)=YB(KSECT)
      YCC(KSECT)=YC(KSECT)
  240 CONTINUE
C-----------------------------------------------------------------------
C
C     04/09/12 - SMALL TOTAL TREATMENT NO LONGER USED.
C
C-----------------------------------------------------------------------
C-----SET FLAG IF TOTAL OR ELASTIC IS NOT POSITIVE.
      IF(YB(2).LE.0.0D+0.OR.YC(2).LE.0.0D+0) NOTPLUS = 1
      IF(YB(3).LE.0.0D+0.OR.YC(3).LE.0.0D+0) NOTPLUS = 1
c-----------------------------------------------------------------------
C
C     KEEP TRACK OF MINIMUM AND MAXMIMUM CROSS SECTION FOR REACTIONS.
C
c-----------------------------------------------------------------------
      DO 260 KSECT=2,NSECT
      IF(YLOW(KSECT).lt.YBB(KSECT)) go to 250
      IF(YLOW(KSECT).eq.YBB(KSECT)) go to 260
      YLOW(KSECT)=YBB(KSECT)
      GO TO 260
  250 IF(YHIGH(KSECT).LT.YBB(KSECT)) YHIGH(KSECT)=YBB(KSECT)
  260 CONTINUE
c-----------------------------------------------------------------------
C
C     COMPUTE EFFECT OF SELF-SHIELDING FACTOR 1/(TOTAL(E)+SIGMA0)**N
C     FOR 25 COMBINATIONS OF (SIGMA0,N). DEFINE INTEGRAL OF SPECTRUM
C     TIMES SELF-SHIELDING FACTOR (XCNORM) FOR ALL 25 VALUES OF
C     (SIGMA0,N). THE SELF-SHIELDED TOTAL CROSS SECTIONS CAN LATER BE
C     DEFINED IN TERMS OF COMBINATIONS OF THESE INTEGRALS. THE EFFECT
C     OF THE SELF-SHIELDING FACTOR ON THE INDIVIDUAL REACTION CROSS
C     SECTIONS MAY BE DIVIDED INTO THREE COMPONENTS..
C
C     (1) FST   - EFFECT ON AVERAGE OF SPECTRUM TIMES AVERAGE OF
C                 REACTION CROSS SECTION.
C     (2) DFST  - EFFECT ON AVERAGE OF SPECTRUM TIMES CHANGE IN
C                 REACTION CROSS SECTION AND AVERAGE REACTION CROSS
C                 SECTION TIMES CHANGE IN SPECTRUM.
C     (3) DDFST - EFFECT ON CHANGE IN SPECTRUM TIMES CHANGE IN REACTION
C                 CROSS SECTION.
C
C     THESE FUNCTIONS ARE CALCULATED BELOW IN A DIMENSIONLESS FORM THAT
C     IS ONLY A FUNCTION OF THE RATIO OF THE CHANGE IN THE TOTAL CROSS
C     SECTION TO TWICE THE AVERAGE TOTAL CROSS SECTION.
C
C     RATIO=(SIGMAT(E2)-SIGMAT(E1))/(SIGMAT(E2)+SIGMAT(E1))
C
C     NOTE THAT AS LONG AS THE TOTAL CROSS SECTION IS POSITIVE THIS
C     RATIO IS RESTRICTED TO THE RANGE -1.0 TO 1.0.
C
c-----------------------------------------------------------------------
C-----DEFINE COMPONENTS OF SPECTRUM (AVERAGE AND CHANGE).
      AVSOUR=YBB(1)+YCC(1)
      DSOUR=YBB(1)-YCC(1)
C-----DEFINE CHANGE IN TOTAL CROSS SECTION (SAME FOR ALL SIGMA0).
      DST1=YBB(2)-YCC(2)
C-----N=1 AND 22 VALUES OF SIGMA0 (I.E. 1/(TOTAL(E)+SIGMA0)).
      DO 290 L=2,23
      YBP=YBB(2)+SHIELD(L)
      YCP=YCC(2)+SHIELD(L)
      AVST1=YBP+YCP
C-----ALLOW FOR NEGATIVE TOTAL
      IF(AVST1.GT.0.0D+0) THEN
      DEAVST(L)= DE/AVST1
      RATIO    = DST1/AVST1
      ELSE
      DEAVST(L)= ZERO
      RATIO=     ZERO
      ENDIF
      RATIO2=RATIO**2
      IF(RATIO2.LT.RATMIN) GO TO 270
      XX=(ONE+RATIO)/(ONE-RATIO)
      XX=DLOG(XX)/RATIO
      FST(L)=XX
      XX=(TWO-XX)/RATIO
      DFST(L)=XX
      DDFST(L)=-XX/RATIO
      GO TO 280
  270 XX=(((((F15*RATIO2+F13)*RATIO2+F11)*RATIO2+F9)*RATIO2+F7)*
     1                                RATIO2+F5)*RATIO2+F3
      DDFST(L)=XX
      DFST(L)=-RATIO*XX
      FST(L)=TWO+RATIO2*XX
  280 CONTINUE
  290 CONTINUE
c-----------------------------------------------------------------------
C
C     SIGMA0=0, N=2 AND 3 (I.E. 1/TOTAL(E)**2 AND 1/TOTAL(E)**3). THE
C     FOLLOWING CODING ASSUMES THAT SHIELD(23) IS 0.0. THEREFORE AVST1
C     AND RATIO NEED NOT BE CALCULATED AGAIN IN THIS SECTION (THEY ARE
C     THE SAME AS CALCULATED IN THE LAST PASS OF THE ABOVE DO LOOP).
C
c-----------------------------------------------------------------------
      FST(24)=2.0d0/(1.0d0-RATIO2)
      DFST(24)=RATIO*(DDFST(23)-FST(24))
      DDFST(24)=FST(24)-2.0d0*DDFST(23)
      FST(25)=0.5d0*(FST(24)**2)
      DFST(25)=-RATIO*FST(25)
      DDFST(25)=DDFST(23)+RATIO2*FST(25)
c-----------------------------------------------------------------------
C
C     NORMALIZE DIMENSIONLESS INTEGRALS AND THEN DEFINE INTEGRAL OF
C     SPECTRUM TIMES SELF-SHIELDING FACTOR (XCNORM) TO USE AS
C     NORMALIZATION FOR ALL REACTIONS.
C
c-----------------------------------------------------------------------
      DEAVST(24)=DEAVST(23)/AVST1
      DEAVST(25)=DEAVST(24)/AVST1
      XCNORM(1)=XCNORM(1)+DE*AVSOUR
      DO 300 L=2,25
      FST(L)=DEAVST(L)*FST(L)
      DFST(L)=DEAVST(L)*DFST(L)
      DDFST(L)=DEAVST(L)*DDFST(L)
      XCNORM(L)=XCNORM(L)+(AVSOUR*FST(L)+DSOUR*DFST(L))
  300 CONTINUE
c-----------------------------------------------------------------------
C
C     FOR EACH REACTION (TOTAL, ELASTIC, CAPTURE AND FISSION) DEFINE
C     INTEGRAL OF THE SPECTRUM TIMES CROSS SECTION TIMES SELF-SHIELDING
C     FACTOR FOR ALL 25 COMBINATION OF (SIGMA0,N).
C
c-----------------------------------------------------------------------
      DO 320 KSECT=2,NSECT
      AVSTN=YBB(KSECT)+YCC(KSECT)
      DSTN=YBB(KSECT)-YCC(KSECT)
      A1=AVSTN*AVSOUR
      A2=DSTN*AVSOUR+DSOUR*AVSTN
      A3=DSTN*DSOUR
      XCINT(1,KSECT)=XCINT(1,KSECT)+DE*(A1+A3/3.0d0)
      DO 310 L=2,25
      XCINT(L,KSECT)=XCINT(L,KSECT)+(A1*FST(L)+A2*DFST(L)+A3*DDFST(L))
  310 CONTINUE
  320 CONTINUE
c-----------------------------------------------------------------------
C
C     TEST FOR END OF GROUP. IF NOT, CONTINUE WITH INTEGRALS.
C     IF END OF GROUP, NORMALIZE ALL INTEGRALS AND DEFINE COMMON
C     FACTORS. DEFINE SELF-SHIELDED AVERAGED CROSS SECTIONS AS
C     RATIO OF INTEGRALS (REACTIONS TO FLUX).
C
c-----------------------------------------------------------------------
  330 IF(XB.LT.XE) GO TO 190
C-----CONVERT TOTAL AND REACTION INTEGRALS TO AVERAGES.
      DO 350 I=1,25
C-----IF NORMALIZATION = 0 SET VALUES = 0
      IF(XCNORM(I).GT.0.0d0) GO TO 340
      DO KSECT=2,NSECT
      XCINT(I,KSECT)=0.0d0
      ENDDO
      GO TO 350
c-----------------------------------------------------------------------
c
C     AT THIS POINT THE NUMERATOR (XCINT) AND DENOMINATOR (XCNORM)
C     DIFFER FROM THE EXACT INTEGRALS BY SCALAR FACTORS.....
C     XCINT(I),I=1,23 - IS 4 TIMES THE CORRECT INTEGRAL
C     XCINT(24)       - IS 2 TIMES THE CORRECT INTEGRAL
C     XCINT(25)       - IS 1 TIMES THE CORRECT INTEGRAL
C     XCNORM(I),I=1,23- IS 2 TIMES THE CORRECT INTEGRAL
C     XCNORM(24)      - IS 1 TIMES THE CORRECT INTEGRAL
C     XCNORM(25)      - IS 1/2 TIMES THE CORRECT INTEGRAL.
C     RENORMALIZE XCNORM TO OBTAIN THE CORRECT RATIOS.
c
c-----------------------------------------------------------------------
  340 XCNORM(I)=2.0d0*XCNORM(I)
      DO KSECT=2,NSECT
      XCINT(I,KSECT)=XCINT(I,KSECT)/XCNORM(I)
      ENDDO
  350 CONTINUE
c-----------------------------------------------------------------------
C
C     CHECK TO INSURE TOTAL DOES NOT INCREASE WITH SIGMA0
C
c-----------------------------------------------------------------------
      IF(NOTPLUS.EQ.0) THEN
      DO KK=2,25
      IF(XCINT(KK,2).GT.1.000001d0*XCINT(KK-1,2).OR.
     1   XCINT(KK,2).GT.1.000001d0*XCINT(1,2)) THEN
      WRITE(3,360) IGR
      WRITE(*,360) IGR
  360 FORMAT(' IGR=',I5)
      WRITE(3,370) (II,XCINT(II,2),XCINT(II,2)/XCINT(1,2),II=1,25)
      WRITE(*,370) (II,XCINT(II,2),XCINT(II,2)/XCINT(1,2),II=1,25)
  370 FORMAT(I8,1PD20.12,0PF20.12,' BEFORE SUM')
      ENDIF
      ENDDO
      ENDIF
c-----------------------------------------------------------------------
C
C     DEFINE THE REST = UNSHIELDED [TOTAL-(ELASTIC+CAPTURE+FISSION)]
C
c-----------------------------------------------------------------------
      DO I=1,25
      THEREST=0.0d0
      DO KSECT=3,NSECT
      THEREST=THEREST+XCINT(I,KSECT)
      ENDDO
      XCINT(I,6) = XCINT(I,2) - THEREST
c-----2016/7/3 - Added lower limit for "Other" -
C-----           Insure TOTAL is EXACTLY SUM OF PARTS
      if(XCINT(I,6).lt.1.0d-6*XCINT(I,2)) then
      XCINT(I,6) = 0.0d0
      XCINT(I,2) = THEREST
      endif
      ENDDO
c-----------------------------------------------------------------------
C
C     IF NON-POSITIVE TOTAL OR ELASTIC DEFINE ALL = UNSHIELDED
C
c-----------------------------------------------------------------------
C-----2020/8/13 - IF LITTLE SELF-SHIELDING (less than 0.1 %) SET TO NONE
      IF(XCINT(23,2).GT.0.9999d0*XCINT(1,2)) NOTPLUS = 1
      IF(NOTPLUS.NE.0) THEN
      DO KSECT=2,6
      DO I=2,25
      XCINT(I,KSECT) = XCINT(1,KSECT)
      ENDDO
      ENDDO
      ENDIF
c-----------------------------------------------------------------------
C
C     DEFINE F FACTORS AND OUTPUT.
C
c-----------------------------------------------------------------------
C-----DEFINE LOWER GROUP BOUNDARY.
      CALL OUT9G(EGB,FIELDX(1,1))
C-----LOOP OVER TOTAL AND PARTIALS.
      DO 410 KSECT=2,6
c-----------------------------------------------------------------------
c
C     ASSUME SMALL "OTHER" IS NOISE AND IGNORE
C     2016/5/21 - Changed multiple IF statement to accommodate compiler
C                 optimizer.
C     IF(KSECT.EQ.6.AND.
C    1   XCINT(1,KSECT).LE.1.0D-6*XCINT(1,2)) GO TO 450
c     The following replaces the above to eliminate AND statements
c
c-----------------------------------------------------------------------
      IF(KSECT.EQ.6) THEN        ! Only execute the next line if KSECT=6
      IF(XCINT(1,KSECT).LE.1.0D-6*XCINT(1,2)) GO TO 410
      ENDIF
C-----CROSS SECTION.
      XCINTS=XCINT(1,KSECT)
      CALL OUT9G(XCINTS,FIELDX(1,2))
C-----CROSS SECTION OR RESONANCE INTEGRAL.
      IF(OPS(1).EQ.2) XCINTS=DLOG(EGROUP(IGR+1)/EGROUP(IGR))*XCINTS
      CALL OUT9G(XCINTS,FIELDX(1,3))
      IF(XCINT(1,KSECT).GT.0.0d0) GO TO 390
      XCFI(1,KSECT)=1.0d0
      DO 380 L=2,25
      XCFI(L,KSECT)=0.0d0
  380 CONTINUE
      GO TO 410
  390 DO 400 L=2,25
      XCFI(L,KSECT)=XCINT(L,KSECT)/XCINT(1,KSECT)
  400 CONTINUE
  410 CONTINUE    ! END REACTION loop
c-----------------------------------------------------------------------
C
C     MULTI-BAND CALCULATION.
C
c-----------------------------------------------------------------------
      IF(METHODB.ne.0) CALL BANDIT
c-----------------------------------------------------------------------
C
C     END OF GROUP LOOP = Save ALL Group Results
C
c-----------------------------------------------------------------------
      DO IS=1,25
      DO IR=1,6
      XCALL(IS,IR,IGR) = XCINT(IS,IR)
      ENDDO
      ENDDO
  420 CONTINUE
c-----------------------------------------------------------------------
C
C     Only for Multi-Band Parameters
C
c-----------------------------------------------------------------------
      IF(METHODB.EQ.0) GO TO 460
c-----------------------------------------------------------------------
C
C     UPDATE MAXMIMUM ERROR FOR THE ENTIRE LIBRARY FOR EACH NUMBER
C     OF BANDS. DEFINE MAXIMUM ERROR FOR CURRENT MATERIAL FOR EACH
C     NUMBER OF BANDS AND OUTPUT THE RESULTS.
C
c-----------------------------------------------------------------------
      DO 440 NB=1,NBNEED
      ERBIG(NB)=0.0d0
      DO 430 I=1,25
      IF(ERMAT(I,NB).GT.ERLIB(I,NB)) ERLIB(I,NB)=ERMAT(I,NB)
      IF(I.GT.23) GO TO 430
      IF(ERMAT(I,NB).GT.ERBIG(NB)) ERBIG(NB)=ERMAT(I,NB)
  430 CONTINUE
      ERBIG(NB)=100.0d0*ERBIG(NB)
  440 CONTINUE
C-----SAVE PARAMETERS FOR FINAL OUTPUT REPORT.
      LZA=LZA+1
      IF(LZA.GT.MAXMAT) THEN
      WRITE(3,470) MAXMAT
      WRITE(*,470) MAXMAT
      CALL ENDERROR
      ENDIF
      IZATAB(LZA)=IZA
      NBNTAB(LZA)=NBNEED
      DO 450 I=1,NBNEED
      ERBTAB(I,LZA)=ERBIG(I)
  450 CONTINUE
c-----------------------------------------------------------------------
c
c     URR Fit? Only performed if,
c     1) Unresolved data is include with ENDF data input
c     2) TART 616 groups
c     3) Sigma0 = multiples of average total in each group
c
c-----------------------------------------------------------------------
c-----Only if there is an unresolved resonance region (URR)
      if(URES2.gt.0.0d0) then
c-----2019/6/8 - Only allow for TART 616 groups
      if(NGR.eq.616) then
c-----2019/6/23 - Only allow for standaard Sigma0 definition
      if(MYSIGMA0.eq.0) then
c-----URR fit
      CALL URRFIT
c-----URR ENDF Format for NJOY/MCNP
      CALL ACEENDF
      endif
      endif
      endif
c-----------------------------------------------------------------------
C
C     Multi-Band Output - After URRFIT
C
c-----------------------------------------------------------------------
c-----Listing
      IF(LIST2.GT.0) CALL BANLST
c-----Compact
      IF(OTAPE2.GT.0) CALL BANOUT
c-----------------------------------------------------------------------
C
C     Self-Shielded Cross Section Output = After URRFIT
C
c-----------------------------------------------------------------------
  460 IF(LIST1.GT.0) CALL XCLST
c-----------------------------------------------------------------------
C
C     PLOTTAB OUTPUT last after all changes
C
c-----------------------------------------------------------------------
      if(IPLOT.gt.0) CALL PLOTIT
      RETURN
  470 FORMAT(1x,78('=')/
     1 ' ERROR - More than',I6,' Materials.'/
     2 '         Execution Terminated.'/1x,78('='))
      END
      SUBROUTINE URRLIMIT
C=======================================================================
C
C     2020/8/4 - Define Average group energy + URR limits
C
C=======================================================================
      INCLUDE 'implicit.h'
      COMMON/RESCOM/RES1,RES2,URES1,URES2,LSSF,ICOMP,INTUNR,INPART
      common/ACECOM/NUNR1,NUNR2,NUNROUT
      INCLUDE 'groupie.h'
      if(URES2.le.0.0d0) RETURN       ! Ignore if no URR
      NUNR1  = 0 ! lower group index
      NUNR2  = 0 ! upper group index
c-----------------------------------------------------------------------
c
c     Define group limits of unresolved region.
c
c     2020/8/7 - Only use bins TOTALLY within the unresolved
c
c     1) First = URR START
c     2) Last  = URR END
c     Ignore ENDS (URES1, URES2)
c
c-----------------------------------------------------------------------
      do 10 igr=1,NGR
      if(EGROUP(igr).le.URES1) go to 10   ! lower limit inside URR
      if(NUNR1.le.0) then             ! First INSIDE
      NUNR1 = igr
      go to 10
      endif
      if(EGROUP(igr+1).ge.URES2) go to 10 ! upper limit inside URR
      NUNR2 = igr                     ! Last INSIDE
   10 continue
c-----------------------------------------------------------------------
c
c     Define URR Energies = start/end + inside
c
c-----------------------------------------------------------------------
      EAVURR(1) = URES1           ! Start with boundary
      NUNROUT   = 1
      do igr=NUNR1,NUNR2          ! Add ALL inside
      NUNROUT   = NUNROUT + 1
      EAVURR(NUNROUT) = EAV(igr)
      enddo
      NUNROUT   = NUNROUT + 1     ! End with boundary
      EAVURR(NUNROUT) = URES2
c-----------------------------------------------------------------------
c
c     Add 2 dummy points at end for 2 ends of URR
c
c-----------------------------------------------------------------------
      EAV(NGRP1) = URES1               ! energy of URR limits
      EAV(NGRP2) = URES2
      do k=2,5
      XCALL(1,k,NGRP1) = XCURRLIM(1,k) ! unshielded cross sections
      XCALL(1,k,NGRP2) = XCURRLIM(2,k) ! total,elastic,capture,fission
      enddo
      return
      end
      SUBROUTINE URRFIT
C=======================================================================
C
C     Fit Unresolved Resonance Region (URR).
C
C=======================================================================
      INCLUDE 'implicit.h'
      COMMON/RESCOM/RES1,RES2,URES1,URES2,LSSF,ICOMP,INTUNR,INPART
      INCLUDE 'groupie.h'
      if(URES2.le.0.0d0) RETURN
      CALL URRLIMIT
      CALL MOMENTS              ! Define self-shielded moments
      CALL FITZ(URES1,URES2)    ! Fit moments to URR by extrapolation
      CALL MBMAKER              ! Define URR multi-band parameters
      RETURN
      END
      SUBROUTINE MOMENTS
C=======================================================================
C
C     Define self-shielded moments: Same as METHODB = 2 option
C
C     1) Unshielded
C     2) Totally Shielded: Sigma0 = 0
C     #0 Partially Shielded: Sigma0 = Unshielded Total Group Average
C
C=======================================================================
      INCLUDE 'implicit.h'
      INCLUDE 'groupie.h'
      common/fitcom/xcmom(3,5,MAXGROUP),AE2(5),AE3(5)
      common/newmom/xcnew(3,5,MAXGROUP)
      common/ACECOM/NUNR1,NUNR2,NUNROUT
      COMMON/TRASH/ERROK,ER10PC,MGROUP,METHODB,NBAND,NBMAX,
     1 NBNEED,MYSIGMA0
      dimension PARTB(2)
c-----------------------------------------------------------------------
c
c     loop over groups
c
c-----------------------------------------------------------------------
      do igr=1,NGR
c-----Unshielded average for SIGMA0
      AVTOTG     = WTBAND(1,igr)*XCBAND(2,1,igr)     +
     1             WTBAND(2,igr)*XCBAND(2,2,igr)
c-----denominator same for all reactions
      sum1t = 1.0d0 ! Sum of weights
      sum2t = WTBAND(1,igr)/XCBAND(2,1,igr)          +
     1        WTBAND(2,igr)/XCBAND(2,2,igr)
c-----2020/8/2 - ALWAYS 1/[sigT + <sigT>]
      sum3t = WTBAND(1,igr)/(XCBAND(2,1,igr)+AVTOTG) +
     1        WTBAND(2,igr)/(XCBAND(2,2,igr)+AVTOTG)
c-----------------------------------------------------------------------
c
c     loop over reactions
c
c-----------------------------------------------------------------------
      do ir=2,5 ! 2-5: total, elastic, capture [1 = spectrum]
      PARTB(1) = WTBAND(1,igr)*XCBAND(ir,1,igr)
      PARTB(2) = WTBAND(2,igr)*XCBAND(ir,2,igr)
      sum1r    = PARTB(1) + PARTB(2)
      sum2r    = PARTB(1)/XCBAND(2,1,igr)    +
     1           PARTB(2)/XCBAND(2,2,igr)
c-----2020/8/2 - ALWAYS 1/[sigT + <sigT>]
      sum3r    = PARTB(1)/(XCBAND(2,1,igr)+AVTOTG) +
     1           PARTB(2)/(XCBAND(2,2,igr)+AVTOTG)
c-----moments
      xcmom(1,ir,igr) = sum1r/sum1t
      xcmom(2,ir,igr) = sum2r/sum2t
      xcmom(3,ir,igr) = sum3r/sum3t
c-----f-factors
      if(xcmom(1,ir,igr).gt.0.0d0) then
      xcmom(3,ir,igr) = xcmom(3,ir,igr)/xcmom(1,ir,igr)
      xcmom(2,ir,igr) = xcmom(2,ir,igr)/xcmom(1,ir,igr)
      xcmom(1,ir,igr) = xcmom(1,ir,igr)/xcmom(1,ir,igr)
      else
      xcmom(3,ir,igr) = 1.0d0 ! usually no fission
      xcmom(2,ir,igr) = 1.0d0
      xcmom(1,ir,igr) = 1.0d0
      endif
c-----initialize NEW (fit) to original
      xcnew(3,ir,igr) = xcmom(3,ir,igr)
      xcnew(2,ir,igr) = xcmom(2,ir,igr)
      xcnew(1,ir,igr) = xcmom(1,ir,igr)
      enddo         ! end reaction loop
      enddo         ! end group loop
      RETURN
      END
      SUBROUTINE FITZ(elow,ehigh)
C=======================================================================
C
C     Define URR self-shielded moments by extrapolation
C
C     elow  = URES1
c     ehigh = URES2
C
C=======================================================================
      INCLUDE 'implicit.h'
      INCLUDE 'groupie.h'
      INTEGER*4 OTAPE2
      COMMON/UNITS/OTAPE2,NTAPE,LIST1,LIST2,LIST3,IPLOT
      common/fitcom/xcmom(3,5,MAXGROUP),AE2(5),AE3(5)
      common/newmom/xcnew(3,5,MAXGROUP)
      COMMON/ERANGES/e1,e2,e3
      common/ACECOM/NUNR1,NUNR2,NUNROUT
      COMMON/TRASH/ERROK,ER10PC,MGROUP,METHODB,NBAND,NBMAX,
     1 NBNEED,MYSIGMA0
c-----------------------------------------------------------------------
c
c     Define moments for fit = fit below unresolved and
c     extrapolate fit across unresolved
c
c-----------------------------------------------------------------------
c-----Fit is below URR
      e1 = 0.5d0*elow
      e2 = 0.9d0*elow
      e3 = 1.5d0*ehigh
c-----WARNING: ir=1 is SPECTRUM: 2-5 = total, elastic, capture, fission
      DO ir = 2,5
      a2  = 0.0d0
      a3  = 0.0d0
      b23 = 0.0d0
      do 10 igr=1,NGR
      ave = EAV(igr)
      if(ave.lt.e1) go to 10
      if(ave.gt.e2) go to 20
      a2  = a2 + ave*(1.0d0 - xcmom(2,ir,igr))
      a3  = a3 + ave*(1.0d0 - xcmom(3,ir,igr))
      b23 = b23 + 1.0d0
   10 continue
c-----------------------------------------------------------------------
c
c     Define fit: F = 1 - A/E   final form
c                 A = E*(1 - F) define A as sum over E
c
c-----------------------------------------------------------------------
c-----Test for no points in E range = set to NO Shielding
   20 if(b23.le.0.0d0) then
      AE2(ir) = 0.0d0
      AE3(ir) = 0.0d0
      else
      AE2(ir) = a2/b23
      AE3(ir) = a3/b23
      endif
c-----Extrapolate through URR - including 2 ends of URR
      do 30 igr=1,NGRP2
      ave = EAV(igr)
c-----define up to e3 = 1.5*ehigh for graphics output only
      if(ave.lt.e1) go to 30
      if(ave.gt.e3) go to 30
c-----------------------------------------------------------------------
c
c     Force to = 1 at URES2 = No Self=Shielding
c
c     For 57-La-139 LINEAR is the closest to Original
c     ALL of these were tested,
c     DEURR = 1.0d0                                             ! same
c     DEURR = (ehigh-ave)/(ehigh-elow)                          ! linear
c     DEURR = DLOG(ehigh/ave)/DLOG(ehigh/elow)                  ! log
c     DEURR = (1.0d0/ehigh-1.0d0/ave)/(1.0d0/ehigh-1.0d0/elow)  ! 1/E
c-----------------------------------------------------------------------
c
c     LInear was adopted as closest to Original
C
c-----------------------------------------------------------------------
      DEURR = (ehigh-ave)/(ehigh-elow)                          ! linear
      if(DEURR.lt.0.0d0) DEURR = 0.0d0       ! no change outside URR
      if(DEURR.gt.1.0d0) DEURR = 1.0d0
c-----------------------------------------------------------------------
c
c     Extrapolate and force no shielding at upper end of urresolved
c
c-----------------------------------------------------------------------
      xcnew(1,ir,igr) = 1.0d0
      xcnew(2,ir,igr) = 1.0d0 - DEURR*AE2(ir)/ave
      xcnew(3,ir,igr) = 1.0d0 - DEURR*AE3(ir)/ave
   30 continue  ! end group loop
      ENDDO     ! end reaction loop
      RETURN
      END
      SUBROUTINE PLOTIT
c=======================================================================
c
c     1) Plot moments to extrapolate
c     2) Plot unshielded and shielded cross sections
c
c=======================================================================
      INCLUDE 'implicit.h'
      INTEGER*4 OTAPE2
      CHARACTER*1 ZABCD,FIELDX,plot1
      character*8 reacts
      character*24 plot24
      COMMON/WHATZA/ATWT,IZA,MATNOW,MFNOW
      COMMON/ELPASZ/ZABCD(12)
      COMMON/FIELDC/FIELDX(11,22)
      COMMON/UNITS/OTAPE2,NTAPE,LIST1,LIST2,LIST3,IPLOT
      INCLUDE 'groupie.h'
      common/fitcom/xcmom(3,5,MAXGROUP),AE2(5),AE3(5)
      common/newmom/xcnew(3,5,MAXGROUP)
      COMMON/ERANGES/e1,e2,e3
      common/ACECOM/NUNR1,NUNR2,NUNROUT
      COMMON/REALLY/XE,XA(5),YA(5),YB(5),YC(5),NPTAB(5),IPTAB(5),NSECT
      dimension reacts(5),plot1(24)
      equivalence (plot24,plot1(1))
      data plot24/'ZA000000.PLOT.CUR       '/
c                    zzzaaa
c                  123456789012345678901234
c-----------------------------------------------------------------------
c
c     Define PLOTIT.CUR Filename = ZAzzzaaa.PLOTIT.CUR
c
c-----------------------------------------------------------------------
      call ZANAME(IZA,plot1(1))
      OPEN(IPLOT,FILE=plot24,STATUS='UNKNOWN')
      data reacts/
     1 '        ',
     2 'Total   ',
     3 'Elastic ',
     4 'Capture ',
     5 'Fission '/
c-----------------------------------------------------------------------
c
c     2020/2/2   - Skip if no URR Fit.
c
c-----------------------------------------------------------------------
      if(e1.le.0.0d0.and.e2.le.0.0d0) go to 80
c-----------------------------------------------------------------------
c
c     Original moments = only over fit energy range e1 to e2 = 0.9*elow
c     Note: NSECT=1 is weighting spectrum
c                =2 through 5 = total, elastic, capture, fission
c
c-----------------------------------------------------------------------
c-----Loop over reactions: total, elastic, capture, fission
      DO ir = 2,NSECT
c-----Loop over 3 moments to extrapolate
      DO m=1,3
      write(IPLOT,10) ZABCD,m,reacts(ir)
   10 format(12a1,i2,1x,a8)
      do 30 igr=1,NGR
      ave = EAV(igr)
      if(ave.lt.e1) go to 30
      if(ave.gt.e2) go to 40
      write(IPLOT,20) ave,xcmom(m,ir,igr)
   20 format(1p2d11.4)
   30 continue
   40 write(IPLOT,50)
   50 format(30x,'(BLANK LINE)')
c-----------------------------------------------------------------------
c
c     Final moments = over extended energy range e1 to e3 = 1.5*ehigh
c
c-----------------------------------------------------------------------
      write(IPLOT,10) ZABCD,m,reacts(ir)
      do 60 igr=1,NGR
      ave = EAV(igr)
      if(ave.lt.e1) go to 60
      if(ave.gt.e3) go to 70
      write(IPLOT,20) ave,xcnew(m,ir,igr)
   60 continue
   70 write(IPLOT,50)
      ENDDO     ! end moments  loop
      ENDDO     ! end reaction loop
c=======================================================================
c
c     Plot unshielded and shielded cross sections
c     Note: NSECT=1 is weighting spectrum
c                =2 through 5 = total, elastic, capture, fission
c
c=======================================================================
c-----Loop over reactions: total, elastic, capture, fission
   80 do ir=2,NSECT
c-----Unshielded
      WRITE(IPLOT,90) ZABCD,reacts(ir)
   90 FORMAT(12A1,1x,A8,' Unshielded')
      DO igr=1,NGR
      CALL OUT9G(EGROUP(igr),FIELDX(1,1))
      CALL OUT9G(XCALL (1,ir,igr),FIELDX(1,2))
      CALL OUT9G(EGROUP(igr+1),FIELDX(1,3))
      WRITE(IPLOT,100) (FIELDX(I,1),I=1,11),(FIELDX(I,2),I=1,11),
     1                 (FIELDX(I,3),I=1,11),(FIELDX(I,2),I=1,11)
  100 FORMAT(22A1)
      ENDDO
      WRITE(IPLOT,110)
  110 FORMAT(30X,'(BLANK LINE)')
c-----Shielded
      WRITE(IPLOT,120) ZABCD,reacts(ir)
  120 FORMAT(12A1,1x,A8,' Shielded')
      DO igr=1,NGR
      CALL OUT9G(EGROUP(igr),FIELDX(1,1))
      CALL OUT9G(XCALL (23,ir,igr),FIELDX(1,2))
      CALL OUT9G(EGROUP(igr+1),FIELDX(1,3))
      WRITE(IPLOT,100) (FIELDX(I,1),I=1,11),(FIELDX(I,2),I=1,11),
     1                 (FIELDX(I,3),I=1,11),(FIELDX(I,2),I=1,11)
      ENDDO
      WRITE(IPLOT,110)
      enddo  ! END REACTION LOOP
      CLOSE(IPLOT)
      RETURN
      END
      SUBROUTINE MBMAKER
C=======================================================================
C
C     Define URR multi-band parameters and self-shielded cross sections
C
C=======================================================================
      INCLUDE 'implicit.h'
      INCLUDE 'groupie.h'
      character*4 title4
      common/newmom/xcnew(3,5,MAXGROUP)
      common/ACECOM/NUNR1,NUNR2,NUNROUT
      COMMON/TRASH/ERROK,ER10PC,MGROUP,METHODB,NBAND,NBMAX,
     1 NBNEED,MYSIGMA0
      dimension BOTTOM(25),TOP(25),SIGMA0(25),PARTB(2),imuse(3),
     1 title4(5)
c-----Titles for moment test
      data title4/
     1 '    ',
     2 'Totl',
     3 'Elas',
     4 'Capt',
     5 'Fiss'/
c-----Define acceptable per-cent fractional difference in fir
      data dxcnewok/1.0d-01/               ! 0.1 %
c-----Indices to 3 moments to conserve
c-----Methodb #2: Always use: 1) unshielded, 2) total, 3) partial
      data imuse/ 1, 23, 12/
c-----------------------------------------------------------------------
c
c     Multi-Band Parameters from Unresolved Moments Fit
c
c-----------------------------------------------------------------------
c-----Loop = 1: over groups within Unresolved Resonance Region
c-----     = 2: ENDS of URR
      DO LOOP=1,2
      NUX1 = NUNR1
      NUX2 = NUNR2
      if(LOOP.eq.2) then
      NUX1 = NGRP1
      NUX2 = NGRP2
      endif
      DO igr=NUX1,NUX2
c-----unshielded total
      TOTNS = XCALL(1,2,igr) ! 1=unshield 2=total igr=group
c-----f-factor to XC
      SIGT1   = TOTNS*xcnew(1,2,igr)
      SIGT2   = TOTNS*xcnew(2,2,igr)
      SIGT3   = TOTNS*xcnew(3,2,igr)
      DSIGT12 = SIGT1 - SIGT2
      DSIGT13 = SIGT1 - SIGT3
c-----Initiallize, just in case
      ABAND   = SIGT1
      BBAND   = 0.0d0
      DBAND   = 0.0d0
C-----------------------------------------------------------------------
C
C     IF TOTAL = 0 OR NO SHIELDING USE 2 BAND with same cross section
C
C-----------------------------------------------------------------------
c-----NO Shielding.
      IF(SIGT1  .LE.0.0d0)  GO TO 20   ! no total
      IF(DSIGT12.le.0.0d0)  GO TO 20   ! no shielding
C-----------------------------------------------------------------------
C
C     2020/8/13 - SMALL TEST on self-shielding < 0.1% (accuracy of data)
C
C     Conserve 2 moments
C     wt1 = wt2 = 1/2
c     BB  = (sigt1 - sigt2)/sigt1  < 1 - 0.999     < 0.001
C     A   =        1/sigt2
C     B   = sqrt[BB]/sigt2                         < 0.031
C
C-----------------------------------------------------------------------
      IF(SIGT2.le.0.999d0*SIGT1) go to 10
      ABAND  = 1.0d0/SIGT2
      BB2    = DSIGT12/SIGT1
      if(BB2.le.0.0d0) go to 20
      BBAND  = ABAND*DSQRT(BB2)  ! note: ABAND = 1/SIGT2 (defined above)
      DBAND  = 0.0d0                          ! for below tests
      WT1    = 0.5d0
      WT2    = 0.5d0
      BANDT1 = 1.0d0/(ABAND + BBAND)
      BANDT2 = 1.0d0/(ABAND - BBAND)
      go to 30
C-----------------------------------------------------------------------
C
C     NORMAL SHIELDING - USE 2 BANDS
C
C     2020/8/2 - METHODB #2: CONSERVE 1/TOT AND 1/(TOT + <TOT>)
C
C-----------------------------------------------------------------------
   10 ABAND = DSIGT12/(2.0d0*DSIGT13*SIGT2)
      BB2   = (SIGT2*ABAND*(SIGT1*ABAND-2.0d0)+1.0d0)/(SIGT1*SIGT2)
      if(BB2.le.0.0d0) go to 20
      BBAND = DSQRT(BB2)
      DBAND = (1.0d0-ABAND*SIGT2)/(2.0d0*SIGT2*BBAND)
      WT1   = 0.5d0 + DBAND
      WT2   = 0.5d0 - DBAND
      BANDT1 = 1.0d0/(ABAND + BBAND)
      BANDT2 = 1.0d0/(ABAND - BBAND)
      go to 30
C-----------------------------------------------------------------------
C
c     Little or no self-shielding = 2 IDENTICAL bands
C
C-----------------------------------------------------------------------
   20 WT1    = 0.5d0
      WT2    = 0.5d0
      BANDT1 = SIGT1
      BANDT2 = SIGT1
C-----------------------------------------------------------------------
C
c     Save new Total Band Paramters
C
C-----------------------------------------------------------------------
   30 WTBAND  (1,igr) = WT1
      WTBAND  (2,igr) = WT2
      XCBAND(2,1,igr) = BANDT1
      XCBAND(2,2,igr) = BANDT2
c-----Define constants for Patials
      if(DSIGT12.le.0.0d0) then                 ! No Shielding
      TOTNORM = 0.0d0
      else
      BTRY    = DBAND*DSIGT12
      CTRY    = (0.25d0 - DBAND**2)*SIGT1*DSIGT12
      ROOT    = DSQRT(BTRY**2 + CTRY)
      DTOT    = BTRY+ROOT
      TOTNORM = DTOT/DSIGT12
      endif
c-----------------------------------------------------------------------
c
c     Partials
c
c-----------------------------------------------------------------------
c-----Loop over other reactons: elastic, capture, fission
      DO ir=3,5 ! note 3 to 5 (not total)
c-----unshielded reaction
      PARNS = XCALL(1,ir,igr)
c-----f-factor to XC
      SIGP1 = PARNS*xcnew(1,ir,igr)
      SIGP2 = PARNS*xcnew(2,ir,igr)
      if(SIGP1.le.0.0d0) then
      BANDP1 = 0.0d0          ! no cross section - usually fission
      BANDP2 = 0.0d0
      else
      CBAND  = TOTNORM*(SIGP1 - SIGP2)
      BANDP1 = SIGP1 - CBAND/WT1
      BANDP2 = SIGP1 + CBAND/WT2
      endif
c
c     Define new Partial cross sections
c
      XCBAND(ir,1,igr) = BANDP1
      XCBAND(ir,2,igr) = BANDP2
      ENDDO ! end of reaction loop
      ENDDO ! end of group loop
      ENDDO ! 2 loop to add URR ends
c-----------------------------------------------------------------------
c
c     Self-Shielded Cross Sections
c
c-----------------------------------------------------------------------
c-----Loop = 1: over groups within Unresolved Resonance Region
c-----     = 2: ENDS of URR
      DO LOOP=1,2
      NUX1 = NUNR1
      NUX2 = NUNR2
      if(LOOP.eq.2) then
      NUX1 = NGRP1
      NUX2 = NGRP2
      endif
      DO igr=NUX1,NUX2
c-----unshielded group average (use as SIGMA-0 multiplier)
      AVTOTG     = WTBAND(1,igr)*XCBAND(2,1,igr)              +
     1             WTBAND(2,igr)*XCBAND(2,2,igr)
c-----denominator same for all reactions
      BOTTOM( 1) = 1.0d0  ! = sum of weights
      DO is=2,23
      SIGMA0(is) = AVTOTG*SIGMAB(is)
      BOTTOM(is) = WTBAND(1,igr)/(XCBAND(2,1,igr)+SIGMA0(is)) +
     1             WTBAND(2,igr)/(XCBAND(2,2,igr)+SIGMA0(is))
      ENDDO
      BOTTOM(24) = WTBAND(1,igr)/(XCBAND(2,1,igr)**2)         +
     1             WTBAND(2,igr)/(XCBAND(2,2,igr)**2)
      BOTTOM(25) = WTBAND(1,igr)/(XCBAND(2,1,igr)**3)         +
     1             WTBAND(2,igr)/(XCBAND(2,2,igr)**3)
c-----------------------------------------------------------------------
c
c     loop over reactions: total, elastic, capture, fission
c
c-----------------------------------------------------------------------
      DO ir=2,5
      PARTB ( 1) = WTBAND(1,igr)*XCBAND(ir,1,igr)
      PARTB ( 2) = WTBAND(2,igr)*XCBAND(ir,2,igr)
      TOP   ( 1) = PARTB(1) + PARTB(2)
      DO is=2,23
      TOP   (is) = PARTB(1)/(XCBAND(2,1,igr)+SIGMA0(is)) +
     1             PARTB(2)/(XCBAND(2,2,igr)+SIGMA0(is))
      ENDDO    ! end SIGMA0   loop
      TOP   (24) = PARTB(1)/(XCBAND(2,1,igr)**2)         +
     1             PARTB(2)/(XCBAND(2,2,igr)**2)
      TOP   (25) = PARTB(1)/(XCBAND(2,1,igr)**3)         +
     1             PARTB(2)/(XCBAND(2,2,igr)**3)
c-----New Unresolved, self-shielded cross sections.
      DO is=1,25
      XCALL(is,ir,igr) = TOP(is)/BOTTOM(is)
      ENDDO    ! end SIGMA0   loop
      ENDDO    ! end reaction loop
      ENDDO    ! end group    loop
      ENDDO    ! 2 loops to include URR ends
c-----------------------------------------------------------------------
c
c     Check that new paramters conserve 3 new moments
c
c-----------------------------------------------------------------------
      imdiff=0
c-----loop over groups
      DO igr=NUNR1,NUNR2
c-----loop over reactions
      DO ir=2,5
      xcnoshield = XCALL(1,ir,igr)         ! unshielded barns
      if(xcnoshield.gt.0.0d0) then
c-----loop over moments
      do m=1,3
      im = imuse(m)
      xcbarns = xcnoshield*xcnew(m,ir,igr) ! barns x f-factors
c-----compare to "new" cross section values based on
c-----           "new" multi-band parameters
      dxcnew = 100.0d0*(XCALL(im,ir,igr)-xcbarns)/XCALL(im,ir,igr)
      if(dabs(dxcnew).gt.dxcnewok) then
      if(imdiff.le.0) then ! Title define first output
      imdiff = 1
      write(3,40) dxcnewok
   40 format(1x,78('-')/' Failed Moments Conservation Test',
     1 ' by More than',0pf12.4,' %'/
     1 ' Group React Mom#  New         Old         Difference %'/
     2 1x,78('-'))
      endif
      write(3,50) igr,title4(ir),m,XCALL(im,ir,igr),xcbarns,dxcnew
      endif
   50 format(i6,1x,a4,i6,1p2d12.4,0pf12.4,' %')
      ENDDO    ! end moment, 1, 2, 3
      endif    ! end reaction > 0
      ENDDO    ! end reaction loop
      ENDDO    ! end group    loop
      if(imdiff.gt.0) write(3,60)
   60 format(1x,78('-'))
      RETURN
      END
      SUBROUTINE XCLST
C=======================================================================
C
C     PRINT SHIELDED OUTPUT LISTING.
C
C=======================================================================
      INCLUDE 'implicit.h'
      INTEGER*4 OTAPE2,OPS
      CHARACTER*1 ZABCD,FIELDX,xc1
      CHARACTER*24 xc1file
      CHARACTER*4 TUNITS,TMPHOL
      CHARACTER*8 SIGHL1,SIGHL2
      COMMON/UNITS/OTAPE2,NTAPE,LIST1,LIST2,LIST3,IPLOT
      COMMON/OPUS/OPS(5)
      COMMON/WHATZA/ATWT,IZA,MATNOW,MFNOW
      COMMON/TRASH/ERROK,ER10PC,MGROUP,METHODB,NBAND,NBMAX,
     1 NBNEED,MYSIGMA0
      COMMON/ELPASD/TUNITS(2,4),TMPHOL(3)
      COMMON/ELPASZ/ZABCD(12)
      COMMON/ELPAS2/EGB,TMPK
      COMMON/FIELDC/FIELDX(11,22)
      COMMON/SIGGIE/SIGHL1(12),SIGHL2(12)
      INCLUDE 'groupie.h'
      DIMENSION ITSIG(12),XCFIS(11)
      dimension xc1(24)
      equivalence (xc1file,xc1(1))
      data xc1file/'ZA000000.SHIELD.LST     '/
c                     zzzaaa
c                   123456789012345678901234
C-----DEFINE INDICES TO SIGMA0 SHIELDED VALUES TO LIST IN OUTPUT.
      DATA ITSIG/1,4,6,8,10,12,14,16,18,20,23,24/
c-----------------------------------------------------------------------
c
c     Define SHIELD.LST Filename = ZAzzzaaa.SHIELD.LST
c
c-----------------------------------------------------------------------
      call ZANAME(IZA,xc1(1))
      OPEN(LIST1,FILE=xc1file,STATUS='UNKNOWN')
c-----------------------------------------------------------------------
C
C     Heading.
C
c-----------------------------------------------------------------------
      CALL TOP1
c-----------------------------------------------------------------------
C
C     Loop Over Groups
C
c-----------------------------------------------------------------------
      DO 60 IGR=1,NGR
      CALL OUT9G(EGROUP(IGR),FIELDX(1,1))
      DO 50 KSECT=2,6
      CALL OUT9G(XCALL(1,KSECT,IGR),FIELDX(1,3))
c-----Ignore reactions with 0 cross section.
      if(XCALL(1,KSECT,IGR).le.0.0d0) go to 50
      DO 10 L=1,11
      LOUT = ITSIG(L+1)
c-----Define F-Factor
      XCFIS(L)=XCALL(LOUT,KSECT,IGR)/XCALL(1,KSECT,IGR)
   10 CONTINUE
c-----Insure TOTAL does not incresse vs. SIGMA-0.
      IF(KSECT.EQ.2) THEN
      DO KKK=1,11
      IF(XCFIS(KKK).GT.1.000001d0) THEN
      WRITE(3,20) (LLL,XCFIS(LLL),LLL=1,11)
      WRITE(*,20) (LLL,XCFIS(LLL),LLL=1,11)
      WRITE(3,20) (LLL,XCFI(LLL,2),LLL=1,25)
      WRITE(*,20) (LLL,XCFI(LLL,2),LLL=1,25)
   20 FORMAT(I8,0PF20.12)
      ENDIF
      ENDDO
      ENDIF
C-----INCLUDE GROUP NUMBER AND LOWER ENERGY WITH TOTAL.
      IF(KSECT.NE.2) GO TO 30
      WRITE(LIST1,80) IGR,(FIELDX(M,1),M=1,11),
     1 REACT3(1,KSECT),REACT3(2,KSECT),
     2 (FIELDX(M,3),M=1,11),XCFIS
      GO TO 40
   30 WRITE(LIST1,90) REACT3(1,KSECT),REACT3(2,KSECT),
     1 (FIELDX(M,3),M=1,11),XCFIS
   40 CONTINUE
   50 CONTINUE
   60 CONTINUE
c-----------------------------------------------------------------------
C
C     FINISH LAST PAGE OF LISTINGS FOR THIS MATERIAL.
C
c-----------------------------------------------------------------------
      CALL OUT9G(EGROUP(NGRP1),FIELDX(1,1))
C-----FINISH PAGE OF SELF-SHIELDED CROSS SECTIONS.
      IF(LIST1.LE.0.OR.NGR.LE.1) GO TO 70
      WRITE(LIST1,80) NGRP1,(FIELDX(M,1),M=1,11)
   70 CLOSE(LIST1)
      RETURN
   80 FORMAT(I5,11A1,1X,A4,A1,11A1,11F8.5)
   90 FORMAT(       17X,A4,A1,11A1,11F8.5)
      END
      SUBROUTINE TOP1
C=======================================================================
C
C     PRINT HEADING FOR SHIELDED OUTPUT LISTING.
C
C=======================================================================
      INCLUDE 'implicit.h'
      INTEGER*4 OTAPE2,OPS
      CHARACTER*1 ZABCD,FIELDX
      CHARACTER*4 TUNITS,TMPHOL
      CHARACTER*8 SIGHL1,SIGHL2,RICHAR
      COMMON/UNITS/OTAPE2,NTAPE,LIST1,LIST2,LIST3,IPLOT
      COMMON/OPUS/OPS(5)
      COMMON/WHATZA/ATWT,IZA,MATNOW,MFNOW
      COMMON/TRASH/ERROK,ER10PC,MGROUP,METHODB,NBAND,NBMAX,
     1 NBNEED,MYSIGMA0
      COMMON/ELPASD/TUNITS(2,4),TMPHOL(3)
      COMMON/ELPASZ/ZABCD(12)
      COMMON/ELPAS2/EGB,TMPK
      COMMON/FIELDC/FIELDX(11,22)
      COMMON/SIGGIE/SIGHL1(12),SIGHL2(12)
      INCLUDE 'groupie.h'
      DATA RICHAR/'R.I.    '/
c-----------------------------------------------------------------------
C
C     NOTHING TO DO IF NO SHIELDED OUTPUT LISTING.
C
c-----------------------------------------------------------------------
      IF(LIST1.LE.0) RETURN
c-----------------------------------------------------------------------
C
C     CALL SELECT EITHER COMPACT, SIMPLIFIED LISTING IF ONLY
C     1 GROUP (SPECTRUM AVERAGES) OR NORMAL LISTING IF MORE THAN
C     1 GROUP.
C
c-----------------------------------------------------------------------
c-----------------------------------------------------------------------
C
C     IF OUTPUT IS RESONANCE INTEGRALS CHANGE TITLE.
C
c-----------------------------------------------------------------------
      IF(OPS(1).NE.2) GO TO 10
      SIGHL1(1)=RICHAR
      SIGHL2(1)=RICHAR
   10 IF(NGR.GT.1) go to 30
c-----------------------------------------------------------------------
C
C     USE COMPACT, SIMPLIFIED FORMAT FOR 1 GROUP RESULTS.
C
c-----------------------------------------------------------------------
      CALL OUT9G(TMPK,     FIELDX(1,1))
      CALL OUT9G(EGROUP(1),FIELDX(1,2))
      CALL OUT9G(EGROUP(2),FIELDX(1,3))
      IF(MYSIGMA0.NE.0) GO TO 20
c-----Standard = multiples of unshielded total in each group
      IF(OPS(1).EQ.1) WRITE(LIST1,90) (FIELDX(M,1),M=1,11),
     1 TMPHOL(2),TMPHOL(3),((FIELDX(M,J),M=1,11),J=2,3),SIGHL1
      IF(OPS(1).EQ.2) WRITE(LIST1,100) (FIELDX(M,4),M=1,11),
     1 TMPHOL(2),TMPHOL(3),((FIELDX(M,J),M=1,11),J=2,3),SIGHL1
      RETURN
c-----Non-Standard = fixed barns in each group
C-----IDENTIFY CROSS SECTIONS OR RESONANCE INTEGRALS.
   20 IF(OPS(1).EQ.1) WRITE(LIST1,110) (FIELDX(M,4),M=1,11),
     1 TMPHOL(2),TMPHOL(3),((FIELDX(M,J),M=1,11),J=2,3),SIGHL2
      IF(OPS(1).EQ.2) WRITE(LIST1,120) (FIELDX(M,4),M=1,11),
     1 TMPHOL(2),TMPHOL(3),((FIELDX(M,J),M=1,11),J=2,3),SIGHL2
      RETURN
c-----------------------------------------------------------------------
c
C     IDENTIFY CROSS SECTIONS OR RESONANCE INTEGRALS.
C
C     USE NORMAL OUTPUT LISTING IF MORE THAN 1 GROUP.
C
c-----------------------------------------------------------------------
C-----CONVERT KELVIN TEMPERATURE TO OUTPUT FORM.
   30 IF(NGR.LE.1) RETURN
      CALL OUT9G(TMPK,FIELDX(1,4))
      IF(MYSIGMA0.NE.0) GO TO 40
C-----IDENTIFY CROSS SECTIONS OR RESONANCE INTEGRALS.
      IF(OPS(1).EQ.1) WRITE(LIST1,50) MATNOW,ZABCD,
     1 (FIELDX(M,4),M=1,11),
     1 TMPHOL(2),TMPHOL(3),ZABCD,SIGHL1
      IF(OPS(1).EQ.2) WRITE(LIST1,60) MATNOW,ZABCD,
     1 (FIELDX(M,4),M=1,11),
     1 TMPHOL(2),TMPHOL(3),ZABCD,SIGHL1
      RETURN
C-----IDENTIFY CROSS SECTIONS OR RESONANCE INTEGRALS.
   40 IF(OPS(1).EQ.1) WRITE(LIST1,70) MATNOW,ZABCD,
     1 (FIELDX(M,4),M=1,11),
     1 TMPHOL(2),TMPHOL(3),ZABCD,SIGHL2
      IF(OPS(1).EQ.2) WRITE(LIST1,80) MATNOW,ZABCD,
     1 (FIELDX(M,4),M=1,11),
     1 TMPHOL(2),TMPHOL(3),ZABCD,SIGHL2
      RETURN
   50 FORMAT(' MAT',I5,1X,12A1,12X,11A1,1X,
     1 A4,A2,' Self-Shielded Cross Sections',28X,12A1//
     2 21X,'  Unshielded (Sigma-0 = the Unshielded Total Cross',
     3 ' Section in Each Group times Below Multipliers)'/
     4 '  No.   Group-eV React',3X,12A8)
   60 FORMAT(' MAT',I5,1X,12A1, 9X,11A1,1X,
     1 A4,A2,' Self-Shielded Resonance Integrals',26X,12A1//
     2 21X,'  Unshielded (Sigma-0 = the Unshielded Total Cross',
     3 ' Section in Each Group times Below Multipliers)'/
     4 '  No.   Group-eV React',3X,12A8)
   70 FORMAT(' MAT',I5,1X,12A1,12X,11A1,1X,
     1 A4,A2,' Self-Shielded Cross Sections',28X,12A1//
     2 21X,'  Unshielded (Sigma-0 = the barns Values Listed',
     3 'Below)'/
     4 '  No.   Group-eV React',3X,12A8)
   80 FORMAT(' MAT',I5,1X,12A1, 9X,11A1,1X,
     1 A4,A2,' Self-Shielded Resonance Integrals',26X,12A1//
     2 21X,'  Unshielded (Sigma-0 = the barns Values Listed',
     3 ' Below)'/
     4 '  No.   Group-eV React',3X,12A8)
   90 FORMAT(' Self-Shielded Cross Sections'/
     1 1X,11A1,1X,A4,A2/
     2 1X,11A1,' to',11A1,' eV'//
     3 21X,'  Unshielded (Sigma-0 = the Unshielded Total Cross',
     4 ' Section in Each Group times Below Multipliers)'/
     5 ' Material   MAT React',2X,12A8)
  100 FORMAT(' Self-Shielded Resonance Integrals'/
     1 1X,11A1,1X,A4,A2/
     2 1X,11A1,' to',11A1,' eV'//
     3 21X,'  Unshielded (Sigma-0 = the Unshielded Total Cross',
     4 ' Section in Each Group times Below Multipliers)'/
     5 ' Material   MAT React',2X,12A8)
  110 FORMAT(' Self-Shielded Cross Sections'/
     1 1X,11A1,1X,A4,A2/
     2 1X,11A1,' to',11A1,' eV'//
     3 21X,'  Unshielded (Sigma-0 = the barns Values Listed',
     5 'Below)'/' Material   MAT React',2X,12A8)
  120 FORMAT(' Self-Shielded Resonance Integrals'/
     1 1X,11A1,1X,A4,A2/
     2 1X,11A1,' to',11A1,' eV'//
     3 21X,'  Unshielded (Sigma-0 = the barns Values Listed',
     5 ' Below)'/' Material   MAT React',2X,12A8)
      END
      SUBROUTINE TAB1(E,AV,IGRLOW)
C=======================================================================
C
C     OUTPUT MULTI-GROUP CROSS SECTIONS IN ENDF/B FORMAT IN EITHER
C     HISTOGRAM OR LINEAR-LINEAR INTERPOLABLE FORM.
C
C=======================================================================
      INCLUDE 'implicit.h'
      COMMON/LEADER/TEMP,Q,L1,L2,N1,N2,MAT,MF,MT
      COMMON/LAWYER/MYLAWO
      COMMON/FLAGS/MINUS3,IMPLUS
      INCLUDE 'groupie.h'
      DIMENSION E(*),AV(*),NBTO(1),INTO(2)
C-----DEFINE HISTOGRAM AND LINEAR-LINEAR INTERPOLATION LAW.
      DATA INTO/1,2/
C-----INITIALIZE INDEX TO OUTPUT ARRAY.
      II=0
      MINUS3=0
      IMPLUS=0
C-----SELECT HISTOGRAM OR LINEAR-LINEAR INTERPOLABLE FORM.
      IF(MYLAWO.GT.1) GO TO 20
c-----------------------------------------------------------------------
C
C     HISTOGRAM OUTPUT.
C
c-----------------------------------------------------------------------
C-----THERE WILL BE ONE POINT OUTPUT FOR EACH GROUP, PLUS A FINAL
C-----ENERGY AT UPPER ENERGY LIMIT OF LAST GROUP.
      N2OUT=NGR-IGRLOW+2
C-----OUTPUT LEADER CARD AND INTERPOLATION LAW (ONE INTERPOLATION REGION
C-----USING INTERPOLATION LAW 1).
      N1XX=1
      CALL CARDO(TEMP,Q,L1,L2,N1XX,N2OUT)
      NBTO(1)=N2OUT
      CALL TERPO(NBTO,INTO,1)
C-----OUTPUT ONE DATA POINT FOR EACH DATA POINT, PLUS AN EXTRA ENERGY
C-----AS THE UPPER ENERGY LIMIT OF THE LAST GROUP
      DO 10 ILOW=IGRLOW,NGR
      II=II+1
      XOUT(II)=E(ILOW)
      YOUT(II)=AV(ILOW)
      IF(II.LT.MAXOUT) GO TO 10
      CALL POINTO9(XOUT,YOUT,II)
      II=0
   10 CONTINUE
C-----ADD UPPER ENERGY LIMIT OF LAST GROUP AND OUTPUT.
      II=II+1
      XOUT(II)=E(NGRP1)
      YOUT(II)=0.0d0
      CALL POINTO9(XOUT,YOUT,II)
      GO TO 60
c-----------------------------------------------------------------------
C
C     LINEAR-LINEAR INTERPOLABLE OUTPUT.
C
c-----------------------------------------------------------------------
C-----THERE WILL BE TWO POINTS OUTPUT FOR EACH GROUP.
   20 N2OUT=2*(NGR-IGRLOW+1)
C-----IF CROSS SECTION HAS A THRESHOLD AND DOES NOT SPAN GROUP
C-----STRUCTURE DEFINE AN ADDITIONAL POINT TO DEFINE CROSS SECTION
C-----TO BE ZERO AT LOWER ENERGY LIMIT OF FIRST GROUP WITH NON-ZERO
C-----AVERAGE CROSS SECTION (GROUP IGRLOW).
      IF(IGRLOW.LE.1.OR.AV(IGRLOW).LE.0.0d0) GO TO 30
      XOUT(1)=E(IGRLOW)
      YOUT(1)=0.0d0
C-----INCREASE OUTPUT POINT COUNT FOR POINT AT THRESHOLD.
      N2OUT=N2OUT+1
      II=1
C-----OUTPUT LEADER CARD AND INTERPOLATION LAW (ONE INTERPOLATION REGION
C-----USING INTERPOLATION LAW 2).
   30 L1XX=1
      CALL CARDO(TEMP,Q,L1,L2,L1XX,N2OUT)
      NBTO(1)=N2OUT
      CALL TERPO(NBTO,INTO(2),1)
C-----CREATE TWO DATA POINTS FOR EACH ENERGY GROUP (POINTS AT LOWER
C-----AND UPPER ENERGY LIMITS OF GROUP. CROSS SECTION SAME AT BOTH
C-----POINTS).
      DO 50 ILOW=IGRLOW,NGR
      II=II+1
      XOUT(II)=E(ILOW)
      YOUT(II)=AV(ILOW)
      IF(II.LT.MAXOUT) GO TO 40
      CALL POINTO9(XOUT,YOUT,II)
      II=0
   40 II=II+1
      XOUT(II)=E(ILOW+1)
      YOUT(II)=AV(ILOW)
      IF(II.LT.MAXOUT) GO TO 50
      CALL POINTO9(XOUT,YOUT,II)
      II=0
   50 CONTINUE
      IF(II.GT.0) CALL POINTO9(XOUT,YOUT,II)
   60 RETURN
      END
      SUBROUTINE LISTAV(E,AV,IGRLOW)
C=======================================================================
C
C     LIST UNSHIELDED GROUP AVERAGE CROSS SECTION FOR ONE REACTION.
C
C=======================================================================
      INCLUDE 'implicit.h'
      INTEGER*4 OTAPE2,OPS
      CHARACTER*1 ZABCD,FIELD1,FIELD2,xc2
      CHARACTER*24 xc2file
      CHARACTER*4 QBLANK
      COMMON/UNITS/OTAPE2,NTAPE,LIST1,LIST2,LIST3,IPLOT
      COMMON/HEADER/C1H,C2H,L1H,L2H,N1H,N2H,MATH,MFH,MTH,NOSEQ
      COMMON/WHATZA/ATWT,IZA,MATNOW,MFNOW
      COMMON/ELPASZ/ZABCD(12)
      COMMON/OPUS/OPS(5)
      INCLUDE 'groupie.h'
      DIMENSION E(*),AV(*),KEY(4),FIELD1(11,6),FIELD2(11,6)
      DATA QBLANK/'    '/
      DATA IPASS/0/
      DATA LSTMAT/-9999/
      DATA LASTZA/-9999/
      dimension xc2(24)
      equivalence (xc2file,xc2(1))
      data xc2file/'ZA000000.UNSHIELD.LST   '/
c                    zzzaaa
c                  123456789012345678901234
c-----------------------------------------------------------------------
c
c     Define UNSHIELD.LST Filename = ZAzzzaaa.UNSHIELD.LST
c
c-----------------------------------------------------------------------
      if(IZA.ne.LASTZA) then
      if(LASTZA.gt.0) CLOSE(LIST3) ! Close current file
      LASTZA = IZA
      IPASS  = 0                   ! Initialize for each new ZA
      call ZANAME(IZA,xc2(1))
      OPEN(LIST3,FILE=xc2file,STATUS='UNKNOWN')
      endif
C-----DEFINE PARAMETERS FOR PAGE LAYOUT AT FIRST CALL.
      IF(IPASS.GT.0) GO TO 10
      IPASS=1
C-----PRINT TITLE IF USING ONLY 1 GROUP (SPECTRUM AVERAGES).
      CALL TOP3
c-----------------------------------------------------------------------
C
C     SELECT COMPACT OR NORMAL OUTPUT FORMAT.
C
c-----------------------------------------------------------------------
   10 IF(NGRP1.GT.2) GO TO 30
C-----SKIP ZERO OUTPUT.
      IF(AV(1).LE.0.0d0) GO TO 20
C-----SELECT CROSS SECTION OR RESONANCE INTEGRAL.
      AVUSE=AV(1)
      IF(OPS(5).EQ.2) AVUSE=DLOG(E(2)/E(1))*AVUSE
      CALL OUT9G(AVUSE,FIELD2(1,1))
      IF(MATNOW.NE.LSTMAT)
     1 WRITE(LIST3,130) ZABCD,MATNOW,MTH,(FIELD2(M,1),M=1,11)
      IF(MATNOW.EQ.LSTMAT)
     1 WRITE(LIST3,140) MTH,(FIELD2(M,1),M=1,11)
      LSTMAT=MATH
   20 RETURN
c-----------------------------------------------------------------------
C
C     NORMAL PAGE LAYOUT.
C
c-----------------------------------------------------------------------
C-----DEFINE NUMBER OF VALUES TO PRINT.
   30 LGR=(NGRP1-IGRLOW)+1
C-----DEVIDE INTO 4 COLUMNS.
      LCOL=(LGR+3)/4
      LCOLM1=LCOL-1
      LPAGE=4*LCOL
C-----SET UP LOOP OVER PAGES OF OUTPUT.
      DO 100 I1=IGRLOW,NGRP1,LPAGE
C-----LIST TITLE FOR PAGE.
      CALL TOP3
C-----DEFINE INDEX TO END OF FIRST COLUMN.
      I2=I1+LCOLM1
      IF(I2.GT.NGRP1) I2=NGRP1
C-----SET  UP LOOP OVER LINES OF OUTPUT ON THIS PAGE (UP TO 53 LINES).
      DO 90 I3=I1,I2
C-----SELECT UP TO FOUR GROUPS THAT WILL APPEAR ON THIS LINE.
      KEY(1)=I3
      CALL OUT9G(E(I3),FIELD1(1,1))
      IF(I3.GE.NGRP1) GO TO 40
C-----SELECT CROSS SECTION OR RESONANCE INTEGRAL.
      AVUSE=AV(I3)
      IF(OPS(5).EQ.2) AVUSE=DLOG(E(I3+1)/E(I3))*AVUSE
      CALL OUT9G(AVUSE,FIELD2(1,1))
   40 KK=I3
      DO 50 K=2,4
      KK=KK+LCOL
      IF(KK.GT.NGRP1) GO TO 60
      KEY(K)=KK
      CALL OUT9G(E(KK),FIELD1(1,K))
      IF(KK.GE.NGRP1) GO TO 50
C-----SELECT CROSS SECTION OR RESONANCE INTEGRAL.
      AVUSE=AV(KK)
      IF(OPS(5).EQ.2) AVUSE=DLOG(E(I3+1)/E(I3))*AVUSE
      CALL OUT9G(AVUSE,FIELD2(1,K))
   50 CONTINUE
      K=5
   60 K=K-1
C-----FOR UPPER ENERGY OF LAST GROUP DO NOT PRINT AVERAGE VALUE.
      IF(KEY(K).GE.NGRP1) GO TO 70
      WRITE(LIST3,110) (KEY(L),(FIELD1(M,L),M=1,11),
     1 (FIELD2(M,L),M=1,11),L=1,K)
      GO TO 90
   70 IF(K.LE.1) GO TO 80
      KM1=K-1
      WRITE(LIST3,110) (KEY(L),(FIELD1(M,L),M=1,11),
     1 (FIELD2(M,L),M=1,11),L=1,KM1),
     2 KEY(K),(FIELD1(M,K),M=1,11)
      GO TO 90
   80 WRITE(LIST3,110) NGRP1,(FIELD1(M,1),M=1,11)
   90 CONTINUE
C-----SPACE TO THE BOTTOM OF THE PAGE.
      WRITE(LIST3,120) QBLANK
  100 CONTINUE
      RETURN
  110 FORMAT(I6,22A1,3(I7,22A1))
  120 FORMAT(A1)
  130 FORMAT(1X,12A1,I5,I4,11A1)
  140 FORMAT(16X,I4,11A1)
      END
      SUBROUTINE TOP3
C=======================================================================
C
C     PRINT HEADING FOR UNSHIELDED OUTPUT LISTING.
C
C=======================================================================
      INCLUDE 'implicit.h'
      INTEGER*4 OTAPE2,OPS
      CHARACTER*1 ZABCD,FIELD1
      CHARACTER*4 TUNITS,TMPHOL
      COMMON/UNITS/OTAPE2,NTAPE,LIST1,LIST2,LIST3,IPLOT
      COMMON/HEADER/C1H,C2H,L1H,L2H,N1H,N2H,MATH,MFH,MTH,NOSEQ
      COMMON/WHATZA/ATWT,IZA,MATNOW,MFNOW
      COMMON/ELPASD/TUNITS(2,4),TMPHOL(3)
      COMMON/ELPASZ/ZABCD(12)
      COMMON/ELPAS2/EGB,TMPK
      COMMON/OPUS/OPS(5)
      INCLUDE 'groupie.h'
      DIMENSION FIELD1(11,3)
      DATA IPASS/0/
c-----Initialize for each new ZA
      data LASTZA/-9999/
      if(LASTZA.ne.IZA) then
      LASTZA = IZA
      IPASS  = 0
      endif
c-----------------------------------------------------------------------
C
C     NOTHING TO DO IF NO UNSHIELDED OUTPUT LISTING.
C
c-----------------------------------------------------------------------
      IF(LIST3.LE.0) RETURN
c-----------------------------------------------------------------------
C
C     ON FIRST CALL SELECT EITHER SPECIAL, COMPACT FORMAT IF ONLY
C     1 GROUP OR NORMAL OUTPUT LISTING.
C
c-----------------------------------------------------------------------
      IF(IPASS.GT.0) GO TO 10
      IPASS=1
c-----------------------------------------------------------------------
C
C     SPECIAL, COMPACT FORMAT IF ONLY 1 GROUP.
C
c-----------------------------------------------------------------------
      IF(NGR.GT.1) RETURN
      CALL OUT9G(TMPK     ,FIELD1(1,1))
      CALL OUT9G(EGROUP(1),FIELD1(1,2))
      CALL OUT9G(EGROUP(2),FIELD1(1,3))
C-----IDENTIFY EITHER CROSS SECTIONS OR RESONANCE INTEGRALS.
      IF(OPS(5).EQ.1) WRITE(LIST3,40) (FIELD1(M,1),M=1,11),
     1 TMPHOL(2),TMPHOL(3),((FIELD1(M,J),M=1,11),J=2,3)
      IF(OPS(5).EQ.2) WRITE(LIST3,50) (FIELD1(M,1),M=1,11),
     1 TMPHOL(2),TMPHOL(3),((FIELD1(M,J),M=1,11),J=2,3)
      RETURN
c-----------------------------------------------------------------------
C
C     IF MORE THAN 1 GROUP PRINT NORMAL HEADING.
C
c-----------------------------------------------------------------------
   10 IF(NGR.LE.1) RETURN
C-----LIST TITLE FOR PAGE.
      CALL OUT9G(TMPK     ,FIELD1(1,1))
C-----IDENTIFY EITHER CROSS SECTIONS OR RESONANCE INTEGRALS.
      IF(OPS(5).EQ.1) WRITE(LIST3,20) MTH,MATNOW,(FIELD1(M,1),M=1,11),
     1 TMPHOL(2),TMPHOL(3),ZABCD
      IF(OPS(5).EQ.2) WRITE(LIST3,30) MTH,MATNOW,(FIELD1(M,1),M=1,11),
     1 TMPHOL(2),TMPHOL(3),ZABCD
      RETURN
   20 FORMAT(53X,'MT=',I3/' MAT',I5,
     1 24X,11A1,1X,A4,A2,' Unshielded Cross Sections',
     2 26X,12A1//1X,'  No.  Group-eV   Average',
     3 3(4X,'  No.  Group-eV   Average')/)
   30 FORMAT(53X,'MT=',I3/' MAT',I5,
     1 22X,11A1,1X,A4,A2,' Unshielded Resonance Integrals',
     2 23X,12A1//1X,'  No.  Group-eV   R.I.   ',
     3 3(4X,'  No.  Group-eV   R.I.   ')/)
   40 FORMAT(
     1 ' Unshielded Cross Sections'/
     1 1X,11A1,1X,A4,A2/
     3 1X,11A1,' to',11A1,' eV'//
     2 '   Material  MAT  MT Average'/)
   50 FORMAT(
     1 ' Unshielded ResonAnce Integrals'/
     1 1X,11A1,1X,A4,A2/
     3 1X,11A1,' to',11A1,' eV'//
     2 '   Material  MAT  MT R.I.'/)
      END
      SUBROUTINE XYPAGE(I,ITYPE,X,Y)
C=======================================================================
C
C     RETRIEVE AND RETURN SELECTED X AND Y VALUES FROM THE PAGING
C     SYSTEM.
C
C     I     = DATA POINT INDEX (I=1 UP TO TABLE SIZE)
C     ITYPE = PAGING SYSTEM ARRAY INDEX WHICH DEFINES TYPE OF DATA.
C           = 1 ENERGY DEPENDENT WEIGHTING SPECTRUM.
C           = 2 TOTAL CROSS SECTION.
C           = 3 ELASTIC CROSS SECTION.
C           = 4 CAPTURE CROSS SECTION
C           = 5 FISSION CROSS SECTION.
C
C=======================================================================
      INCLUDE 'implicit.h'
      INTEGER*4 OUTP,OTAPE
      COMMON/ENDFIO/INP,OUTP,ITAPE,OTAPE
      COMMON/PAGER/NPAGE,NPAGM1
      COMMON/REALLY/XE,XA(5),YA(5),YB(5),YC(5),NPTAB(5),IPTAB(5),NSECT
      COMMON/INPAGE/IXYLOW(5),IXYHI(5),ISCR(5)
      INCLUDE 'groupie.h'
C-----INSURE POINT INDEX IS IN LEGAL RANGE.
      IF(I.GT.0.AND.I.LE.NPTAB(ITYPE)) GO TO 10
C-----ILLEGAL POINT INDEX.
      WRITE(OUTP,40) I,NPTAB(ITYPE)
      X=0.0d0
      Y=0.0d0
      RETURN
C-----IF DATA IS NOT IN CORE LOAD CORRECT PAGE.
   10 IF(I.GT.IXYLOW(ITYPE)) GO TO 30
      IXYHI(ITYPE)=0
      NSCR=ISCR(ITYPE)
      REWIND NSCR
   20 IXYLOW(ITYPE)=IXYHI(ITYPE)
      IXYHI(ITYPE)=IXYHI(ITYPE)+NPAGE
      CALL IBLOCK(ISCR(ITYPE),XPAGE(1,ITYPE),YPAGE(1,ITYPE),NPAGE)
   30 IF(I.GT.IXYHI(ITYPE)) GO TO 20
C-----DEFINE REQUIRED POINT.
      ICORE=I-IXYLOW(ITYPE)
      X=XPAGE(ICORE,ITYPE)
      Y=YPAGE(ICORE,ITYPE)
      RETURN
   40 FORMAT(15H XYPAGE..Index=,I6,' (MUST be 1 TO',I6,')')
      END
      SUBROUTINE BANDIT
C=======================================================================
C
C     THIS ROUTINE ONLY DOES ONE GROUP (IGR) USING XCINT, Defined only
C     for one group.
C
C     DEFINE MULTI-BAND WEIGHTS AND CROSS SECTIONS FOR TOTAL, ELASTIC,
C     CAPTURE AND FISSION. MULTI-BAND PARAMETERS ARE SELECTED TO
C     CONSERVE MOMENTS OF THE CROSS SECTIONS BASED UPON BONDERENKO
C     SELF-SHIELDED CROSS SECTIONS. IN ALL CASES THE AVERAGE SHIELDED
C     AND UNSHIELDED CROSS SECTIONS WILL BE CONSERVED. ADDITIONAL
C     MOMENTS WILL BE CONSERVED AS MORE CROSS SECTION BANDS ARE
C     USED.
C
C     THIS ROUTINE WILL START WITH ONE BAND AND INCREASE THE NUMBER OF
C     BANDS UNTIL EITHER ALL BONDERENKO SELF-SHIELDED CROSS SECTIONS
C     CAN BE APPROXIMATED TO WITHIN SOME ACCURACY (ERROK) OR THE MAXIMUM
C     DESIRED NUMBER OF BAND (NBMAX) IS REACHED.
C
C=======================================================================
      INCLUDE 'implicit.h'
      INTEGER*4 OUTP,OTAPE,OTAPE2
      CHARACTER*1 FIELDX,ZABCD
      CHARACTER*4 BUMMER
      COMMON/ENDFIO/INP,OUTP,ITAPE,OTAPE
      COMMON/UNITS/OTAPE2,NTAPE,LIST1,LIST2,LIST3,IPLOT
      COMMON/REALLY/XE,XA(5),YA(5),YB(5),YC(5),NPTAB(5),IPTAB(5),NSECT
      COMMON/WHATZA/ATWT,IZA,MATNOW,MFNOW
      COMMON/TRASH/ERROK,ER10PC,MGROUP,METHODB,NBAND,NBMAX,
     1 NBNEED,MYSIGMA0
      COMMON/ELPAS2/EGB,TMPK
      COMMON/FILLER/ISECT
      COMMON/ZABAD/IZABAD
      COMMON/FIELDC/FIELDX(11,22)
      COMMON/ELPASZ/ZABCD(12)
      COMMON/LOGCOM/MYLOG(8)
      INCLUDE 'groupie.h'
      DIMENSION XCB(5),WTB(5)
      DATA IERR/0/
C-----INITIALIZE ALL PARAMETERS (ONLY USED FOR 3 OR MORE BANDS).
      DATA BUMMER/'ERR '/
      DATA ZERO   /0.00D+00/
      DATA QUARTER/0.25D+00/
      DATA HALF   /0.50D+00/
      DATA ONE    /1.00D+00/
      DATA TWO    /2.00D+00/
c-----------------------------------------------------------------------
C
C     INITIALIZE TO 2 BANDS BEING USED
C
c-----------------------------------------------------------------------
      NBUSE=2
      NBNEED=NBUSE
      NBAND=NBUSE
C-----INITIALIZE ALL BAND VALUES FOR GROUP
      DO I=1,6
      DO J=1,MAXBAND
      XCBAND(I,J,IGR) = 0.0D+0
      ENDDO
      ENDDO
c-----------------------------------------------------------------------
C
C     EXTEND CROSS SECTION LIMITS OUTWARD
C     DEFINE 3 RANGES FOR SUCCESSIVE PASSES
C     #1:   1%
C     #2:  10%
C     #3: 100%
C
c-----------------------------------------------------------------------
      DO K=2,NSECT
      YLOWP1(K)  = 0.99d0*YLOW(K)
      YLOWP2(K)  = 0.90d0*YLOW(K)
      YLOWP3(K)  = 0.50d0*YLOW(K)
      YLOW (K)   = 0.50d0*YLOW(K)
      YHIGHP1(K) = 1.01d0*YHIGH(K)
      YHIGHP2(K) = 1.10d0*YHIGH(K)
      YHIGHP3(K) = 2.00d0*YHIGH(K)
      YHIGH(K)   = 2.00d0*YHIGH(K)
      ENDDO
C-----------------------------------------------------------------------
C
C     IF TOTAL = 0 OR NO SHIELDING USE 1 BAND
C
C-----------------------------------------------------------------------
      SIGT1   = XCINT( 1,2)
      SIGT2   = XCINT(23,2)
      IF(SIGT1.LE.ZERO)  GO TO 250
      IF(SIGT2.ge.SIGT1) GO TO 250
C-----------------------------------------------------------------------
C
C     LITTLE SHIELDING = CONSERVE 2 MOMENTS.
C
C-----------------------------------------------------------------------
c-----SMALL 0.01% TEST
      IF(SIGT2.gt.0.999d0*SIGT1) THEN
      MYLOGX = 2
      ABAND  = ONE/SIGT2
      BB2    = (SIGT1 - SIGT2)/SIGT1
      if(BB2.le.0.0d0) go to 250
      BBAND  = DSQRT(BB2)/SIGT2
      DBAND  = ZERO
      WT1    = HALF
      WT2    = HALF
      BANDT1 = ONE/(ABAND + BBAND)
      BANDT2 = ONE/(ABAND - BBAND)
      go to 10
      endif
C-----------------------------------------------------------------------
C
C     USE 2 BANDS
C
C     2020/8/2 - METHODB #2: CONSERVE 1/TOT AND 1/(TOT + <TOT>)
C
C-----------------------------------------------------------------------
      MYLOGX = 3
      SIGT3 = XCINT(12,2)
      ABAND = (SIGT1 - SIGT2)/(TWO*(SIGT1 - SIGT3)*SIGT2)
c-----------------------------------------------------------------------
C
C     THE FOLLOWING IS THE SAME FOR BOTH METHODS
C
c-----------------------------------------------------------------------
      BB2   = (SIGT2*ABAND*(SIGT1*ABAND-TWO)+ONE)/(SIGT1*SIGT2)
      if(BB2.le.0.0d0) go to 250
      BBAND = DSQRT(BB2)
      DBAND = (ONE-ABAND*SIGT2)/(TWO*SIGT2*BBAND) ! Note: divide by B
      WT1   = HALF + DBAND
      WT2   = HALF - DBAND
      BANDT1 = ONE/(ABAND + BBAND)
      BANDT2 = ONE/(ABAND - BBAND)
C-----------------------------------------------------------------------
C
C     TEST MOMENTS
C
C-----------------------------------------------------------------------
   10 APPROX1 = WT1*BANDT1 + WT2*BANDT2
      APPROX2 = ONE/(WT1/BANDT1 + WT2/BANDT2)
      if(MYLOGX.eq.2) then
      SIGT3   = XCINT(12,2)                   ! for below tests
      APPROX3 = SIGT3
      else                ! for below tests
      BB1     = BANDT1+SIGT1
      BB2     = BANDT2+SIGT1
      APPROX3 = (WT1*BANDT1/BB1 + WT2*BANDT2/BB2)/
     1          (WT1       /BB1 + WT2       /BB2)
      endif
      ERR2 = (SIGT1 - APPROX1)/SIGT1
      ERR2 = (SIGT2 - APPROX2)/SIGT2
      ERR3 = (SIGT3 - APPROX3)/SIGT3
      IF(DABS(ERR1).GT.1.0D-6.OR.
     1   DABS(ERR2).GT.1.0D-6.OR.
     1   DABS(ERR3).GT.1.0D-6) THEN
c-----2017/4/14 - ERROR message turned off
      WRITE(3,20) IGR,SIGT1,     SIGT2,     SIGT3,   METHODB,
     1                APPROX1,   APPROX2,   APPROX3,
     1                100.0d0*ERR1,100.0d0*ERR2,100.0d0*ERR3
      WRITE(*,20) IGR,SIGT1,     SIGT2,     SIGT3,   METHODB,
     1                APPROX1,   APPROX2,   APPROX3,
     1                100.0d0*ERR1,100.0d0*ERR2,100.0d0*ERR3
   20 FORMAT(I6,1P3D12.5,' moments   Method #',i1/
     1       6X,1P3D12.5,' approximations'/
     1       6X,1P3D12.5,' % differences')
      CALL ENDERROR
c-----2017/4/14 - ERROR message turned off
      ENDIF
C-----TEST D, A AND B
      IF(DABS(DBAND).GT.HALF.OR.BBAND.GT.ABAND) THEN
      WRITE(3,30) IGR,DBAND,ABAND,BBAND,METHODB
      WRITE(*,30) IGR,DBAND,ABAND,BBAND,METHODB
   30 FORMAT(' ERROR - IGR/D/A/B=',I6,1P3D20.12,' Method #',i1)
      CALL ENDERROR
      ENDIF
C-----------------------------------------------------------------------
C
C     DEFINE TOTAL BAND PARAMETERS
C
C-----------------------------------------------------------------------
      WTBAND  (1,IGR) = WT1
      WTBAND  (2,IGR) = WT2
      XCBAND(2,1,IGR) = BANDT1
      XCBAND(2,2,IGR) = BANDT2
C-----------------------------------------------------------------------
C
C     NEW LINEAR EQUATIONS.
C
C     SIG1 = <SIG1> - p/P1  BOTH TOTAL AND PARTIALS
c     SIG2 = <SIG1> + p/P2
C
C     T^2 = [(1/4-D^2)*<SIGT1>+2DT][<SIGT1>-<SIGT2>]
C     T^2 + 2bT + c = 0
C     Switching signs of both b and c
C     b = D[<sigt1>-<sigt2>]                > 0
C     c = (1/4-D^2)<sigt1>[<sigt1>-<sigt2>] > 0
C     T = b+[b^2 + c]^1/2  Only the + sign has a positive solution
C
C     P   = T[<SIGP1>-<SIGP2>]/[<SIGT1>-<SIGT2>]
C
C-----------------------------------------------------------------------
      DSIGT12 = SIGT1 - SIGT2
      if(DSIGT12.eq.0.0d0) go to 250            ! No Shielding
      BTRY = DBAND*DSIGT12
      CTRY = (QUARTER - DBAND**2)*SIGT1*DSIGT12
      ROOT = DSQRT(BTRY**2 + CTRY)
      DTOT = BTRY+ROOT
C-----------------------------------------------------------------------
C
C     LOOP OVER PARTIALS
C
C-----------------------------------------------------------------------
C
C     FIRST TRY STANDARD
C
c-----------------------------------------------------------------------
      TOTNORM = DTOT/DSIGT12
      DO 70 MSECT=3,6
      SIGP1 = XCINT( 1,MSECT)
      SIGP2 = XCINT(23,MSECT)
C-----NOTHING TO DO IF NO CROSS SECTION.
      IF(SIGP1.LE.ZERO) GO TO 50
      CBAND  = TOTNORM*(SIGP1 - SIGP2)
      BANDP1 = SIGP1 - CBAND/WT1
      BANDP2 = SIGP1 + CBAND/WT2
c-----------------------------------------------------------------------
C
C     TEST MOMENTS
C
c-----------------------------------------------------------------------
      SIXP1  = WT1*BANDP1 + WT2*BANDP2
      SIXP2  = (WT1*BANDP1/BANDT1 + WT2*BANDP2/BANDT2)/
     1         (WT1       /BANDT1 + WT2       /BANDT2)
      ERR1 = DABS(SIGP1 - SIXP1)
      ERR2 = DABS(SIGP2 - SIXP2)
      if(DABS(SIGP1).ne.0.0d0.and.DABS(SIGP2).ne.0.0d0) then
      if(ERR1.gt.1.0d-6*DABS(SIXP1).or.
     1   ERR2.gt.1.0d-6*DABS(SIXP2)) then
c-----2017/4/14 - ERROR message turned off = now a WARNING = NO STOP
      write(3,40) IGR,MSECT,SIGP1,     SIGP2,
     1                      SIXP1,     SIXP2,
     2                      100.0d0*ERR1,100.0d0*ERR2
      write(*,40) IGR,MSECT,SIGP1,     SIGP2,
     1                      SIXP1,     SIXP2,
     2                      100.0d0*ERR1,100.0d0*ERR2
   40 format(2i4,1p2d12.5,' partials'/
     1        8x,1p2d12.5,' approximations'/
     1        8x,1p2d12.5,' % differences')
c-----2017/4/14 - ERROR message turned off = now a WARNING = NO STOP
c     CALL ENDERROR
      endif
      endif
c-----------------------------------------------------------------------
C
C     INSURE PARTIAL CROSS SECTIONS ARE POSITIVE.
C
c-----------------------------------------------------------------------
      if(CBAND.ge.0.0d0) then
      if(CBAND.gt. 0.999d0*WT1*SIGP1) then
      CBAND  =     0.999d0*WT1*SIGP1
      BANDP1 = SIGP1 - CBAND/WT1
      BANDP2 = SIGP1 + CBAND/WT2
      endif
      else
      if(CBAND.lt.-0.999d0*WT2*SIGP1) then
      CBAND  =    -0.999d0*WT2*SIGP1
      BANDP1 = SIGP1 - CBAND/WT1
      BANDP2 = SIGP1 + CBAND/WT2
      endif
      endif
C-----SKIP RANGE TEST FOR "OTHER"
      IF(MSECT.EQ.6) GO TO 60
C-----INSURE PARTIALS ARE IN LEGAL RANGE (STRICT HERE).
      IF(BANDP1.LT.YLOW(MSECT).OR.BANDP1.GT.YHIGH(MSECT)) GO TO 80
      IF(BANDP2.LT.YLOW(MSECT).OR.BANDP2.GT.YHIGH(MSECT)) GO TO 80
      GO TO 60
c-----------------------------------------------------------------------
C
C     USE NO SHIELDING FOR PARTIAL.
C
c-----------------------------------------------------------------------
   50 BANDP1=SIGP1
      BANDP2=SIGP1
c-----------------------------------------------------------------------
C
C     PARTIAL PARAMETERS ARE O.K. - SAVE THEM.
C
c-----------------------------------------------------------------------
   60 XCBAND(MSECT,1,IGR)=BANDP1
      XCBAND(MSECT,2,IGR)=BANDP2
C-----END OF PARTIAL LOOP
   70 CONTINUE
C-----ALL PARTIALS ARE O.K.
      MYLOG(MYLOGX) = MYLOG(MYLOGX) + 1
      GO TO 270
C-----------------------------------------------------------------------
C
C     NEXT TRY ITERATION
C
C-----------------------------------------------------------------------
   80 DBSTART = DBAND
      DBSTEP = 1.0D-05
      IF(DBAND.GT.0.0D+0) DBSTEP = -DBSTEP
c-----------------------------------------------------------------------
c
C     LOOP FOR STRICT/LOOSE CONVERGENCE
C     MYLOOP = 1:   1%
C              2:  10%
C              3: 100%
C              4: POSITIVE
C
c-----------------------------------------------------------------------
      DO 210 MYLOOP=1,4
      MYCHANGE = 0
C-----LOOP TO VARY DBAND
      DO 200 IDB = -50000,50000
      DBAND = IDB*DBSTEP
      BTRY   = DBAND*DSIGT12
      CTRY   = (QUARTER - DBAND**2)*SIGT1*DSIGT12
      ROOT   = DSQRT(BTRY**2 + CTRY)
      DTOT   = BTRY+ROOT
      WT1    = HALF + DBAND
      WT2    = HALF - DBAND
      BANDT1 = SIGT1 - DTOT/WT1
      BANDT2 = SIGT1 + DTOT/WT2
C-----SKIP IF TOTAL PARAMETERS AREE NOT O.K.
      IF(WT1.LT.ZERO.OR.WT2.LT.ZERO) GO TO 190
      IF(BANDT1.LT.YLOW(2).OR.BANDT1.GT.YHIGH(2)) GO TO 190
      IF(BANDT2.LT.YLOW(2).OR.BANDT2.GT.YHIGH(2)) GO TO 190
      TOTNORM = DTOT/DSIGT12
      DO 180 MSECT=3,6
      SIGP1 = XCINT( 1,MSECT)
      SIGP2 = XCINT(23,MSECT)
C-----NOTHING TO DO IF NO CROSS SECTION.
      IF(SIGP1.LE.ZERO) GO TO 160
      CBAND = TOTNORM*(SIGP1 - SIGP2)
      BANDP1 = SIGP1 - CBAND/WT1
      BANDP2 = SIGP1 + CBAND/WT2
C-----SKIP RANGE TEST FOR "OTHER"
      IF(MSECT.EQ.6) GO TO 170
C-----INSURE PARTIALS ARE IN LEGAL RANGE
      GO TO (90,110,130,150), MYLOOP
C-----PASS 1: STRICT 1%
   90 IF(BANDP1.GE.YLOWP1(MSECT).AND.BANDP1.LE.YHIGHP1(MSECT)) GO TO 100
      GO TO 190
  100 IF(BANDP2.GE.YLOWP1(MSECT).AND.BANDP2.LE.YHIGHP1(MSECT)) GO TO 170
      GO TO 190
C-----PASS 2: NOT STRICT 10%
  110 IF(BANDP1.GE.YLOWP2(MSECT).AND.BANDP1.LE.YHIGHP2(MSECT)) GO TO 120
      GO TO 190
  120 IF(BANDP2.GE.YLOWP2(MSECT).AND.BANDP2.LE.YHIGHP2(MSECT)) GO TO 170
      GO TO 190
C-----PASS 3: SOFT 100%
  130 IF(BANDP1.GE.YLOWP3(MSECT).AND.BANDP1.LE.YHIGHP3(MSECT)) GO TO 140
      GO TO 190
  140 IF(BANDP2.GE.YLOWP3(MSECT).AND.BANDP2.LE.YHIGHP3(MSECT)) GO TO 170
      GO TO 190
C-----PASS 4: VERY SOFT
  150 IF(BANDP1.GE.ZERO.AND.BANDP2.GE.ZERO) GO TO 170
      GO TO 190
c-----------------------------------------------------------------------
C
C     USE NO SHIELDING FOR PARTIAL.
C
c-----------------------------------------------------------------------
  160 BANDP1=SIGP1
      BANDP2=SIGP1
c-----------------------------------------------------------------------
C
C     PARTIAL PARAMETERS ARE O.K. - SAVE THEM.
C
c-----------------------------------------------------------------------
  170 XCBAND(MSECT,1,IGR)=BANDP1
      XCBAND(MSECT,2,IGR)=BANDP2
C-----END OF PARTIAL LOOP
  180 CONTINUE
C-----ALL PARTIALS ARE O.K. - IF CHANGED, COPY NEW TOTALS
      MYLOGX = 3+MYLOOP
      MYLOG(MYLOGX) = MYLOG(MYLOGX) + 1
      IF(MYCHANGE.NE.0) THEN
      WTBAND(1,IGR) = WT1
      WTBAND(2,IGR) = WT2
      XCBAND(2,1,IGR) = BANDT1
      XCBAND(2,2,IGR) = BANDT2
      ENDIF
      GO TO 270
C-----END OF LOOP TO CHANGE DBAND
  190 MYCHANGE = 1
  200 CONTINUE
C-----END OF STRICT/LOOSE LOOP
  210 CONTINUE
C-----------------------------------------------------------------------
C
C     CHANGING DBAND DID NOT HELP - RESET TO ORIGINAL
C     AND INSURE PARTIALS ARE NOT NEGATIVE.
C
C-----------------------------------------------------------------------
      MYLOGX   = 8
      MYLOG(8) = MYLOG(8) + 1
      DBAND = DBSTART
      WT1   = HALF + DBAND
      WT2   = HALF - DBAND
      BTRY = DBAND*DSIGT12
      CTRY = (QUARTER - DBAND**2)*SIGT1*DSIGT12
      ROOT = DSQRT(BTRY**2 + CTRY)
      DTOT= BTRY+ROOT
      BANDT1 = SIGT1 - DTOT/WT1
      BANDT2 = SIGT1 + DTOT/WT2
      WTBAND(1,IGR) = WT1
      WTBAND(2,IGR) = WT2
      XCBAND(2,1,IGR) = BANDT1
      XCBAND(2,2,IGR) = BANDT2
      TOTNORM = DTOT/DSIGT12
C-----LOOP OVER REACTIONS
      DO 240 MSECT=3,6
      SIGP1 = XCINT( 1,MSECT)
      SIGP2 = XCINT(23,MSECT)
C-----NOTHING TO DO IF NO CROSS SECTION.
      IF(SIGP1.LE.ZERO) GO TO 220
      CBAND = TOTNORM*(SIGP1 - SIGP2)
      BANDP1 = SIGP1 - CBAND/WT1
      BANDP2 = SIGP1 + CBAND/WT2
C-----NO NEGATIVES
      IF(BANDP1.LT.ZERO) THEN
      CBAND =  WT1*SIGP1
      BANDP1 = SIGP1 - CBAND/WT1
      BANDP2 = SIGP1 + CBAND/WT2
      ENDIF
      IF(BANDP2.LT.ZERO) THEN
      CBAND = -WT2*SIGP1
      BANDP1 = SIGP1 - CBAND/WT1
      BANDP2 = SIGP1 + CBAND/WT2
      ENDIF
      IF(BANDP1.LT.ZERO) BANDP1 = ZERO
      IF(BANDP2.LT.ZERO) BANDP2 = ZERO
      GO TO 230
  220 BANDP1=SIGP1
      BANDP2=SIGP1
  230 XCBAND(MSECT,1,IGR)=BANDP1
      XCBAND(MSECT,2,IGR)=BANDP2
  240 CONTINUE
      GO TO 270
C-----------------------------------------------------------------------
C
C     NO SHIELDING - USE 1 BAND
C
C-----------------------------------------------------------------------
  250 MYLOGX   = 1
      MYLOG(1) = MYLOG(1) + 1
      WTBAND(1,IGR)=0.5d0
      WTBAND(2,IGR)=0.5d0
      DO 260 MSECT=2,6
      XCBAND(MSECT,1,IGR)=XCINT(1,MSECT)
      XCBAND(MSECT,2,IGR)=XCINT(1,MSECT)
  260 CONTINUE
C-----------------------------------------------------------------------
C
C     DEFINE TOTAL = SUM OF PARTS
C
C     WARNING - This SUM allows for competition - MSECT = 6
C
C-----------------------------------------------------------------------
  270 XCBAND(2,1,IGR)=ZERO
      XCBAND(2,2,IGR)=ZERO
      DO 280 MSECT=3,6
      XCBAND(2,1,IGR)=XCBAND(2,1,IGR)+XCBAND(MSECT,1,IGR)
      XCBAND(2,2,IGR)=XCBAND(2,2,IGR)+XCBAND(MSECT,2,IGR)
  280 CONTINUE
C-----------------------------------------------------------------------
C
C     DEFINE ERROR IN FIT
C
C-----------------------------------------------------------------------
      ERRMAX=ZERO
      XCB(1)=XCBAND(2,1,IGR)/XCINT(1,2)
      XCB(2)=XCBAND(2,2,IGR)/XCINT(1,2)
      WTB(1)=WTBAND(1,IGR)
      WTB(2)=WTBAND(2,IGR)
      DO 300 I=2,23
      XCTOP=0.0d0
      AVNORM(I)=ZERO
      DO 290 NB=1,NBUSE
      FACTOR=WTB(NB)/(XCB(NB)+SIGMAB(I))
      XCTOP=XCTOP+FACTOR*XCB(NB)
      AVNORM(I)=AVNORM(I)+FACTOR
  290 CONTINUE
      IF(AVNORM(I).gt.0.0d0.and.XCFI(I,2).gt.0.0d0) then
      XCAV=XCTOP/AVNORM(I)
      ERNOW(I,NBUSE)=DABS(ONE-XCAV/XCFI(I,2))
      IF(ERNOW(I,NBUSE).GT.ERRMAX) ERRMAX=ERNOW(I,NBUSE)
      else
      ERNOW(I,NBUSE) = 0.0d0
      endif
  300 CONTINUE
      AVNORM(24)=WTB(1)/(XCB(1)**2)
      AVNORM(25)=AVNORM(24)/XCB(1)
      DO 310 NB=2,NBUSE
      FACTOR=WTB(NB)/(XCB(NB)**2)
      AVNORM(24)=AVNORM(24)+FACTOR
      AVNORM(25)=AVNORM(25)+FACTOR/XCB(NB)
  310 CONTINUE
C-----------------------------------------------------------------------
C
C     MULTI-BAND PARAMETERS ARE PHYSICALLY ACCEPTABLE AND YIELD LOWEST
C     ERROR OF ANY NUMBER OF BANDS CONSIDERED SO FAR.
C
C-----------------------------------------------------------------------
      DO 320 I=2,23
      IF(ERNOW(I,NBAND).GT.ERMAT(I,NBAND)) ERMAT(I,NBAND)=ERNOW(I,NBAND)
  320 CONTINUE
C-----------------------------------------------------------------------
C
C     ITERATION IS COMPLETED. SET ALL REMAINING WEIGHTS TO ZERO AND
C     CROSS SECTIONS TO UNSHIELDED AVERAGES. SAVE LAST ACCEPTABLE
C     SET OF WEIGHTS AND CROSS SECTIONS FOR DETERMNATION OF PARTIAL
C     CROSS SECTIN BAND PARAMETERS.
C
C-----------------------------------------------------------------------
      IF(NBAND.GE.NBMAX) GO TO 350
      NBP1=NBAND+1
      DO 340 NB=NBP1,NBMAX
      WTBAND(NB,IGR)=ZERO
      DO 330 MSECT=2,6
      XCBAND(MSECT,NB,IGR)=XCINT(1,MSECT)
  330 CONTINUE
  340 CONTINUE
C-----------------------------------------------------------------------
C
C     CHECK THAT TOTAL IS SUM OF PARTS IN EACH BAND
C
C-----------------------------------------------------------------------
  350 IF(XCINT(1,2).LE.ZERO) GO TO 630
      DO 390 NB=1,NBAND
      SUMMER=0.0d0
      IF(XCBAND(2,NB,IGR).GT.ZERO) THEN
      DO 360 KSECT=3,6
      SUMMER=SUMMER+XCBAND(KSECT,NB,IGR)
  360 CONTINUE
      DIFF=(XCBAND(2,NB,IGR)-SUMMER)/XCBAND(2,NB,IGR)
      IF(DABS(DIFF).LE.1.0D-03) GO TO 390
      GO TO 370
      ELSE
      DIFF   = ZERO
      SUMMER = ZERO
      ENDIF
  370 WRITE(OUTP,380) IGR,NB,WTBAND(NB,IGR),100.0d0*DIFF,SUMMER,
     1 (XCBAND(K,NB,IGR),K=2,6)
      WRITE(   *,380) IGR,NB,WTBAND(NB,IGR),100.0d0*DIFF,SUMMER,
     1 (XCBAND(K,NB,IGR),K=2,6)
  380 FORMAT(' Band Sum ERROR',I6,I2,1PE11.4,0PF10.2,' %',1P8E11.4)
  390 CONTINUE
C-----------------------------------------------------------------------
C
C     COMPARE EXACT CROSS SECTION MOMENTS TO THOSE RECONSTRUCTED
C     FROM THE BAND PARAMETERS.
C
C-----------------------------------------------------------------------
C-----DEFINE NORMALIZATION (DENOMINATOR) FOR ALL SELF-SHIELDED
C-----CROSS SECTIONS.
      DO 400 I=2,25
      AVNORM(I)=ZERO
  400 CONTINUE
      DO 420 NB=1,NBAND
      DO 410 I=2,23
      AVNORM(I)=AVNORM(I)+WTBAND(NB,IGR)/
     1 (XCBAND(2,NB,IGR)+SHIELD(I))
  410 CONTINUE
      SA2=XCBAND(2,NB,IGR)**2
      SA3=SA2*XCBAND(2,NB,IGR)
      AVNORM(24)=AVNORM(24)+WTBAND(NB,IGR)/SA2
      AVNORM(25)=AVNORM(25)+WTBAND(NB,IGR)/SA3
  420 CONTINUE
C-----DEFINE NUMERATOR FOR EACH REACTION AND EACH SELF-SHIELDED
C-----CROSS SECTION.
      DO 620 ISECT=2,6
      IF(XCINT(1,ISECT).LE.ZERO) GO TO 620
      DO 430 I=1,25
      AVEXP(I)=0.0d0
  430 CONTINUE
      DO 450 NB=1,NBAND
      ADDNB=WTBAND(NB,IGR)*XCBAND(ISECT,NB,IGR)
      AVEXP(1)=AVEXP(1)+ADDNB
      DO 440 I=2,23
      AVEXP(I)=AVEXP(I)+ADDNB/(XCBAND(2,NB,IGR)+SHIELD(I))
  440 CONTINUE
      SA2=XCBAND(2,NB,IGR)**2
      SA3=SA2*XCBAND(2,NB,IGR)
      AVEXP(24)=AVEXP(24)+ADDNB/SA2
      AVEXP(25)=AVEXP(25)+ADDNB/SA3
  450 CONTINUE
C-----DEFINE NORMALIZED RECONSTRUCTED SELF-SHIELDED
C-----CROSS SECTIONS.
      DO 460 I=2,25
      AVEXP(I)=AVEXP(I)/AVNORM(I)
  460 CONTINUE
C-----DEFINE DIFFERENCE BETWEEN EXACT AND RECONSTRUCTED VALUES.
      DO 480 I=1,25
      IF(XCINT(I,ISECT).GT.0.0d0) GO TO 470
      ERNOW(I,NBAND)=ZERO
      GO TO 480
  470 ERNOW(I,NBAND)=DABS(ONE-AVEXP(I)/XCINT(I,ISECT))
  480 CONTINUE
C-----UPDATE MAXIMUM ERROR FOR SELF-SHIELDED TOTAL CROSS SECTIONS.
      IF(ISECT.NE.2) GO TO 500
      IF(ERNOW(24,NBAND).GT.ERMAT(24,NBAND))
     1 ERMAT(24,NBAND)=ERNOW(24,NBAND)
      IF(ERNOW(25,NBAND).GT.ERMAT(25,NBAND))
     1 ERMAT(25,NBAND)=ERNOW(25,NBAND)
      DO 490 I=1,25
C-----UPDATE MAXIMUM ERROR IF MULTI-BANDS ARE NOT USED
C-----(I.E. ONE BAND/GROUP)
      IF(XCFI(I,2).gt.ZERO) then
      ERNOW(I,1)=DABS(ONE-ONE/XCFI(I,2))
      IF(ERNOW(I,1).GT.ERMAT(I,1)) ERMAT(I,1)=ERNOW(I,1)
      else
      ERNOW(I,1) = 0.0d0
      endif
  490 CONTINUE
C-----------------------------------------------------------------------
C
C     CHECK DATA AND PRINT IF ANY ERRORS
C
C-----------------------------------------------------------------------
C-----CHECK WEIGHTS BETWEEN ZERO AND ONE AND BAND CROSS SECTIONS
C-----BETWEEN MINIMUM AND MAXIMUM FOR EACH REACTION.
  500 DO 510 NB=1,NBMAX
      IF(WTBAND(NB,IGR).LT.ZERO.OR.WTBAND(NB,IGR).GT.ONE)
     1 GO TO 520
C-----NO LIMIT TEST FOR OTHER
      IF(ISECT.GE.5) GO TO 510
C-----NO LIMIT TEST FOR CROSS SECTION SMALL COMPARED TO TOTAL
      IF(XCINT(1,ISECT).LE.0.005d0*XCINT(1,2)) GO TO 510
      IF(XCBAND(ISECT,NB,IGR).LT.YLOW (ISECT).OR.
     1   XCBAND(ISECT,NB,IGR).GT.YHIGH(ISECT)) GO TO 520
  510 CONTINUE
C-----FOR EACH CROSS SECTION CHECK TWO CONSERVED MOMENTS.
      IF(ERNOW(1,NBAND).LE.ER10PC.AND.ERNOW(23,NBAND).LE.ERROK)
     1 GO TO 620
C-----------------------------------------------------------------------
C
C     ONE OR MORE ERRORS IN PARAMETERS. RE-CHECK, FLAG AND LIST ALL
C     PARAMETERS.
C
C-----------------------------------------------------------------------
  520 XES=XE
C-----NO ERROR MESSAGE FOR OTHER
      IF(ISECT.GT.5) GO TO 620
      WRITE(OUTP,650) IGR,ZABCD,REACT2(1,ISECT),REACT2(2,ISECT),
     1 EGB,XES,YLOW(2),YHIGH(2),YLOW(ISECT),YHIGH(ISECT),XCINT(1,2),
     2             XCINT(23,2),XCINT(1,ISECT),
     3 XCINT(23,ISECT),AVEXP(1),          AVEXP(23),
     4 100.0d0*ERNOW( 1,NBAND),
     5 100.0d0*ERNOW(23,NBAND)
C-----CHECK ERRORS.
      IERR=0
      DO 530 I=1,3
      POINT(I)='    '
  530 CONTINUE
      IF(ERNOW(1,NBAND).LE.ER10PC) GO TO 540
      IERR=1
      POINT(1)=BUMMER
  540 IF(ERNOW(23,NBAND).LE.ERROK) GO TO 550
      IERR=1
      POINT(2)=BUMMER
  550 IF(IERR.GT.0) WRITE(OUTP,690) (POINT(I),I=1,2)
C-----CHECK BAND WEIGHTS.
      WRITE(OUTP,660) (WTBAND(NB,IGR),NB=1,NBMAX)
      IF(ISECT.GT.2) GO TO 580
      IERR=0
      DO 570 NB=1,NBMAX
      IF(WTBAND(NB,IGR).LT.ZERO.OR.WTBAND(NB,IGR).GT.ONE)
     1 GO TO 560
      POINT(NB)='    '
      GO TO 570
  560 IERR=1
      POINT(NB)=BUMMER
      IF(IZABAD.LE.0) WRITE(OUTP,640) IZA,IGR
      IZABAD=1
  570 CONTINUE
      IF(IERR.GT.0) WRITE(OUTP,690) (POINT(NB),NB=1,NBMAX)
  580 WRITE(OUTP,670) (XCBAND(2,NB,IGR),NB=1,NBMAX)
C-----CHECK PARTIAL BAND CROSS SECTIONS.
      WRITE(OUTP,680) (XCBAND(ISECT,NB,IGR),NB=1,NBMAX)
      IERR=0
      DO 600 NB=1,NBMAX
      IF(XCBAND(ISECT,NB,IGR).LT.YLOW (ISECT).OR.
     1   XCBAND(ISECT,NB,IGR).GT.YHIGH(ISECT)) GO TO 590
      POINT(NB)='    '
      GO TO 600
  590 IERR=1
      POINT(NB)=BUMMER
  600 CONTINUE
      IF(IERR.GT.0) WRITE(OUTP,690) (POINT(NB),NB=1,NBMAX)
      WRITE(OUTP,700)
      IF(XCBAND(ISECT,1,IGR).LT.0.0d0.OR.
     1   XCBAND(ISECT,2,IGR).LT.0.0d0) THEN
      WRITE(3,610) ISECT,IGR,(XCBAND(ISECT,k,IGR),k=1,2)
      WRITE(*,610) ISECT,IGR,(XCBAND(ISECT,k,IGR),k=1,2)
  610 FORMAT(' ERROR - Negative Partials..ISECT/IGR=',2i5/
     1       '         Partialls=',1P2D12.5)
      CALL ENDERROR
      ENDIF
C-----------------------------------------------------------------------
C
C     END OF CHECK LOOP
C
C-----------------------------------------------------------------------
  620 CONTINUE
  630 RETURN
  640 FORMAT(' ERROR - Bad Weights in',I6,' Group',I6)
  650 FORMAT(1X,78('-')/
     1  1X,'ERROR in Group',I5,1X,12A1,2A4/
     2  1X,'Energy Range    ',1P2E11.4,' eV'/
     3  1X,'Total Limits    ',1P2E11.4/
     4  1X,'Partial Limits  ',1P2E11.4/
     5  1X,'Total Averages  ',1P2E11.4/
     6  1X,'Partial Averages',1P2E11.4/
     7  1X,'Approximation   ',1P2E11.4/
     8  1X,'Error           ',0P2F11.2,' %')
  660 FORMAT(1X,'Weights         ',1P5E11.4)
  670 FORMAT(1X,'Total Bands     ',1P5E11.4)
  680 FORMAT(1X,'Partial Bands   ',1P5E11.4)
  690 FORMAT(17X,5(6X,A4))
  700 FORMAT(1X,78('-'))
      END
      SUBROUTINE GROPE(IWANT,EGROUP,NGROUP)
C=======================================================================
C
C     THIS ROUTINE IS DESIGNED TO DEFINE ONE OF THE BUILT IN GROUP
C     STRUCTURES.
C
C     ENERGIES ARE RETURNED IN ASCENDING ORDER IN EV.
C
C     ARGUMENTS
C     ---------
C     IWANT   = ENERGY GROUP STRUCTURE SELECTOR.
C             = 0  175 GROUPS (TART)
C             = 1   50 GROUPS (ORNL)
C             = 2  126 GROUPS (ORNL)
C             = 3  171 GROUPS (ORNL)
C             = 4  620 GROUPS (SAND-II, 1.0D-4, UP TO 18 MEV)
C             = 5  640 GROUPS (SAND-II, 1.0D-4, UP TO 20 MEV)
C             = 6   69 GROUPS (WIMS)
C             = 7   68 GROUPS (GAM-I)
C             = 8   99 GROUPS (GAM-II)
C             = 9   54 GROUPS (MUFT)
C             =10   28 GROUPS (ABBN)
C             =11  616 GROUPS (TART TO 20 MEV)
C             =12  700 GROUPS (TART TO 1 GEV)
C             =13  665 GROUPS (SAND-II, 1.0D-5 eV, UP TO 18 MEV)
C             =14  685 GROUPS (SAND-II, 1.0D-5 eV, UP TO 20 MEV)
C             =15  666 GROUPS (TART TO 200 MEV)
C             =16  725 GROUPS (SAND-II, 1.0D-5 eV, UP TO  60 MEV)
C             =17  755 GROUPS (SAND-II, 1.0D-5 eV, UP TO 150 MEV)
C             =18  765 GROUPS (SAND-II, 1.0D-5 eV, UP TO 200 MEV)
C             =19 1102 GROUPS (UKAEA  , 1.0D-5 eV, UP TO   1 GeV)
C             = OTHERWISE ZERO GROUP BOUNDARIES ARE RETURNED
C
C=======================================================================
      INCLUDE 'implicit.h'
      DIMENSION EGROUP(*),
     1 TART(176),ORNLA(51),ORNLB(127),ORNLC(172),
     1 WIMS(70),GAMI(69),GAMII(100),XMUFT(55),ABBN(29),
     2 TART1(40),TART2(40),TART3(40),
     3 TART4(40),TART5(16),GR50A(45),GR50B(6),GR126A(45),GR126B(45),
     4 GR126C(37),GR171A(45),GR171B(45),GR171C(45),GR171D(37),
     7 WIMSA(45),WIMSB(25),
     8 GAMIA(45),GAMIB(24),GAMIIA(45),GAMIIB(45),GAMIIC(10)
      EQUIVALENCE (TART(1),TART1(1)),(TART(41),TART2(1)),
     1 (TART(81),TART3(1)),(TART(121),TART4(1)),(TART(161),TART5(1)),
     2 (ORNLA(1),GR50A(1)),(ORNLA(46),GR50B(1)),(ORNLB(1),GR126A(1)),
     3 (ORNLB(46),GR126B(1)),(ORNLB(91),GR126C(1)),(ORNLC(1),GR171A(1)),
     4 (ORNLC(46),GR171B(1)),(ORNLC(91),GR171C(1)),
     5 (ORNLC(136),GR171D(1))
      EQUIVALENCE (WIMS(1),WIMSA(1)),
     1 (WIMS(46),WIMSB(1)),(GAMI(1),GAMIA(1)),(GAMI(46),GAMIB(1)),
     2 (GAMII(1),GAMIIA(1)),(GAMII(46),GAMIIB(1)),(GAMII(91),GAMIIC(1))
c-----------------------------------------------------------------------
C
C     DEFINE TART 175 GROUP STRUCTURE
C
c-----------------------------------------------------------------------
      DATA TART1/ 1.3068D-03, 5.2271D-03, 2.0908D-02, 3.2669D-02,
     1 4.7044D-02, 8.3215D-02, 1.3068D-01, 1.8817D-01,
     2 2.5613D-01, 3.3453D-01, 4.2339D-01, 5.1230D-01,
     3 7.5270D-01, 1.1761D+00, 1.5106D+00, 2.0908D+00,
     4 2.7411D+00, 3.5335D+00, 4.7044D+00, 5.6578D+00,
     5 6.7367D+00, 8.3215D+00, 9.6199D+00, 1.1012D+01,
     6 1.3068D+01, 1.4683D+01, 1.5812D+01, 1.7584D+01,
     7 1.8817D+01, 2.0746D+01, 2.2769D+01, 2.4170D+01,
     8 2.5613D+01, 2.7097D+01, 2.8623D+01, 2.9402D+01,
     9 3.0991D+01, 3.3453D+01, 3.6009D+01, 3.8659D+01/
      DATA TART2/ 4.0478D+01, 4.2339D+01, 4.3285D+01, 4.6186D+01,
     1 4.7174D+01, 4.9181D+01, 5.1230D+01, 5.3321D+01,
     2 5.6536D+01, 5.7628D+01, 6.0968D+01, 6.3247D+01,
     3 6.5568D+01, 6.6744D+01, 7.0335D+01, 7.1553D+01,
     4 7.5270D+01, 7.7800D+01, 7.9080D+01, 8.1673D+01,
     5 8.4307D+01, 8.8337D+01, 9.1076D+01, 9.3857D+01,
     6 9.6680D+01, 9.8107D+01, 1.0245D+02, 1.0990D+02,
     7 1.1761D+02, 1.2558D+02, 1.3381D+02, 1.4059D+02,
     8 1.5106D+02, 1.6008D+02, 1.6936D+02, 1.7890D+02,
     9 1.8870D+02, 1.9876D+02, 2.0908D+02, 2.7411D+02/
      DATA TART3/ 3.2669D+02, 3.8105D+02, 4.7044D+02, 4.9908D+02,
     1 5.6578D+02, 6.0425D+02, 6.3666D+02, 7.1558D+02,
     2 8.3215D+02, 9.1767D+02, 1.0585D+03, 1.3068D+03,
     3 1.5812D+03, 1.8817D+03, 2.2084D+03, 2.5613D+03,
     4 2.9402D+03, 3.3453D+03, 3.7765D+03, 4.2339D+03,
     5 5.7628D+03, 7.5270D+03, 1.0245D+04, 1.5106D+04,
     6 2.0908D+04, 2.6462D+04, 3.2669D+04, 3.9530D+04,
     7 4.7044D+04, 5.7615D+04, 7.0020D+04, 8.3215D+04,
     8 9.8909D+04, 1.3068D+05, 1.8195D+05, 2.0746D+05,
     9 2.4170D+05, 2.7097D+05, 2.9402D+05, 3.3453D+05/
      DATA TART4/ 3.7765D+05, 4.2339D+05, 5.1230D+05, 6.3247D+05,
     1 7.5270D+05, 8.8337D+05, 1.0245D+06, 1.1761D+06,
     2 1.3381D+06, 1.5106D+06, 1.6936D+06, 1.8870D+06,
     3 2.0908D+06, 2.3051D+06, 2.5299D+06, 2.7411D+06,
     4 3.0108D+06, 3.2669D+06, 3.5335D+06, 3.8105D+06,
     5 4.0688D+06, 4.3960D+06, 4.7044D+06, 4.9908D+06,
     6 5.3525D+06, 5.6578D+06, 6.0425D+06, 6.3666D+06,
     7 6.7367D+06, 7.1558D+06, 7.5479D+06, 7.9096D+06,
     8 8.3215D+06, 8.7867D+06, 9.1767D+06, 9.6648D+06,
     9 1.0120D+07, 1.0585D+07, 1.1012D+07, 1.1547D+07/
      DATA TART5/ 1.1993D+07, 1.2499D+07, 1.3068D+07, 1.3542D+07,
     1 1.3863D+07, 1.4134D+07, 1.4407D+07, 1.4683D+07,
     2 1.5186D+07, 1.5754D+07, 1.6334D+07, 1.6923D+07,
     3 1.7523D+07, 1.8134D+07, 1.8755D+07, 2.0000D+07/
c-----------------------------------------------------------------------
C
C     DEFINE ORNL 50, 126 AND 171 GROUP STRUCTURES.
C
c-----------------------------------------------------------------------
C-----DEFINE 50 GROUP ENERGY BOUNDARIES.
      DATA GR50A/
     1 1.0000D-05, 6.8256D-01, 1.1250D+00, 1.8550D+00, 3.0590D+00,
     2 5.0430D+00, 8.3150D+00, 1.3710D+01, 2.2600D+01, 3.7270D+01,
     3 6.1440D+01, 1.0130D+02, 1.6700D+02, 2.7540D+02, 3.5360D+02,
     4 4.5400D+02, 5.8290D+02, 7.4850D+02, 9.6110D+02, 1.2340D+03,
     5 1.5850D+03, 2.0350D+03, 2.7470D+03, 3.3550D+03, 4.3070D+03,
     6 5.5310D+03, 7.1020D+03, 9.1190D+03, 1.1710D+04, 1.5030D+04,
     7 1.9300D+04, 2.4790D+04, 3.1830D+04, 4.0870D+04, 5.2480D+04,
     8 6.7380D+04, 8.6520D+04, 1.1110D+05, 1.4260D+05, 1.8320D+05,
     9 2.3520D+05, 3.0200D+05, 3.8770D+05, 4.9790D+05, 8.2080D+05/
      DATA GR50B/
     1 1.3530D+06, 2.2310D+06, 3.6790D+06, 6.0650D+06, 1.0000D+07,
     2 1.9970D+07/
C-----DEFINE 126 GROUP ENERGY BOUNDARIES.
      DATA GR126A/
     1 1.0000D-05, 1.0000D-01, 4.1399D-01, 1.1254D+00, 2.3724D+00,
     2 5.0435D+00, 1.0677D+01, 2.2603D+01, 3.7267D+01, 4.7851D+01,
     3 6.1442D+01, 1.0130D+02, 1.6702D+02, 2.1445D+02, 2.7536D+02,
     4 4.5400D+02, 7.4852D+02, 9.6112D+02, 1.2341D+03, 1.5846D+03,
     5 2.0347D+03, 2.2487D+03, 2.4852D+03, 2.6126D+03, 2.7465D+03,
     6 3.0354D+03, 3.3546D+03, 3.7074D+03, 4.3074D+03, 5.5308D+03,
     7 7.1017D+03, 9.1188D+03, 1.1709D+04, 1.5034D+04, 1.9305D+04,
     8 2.1875D+04, 2.3579D+04, 2.4788D+04, 2.6058D+04, 2.7000D+04,
     9 2.8500D+04, 3.1828D+04, 3.4307D+04, 4.0868D+04, 4.6309D+04/
      DATA GR126B/
     1 5.2475D+04, 5.6562D+04, 6.7379D+04, 7.2000D+04, 7.9500D+04,
     2 8.2500D+04, 8.6517D+04, 9.8037D+04, 1.1109D+05, 1.1679D+05,
     3 1.2277D+05, 1.2907D+05, 1.3569D+05, 1.4264D+05, 1.4996D+05,
     4 1.5764D+05, 1.6573D+05, 1.7422D+05, 1.8316D+05, 1.9255D+05,
     5 2.0242D+05, 2.1280D+05, 2.2371D+05, 2.4724D+05, 2.7324D+05,
     6 2.8725D+05, 2.9452D+05, 2.9720D+05, 2.9850D+05, 3.0197D+05,
     7 3.3373D+05, 3.6883D+05, 4.0762D+05, 4.5049D+05, 4.9787D+05,
     8 5.2340D+05, 5.5023D+05, 5.7844D+05, 6.0810D+05, 6.3928D+05,
     9 6.7206D+05, 7.0651D+05, 7.4274D+05, 7.8082D+05, 8.2085D+05/
      DATA GR126C/
     1 8.6294D+05, 9.0718D+05, 9.6164D+05, 1.0026D+06, 1.1080D+06,
     2 1.1648D+06, 1.2246D+06, 1.2873D+06, 1.3534D+06, 1.4227D+06,
     3 1.4957D+06, 1.5724D+06, 1.6530D+06, 1.7377D+06, 1.8268D+06,
     4 1.9205D+06, 2.0190D+06, 2.1225D+06, 2.2313D+06, 2.3069D+06,
     5 2.3653D+06, 2.3852D+06, 2.4660D+06, 2.5924D+06, 2.7253D+06,
     6 2.8650D+06, 3.0119D+06, 3.1664D+06, 3.6788D+06, 4.4933D+06,
     7 5.4881D+06, 6.0653D+06, 6.7032D+06, 8.1873D+06, 1.0000D+07,
     8 1.2214D+07, 1.7333D+07/
C-----DEFINE 171 GROUP ENERGY BOUNDARIES.
      DATA GR171A/
     1 1.0000D-05, 1.0000D-01, 4.1399D-01, 5.3158D-01, 6.8256D-01,
     2 8.7642D-01, 1.1254D+00, 1.4450D+00, 1.8554D+00, 2.3724D+00,
     3 3.0590D+00, 3.9279D+00, 5.0435D+00, 6.4760D+00, 8.3153D+00,
     4 1.0677D+01, 1.3710D+01, 1.7603D+01, 2.2603D+01, 2.9203D+01,
     5 3.7267D+01, 4.7851D+01, 6.1442D+01, 7.8893D+01, 1.0130D+02,
     6 1.3007D+02, 1.6702D+02, 2.1445D+02, 2.7536D+02, 3.5358D+02,
     7 4.5400D+02, 5.8295D+02, 7.4852D+02, 9.6112D+02, 1.2341D+03,
     8 1.5846D+03, 2.0347D+03, 2.2487D+03, 2.4852D+03, 2.6126D+03,
     9 2.7465D+03, 3.0354D+03, 3.3546D+03, 3.7074D+03, 4.3074D+03/
      DATA GR171B/
     1 5.5308D+03, 7.1017D+03, 9.1188D+03, 1.1709D+04, 1.5034D+04,
     2 1.9305D+04, 2.1875D+04, 2.3579D+04, 2.4176D+04, 2.4788D+04,
     3 2.6058D+04, 2.7000D+04, 2.8500D+04, 3.1828D+04, 3.4307D+04,
     4 4.0868D+04, 4.6309D+04, 5.2475D+04, 5.6562D+04, 6.7379D+04,
     5 7.2000D+04, 7.9500D+04, 8.2500D+04, 8.6517D+04, 9.8037D+04,
     6 1.1109D+05, 1.1679D+05, 1.2277D+05, 1.2907D+05, 1.3569D+05,
     7 1.4264D+05, 1.4996D+05, 1.5764D+05, 1.6573D+05, 1.7422D+05,
     8 1.8316D+05, 1.9255D+05, 2.0242D+05, 2.1280D+05, 2.2371D+05,
     9 2.3518D+05, 2.4724D+05, 2.7324D+05, 2.8725D+05, 2.9452D+05/
      DATA GR171C/
     1 2.9720D+05, 2.9850D+05, 3.0197D+05, 3.3373D+05, 3.6883D+05,
     2 3.8774D+05, 4.0762D+05, 4.5049D+05, 4.9787D+05, 5.2340D+05,
     3 5.5023D+05, 5.7844D+05, 6.0810D+05, 6.3928D+05, 6.7206D+05,
     4 7.0651D+05, 7.4274D+05, 7.8082D+05, 8.2085D+05, 8.6294D+05,
     5 9.0718D+05, 9.6164D+05, 1.0026D+06, 1.1080D+06, 1.1648D+06,
     6 1.2246D+06, 1.2873D+06, 1.3534D+06, 1.4227D+06, 1.4957D+06,
     7 1.5724D+06, 1.6530D+06, 1.7377D+06, 1.8268D+06, 1.9205D+06,
     8 2.0190D+06, 2.1225D+06, 2.2313D+06, 2.3069D+06, 2.3457D+06,
     9 2.3653D+06, 2.3852D+06, 2.4660D+06, 2.5924D+06, 2.7253D+06/
      DATA GR171D/
     1 2.8650D+06, 3.0119D+06, 3.1664D+06, 3.3287D+06, 3.6788D+06,
     2 4.0657D+06, 4.4933D+06, 4.7237D+06, 4.9659D+06, 5.2205D+06,
     3 5.4881D+06, 5.7695D+06, 6.0653D+06, 6.3763D+06, 6.5924D+06,
     4 6.7032D+06, 7.0469D+06, 7.4082D+06, 7.7880D+06, 8.1873D+06,
     5 8.6071D+06, 9.0484D+06, 9.5123D+06, 1.0000D+07, 1.0513D+07,
     6 1.1052D+07, 1.1618D+07, 1.2214D+07, 1.2840D+07, 1.3499D+07,
     7 1.3840D+07, 1.4191D+07, 1.4550D+07, 1.4918D+07, 1.5683D+07,
     8 1.6487D+07, 1.7333D+07/
c-----------------------------------------------------------------------
C
C     DEFINE WIMS 69 GROUP STRUCTURE.
C
c-----------------------------------------------------------------------
      DATA WIMSA/
     1 0.0001D0  , 0.0050D0  , 0.0100D0  , 0.0150D0  , 0.0200D0  ,
     2 0.0250D0  , 0.0300D0  , 0.0350D0  , 0.0420D0  , 0.0500D0  ,
     3 0.0580D0  , 0.0670D0  , 0.0800D0  , 0.1000D0  , 0.1400D0  ,
     4 0.1800D0  , 0.2200D0  , 0.2500D0  , 0.2800D0  , 0.3000D0  ,
     5 0.3200D0  , 0.3500D0  , 0.4000D0  , 0.5000D0  , 0.6250D0  ,
     6 0.7800D0  , 0.8500D0  , 0.9100D0  , 0.9500D0  , 0.9720D0  ,
     7 0.9960D0  , 1.0200D0  , 1.0450D0  , 1.0710D0  , 1.0970D0  ,
     8 1.1230D0  , 1.1500D0  , 1.3000D0  , 1.5000D0  , 2.1000D0  ,
     9 2.6000D0  , 3.3000D0  , 4.0000D0  , 9.8770D0  , 15.968D0  /
      DATA WIMSB/
     1 27.7000D0  , 48.0520D0   , 75.5014D0  , 148.728D0 , 367.262D0 ,
     2 906.898D0  , 1425.10D0   , 2239.45D0  , 3519.10D0 , 5530.00D0 ,
     3 9118.00D0  , 15030.0D0   , 24780.0D0  , 40850.0D0 , 67340.0D0 ,
     4 111000.0D0 , 183000.0D0  , 302000.0D0 , 500000.0D0, 821000.0D0,
     5 1353000.0D0, 2231000.0D0 , 3679000.0D0,
     6 6065000.0D0, 10000000.0D0/
c-----------------------------------------------------------------------
C
C     DEFINE GAM-I 68 GROUP STRUCTURE.
C
c-----------------------------------------------------------------------
      DATA GAMIA/
     1 0.414D0,    0.532D0,    0.683D0,    0.876D0,    1.125D0,
     2 1.44D0,     1.86D0,     2.38D0,     3.06D0,     3.93D0,
     3 5.04D0,     6.48D0,     8.32D0,    10.68D0,    13.7D0,
     4 17.6D0,     22.6D0,     29.0D0,     37.3D0,     47.9D0,
     5 61.4D0,     78.9D0,    101.0D0,    130.0D0,    167.0D0,
     6 215.0D0,    275.0D0,    354.0D0,    454.0D0,    583.0D0,
     7 748.0D0,    961.0D0,   1230.0D0,   1590.0D0,   2040.0D0,
     8 2610.0D0,   3360.0D0,   4310.0D0,   5530.0D0,   7100.0D0,
     9 9120.0D0,  11700.0D0,  15000.0 D0, 19300.0D0,  24800.0D0/
      DATA GAMIB/
     1 31800.0D0 , 40900.0D0 , 52500.0D0 , 67400.0D0 , 86500.0D0 ,
     2 111000.0D0, 143000.0D0, 183000.0D0, 235000.0D0, 302000.0D0,
     3 388000.0D0, 498000.0D0, 639000.0D0, 821000.0D0, 1.0500D+06,
     4 1.3600D+06, 1.7400D+06, 2.2300D+06, 2.8700D+06, 3.6800D+06,
     5 4.7200D+06, 6.0700D+06, 7.7900D+06, 1.0000D+07/
c-----------------------------------------------------------------------
C
C     DEFINE GAM-II 99 GROUP STRUCTURE.
C
c-----------------------------------------------------------------------
      DATA GAMIIA/
     1 0.414D0,    0.532D0,    0.683D0,    0.876D0,    1.125D0,
     2 1.44D0,     1.86D0,     2.38D0,     3.06D0,     3.93D0,
     3 5.04D0,     6.48D0,     8.32D0,    10.68D0,    13.7D0,
     4 17.6D0,     22.6D0,     29.0D0,     37.3D0,     47.9D0,
     5 61.4D0,     78.9D0,    101.0D0,    130.0D0,    167.0D0,
     6 215.0D0,    275.0D0,    354.0D0,    454.0D0,    583.0D0,
     7 748.0D0,    961.0D0,   1230.0D0,   1590.0D0,   2040.0D0,
     8 2610.0D0,   3360.0D0,   4310.0D0,   5530.0D0,   7100.0D0,
     9 9120.0D0,  11700.0D0,  15000.0D0,  19300.0D0,  24800.0D0/
      DATA GAMIIB/
     1 31800.00D0,  40900.0D0,  52500.0D0,  67400.0D0,  86500.0D0,
     2 111000.0D0, 128000.0D0, 136000.0D0, 150000.0D0, 166000.0D0,
     3 183000.0D0, 202000.0D0, 224000.0D0, 247000.0D0, 273000.0D0,
     4 302000.0D0, 334000.0D0, 369000.0D0, 408000.0D0, 450000.0D0,
     5 498000.0D0, 550000.0D0, 608000.0D0, 672000.0D0, 743000.0D0,
     6 821000.0D0, 907000.0D0, 1.0000D+06, 1.1100D+06, 1.2200D+06,
     7 1.3500D+06, 1.5000D+06, 1.6500D+06, 1.8300D+06, 2.0200D+06,
     8 2.2300D+06, 2.4700D+06, 2.7300D+06, 3.0100D+06, 3.3300D+06,
     9 3.6800D+06, 4.0700D+06, 4.4900D+06, 4.9600D+06, 5.4900D+06/
      DATA GAMIIC/
     1 6.0700D+06, 6.7000D+06, 7.4100D+06, 8.1900D+06, 9.0500D+06,
     2 1.0000D+07, 1.1100D+07, 1.2200D+07, 1.3500D+07, 1.4900D+07/
c-----------------------------------------------------------------------
C
C     DEFINE MUFT 54 GROUP STRUCTURE.
C
c-----------------------------------------------------------------------
      DATA XMUFT/
     1   0.625D+0,   0.835D+0,   1.125D+0,   1.440D+0,   1.855D+0,
     2    2.38D+0,    3.06D+0,    3.97D+0,    5.10D+0,    6.50D+0,
     3    8.32D+0,    10.7D+0,    13.7D+0,    17.6D+0,    22.6D+0,
     4    29.0D+0,    37.2D+0,    47.8D+0,    61.3D+0,    78.7D+0,
     5   101.0D+0,   130.0D+0,   167.0D+0,   275.0D+0,   454.0D+0,
     6   750.0D+0,  1230.0D+0,  2030.0D+0,  3350.0D+0,  5530.0D+0,
     7  9120.0D+0, 15000.0D+0, 24800.0D+0, 40900.0D+0, 67400.0D+0,
     8 86500.0D+0, 1.11000D+5, 1.43000D+5, 1.83000D+5, 2.35000D+5,
     9 3.02000D+5, 3.87000D+5, 4.98000D+5, 6.39000D+5, 8.21000D+5,
     A 1.0500D+06, 1.3500D+06, 1.7400D+06, 2.2300D+06, 2.8600D+06,
     1 3.6800D+06, 4.7200D+06, 6.0700D+06, 7.7900D+06, 1.0000D+07/
c-----------------------------------------------------------------------
C
C    ABBN GROUP STRUCTURE (28 GROUPS - NARROW GROUP NEAR THERMAL,
C    DUMMY GROUP FROM 0.0256 TO 0.215 EV, 26 GROUPS UP TO 15 MEV).
C
c-----------------------------------------------------------------------
      DATA ABBN/  2.500D-02, 2.560D-02,
     1 2.150D-01, 4.650D-01, 1.000D+00, 2.150D+00, 4.650D+00, 1.000D+01,
     1 2.150D+01, 4.650D+01, 1.000D+02, 2.150D+02, 4.650D+02, 1.000D+03,
     1 2.150D+03, 4.650D+03, 1.000D+04, 2.150D+04, 4.650D+04, 1.000D+05,
     1 2.000D+05, 4.000D+05, 8.000D+05, 1.400D+06, 2.500D+06, 4.000D+06,
     1 6.500D+06, 1.050D+07, 1.500D+07/
c-----------------------------------------------------------------------
C
C     CHECK FOR ALLOWABLE VALUES - IF NOT, RETURN NO GROUPS.
C
c-----------------------------------------------------------------------
      IF(IWANT.GE.0.AND.IWANT.LE.19) GO TO 10
      NGROUP=0
      RETURN
c-----------------------------------------------------------------------
C
C     SELECT GROUP STRUCTURE
C
c-----------------------------------------------------------------------
   10 II=IWANT+1
c              1   2   3   4   5   6   7   8   9  10
      GO TO ( 20, 40, 60, 80,100,110,120,140,160,180,
     1       200,220,230,250,260,240,270,280,290,300),II
C-----TART 176 GROUPS
   20 DO 30 I=1,176
      EGROUP(I)=TART(I)
   30 CONTINUE
      NGROUP=175
      RETURN
C-----ORNL 50 GROUPS
   40 DO 50 I=1,51
      EGROUP(I)=ORNLA(I)
   50 CONTINUE
      NGROUP=50
      RETURN
C-----ORNL 126 GROUPS
   60 DO 70 I=1,127
      EGROUP(I)=ORNLB(I)
   70 CONTINUE
      NGROUP=126
      RETURN
C-----ORNL 171 GROUPS
   80 DO 90 I=1,172
      EGROUP(I)=ORNLC(I)
   90 CONTINUE
      NGROUP=171
      RETURN
c-----------------------------------------------------------------------
C
C     SAND-II - Original - 1.0D-4 eV to 18 or 20 MeV.
C
c-----------------------------------------------------------------------
C-----SAND 620 GROUPS (1.0D-4 eV to 18 MeV)
  100 EGRPMIN = 1.0D-4
      EGRPMAX = 1.8D+7
      CALL SAND2GEN(EGROUP,NGROUP,EGRPMIN,EGRPMAX)
      RETURN
C-----SAND 640 GROUPS (1.0D-4 eV to 20 MeV)
  110 EGRPMIN = 1.0D-4
      EGRPMAX = 2.0D+7
      CALL SAND2GEN(EGROUP,NGROUP,EGRPMIN,EGRPMAX)
      RETURN
C-----WIMS 69 GROUPS
  120 DO 130 I=1,70
      EGROUP(I)=WIMS(I)
  130 CONTINUE
      NGROUP=69
      RETURN
C-----GAM-I 68 GROUPS
  140 DO 150 I=1,69
      EGROUP(I)=GAMI(I)
  150 CONTINUE
      NGROUP=68
      RETURN
C-----GAM-II 99 GROUPS
  160 DO 170 I=1,100
      EGROUP(I)=GAMII(I)
  170 CONTINUE
      NGROUP=99
      RETURN
C-----MUFT 54 GROUPS
  180 DO 190 I=1,55
      EGROUP(I)=XMUFT(I)
  190 CONTINUE
      NGROUP=54
      RETURN
C-----ABBN 28 GROUPS
  200 DO 210 I=1,29
      EGROUP(I)=ABBN(I)
  210 CONTINUE
      NGROUP=28
      RETURN
C-----TART 616 GROUPS UP TO 20 MeV
  220 EGRPMAX = 2.0D+7
      CALL TARTGEN(EGROUP,NGROUP,EGRPMAX)
      RETURN
C-----TART 700 GROUPS UP TO 1 GeV
  230 EGRPMAX = 1.0D+9
      CALL TARTGEN(EGROUP,NGROUP,EGRPMAX)
      RETURN
C-----TART 666 GROUPS UP TO 200 MeV
  240 EGRPMAX = 2.0D+8
      CALL TARTGEN(EGROUP,NGROUP,EGRPMAX)
      RETURN
c-----------------------------------------------------------------------
C
C     SAND-II - Extended down to 1.0D-5 up to 18 or 20 MeV.
C
c-----------------------------------------------------------------------
C-----SAND 665 GROUPS (1.0D-5 eV to 18 MeV)
  250 EGRPMIN = 1.0D-5
      EGRPMAX = 1.8D+7
      CALL SAND2GEN(EGROUP,NGROUP,EGRPMIN,EGRPMAX)
      RETURN
C-----SAND 685 GROUPS (1.0D-5 eV to 20 MeV)
  260 EGRPMIN = 1.0D-5
      EGRPMAX = 2.0D+7
      CALL SAND2GEN(EGROUP,NGROUP,EGRPMIN,EGRPMAX)
      RETURN
c-----------------------------------------------------------------------
C
C     SAND-II - Extended up to 60, 150 or 200 MeV.
C
c-----------------------------------------------------------------------
C-----SAND 725 GROUPS (1.0D-5 eV to 60 MeV)
  270 EGRPMIN = 1.0D-5
      EGRPMAX = 6.0D+7
      CALL SAND2GEN(EGROUP,NGROUP,EGRPMIN,EGRPMAX)
      RETURN
C-----SAND 755 GROUPS (1.0D-5 eV to 150 MeV)
  280 EGRPMIN = 1.0D-5
      EGRPMAX = 1.5D+8
      CALL SAND2GEN(EGROUP,NGROUP,EGRPMIN,EGRPMAX)
      RETURN
C-----SAND 765 GROUPS (1.0D-5 eV to 200 MeV)
  290 EGRPMIN = 1.0D-5
      EGRPMAX = 2.0D+8
      CALL SAND2GEN(EGROUP,NGROUP,EGRPMIN,EGRPMAX)
      RETURN
c-----------------------------------------------------------------------
C
C     UKAEA 1102 GROUPS (1.0D-5 eV to 1 GeV)
C
c-----------------------------------------------------------------------
  300 EGRPMAX = 1.0D+9
      CALL UKAEAGEN(EGROUP,NGROUP,EGRPMAX)
      RETURN
      END
      SUBROUTINE TARTGEN(EGROUP,NGROUP,EGRPMAX)
C===============================================================
C
C     DEFINE TART GROUP STRUCTURE FROM 1.0D-5 eV TO UP
C     ANY UPPER LIMIT DEFINED BY EGRPMAX INPUT.
C
C===============================================================
      INCLUDE 'implicit.h'
      DIMENSION EGROUP(*)
c-----2011/11 - Corrected lower energy to 1.0D-5 from 1.0D-04.
      DATA EGRPMIN/1.0D-05/
      DATA TEN/10.0D+00/
      DATA FIFTY/50.0D+00/
C-----DEFAULT IS 700 GROUPS
      NGROUP=700
C-----50 PER ENERGY DECADE
      DE=DEXP(DLOG(TEN)/FIFTY)
      ENOW=EGRPMIN
C-----DEFINE GROUPS UP TO MAXIMUM ENDL ENERGY
      DO 10 I=1,NGROUP+1
      EGROUP(I)=ENOW
      IF(EGROUP(I).eq.EGRPMAX) go to 30
      IF(EGROUP(I).gt.EGRPMAX) go to 20
      ENOW=ENOW*DE
   10 CONTINUE
      RETURN
C-----DEFINE END OF GROUPS AT MAXIMUM ENDL ENERGY
   20 EGROUP(I)=EGRPMAX
   30 NGROUP=I-1
      RETURN
      END
      SUBROUTINE SAND2GEN(EGROUP,NGROUP,EGRPMIN,EGRPMAX)
C=======================================================================
C
C     GENERAL SAND-II GROUP STRUCTURE TO SELECT ALL GROUPS
C     BETWEEN EGRPMIN AND EGRPMAX (INPUT PARAMETERS).
C
C=======================================================================
      INCLUDE 'implicit.h'
      DIMENSION EGROUP(*),SAND(766),
     1 SANDA(45),SANDB(45),SANDC(45),SANDD(45),SANDE(45),SANDF(45),
     2 SANDG(45),SANDH(45),SANDI(45),SANDJ(45),SANDK(45),SANDL(45),
     3 SANDM(45),SANDN(45),SANDO(36),SANDP(20),SANDQ(40),SANDR(30),
     4 SANDS(10)
c
      EQUIVALENCE (SAND(  1),SANDA(1)),    ! 45
     1            (SAND( 46),SANDB(1)),    ! 45
     1            (SAND( 91),SANDC(1)),    ! 45
     1            (SAND(136),SANDD(1)),    ! 45
     1            (SAND(181),SANDE(1)),    ! 45
     1            (SAND(226),SANDF(1)),    ! 45
     1            (SAND(271),SANDG(1)),    ! 45
     1            (SAND(316),SANDH(1)),    ! 45
     1            (SAND(361),SANDI(1)),    ! 45
     1            (SAND(406),SANDJ(1)),    ! 45
     1            (SAND(451),SANDK(1)),    ! 45
     1            (SAND(496),SANDL(1)),    ! 45
     1            (SAND(541),SANDM(1)),    ! 45
     1            (SAND(586),SANDN(1)),    ! 45
     1            (SAND(631),SANDO(1)),    ! 36
     1            (SAND(667),SANDP(1)),    ! 20
     1            (SAND(687),SANDQ(1)),    ! 40
     1            (SAND(727),SANDR(1)),    ! 30
     1            (SAND(757),SANDS(1))     ! 10
c                       766
c-----------------------------------------------------------------------
C
C     DEFINE SAND-II 45 GROUP EXTENSION DOWN TO 10D-5 EV
C
c-----------------------------------------------------------------------
      DATA SANDA/
     1 1.0000D-05, 1.0500D-05, 1.1000D-05, 1.1500D-05, 1.2000D-05,
     2 1.2750D-05, 1.3500D-05, 1.4250D-05, 1.5000D-05, 1.6000D-05,
     3 1.7000D-05, 1.8000D-05, 1.9000D-05, 2.0000D-05, 2.1000D-05,
     4 2.2000D-05, 2.3000D-05, 2.4000D-05, 2.5500D-05, 2.7000D-05,
     5 2.8000D-05, 3.0000D-05, 3.2000D-05, 3.4000D-05, 3.6000D-05,
     6 3.8000D-05, 4.0000D-05, 4.2500D-05, 4.5000D-05, 4.7500D-05,
     7 5.0000D-05, 5.2500D-05, 5.5000D-05, 5.7500D-05, 6.0000D-05,
     8 6.3000D-05, 6.6000D-05, 6.9000D-05, 7.2000D-05, 7.6000D-05,
     9 8.0000D-05, 8.4000D-05, 8.8000D-05, 9.2000D-05, 9.6000D-05/
c-----------------------------------------------------------------------
C
C     DEFINE SAND-II 620 (665) AND 620 (685) GROUP STRUCTURES.
C
c-----------------------------------------------------------------------
      DATA SANDB/
     1 1.0000D-04, 1.0500D-04, 1.1000D-04, 1.1500D-04, 1.2000D-04,
     2 1.2750D-04, 1.3500D-04, 1.4250D-04, 1.5000D-04, 1.6000D-04,
     3 1.7000D-04, 1.8000D-04, 1.9000D-04, 2.0000D-04, 2.1000D-04,
     4 2.2000D-04, 2.3000D-04, 2.4000D-04, 2.5500D-04, 2.7000D-04,
     5 2.8000D-04, 3.0000D-04, 3.2000D-04, 3.4000D-04, 3.6000D-04,
     6 3.8000D-04, 4.0000D-04, 4.2500D-04, 4.5000D-04, 4.7500D-04,
     7 5.0000D-04, 5.2500D-04, 5.5000D-04, 5.7500D-04, 6.0000D-04,
     8 6.3000D-04, 6.6000D-04, 6.9000D-04, 7.2000D-04, 7.6000D-04,
     9 8.0000D-04, 8.4000D-04, 8.8000D-04, 9.2000D-04, 9.6000D-04/
      DATA SANDC/
     1 1.0000D-03, 1.0500D-03, 1.1000D-03, 1.1500D-03, 1.2000D-03,
     2 1.2750D-03, 1.3500D-03, 1.4250D-03, 1.5000D-03, 1.6000D-03,
     3 1.7000D-03, 1.8000D-03, 1.9000D-03, 2.0000D-03, 2.1000D-03,
     4 2.2000D-03, 2.3000D-03, 2.4000D-03, 2.5500D-03, 2.7000D-03,
     5 2.8000D-03, 3.0000D-03, 3.2000D-03, 3.4000D-03, 3.6000D-03,
     6 3.8000D-03, 4.0000D-03, 4.2500D-03, 4.5000D-03, 4.7500D-03,
     7 5.0000D-03, 5.2500D-03, 5.5000D-03, 5.7500D-03, 6.0000D-03,
     8 6.3000D-03, 6.6000D-03, 6.9000D-03, 7.2000D-03, 7.6000D-03,
     9 8.0000D-03, 8.4000D-03, 8.8000D-03, 9.2000D-03, 9.6000D-03/
      DATA SANDD/
     1 1.0000D-02, 1.0500D-02, 1.1000D-02, 1.1500D-02, 1.2000D-02,
     2 1.2750D-02, 1.3500D-02, 1.4250D-02, 1.5000D-02, 1.6000D-02,
     3 1.7000D-02, 1.8000D-02, 1.9000D-02, 2.0000D-02, 2.1000D-02,
     4 2.2000D-02, 2.3000D-02, 2.4000D-02, 2.5500D-02, 2.7000D-02,
     5 2.8000D-02, 3.0000D-02, 3.2000D-02, 3.4000D-02, 3.6000D-02,
     6 3.8000D-02, 4.0000D-02, 4.2500D-02, 4.5000D-02, 4.7500D-02,
     7 5.0000D-02, 5.2500D-02, 5.5000D-02, 5.7500D-02, 6.0000D-02,
     8 6.3000D-02, 6.6000D-02, 6.9000D-02, 7.2000D-02, 7.6000D-02,
     9 8.0000D-02, 8.4000D-02, 8.8000D-02, 9.2000D-02, 9.6000D-02/
      DATA SANDE/
     1 1.0000D-01, 1.0500D-01, 1.1000D-01, 1.1500D-01, 1.2000D-01,
     2 1.2750D-01, 1.3500D-01, 1.4250D-01, 1.5000D-01, 1.6000D-01,
     3 1.7000D-01, 1.8000D-01, 1.9000D-01, 2.0000D-01, 2.1000D-01,
     4 2.2000D-01, 2.3000D-01, 2.4000D-01, 2.5500D-01, 2.7000D-01,
     5 2.8000D-01, 3.0000D-01, 3.2000D-01, 3.4000D-01, 3.6000D-01,
     6 3.8000D-01, 4.0000D-01, 4.2500D-01, 4.5000D-01, 4.7500D-01,
     7 5.0000D-01, 5.2500D-01, 5.5000D-01, 5.7500D-01, 6.0000D-01,
     8 6.3000D-01, 6.6000D-01, 6.9000D-01, 7.2000D-01, 7.6000D-01,
     9 8.0000D-01, 8.4000D-01, 8.8000D-01, 9.2000D-01, 9.6000D-01/
      DATA SANDF/
     1 1.0000D+00, 1.0500D+00, 1.1000D+00, 1.1500D+00, 1.2000D+00,
     2 1.2750D+00, 1.3500D+00, 1.4250D+00, 1.5000D+00, 1.6000D+00,
     3 1.7000D+00, 1.8000D+00, 1.9000D+00, 2.0000D+00, 2.1000D+00,
     4 2.2000D+00, 2.3000D+00, 2.4000D+00, 2.5500D+00, 2.7000D+00,
     5 2.8000D+00, 3.0000D+00, 3.2000D+00, 3.4000D+00, 3.6000D+00,
     6 3.8000D+00, 4.0000D+00, 4.2500D+00, 4.5000D+00, 4.7500D+00,
     7 5.0000D+00, 5.2500D+00, 5.5000D+00, 5.7500D+00, 6.0000D+00,
     8 6.3000D+00, 6.6000D+00, 6.9000D+00, 7.2000D+00, 7.6000D+00,
     9 8.0000D+00, 8.4000D+00, 8.8000D+00, 9.2000D+00, 9.6000D+00/
      DATA SANDG/
     1 1.0000D+01, 1.0500D+01, 1.1000D+01, 1.1500D+01, 1.2000D+01,
     2 1.2750D+01, 1.3500D+01, 1.4250D+01, 1.5000D+01, 1.6000D+01,
     3 1.7000D+01, 1.8000D+01, 1.9000D+01, 2.0000D+01, 2.1000D+01,
     4 2.2000D+01, 2.3000D+01, 2.4000D+01, 2.5500D+01, 2.7000D+01,
     5 2.8000D+01, 3.0000D+01, 3.2000D+01, 3.4000D+01, 3.6000D+01,
     6 3.8000D+01, 4.0000D+01, 4.2500D+01, 4.5000D+01, 4.7500D+01,
     7 5.0000D+01, 5.2500D+01, 5.5000D+01, 5.7500D+01, 6.0000D+01,
     8 6.3000D+01, 6.6000D+01, 6.9000D+01, 7.2000D+01, 7.6000D+01,
     9 8.0000D+01, 8.4000D+01, 8.8000D+01, 9.2000D+01, 9.6000D+01/
      DATA SANDH/
     1 1.0000D+02, 1.0500D+02, 1.1000D+02, 1.1500D+02, 1.2000D+02,
     2 1.2750D+02, 1.3500D+02, 1.4250D+02, 1.5000D+02, 1.6000D+02,
     3 1.7000D+02, 1.8000D+02, 1.9000D+02, 2.0000D+02, 2.1000D+02,
     4 2.2000D+02, 2.3000D+02, 2.4000D+02, 2.5500D+02, 2.7000D+02,
     5 2.8000D+02, 3.0000D+02, 3.2000D+02, 3.4000D+02, 3.6000D+02,
     6 3.8000D+02, 4.0000D+02, 4.2500D+02, 4.5000D+02, 4.7500D+02,
     7 5.0000D+02, 5.2500D+02, 5.5000D+02, 5.7500D+02, 6.0000D+02,
     8 6.3000D+02, 6.6000D+02, 6.9000D+02, 7.2000D+02, 7.6000D+02,
     9 8.0000D+02, 8.4000D+02, 8.8000D+02, 9.2000D+02, 9.6000D+02/
      DATA SANDI/
     1 1.0000D+03, 1.0500D+03, 1.1000D+03, 1.1500D+03, 1.2000D+03,
     2 1.2750D+03, 1.3500D+03, 1.4250D+03, 1.5000D+03, 1.6000D+03,
     3 1.7000D+03, 1.8000D+03, 1.9000D+03, 2.0000D+03, 2.1000D+03,
     4 2.2000D+03, 2.3000D+03, 2.4000D+03, 2.5500D+03, 2.7000D+03,
     5 2.8000D+03, 3.0000D+03, 3.2000D+03, 3.4000D+03, 3.6000D+03,
     6 3.8000D+03, 4.0000D+03, 4.2500D+03, 4.5000D+03, 4.7500D+03,
     7 5.0000D+03, 5.2500D+03, 5.5000D+03, 5.7500D+03, 6.0000D+03,
     8 6.3000D+03, 6.6000D+03, 6.9000D+03, 7.2000D+03, 7.6000D+03,
     9 8.0000D+03, 8.4000D+03, 8.8000D+03, 9.2000D+03, 9.6000D+03/
      DATA SANDJ/
     1 1.0000D+04, 1.0500D+04, 1.1000D+04, 1.1500D+04, 1.2000D+04,
     2 1.2750D+04, 1.3500D+04, 1.4250D+04, 1.5000D+04, 1.6000D+04,
     3 1.7000D+04, 1.8000D+04, 1.9000D+04, 2.0000D+04, 2.1000D+04,
     4 2.2000D+04, 2.3000D+04, 2.4000D+04, 2.5500D+04, 2.7000D+04,
     5 2.8000D+04, 3.0000D+04, 3.2000D+04, 3.4000D+04, 3.6000D+04,
     6 3.8000D+04, 4.0000D+04, 4.2500D+04, 4.5000D+04, 4.7500D+04,
     7 5.0000D+04, 5.2500D+04, 5.5000D+04, 5.7500D+04, 6.0000D+04,
     8 6.3000D+04, 6.6000D+04, 6.9000D+04, 7.2000D+04, 7.6000D+04,
     9 8.0000D+04, 8.4000D+04, 8.8000D+04, 9.2000D+04, 9.6000D+04/
      DATA SANDK/
     1 1.0000D+05, 1.0500D+05, 1.1000D+05, 1.1500D+05, 1.2000D+05,
     2 1.2750D+05, 1.3500D+05, 1.4250D+05, 1.5000D+05, 1.6000D+05,
     3 1.7000D+05, 1.8000D+05, 1.9000D+05, 2.0000D+05, 2.1000D+05,
     4 2.2000D+05, 2.3000D+05, 2.4000D+05, 2.5500D+05, 2.7000D+05,
     5 2.8000D+05, 3.0000D+05, 3.2000D+05, 3.4000D+05, 3.6000D+05,
     6 3.8000D+05, 4.0000D+05, 4.2500D+05, 4.5000D+05, 4.7500D+05,
     7 5.0000D+05, 5.2500D+05, 5.5000D+05, 5.7500D+05, 6.0000D+05,
     8 6.3000D+05, 6.6000D+05, 6.9000D+05, 7.2000D+05, 7.6000D+05,
     9 8.0000D+05, 8.4000D+05, 8.8000D+05, 9.2000D+05, 9.6000D+05/
      DATA SANDL/
     1 1.0000D+06, 1.1000D+06, 1.2000D+06, 1.3000D+06, 1.4000D+06,
     2 1.5000D+06, 1.6000D+06, 1.7000D+06, 1.8000D+06, 1.9000D+06,
     3 2.0000D+06, 2.1000D+06, 2.2000D+06, 2.3000D+06, 2.4000D+06,
     4 2.5000D+06, 2.6000D+06, 2.7000D+06, 2.8000D+06, 2.9000D+06,
     5 3.0000D+06, 3.1000D+06, 3.2000D+06, 3.3000D+06, 3.4000D+06,
     6 3.5000D+06, 3.6000D+06, 3.7000D+06, 3.8000D+06, 3.9000D+06,
     7 4.0000D+06, 4.1000D+06, 4.2000D+06, 4.3000D+06, 4.4000D+06,
     8 4.5000D+06, 4.6000D+06, 4.7000D+06, 4.8000D+06, 4.9000D+06,
     9 5.0000D+06, 5.1000D+06, 5.2000D+06, 5.3000D+06, 5.4000D+06/
      DATA SANDM/
     1 5.5000D+06, 5.6000D+06, 5.7000D+06, 5.8000D+06, 5.9000D+06,
     2 6.0000D+06, 6.1000D+06, 6.2000D+06, 6.3000D+06, 6.4000D+06,
     3 6.5000D+06, 6.6000D+06, 6.7000D+06, 6.8000D+06, 6.9000D+06,
     4 7.0000D+06, 7.1000D+06, 7.2000D+06, 7.3000D+06, 7.4000D+06,
     5 7.5000D+06, 7.6000D+06, 7.7000D+06, 7.8000D+06, 7.9000D+06,
     6 8.0000D+06, 8.1000D+06, 8.2000D+06, 8.3000D+06, 8.4000D+06,
     7 8.5000D+06, 8.6000D+06, 8.7000D+06, 8.8000D+06, 8.9000D+06,
     8 9.0000D+06, 9.1000D+06, 9.2000D+06, 9.3000D+06, 9.4000D+06,
     9 9.5000D+06, 9.6000D+06, 9.7000D+06, 9.8000D+06, 9.9000D+06/
      DATA SANDN/
     1 1.0000D+07, 1.0100D+07, 1.0200D+07, 1.0300D+07, 1.0400D+07,
     2 1.0500D+07, 1.0600D+07, 1.0700D+07, 1.0800D+07, 1.0900D+07,
     3 1.1000D+07, 1.1100D+07, 1.1200D+07, 1.1300D+07, 1.1400D+07,
     4 1.1500D+07, 1.1600D+07, 1.1700D+07, 1.1800D+07, 1.1900D+07,
     5 1.2000D+07, 1.2100D+07, 1.2200D+07, 1.2300D+07, 1.2400D+07,
     6 1.2500D+07, 1.2600D+07, 1.2700D+07, 1.2800D+07, 1.2900D+07,
     7 1.3000D+07, 1.3100D+07, 1.3200D+07, 1.3300D+07, 1.3400D+07,
     8 1.3500D+07, 1.3600D+07, 1.3700D+07, 1.3800D+07, 1.3900D+07,
     9 1.4000D+07, 1.4100D+07, 1.4200D+07, 1.4300D+07, 1.4400D+07/
      DATA SANDO/
     1 1.4500D+07, 1.4600D+07, 1.4700D+07, 1.4800D+07, 1.4900D+07,
     2 1.5000D+07, 1.5100D+07, 1.5200D+07, 1.5300D+07, 1.5400D+07,
     3 1.5500D+07, 1.5600D+07, 1.5700D+07, 1.5800D+07, 1.5900D+07,
     4 1.6000D+07, 1.6100D+07, 1.6200D+07, 1.6300D+07, 1.6400D+07,
     5 1.6500D+07, 1.6600D+07, 1.6700D+07, 1.6800D+07, 1.6900D+07,
     6 1.7000D+07, 1.7100D+07, 1.7200D+07, 1.7300D+07, 1.7400D+07,
     7 1.7500D+07, 1.7600D+07, 1.7700D+07, 1.7800D+07, 1.7900D+07,
     8 1.8000D+07/
C------DEFINE EXTENSION OF SAND-II STRUCTURE FROM 18 TO 20 MEV USING
C------20 ADDITIONAL GROUPS EACH 0.1 MEV WIDTH.
      DATA SANDP/
     1 1.8100D+07, 1.8200D+07, 1.8300D+07, 1.8400D+07, 1.8500D+07,
     1 1.8600D+07, 1.8700D+07, 1.8800D+07, 1.8900D+07, 1.9000D+07,
     1 1.9100D+07, 1.9200D+07, 1.9300D+07, 1.9400D+07, 1.9500D+07,
     1 1.9600D+07, 1.9700D+07, 1.9800D+07, 1.9900D+07, 2.0000D+07/
C------DEFINE EXTENSION OF SAND-II STRUCTURE FROM 20 TO 60 MEV USING
C------20 ADDITIONAL GROUPS EACH 0.5 MEV WIDTH.
C------10 ADDITIONAL GROUPS EACH 1.0 MEV WIDTH.
C------10 ADDITIONAL GROUPS EACH 2.0 MEV WIDTH.
      DATA SANDQ/
     1 20.500D+06, 21.000D+06, 21.500D+06, 22.000D+06, 22.500D+06,
     1 23.000D+06, 23.500D+06, 24.000D+06, 24.500D+06, 25.000D+06,
     1 25.500D+06, 26.000D+06, 26.500D+06, 27.000D+06, 27.500D+06,
     1 28.000D+06, 28.500D+06, 29.000D+06, 29.500D+06, 30.000D+06,
     1 31.000D+06, 32.000D+06, 33.000D+06, 34.000D+06, 35.000D+06,
     1 36.000D+06, 37.000D+06, 38.000D+06, 39.000D+06, 40.000D+06,
     1 42.000D+06, 44.000D+06, 46.000D+06, 48.000D+06, 50.000D+06,
     1 52.000D+06, 54.000D+06, 56.000D+06, 58.000D+06, 60.000D+06/
C------DEFINE EXTENSION OF SAND-II STRUCTURE FROM 60 TO 150 MEV USING
C------20 ADDITIONAL GROUPS EACH 2.0 MEV WIDTH.
C------10 ADDITIONAL GROUPS EACH 5.0 MEV WIDTH.
      DATA SANDR/
     1 62.000D+06, 64.000D+06, 66.000D+06, 68.000D+06, 70.000D+06,
     1 72.000D+06, 74.000D+06, 76.000D+06, 78.000D+06, 80.000D+06,
     1 82.000D+06, 84.000D+06, 86.000D+06, 88.000D+06, 90.000D+06,
     1 92.000D+06, 94.000D+06, 96.000D+06, 98.000D+06,100.000D+06,
     1105.000D+06,110.000D+06,115.000D+06,120.000D+06,125.000D+06,
     1130.000D+06,135.000D+06,140.000D+06,145.000D+06,150.000D+06/
C------DEFINE EXTENSION OF SAND-II STRUCTURE FROM 150 TO 200 MEV USING
C------10 ADDITIONAL GROUPS EACH 5.0 MEV WIDTH.
      DATA SANDS/
     1 155.000D+06,160.000D+06,165.000D+06,170.000D+06,175.000D+06,
     1 180.000D+06,185.000D+06,190.000D+06,195.000D+06,200.000D+06/
c-----------------------------------------------------------------------
C
C     USE ALL GROUPS BETWEEN EGRPMIN AND EGRPMAX.
C
c-----------------------------------------------------------------------
      ig = 0
      do i=1,766
      if(SAND(i).ge.EGRPMIN.and.SAND(i).le.EGRPMAX) then
      ig = ig + 1
      EGROUP(ig) = SAND(i)
      endif
      enddo
      NGROUP = ig - 1 ! # of groups is one less than # group boundaries
      return
      END
      SUBROUTINE UKAEAGEN(EGROUP,NGROUP,EGRPMAX)
C===============================================================
C
C     DEFINE UKAEA GROUP STRUCTURE FROM 1.0D-5 EV TO
C     ANY UPPER LIMIT ABOVE 30 MEV DEFINED BY EGRPMAX INPUT.
C
C     WARNING - As used by GROUPIE   EGRPMAX = 1 GeV.
C               There is no test for EGRPMAX > 30 MeV (Caveat Emptor).
C
C===============================================================
      INCLUDE 'implicit.h'
      DIMENSION EGROUP(*)
      DATA TEN/  10.0D+00/
      DATA FIFTY/50.0D+00/
      DATA EGRPMIN1/1.0D-05/
      DATA EGRPMIN2/5.5D-01/
      DATA EGRPMIN3/1.0D+01/
      DATA EGRPMIN4/5.0D+06/
      DATA E10MEV  /1.0D+07/
      DATA E30MEV  /3.0D+07/
c-----------------------------------------------------------------------
C
C     GROUPS SPLIT INTO EQUAL E (energy) AND U (lethargy) SECTIONS
C      237 EQUAL U FROM 1.0E-05 TO 5.5D-01
C      378 EQUAL E FROM 5.5D-01 TO 1.0D+01
C      285 EQUAL U FROM 1.0D+01 TO 5.0D+06
C      126 EQUAL E FROM 5.0D+06 TO ~3.02D+07
C       76 EQUAL U FROM ~3.02D+07 TO 1.0D+09
C     1102 TOTAL GROUPS
C
c-----------------------------------------------------------------------
C-----CUMULATIVE GROUPS USED IN BUILD BELOW
      NGROUP1= 237
      NGROUP2= 615
      NGROUP3= 900
      NGROUP4=1026
      NGROUP5=1102
      NGROUP= 1102
C-----50 GROUPS PER ENERGY DECADE (Same as TART Group Structure).
      DEU=DEXP(DLOG(TEN)/FIFTY)
C-----------------------------------------------------------------------
C
C     DEFINE GROUPS SEQUENTIALLY OVER 5 LOOPS
C     OPTION TO EXIT AT OTHER MAXIMUM ENERGY ABOVE 30 MEV
C
C-----------------------------------------------------------------------
c
c     10E-5 eV to 0.55 eV: 50 Groups per energy decade (same as TART)
c
c-----------------------------------------------------------------------
      ENOW=EGRPMIN1
      DO I=1,NGROUP1
      EGROUP(I)=ENOW
      ENOW=ENOW*DEU
      ENDDO
c-----------------------------------------------------------------------
c
c     0.55 eV to 10 eV: 0.025 eV spacing.
c
c-----------------------------------------------------------------------
      ENOW=EGRPMIN2
      DO I=NGROUP1+1,NGROUP2
      EGROUP(I)=ENOW
      ENOW=ENOW+2.5D-02
      ENDDO
c-----------------------------------------------------------------------
c
c     10 eV to 5 MeV: 50 Groups per energy decade (same as TART)
c
c-----------------------------------------------------------------------
      ENOW=EGRPMIN3
      DO I=NGROUP2+1,NGROUP3
      EGROUP(I)=ENOW
      ENOW=ENOW*DEU
      ENDDO
c-----------------------------------------------------------------------
c
c     5 MeV to 30 MeV: 200 keV spacing.
c
c-----------------------------------------------------------------------
      ENOW=EGRPMIN4
      DO I=NGROUP3+1,NGROUP4
      EGROUP(I)=ENOW
      ENOW=ENOW+2.0D+05
      ENDDO
c-----------------------------------------------------------------------
c
c     30 MeV to 1 GeV: 50 Groups per energy decade (same as TART)
c
c-----------------------------------------------------------------------
c-----First TART group boundary over 30 MeV
      EGRPMIN5 = E10MEV
   10 EGRPMIN5 = EGRPMIN5*DEU
      if(EGRPMIN5.le.E30MEV) go to 10
      ENOW=EGRPMIN5
      DO I=NGROUP4+1,NGROUP5+1
      EGROUP(I)=ENOW
      IF(EGROUP(I).gt.EGRPMAX) go to 20
      IF(EGROUP(I).eq.EGRPMAX) go to 30
      ENOW=ENOW*DEU
      ENDDO
      I = NGROUP5+1
C-----DEFINE END OF GROUPS AT MAXIMUM ENDL ENERGY
   20 EGROUP(I)=EGRPMAX
   30 NGROUP=I-1
      RETURN
      END
      SUBROUTINE BANLST
C=======================================================================
C
C     LIST MULTI-BAND PARAMETERS FOR NEXT MATERIAL.
C
C=======================================================================
      INCLUDE 'implicit.h'
      INTEGER*4 OTAPE2
      CHARACTER*1 ZABCD,FIELDX,STAR,ban1
      CHARACTER*24 ban1file
      CHARACTER*4 TUNITS,TMPHOL
      CHARACTER*72 LIBID
      COMMON/UNITS/OTAPE2,NTAPE,LIST1,LIST2,LIST3,IPLOT
      COMMON/TRASH/ERROK,ER10PC,MGROUP,METHODB,NBAND,NBMAX,
     1 NBNEED,MYSIGMA0
      COMMON/WHATZA/ATWT,IZA,MATNOW,MFNOW
      COMMON/TEMPO/TMPTAB(3),TEMP1,NTEMP
      COMMON/REALLY/XE,XA(5),YA(5),YB(5),YC(5),NPTAB(5),IPTAB(5),NSECT
      COMMON/GROUPC/LIBID
      COMMON/ELPAS2/EGB,TMPK
      COMMON/ELPASZ/ZABCD(12)
      COMMON/FIELDC/FIELDX(11,22)
      COMMON/ELPASD/TUNITS(2,4),TMPHOL(3)
      INCLUDE 'groupie.h'
      dimension ban1(24)
      equivalence (ban1file,ban1(1))
      DATA STAR/'*'/
      DATA ZERO/0.0d0/
      data ban1file/'ZA000000.MULTBAND.LST   '/
c                      zzzaaa
c                    123456789012345678901234
c-----------------------------------------------------------------------
c
c     Define MULTBAND.LST Filename = ZAzzzaaa.MULTBAND.LST
c
c-----------------------------------------------------------------------
      call ZANAME(IZA,ban1(1))
      OPEN(LIST2,FILE=ban1file,STATUS='UNKNOWN')
C-----------------------------------------------------------------------
c
C     START LIST OF MULTI-BAND PARAMETERS.
c
C-----------------------------------------------------------------------
C-----CONVERT KELVIN TEMPERATURE TO OUTPUT FORM.
      CALL OUT9G(TMPK,FIELDX(1,4))
      IF(NSECT.LT.5) GO TO 10
      WRITE(LIST2,210) MATNOW,(FIELDX(M,4),M=1,11),TMPHOL(2),
     1 TMPHOL(3),ZABCD,
     2 (REACT2(1,I),REACT2(2,I),I=2,5)
     3,(REACT2(1,I),REACT2(2,I),I=2,6)
      GO TO 20
   10 WRITE(LIST2,220) MATNOW,(FIELDX(M,4),M=1,11),TMPHOL(2),
     1 TMPHOL(3),ZABCD,
     2 (REACT2(1,I),REACT2(2,I),I=2,4),
     3 (REACT2(1,I),REACT2(2,I),I=2,4),REACT2(1,6),REACT2(2,6)
C-----------------------------------------------------------------------
C
C     LIST MULTI-BAND PARAMETERS.
C
C-----------------------------------------------------------------------
   20 DO 180 IGR=1,NGR
c-----Define Lower Energy limit of group
      CALL OUT9G(EGROUP(IGR),FIELDX(1,1))
      LINOUT=1
      DO 30 NB=2,NBAND
      IF(WTBAND(NB,IGR).GT.ZERO) LINOUT=LINOUT+1
   30 CONTINUE
C-----CONVERT BAND CROSS SECTIONS TO HOLLERITH. CONVERT UNUSED TO BLANK.
      DO 170 NB=1,LINOUT
      DO 60 MSECT=2,5
      IF(MSECT.GT.NSECT) GO TO 40
      CALL OUT9G(XCBAND(MSECT,NB,IGR),FIELDX(1,MSECT))
      GO TO 60
C-----UNUSED =  BLANK
   40 DO 50 M=1,11
      FIELDX(M,MSECT)=' '
   50 CONTINUE
   60 CONTINUE
      IF(NB.GT.1) GO TO 150
C-----CONVERT UNSHIELDED AVERAGES TO HOLLERITH.
      DO 90 MSECT=2,5
      ISP4=MSECT+4
      IF(MSECT.GT.NSECT) GO TO 70
c-----2019/6/8 - Use XCALL, not XCINT
      CALL OUT9G(XCALL(1,MSECT,IGR),FIELDX(1,ISP4))
      GO TO 90
C-----UNUSED = BLANK
   70 DO 80 M=1,11
      FIELDX(M,ISP4)=' '
   80 CONTINUE
   90 CONTINUE
C-----LIST REMAINDER WITH FIRST BAND IF REMAINDER IS AT LEAST
C-----0.05 PER-CENT OF THE UNSHIELDED TOTAL CROSS SECTION.
c-----2019/6/8 - Use XCALL, not XCINT
      REMAIN=XCALL(1,2,IGR)
      DO 100 MSECT=3,NSECT
c-----2019/6/8 - Use XCALL, not XCINT
      REMAIN=REMAIN-XCALL(1,MSECT,IGR)
  100 CONTINUE
      IF(REMAIN.LT.0.0005d0*XCALL(1,2,IGR)) GO TO 110
      CALL OUT9G(REMAIN,FIELDX(1,10))
      GO TO 130
C-----UNUSED = BLANK
  110 DO 120 M=1,11
      FIELDX(M,10)=' '
  120 CONTINUE
C-----LIST PARAMETERS FOR FIRST BAND AND UNSHIELDED GROUP
C-----AVERAGES.
  130 IF(NSECT.LT.5) GO TO 140
      WRITE(LIST2,230) IGR,(FIELDX(M,1),M=1,11),NB,
     1 WTBAND(NB,IGR),
     2 ((FIELDX(M,I),M=1,11),I=2,10)
      GO TO 170
  140 WRITE(LIST2,250) IGR,(FIELDX(M,1),M=1,11),NB,
     1 WTBAND(NB,IGR),
     2 ((FIELDX(M,I),M=1,11),I=2,4),
     3 ((FIELDX(M,I),M=1,11),I=6,8),
     4 (FIELDX(M,10),M=1,11)
      GO TO 170
C-----LIST PARAMETERS FOR SECOND TO N-TH BANDS.
  150 IF(NSECT.LT.5) GO TO 160
      WRITE(LIST2,240) NB,WTBAND(NB,IGR),
     1 ((FIELDX(M,I),M=1,11),I=2,5),STAR
      GO TO 170
  160 WRITE(LIST2,260) NB,WTBAND(NB,IGR),
     1 ((FIELDX(M,I),M=1,11),I=2,4),STAR
  170 CONTINUE
  180 continue
C-----------------------------------------------------------------------
c
C     FINISH LIST OF MULTI-BAND PARAMETERS.
c
C-----------------------------------------------------------------------
c-----Define Upper Energy limit of last group
      CALL OUT9G(EGROUP(NGRP1),FIELDX(1,1))
      IF(NSECT.LT.5) GO TO 190
      WRITE(LIST2,270) NGRP1,(FIELDX(M,1),M=1,11),STAR
      GO TO 200
  190 WRITE(LIST2,280) NGRP1,(FIELDX(M,1),M=1,11),STAR
  200 CLOSE(LIST2)
      RETURN
  210 FORMAT(' MAT',I5,11X,11A1,1X,
     1 A4,A3,' Multi-Band Parameters',13X,'*',
     2 7X,' Unshielded Group Averages',10X,12A1/74X,'*'/
     1 '  No.   Group-eV Band  Weight',4(3X,2A4),' *',    ! 5 column
     2 5(3X,2A4)/74X,'*')
  220 FORMAT(' MAT',I5,11X,11A1,1X,
     1 A4,A3,' Multi-Band Parameters',13X,'*',
     2 7X,' Unshielded Group Averages',10X,12A1/74X,'*'/
     1 '  No.   Group-eV Band  Weight',3(3X,2A4),' *',
     2 4(3X,2A4)/74X,'*')
c               bands                  averages
  230 FORMAT(I5,11A1,I5,F8.5,44A1,' *',55A1)         ! 5 column
  240 FORMAT(16X,    I5,F8.5,44A1,1X,A1)             ! 4
  250 FORMAT(I5,11A1,I5,F8.5,33A1,' *',44A1)         ! 5 column
  260 FORMAT(16X,    I5,F8.5,33A1,1X,A1)             ! 4
  270 FORMAT(I5,11A1,58X,A1)                         ! 5 column
  280 FORMAT(I5,11A1,47X,A1)                         ! 4
      END
      SUBROUTINE BANOUT
C=======================================================================
C
C     OUTPUT MULTI-BAND PARAMETERS FOR NEXT MATERIAL. PACK TABLE
C     TO OUTPUT ONLY THE NUMBER OF BANDS REQUIRED PER GROUP AND WORDS
C     PER BAND AND THEN OUTPUT.
C
C=======================================================================
      INCLUDE 'implicit.h'
      INTEGER*4 OTAPE2
      CHARACTER*1 ZABCD,FIELDX,ban2
      CHARACTER*24 ban2file
      CHARACTER*72 LIBID
      COMMON/UNITS/OTAPE2,NTAPE,LIST1,LIST2,LIST3,IPLOT
      COMMON/TRASH/ERROK,ER10PC,MGROUP,METHODB,NBAND,NBMAX,
     1 NBNEED,MYSIGMA0
      COMMON/WHATZA/ATWT,IZA,MATNOW,MFNOW
      COMMON/TEMPO/TMPTAB(3),TEMP1,NTEMP
      COMMON/REALLY/XE,XA(5),YA(5),YB(5),YC(5),NPTAB(5),IPTAB(5),NSECT
      COMMON/GROUPC/LIBID
      COMMON/ELPASZ/ZABCD(12)
      COMMON/FIELDC/FIELDX(11,22)
      INCLUDE 'groupie.h'
      dimension ban2(24)
      equivalence (ban2file,ban2(1))
      data ban2file/'ZA000000.MULTBAND.TAB   '/
c                      zzzaaa
c                    123456789012345678901234
c-----------------------------------------------------------------------
c
c     Define MULTBAND.TAB Filename = ZAzzzaaa.MULTBAND.TAB
c
c-----------------------------------------------------------------------
      call ZANAME(IZA,ban2(1))
      OPEN(OTAPE2,FILE=ban2file,STATUS='UNKNOWN')
c-----------------------------------------------------------------------
C
C     OUTPUT MULTIBAND PARAMETERS.
C
C     OUTPUT,
C     1) ZA
C     2) NUMBER OF GROUPS
C     3) NUMBER OF BANDS
C     4) TEMPERATURE (KELVIN)
C     5) ZA I.D. IN HOLLERITH.
C
C     ONLY OUTPUT THE NUMBER OF BANDS NEEDED, BUT ALWAYS
C     AT LEAST 2.
C
c-----------------------------------------------------------------------
      NBOUT=NBNEED
      IF(NBOUT.LT.2) NBOUT=2
      CALL OUT9G(TEMP1,FIELDX(1,1))
      WRITE(OTAPE2,40) IZA,NGR,NBOUT,(FIELDX(M,1),M=1,11),ZABCD
c-----------------------------------------------------------------------
C
C     OUTPUT PARAMETERS FOR EACH GROUP/BAND
C
c-----------------------------------------------------------------------
C-----LOOP OVER GROUPS.
      DO 30 IG=1,NGR
C-----FORMAT LOWER GROUP ENERGY BOUNDARY FOR OUTPUT.
      CALL OUT9G(EGROUP(IG)     ,FIELDX(1,   1))
C-----LOOP OVER BANDS
      DO 20 IB=1,NBOUT
C-----FORMAT GROUP/BAND WEIGHT FOR OUTPUT.
      CALL OUT9G(WTBAND(IB,IG),FIELDX(1,   2))
C-----FORMAT GROUP/BAND CROSS SECTIONS FOR OUTPUT.
      IOUT=2
      DO 10 IS=2,NSECT
      IOUT=IOUT+1
      CALL OUT9G(XCBAND(IS,IB,IG),FIELDX(1,IOUT))
   10 CONTINUE
C-----ENERGY OUTPUT WITH FIRST BAND
      IF(IB.EQ.1) WRITE(OTAPE2,50) ((FIELDX(M,K),M=1,11),K=1,IOUT)
C-----NO ENERGY OUTPUT WITH OTHER BANDS
      IF(IB.NE.1) WRITE(OTAPE2,60) ((FIELDX(M,K),M=1,11),K=2,IOUT)
   20 CONTINUE
   30 CONTINUE
C-----OUTPUT LAST GROUP BOUNDARY.
      CALL OUT9G(EGROUP(NGRP1),FIELDX(1,1))
      WRITE(OTAPE2,50) (FIELDX(M,1),M=1,11)
      CLOSE(OTAPE2)
      RETURN
   40 FORMAT(3I11,11A1,1X,12A1)
   50 FORMAT(11A1,11A1,55A1)
   60 FORMAT(11X ,11A1,55A1)
      END
      SUBROUTINE OVERE(ESPECT,SPECT,N,ELOW,EHIGH)
C=======================================================================
C
C     CONSTRUCT TABLE OF 1/E AS DEFINED BY A TABLE OF N POINTS
C     LOGARITHMICALLY SPACED BETWEEN THE ENERGIES ELOW AND EHIGH.
C     VALUES ARE RETURNED IN ASCENDING ENERGY ORDER.
C
C     THE MAXIMUM PER-CENT DIFFERENCE BETWEEN THE EXACT 1/E SHAPE
C     (MAGNITUDE DOES NOT MATTER) AND THE TABULATED APPROXIMATION
C     (ASSUMING LINEAR VARIATION BETWEEN TABULATED POINTS) DEPENDS
C     ONLY ON THE NUMBER OF POINTS PER ENERGY DECADE. THE MAXIMUM
C     ERROR VERSUS POINTS PER DECADE WILL BE...
C
C     POINTS PER DECADE    MAXIMUM PER-CENT ERROR
C     -----------------    ----------------------
C                 10           0.67
C                 20           0.17
C                 30           0.074
C                 40           0.042
C                 50           0.027
C                 60           0.019
C                 70           0.014
C                 80           0.011
C                 90           0.009
C                100           0.007
C
C     FOR EXAMPLE IN ORDER TO CONSTRUCT A TABULATED LINEARLY
C     INTERPOLABLE APPROXIMATION TO 1/E FROM 1.0D-5 EV UP TO 10 MEV
C     (12 DECADES OF ENERGY) TO WITHIN AN ACCURACY OF 0.1 PER-CENT
C     CAN BE ACCOMPLISHED BY USING 30 POINTS PER DECADE, OR A TOTAL
C     OF 361 POINTS (12 X 30 + 1 AT END OF ENERGY INTERVAL). THIS
C     WOULD YIELD A MAXIMUM ERROR OF 0.074 PER-CENT.
C
C=======================================================================
      INCLUDE 'implicit.h'
      DIMENSION ESPECT(*),SPECT(*)
C-----DEFINE MULTIPLIER TO SPACE N POINTS BETWEEN ELOW AND EHIGH
C-----USING EQUAL LOG (I.E., LETHARGY) SPACING.
      FN=N-1
      DE=DEXP(DLOG(EHIGH/ELOW)/FN)
C-----DEFINE FIRST POINT AT LOWER ENERGY LIMIT.
      ESPECT(1)=ELOW
      SPECT(1)=1.0d0/ELOW
C-----DEFINE REMAINING POINTS AS LOGARITHMICALLY SPACED, I.E. EACH
C-----ENERGY POINT IS A MULTILPE OF THE PRECEEDING ENERGY POINT.
      DO 10 J=2,N
      ESPECT(J)=DE*ESPECT(J-1)
      SPECT(J)=1.0d0/ESPECT(J)
   10 CONTINUE
C-----ELIMINATE ROUNDOFF PROBLEMS BY DEFINING LAST POINT AS EXACTLY
C-----AT UPPER ENERGY LIMIT.
      ESPECT(N)=EHIGH
      SPECT(N)=1.0d0/EHIGH
      RETURN
      END
      SUBROUTINE SPECTM(ESPECT,SPECT,N,ETAB,TEMPM,WA,WB)
C=======================================================================
C
C     CONSTRUCT A TABULATED WEIGHTING SPECTRUM COMPOSED OF,
C     (1) MAXWELLIAN - FROM ETAB(1) TO ETAB(2)
C                      S(E) = E*EXP(-E/TEMPM)/TEMPM
C     (2) 1/E        - FROM ETAB(2) TO ETAB(3)
C                      S(E) = C1/E
C     (3) FISSION    - FROM ETAB(3) TO ETAB(4)
C                      S(E) = C2*EXP(-E/WA)*SINH(SQRT(E*WB))
C     (4) FLAT       - FROM ETAB(4) TO ETAB(5)
C                      S(E) = C3 - HIGH ENERGY FLAT.
C
C     NOTE, THIS IS A FLUX WEIGHTING SPECTRUM - NOT NEUTRON
C     DENSITY. A MAXWELLIAN DEFINES THE NEUTRON DENSITY,
C
C     N(E) = C*SQRT(E)*DEXP(-B*E)*D(E)
C
C     FOR THE CORRECT FLUX WEIGHTING MULTIPLY THIS BY NEUTRON
C     SPEED, WHICH INTRODUCES AN ADDITIONAL FACTOR OF SQRT(E).
C     SO THAT THE CORRECT THERMAL WEIGHTING IS,
C
C     FLUX(E) = C*E*EXP(-B*E)*D(E)
C
C=======================================================================
      INCLUDE 'implicit.h'
      DIMENSION ESPECT(*),SPECT(*),ETAB(5)
C-----DEFINE ALLOWABLE ERROR.
C-----05/24/09 - DECREASED FROM 1.0D-5 TO 1.0D-6
      DATA ERROKS/1.0D-6/
      DATA ONE/1.0D+0/
      DATA HALF/5.0D-1/
C-----INITIALIZE COEFFICIENTS TO MAKE SPECTRUM CONTINUOUS.
      C1=1.0d0
      C2=1.0d0
C-----START WITH A MINIMUM OF 50 POINTS IN EACH PART OF SPECTRUM.
      I=50
      XN=I-1
C-----INITIALIZE NUMBER OF POINTS IN SPECTRUM.
      N=0
c-----------------------------------------------------------------------
C
C     CONSTRUCT MAXWELLIAN.
C
c-----------------------------------------------------------------------
      IF(ETAB(2).LE.ETAB(1)) GO TO 50
      DU=DLOG(ETAB(2)/ETAB(1))/XN
      DE=DEXP(DU)
      ENOW=ETAB(1)
   10 N=N+1
      ESPECT(N)=ENOW
      SPECT(N)=ENOW*DEXP(-ENOW/TEMPM)/TEMPM
      IF(N.EQ.1) GO TO 30
   20 EMID=HALF*(ESPECT(N)+ESPECT(N-1))
      SMID=EMID*DEXP(-EMID/TEMPM)/TEMPM
      STERP=HALF*(SPECT(N)+SPECT(N-1))
      IF(ABS(STERP-SMID).LE.ERROKS*ABS(SMID)) GO TO 30
      ESPECT(N)=EMID
      SPECT(N)=SMID
      GO TO 20
   30 IF(ESPECT(N).GE.ETAB(2)) GO TO 40
      ENOW=ESPECT(N)*DE
      IF(ENOW.GE.ETAB(2)) ENOW=ETAB(2)
      GO TO 10
c-----------------------------------------------------------------------
C
C     CONSTRUCT 1/E
C
c-----------------------------------------------------------------------
   40 C1=ESPECT(N)*SPECT(N)
   50 IF(ETAB(3).LE.ETAB(2)) GO TO 100
      DU=DLOG(ETAB(3)/ETAB(2))/XN
      DE=DEXP(DU)
      ENOW=ESPECT(N)*DE
   60 N=N+1
      ESPECT(N)=ENOW
      SPECT(N)=C1/ENOW
      IF(N.EQ.1) GO TO 80
   70 EMID=HALF*(ESPECT(N)+ESPECT(N-1))
      SMID=C1/EMID
      STERP=HALF*(SPECT(N)+SPECT(N-1))
      IF(ABS(STERP-SMID).LE.ERROKS*ABS(SMID)) GO TO 80
      ESPECT(N)=EMID
      SPECT(N)=SMID
      GO TO 70
   80 IF(ESPECT(N).GE.ETAB(3)) GO TO 90
      ENOW=ESPECT(N)*DE
      IF(ENOW.GE.ETAB(3)) ENOW=ETAB(3)
      GO TO 60
c-----------------------------------------------------------------------
C
C     CONSTRUCT FISSION SPECTRUM.
C
c-----------------------------------------------------------------------
   90 R=DSQRT(ESPECT(N)*WB)
      EXPR=DEXP(R)
      C2=SPECT(N)/(DEXP(-ESPECT(N)/WA)*(EXPR-ONE/EXPR))
  100 IF(ETAB(4).LE.ETAB(3)) GO TO 140
      DU=DLOG(ETAB(4)/ETAB(3))/XN
      DE=DEXP(DU)
      ENOW=ESPECT(N)*DE
  110 N=N+1
      ESPECT(N)=ENOW
      R=DSQRT(ENOW*WB)
      EXPR=DEXP(R)
      SPECT(N)=C2*(DEXP(-ENOW/WA)*(EXPR-ONE/EXPR))
      IF(N.EQ.1) GO TO 130
  120 EMID=HALF*(ESPECT(N)+ESPECT(N-1))
      R=DSQRT(EMID*WB)
      EXPR=DEXP(R)
      SMID=C2*(DEXP(-EMID/WA)*(EXPR-ONE/EXPR))
      STERP=HALF*(SPECT(N)+SPECT(N-1))
      IF(ABS(STERP-SMID).LE.ERROKS*ABS(SMID)) GO TO 130
      ESPECT(N)=EMID
      SPECT(N)=SMID
      GO TO 120
  130 IF(ESPECT(N).GE.ETAB(4)) GO TO 140
      ENOW=ESPECT(N)*DE
      IF(ENOW.GE.ETAB(4)) ENOW=ETAB(4)
      GO TO 110
c-----------------------------------------------------------------------
C
C     CONSTRUCT CONSTANT
C
c-----------------------------------------------------------------------
  140 N=N+1
      ESPECT(N)=ETAB(5)
      SPECT(N)=SPECT(N-1)
      RETURN
      END
      SUBROUTINE READIN
C=======================================================================
C
C     INITIALIZE PARAMETERS AND THEN READ AND CHECK INPUT DATA.
C     INITIALIZE ALL OUTPUT FILES THAT WILL BE USED.
C
C=======================================================================
      INCLUDE 'implicit.h'
      INTEGER*4 OUTP,OTAPE,OTAPE2,OPS
      CHARACTER*1 FIELDX
      CHARACTER*4 MESS1,NO,YES,OPSC
      CHARACTER*16 MYLAW,MYGRUP
      CHARACTER*24 TYPEL
      CHARACTER*36 HWEIGH
      CHARACTER*28 MESSBAND
      CHARACTER*72 LIBID
      CHARACTER*8 SIGHL1,SIGHL2
      CHARACTER*72 NAMEIN,NAMEOUT
      COMMON/ENDFIO/INP,OUTP,ITAPE,OTAPE
      COMMON/UNITS/OTAPE2,NTAPE,LIST1,LIST2,LIST3,IPLOT
      COMMON/IOSTATUS/ISTAT1,ISTAT2
      COMMON/REALLY/XE,XA(5),YA(5),YB(5),YC(5),NPTAB(5),IPTAB(5),NSECT
      COMMON/HEADER/ZA,AWRIN,L1H,L2H,N1H,N2H,MATH,MFH,MTH,NOSEQ
      COMMON/LAWYER/MYLAWO
      COMMON/TEMPO/TMPTAB(3),TEMP1,NTEMP
      COMMON/TEMPC/TINOUT(4)
      COMMON/TRASH/ERROK,ER10PC,MGROUP,METHODB,NBAND,NBMAX,
     1 NBNEED,MYSIGMA0
      COMMON/COMXTEND/MYXTEND
      COMMON/GROUPC/LIBID
      COMMON/MATZA/MODGET,NMATZA,MATMIN(101),MFMIN(101),MTMIN(101),
     1 MATMAX(101),MFMAX(101),MTMAX(101)
      COMMON/GRABER/NOSELF,LSECT
      COMMON/SPIM/IMSP
      COMMON/OPUS/OPS(5)
      COMMON/NAMEX/NAMEIN,NAMEOUT
      COMMON/INPAGE/IXYLOW(5),IXYHI(5),ISCR(5)
      COMMON/FIELDC/FIELDX(11,22)
      COMMON/SIGGIE/SIGHL1(12),SIGHL2(12)
      INCLUDE 'groupie.h'
      DIMENSION MYLAW(3),MYGRUP(21),TYPEL(3),HWEIGH(4),MESSBAND(0:2),
     1 MESS1(2),MYGRUI(21),OPSC(5),ETAB(5)
C-----DEFINE DESCRIPTION FOR ENDF/B FORMATTED OUTPUT INTERPOLATION LAW.
      DATA MYLAW/'                ',
     1           '(Histogram)     ',
     2           '(Linear Linear) '/
      DATA MESSBAND/
     1 '                            ',
     2 'Conserve 1/Total^2          ',
     3 'Conserve 1/[Total+<Total>]  '/
c       1234567890123456789012345678901234567890
C-----DEFINE TWO POSSIBLE SELECTION CRITERIA.
      DATA MESS1/' MAT','  ZA'/
C-----DEFINE TWO STATES FOR EACH OUTPUT DEVICE.
      DATA NO/'  No'/
      DATA YES/' Yes'/
C-----NONE, CROSS SECTION OR RESONANCE INTEGRAL OUTPUT.
      DATA TYPEL/
     1 '                        ',
     1 '(Cross Sections)        ',
     2 '(Resonance Integrals)   '/
C-----DEFINE DESCRIPTION OF BUILT IN GROUP STRUCTURES.
      DATA MYGRUP/
     1 '(From Input)    ','(TART)          ',
     2 '(ORNL)          ','(ORNL)          ',
     3 '(ORNL)          ','(SAND-II)       ',
     4 '(SAND-II EXTEND)','(WIMS)          ',
     5 '(GAM-I)         ','(GAM-II)        ',
     6 '(MUFT)          ','(ABBN)          ',
     7 '(TART)          ','(TART)          ',
     8 '(SAND-II)       ','(SAND-II EXTEND)',
     9 '(TART)          ','(SAND-II 60 MeV)',
     A '(SAND-II 150MeV)','(SAND-II 200MeV)',
     B '(UKAEA    1 GeV)'/
      DATA MYGRUI/
     1    0,175, 50,126,171,620,640, 69, 68, 99,
     2   74, 28,616,700,665,685,666,725,755,765,
     3 1102/
C-----DEFINE DESCRIPTION OF WEIGHTING SPECTRUM.
      DATA HWEIGH/
     1 '(Maxwellian-1/E-Fission-Constant)   ',
     2 '(1/E)                               ',
     3 '(Flat Weighted)                     ',
     4 '(From Input)                        '/
C-----DEFINE MINIMUM ALLOWABLE CONVERGENCE CRITERIA.
      DATA ERRMIN/1.0D-04/
C-----DEFINE STANDARD ALLOWABLE CONVERGENCE CRITERIA.
      DATA ERRUSE/1.0D-03/
C-----INITIALIZE CURRENT ENDF/B MAT, MF AND MT.
      MATH=0
      MFH=0
      MTH=0
C-----INITIALIZE ERROR IN INPUT DATA FLAG OFF.
      KERR=0
C-----DEFINE LIMITS FOR SELECTION OF OUTPUT TEMPERATURE.
      BOLTZM=8.6348D-05
      TMPTAB(1)=0.9999D+00/BOLTZM
      TMPTAB(2)=9.999D+02/BOLTZM
      TMPTAB(3)=9.999D+05/BOLTZM
C-----DEFINE CONVERSION FACTORS FROM KELVIN TO OUTPUT UNITS
C-----(KELVIN, EV, KEV OR MEV).
      TINOUT(1)=1.0D+0
      TINOUT(2)=BOLTZM
      TINOUT(3)=BOLTZM/1.0D+03
      TINOUT(4)=BOLTZM/1.0D+06
C-----INITIALIZE EVALUATION COUNT FOR OUTPUT LISTING.
      LZA=0
      WRITE(OUTP,570)
      WRITE(*   ,570)
c-----------------------------------------------------------------------
C
C     READ ALL INPUT PARAMETERS.
C
c-----------------------------------------------------------------------
      IF(ISTAT1.EQ.1) GO TO 20
c-----2017/5/6 - Changed floating point to character.
      READ(INP,10,END=20,ERR=20)
     1 MODGET,MGROUP,METHODB,MSPECT,(FIELDX(k,1),k=1,11),MYSIGMA0,
     2 MYXTEND
   10 FORMAT(4I11,11A1,I11,I4)
      CALL IN9(ERRIN,FIELDX(1,1))
c-----2017/5/6 - Changed floating point to character.
      GO TO 30
C-----DEFINE DEFAULT VALUES
   20 ISTAT1    = 1
      MODGET    = 0
      MGROUP    =-11        ! TART 616 groups
c-----2019/5/26 - METHODB = 1 no longer allowed
      METHODB   = 2         ! <X> <1/(X+<X>) <1/X>
      MSPECT    = 0
      ERRIN     = 0.0d0     ! 2019/6/23 - no longdr used - only 2 bands
      MYSIGMA0  = 0         ! 2019/6/23 - the ONLY allowed option
      ! if doing multi-band calculations.
      MYXTEND   = 0         ! Extend = 0
C-----02/02/02 - UPDATE TO ALLOW INPUT SIGMA0 VALUES
c-----------------------------------------------------------------------
C
C     IF MYSIGMA0 = -1, READ 21 VALUES OF FIXED SIGMA0
C
c-----------------------------------------------------------------------
   30 IF(MYSIGMA0.GE.0) GO TO 50
c-----Read 21 values; 1 assumed infinity, 23 assumed 0.0
      MYSIGMA0 = 1
c-----2017/5/6 - Changed floating point to character.
      READ(INP,40)    ((FIELDX(j,i),j=1,11),i=2,22)
   40 FORMAT(66A1)
      do i=2,22
      CALL IN9(SHIELD(i),FIELDX(1,i))
      enddo
c-----2017/5/6 - Changed floating point to character.
      WRITE(OUTP,790) (SHIELD(I),I=2,22)
      WRITE(   *,790) (SHIELD(I),I=2,22)
C-----THEY MUST BE IN DESCENDING ORDER
      MYERR = 0
      DO I=2,22
      IF(SHIELD(I).LE.SHIELD(I+1)) THEN
      WRITE(OUTP,800) I,SHIELD(I),SHIELD(I+1)
      WRITE(   *,800) I,SHIELD(I),SHIELD(I+1)
      MYERR = MYERR + 1
      ENDIF
      ENDDO
      IF(MYERR.NE.0) THEN
      WRITE(OUTP,810)
      WRITE(   *,810)
      CALL ENDERROR
      ENDIF
C-----CHANGE TITLES IDENTIFYING SIGMA0 VALUES
      DO I=2,10
      CALL OUT8(SHIELD(2*I),SIGHL2(I))
      ENDDO
c-----------------------------------------------------------------------
C
C     READ FILENAMES - IF BLANK USE STANDARD FILENAMES
C
c-----------------------------------------------------------------------
C-----INPUT DATA.
   50 IF(ISTAT1.EQ.1) GO TO 70
      READ(INP,60,END=70,ERR=70) NAMEIN
   60 FORMAT(A72)
      IF(NAMEIN.EQ.' ') NAMEIN = 'ENDFB.IN'
C-----OUTPUT DATA.
      READ(INP,60,END=80,ERR=80) NAMEOUT
      IF(NAMEOUT.EQ.' ') NAMEOUT = 'ENDFB.OUT'
      GO TO 90
C-----USE DEFAULT FILENAMES
   70 NAMEIN  = 'ENDFB.IN'
   80 NAMEOUT = 'ENDFB.OUT'
      ISTAT1 = 1
C-----PRINT FINAL FILENAMES
   90 WRITE(OUTP,100) NAMEIN,NAMEOUT
      WRITE(*   ,100) NAMEIN,NAMEOUT
  100 FORMAT(
     1 ' ENDF/B Input and Output Data Filenames'/1X,A72/
     2 1X,A72/1X,78('-'))
c-----------------------------------------------------------------------
C
C     READ OUTPUT OPTIONS.
C
c-----------------------------------------------------------------------
      IF(ISTAT1.EQ.1) GO TO 120
c-----2017/5/6 - Changed floating point to character.
      READ(INP,110,END=120,ERR=120) OPS,(FIELDX(j,1),j=1,11)
  110 FORMAT(5I11,11A1)
      CALL IN9(TEMPMIN,FIELDX(1,1))
c-----2017/5/6 - Changed floating point to character.
      GO TO 130
C-----DEFINE DEFAULT VALUES
  120 ISTAT1 = 1
      OPS(1) = 1
      OPS(2) = 1
      OPS(3) = 1
      OPS(4) = 1
      OPS(5) = 1
      TEMPMIN = 0.0d0
  130 IF(ISTAT1.EQ.1) GO TO 150
      READ(INP,140) LIBID
  140 FORMAT(A72)
      GO TO 160
  150 ISTAT1 = 1
      LIBID  = ' '
  160 IF(MODGET.NE.0) MODGET=1
c-----------------------------------------------------------------------
C
C     IN PRODUCTION VERSION ONLY ALLOW 0 OR 2 BANDS
C
c-----------------------------------------------------------------------
C-----ONLY ALLOW 2 BANDS - MTHOD #2 - 1/[sigt + <sigt>]
      IF(METHODB.ne.0) METHODB = 2
C-----IF NOT CROSS SECTIONS OR RESONANCE INTEGRALS SELECTED TURN OFF
      IF(OPS(1).LT.0.OR.OPS(1).GT.2) OPS(1)=0
      IF(OPS(5).LT.0.OR.OPS(5).GT.2) OPS(5)=0
      IMOPS1=OPS(1)+1
      IMOPS5=OPS(5)+1
C-----IF ILLEGAL INTERPOLATION LAW FOR ENDF/B FORMATTED OUTPUT, TURN
C-----OFF ENDF/B FORMATTED OUTPUT.
      IF(IABS(OPS(4)).GT.2) OPS(4)=0
C-----DEFINE MESSAGE TO DESCRIBE ENDF/B FORMATTED INTERPOLATION LAW.
      MYLAWO=OPS(4)
C-----IF MULTI-BAND PARAMETERS NOT CALCULATED OUTPUT IS IMPOSSIBLE.
      IF(METHODB.NE.0) GO TO 170
      OPS(2)=0
      OPS(3)=0
      GO TO 180
C-----IF NO MULTI-BAND OUTPUT DO NOT CALCULATE PARAMETERS.
  170 IF(OPS(2).NE.0.OR.OPS(3).NE.0) GO TO 180
      METHODB=0
  180 NBMAX=METHODB
      IF(NBMAX.EQ.1) NBMAX=2
c-----------------------------------------------------------------------
C
C     DEFINE WEIGHTING SPECTRUM
C
c-----------------------------------------------------------------------
C-----INSURE THAT STANDARD SPECTRUM OPTION IS IN STANDARD FORM.
      IF(MSPECT.GE.0) GO TO 190
C-----DEFINE SPECTRUM TO BE 1/E OR MAXWELLIAN, 1/E, FISSION, Constant
      IF(MSPECT.LT.-2) MSPECT=-2
c-----05/24/09 - increased from 3,000 to 30,000
      IF(MSPECT.EQ.-1) THEN
      IMSP=2        ! 1/E
      MSPTAB=30000
      ELSE
      IMSP=1        ! Maxwellian + 1/E + Fission + Constant
      MSPTAB=16724
      ENDIF
      GO TO 200
C-----DEFINE SPECTRUM TO FLAT WEIGHTED OR READ FROM INPUT.
  190 IF(MSPECT.LE.1) MSPECT=0
      MSPTAB=MSPECT
      IF(MSPTAB.LT.1) MSPTAB=2
      IMSP=3
      IF(MSPECT.GT.0) IMSP=4
c-----------------------------------------------------------------------
C
C     INITIALIZE ERROR TO STANDARD OPTION. ONLY USE INPUT ERROR IF IT
C     IS IN THE LEGAL RANGE (I.E. GREATER THAN 0.0001).
C
c-----------------------------------------------------------------------
  200 ERROK=ERRUSE
      IF(ERRIN.GE.ERRMIN) ERROK=ERRIN
      ER10PC=0.1d0*ERROK
C-----INSURE SIGMA-0 DEFINITION SELECTOR IS STANDARD VALUE.
      IF(MYSIGMA0.LE.0) MYSIGMA0=0
      IF(MYSIGMA0.GT.0) MYSIGMA0=1
C-----CONVERT OUTPUT DEVICE SELECTORS TO HOLLERITH (FOR OUTPUT LISTING)
C-----AND DEFINE ALL UNUSED LOGICAL NUMBERS TO BE ZERO.
      IPICK=0
      DO 270 I=1,5
      IF(IABS(OPS(I)).GT.0) GO TO 260
      OPSC(I)=NO
      GO TO (210,220,230,240,250),I
  210 LIST1=0
C-----INITIALIZE TO NO PLOTTED OUTPUT (SHIELDED/UNSHIELDED)
      IPLOT=0
      GO TO 270
  220 LIST2=0
      GO TO 270
  230 OTAPE2=0
      GO TO 270
  240 OTAPE=0
      GO TO 270
  250 LIST3=0
      GO TO 270
  260 OPSC(I)=YES
      IPICK=1
  270 CONTINUE
C-----OPTIONALLY DEFINE FILENAMES.
      CALL FILIO2
c-----------------------------------------------------------------------
C
C     TERMINATE IF ERROR OPENING ENDF/B DATA FILE
C
c-----------------------------------------------------------------------
      IF(ISTAT2.EQ.1) THEN
      WRITE(OUTP,280) NAMEIN
      WRITE(   *,280) NAMEIN
  280 FORMAT(//' ERROR - Opening ENDF/B data file'/1X,A72//)
      CALL ENDERROR
      ENDIF
c-----------------------------------------------------------------------
C
C     IF NO SELF-SHIELDED OR MULTI-BAND OUTPUT SET FLAG TO BYPASS
C     THESE CALCULATIONS (I.E. ONLY DO UNSHIELDED MULTI-GROUP
C     CALCULATIONS).
C
c-----------------------------------------------------------------------
      IF(OTAPE2.NE.0.OR.LIST1.NE.0.OR.LIST2.NE.0) GO TO 290
C-----NO SELF-SHIELDING CALCULATION. UP TO 20,000 GROUPS ALLOWED.
C-----CHECK FOR LEGAL NUMBER OF GROUPS.
      NOSELF=1
C-----LOAD ALL CROSS SECTIONS INTO SECOND PAGE.
      LSECT=2
      IF(MGROUP.GE.-19.AND.MGROUP.LE.MAXGROUP) GO TO 300
      WRITE(OUTP,730) MGROUP,MAXGROUP
      GO TO 560
C-----SELF-SHIELDING CALCULATION. UP TO 20,000 GROUPS ALLOWED.
C-----CHECK FOR LEGAL NUMBER OF GROUPS.
  290 NOSELF=0
C-----LOAD ALL OTHER (OTHER= NOT TOTAL, ELASTIC, CAPTURE OR FISSION)
C-----CROSS SECTIONS INTO PAGE 4 (THIS PAGE WILL BE LAST ONE USED
C-----WHEN TOTAL, ELASTIC, CAPTURE AND FISSION ARE READ.
      LSECT=4
      IF(MGROUP.GE.-19.AND.MGROUP.LE.MAXGROUP) GO TO 300
      WRITE(OUTP,720) MGROUP,MAXGROUP
      GO TO 560
  300 IMGR=IABS(MGROUP)+2
      IF(MGROUP.GT.0) IMGR=1
      MYGRUI(1)=MGROUP
c-----------------------------------------------------------------------
C
C     LIST INTERPRETATION OF INPUT PARAMETERS.
C
c-----------------------------------------------------------------------
      CALL OUT9G(ERROK,FIELDX(1,1))
      WRITE(OUTP,580) MESS1(MODGET+1),MYGRUI(IMGR),
     1 MYGRUP(IMGR),NBMAX,MESSBAND(METHODB),MSPTAB,HWEIGH(IMSP),
     2 (FIELDX(M,1),M=1,11)
      WRITE(*   ,580) MESS1(MODGET+1),MYGRUI(IMGR),
     1 MYGRUP(IMGR),NBMAX,MESSBAND(METHODB),MSPTAB,HWEIGH(IMSP),
     2 (FIELDX(M,1),M=1,11)
      IF(MYSIGMA0.EQ.0) THEN
      WRITE(OUTP,670)
      WRITE(*   ,670)
      ELSE
      WRITE(OUTP,680)
      WRITE(*   ,680)
      ENDIF
c-----2019/6/23 - Only allow ENDF Standard convention
      IF(MYXTEND.EQ.0) THEN   ! high energy cross section extension.
      WRITE(OUTP,690)
      WRITE(*   ,690)
      ELSE
      MYXTEND = 0      ! Set to standard
      WRITE(OUTP,700)
      WRITE(*   ,700)
      ENDIF
C-----MUST USE MULTIPLES OF UNSHIELDED TOTAL IF CALCULATING
C-----MULTI-BAND PARAMETERS
      IF(MYSIGMA0.NE.0.AND.NBMAX.GT.0) THEN
      WRITE(OUTP,310)
      WRITE(*   ,310)
  310 FORMAT(1X,78('-')/
     1 ' ERROR - Multi-Band Parameters Require that Sigma-0'/
     2 '         be Multiples of the Unshielded Total. You MUST'/
     3 '         Turn off either Multi-bands or Sigma-0 Definition.'/
     3 '         EXECUTION TERMINATED.'/1x,78('='))
      CALL ENDERROR
      ENDIF
      WRITE(OUTP,590) OPSC(1),TYPEL(IMOPS1),
     1 (OPSC(J),J=2,4),MYLAW(MYLAWO+1),
     2 OPSC(5),TYPEL(IMOPS5)
      WRITE(*   ,590) OPSC(1),TYPEL(IMOPS1),
     1 (OPSC(J),J=2,4),MYLAW(MYLAWO+1),
     2 OPSC(5),TYPEL(IMOPS5)
C-----IF USING STANDARD BUILT-IN SPECTRA PRINT MAXWELLIAN TEMPERATURE
      IF(MSPECT.EQ.-2) THEN
      IF(TEMPMIN.GT.1000.0D+0) TEMPMIN = 1000.0D+0
      IF(TEMPMIN.LE.0.0d0) TEMPMIN = 0.0253d0 ! DEFAULT ROOM TEMPERATURE
      WRITE(OUTP,600) TEMPMIN
      WRITE(   *,600) TEMPMIN
      ENDIF
      WRITE(OUTP,610) LIBID
      WRITE(   *,610) LIBID
C-----IF NO OUTPUT DEVICES SELECTED TERMINATE RUN.
      IF(IPICK.NE.0) GO TO 320
      WRITE(OUTP,750)
      GO TO 560
c-----------------------------------------------------------------------
C
C     READ SELECTION RANGES (EITHER MAT OR ZA). IF MAXIMUM IS LESS THAN
C     MINIMUM SET IT EQUAL TO MINIMUM. IF FIRST CARD IS BLANK RETRIEVE
C     ALL DATA.
C
c-----------------------------------------------------------------------
  320 IF(MODGET.EQ.0) WRITE(OUTP,620)
      IF(MODGET.EQ.1) WRITE(OUTP,630)
      IF(MODGET.EQ.0) WRITE(*   ,620)
      IF(MODGET.EQ.1) WRITE(*   ,630)
      IF(ISTAT1.EQ.1) GO TO 340
      READ(INP,330,END=340,ERR=340)
     1 MATMIN(1),MFMIN(1),MTMIN(1),MATMAX(1),MFMAX(1),MTMAX(1)
  330 FORMAT(I6,I2,I3,I6,I2,I3)
      GO TO 350
C-----DEFINE DEFAULT VALUES
  340 ISTAT1    = 1
      MATMIN(1) = 0
      MFMIN(1)  = 0
      MTMIN(1)  = 0
      MATMAX(1) = 0
      MFMAX(1)  = 0
      MTMAX(1)  = 0
  350 IF(MATMIN(1).GT.0.OR.MATMAX(1).GT.0) GO TO 360
      MATMAX(1)=9999
      IF(MFMIN(1).LT.0) MFMIN(1)=0
      IF(MFMAX(1).LE.0) MFMAX(1)=99
      IF(MTMIN(1).LT.0) MTMIN(1)=0
      IF(MTMAX(1).LE.0) MTMAX(1)=999
      MODGET=0
      NMATZA=2
      WRITE(OUTP,650) MATMIN(1),MFMIN(1),MTMIN(1),MATMAX(1),MFMAX(1),
     1 MTMAX(1)
      WRITE(*   ,650) MATMIN(1),MFMIN(1),MTMIN(1),MATMAX(1),MFMAX(1),
     1 MTMAX(1)
      GO TO 390
  360 IF(MATMAX(1).LT.MATMIN(1)) MATMAX(1)=MATMIN(1)
      IF(MFMIN(1).LT.0) MFMIN(1)=0
      IF(MFMAX(1).LE.0) MFMAX(1)=99
      IF(MTMIN(1).LT.0) MTMIN(1)=0
      IF(MTMAX(1).LE.0) MTMAX(1)=999
      WRITE(OUTP,640) MATMIN(1),MFMIN(1),MTMIN(1),MATMAX(1),MFMAX(1),
     1 MTMAX(1)
      WRITE(*   ,640) MATMIN(1),MFMIN(1),MTMIN(1),MATMAX(1),MFMAX(1),
     1 MTMAX(1)
      DO 370 NMATZA=2,101
      IF(ISTAT1.EQ.1) GO TO 390
      READ(INP,330,END=380,ERR=380)
     1 MATMIN(NMATZA),MFMIN(NMATZA),MTMIN(NMATZA),
     2 MATMAX(NMATZA),MFMAX(NMATZA),MTMAX(NMATZA)
      IF(MATMIN(NMATZA).LE.0.AND.MATMAX(NMATZA).LE.0) GO TO 390
      IF(MATMAX(NMATZA).LT.MATMIN(NMATZA)) MATMAX(NMATZA)=MATMIN(NMATZA)
      IF(MFMIN(NMATZA).LT.0) MFMIN(NMATZA)=0
      IF(MFMAX(NMATZA).LE.0) MFMAX(NMATZA)=99
      IF(MTMIN(NMATZA).LT.0) MTMIN(NMATZA)=0
      IF(MTMAX(NMATZA).LE.0) MTMAX(NMATZA)=999
      WRITE(OUTP,640) MATMIN(NMATZA),MFMIN(NMATZA),MTMIN(NMATZA),
     1 MATMAX(NMATZA),MFMAX(NMATZA),MTMAX(NMATZA)
      WRITE(*   ,640) MATMIN(NMATZA),MFMIN(NMATZA),MTMIN(NMATZA),
     1 MATMAX(NMATZA),MFMAX(NMATZA),MTMAX(NMATZA)
  370 CONTINUE
      WRITE(OUTP,660)
      WRITE(*   ,660)
      GO TO 560
  380 ISTAT1 = 1
  390 NMATZA=NMATZA-1
c-----------------------------------------------------------------------
C
C     Check if MF=2 (Unresolved will be IGNORED)
C
c-----------------------------------------------------------------------
      if(NMATZA.gt.0) then
      do im=1,NMATZA
      if(MFMIN(im).le.2.and.MFMAX(im).gt.2) go to 410
      enddo
      write(OUTP,400)
      write(   *,400)
  400 format(1x,78('=')/
     1 ' WARNING - Requested MAT/MF/MT ranges IGNORS MF=2 Resonance',
     2 ' Parameters.'/
     3 '           This prevents Unresolved Resonance Region',
     4 ' Calculation.'/
     5 '           To include Unresolved Resonance Region CHANGE INPUT',
     5 ' Parameters '/
     6 '           and RE-RUN.'/1x,78('='))
      endif
c-----------------------------------------------------------------------
C
C     DEFINE GROUP STRUCTURE.
C
c-----------------------------------------------------------------------
  410 IF(MGROUP.eq.0) go to 420
      IF(MGROUP.gt.0) go to 430
c-----------------------------------------------------------------------
C
C     SELECT BUILT IN GROUP STRUCTURE.
C
C             = 0  175 GROUPS (TART)
C             = 1   50 GROUPS (ORNL)
C             = 2  126 GROUPS (ORNL)
C             = 3  171 GROUPS (ORNL)
C             = 4  620 GROUPS (SAND-II, UP TO 18 MEV)
C             = 5  640 GROUPS (SAND-II, UP TO 20 MEV)
C             = 6   69 GROUPS (WIMS)
C             = 7   68 GROUPS (GAM-I)
C             = 8   99 GROUPS (GAM-II)
C             = 9   54 GROUPS (MUFT)
C             =10   28 GROUPS (ABBN)
C             =11  616 GROUPS (TART TO 20 MEV)
C             =12  700 GROUPS (TART TO 1 GEV)
C             =13  665 GROUPS (SAND-II, 1.0D-5 eV, UP TO 18 MEV)
C             =14  685 GROUPS (SAND-II, 1.0D-5 eV, UP TO 20 MEV)
C             =15  666 GROUPS (TART TO 200 MEV)
C             =16  725 GROUPS (SAND-II, 1.0D-5 eV, UP TO  60 MEV)
C             =17  755 GROUPS (SAND-II, 1.0D-5 eV, UP TO 150 MEV)
C             =18  765 GROUPS (SAND-II, 1.0D-5 eV, UP TO 200 MEV)
C             =19 1102 GROUPS (UKAEA  , 1.0D-5 eV, UP TO   1 GeV)
C
c-----------------------------------------------------------------------
      MGROUP=-MGROUP
  420 CALL GROPE(MGROUP,EGROUP,NGR)
      NGRP1=NGR+1
      NGRP2=NGR+2
      GO TO 460
C-----READ AND PRINT ARBITRARY GROUP STRUCTURE.
  430 NGR=MGROUP
      NGRP1=NGR+1
      NGRP2=NGR+2
c-----2017/5/6 - Changed floating point to character.
      CALL LISTIV(INP,EGROUP,NGRP1)
c-----2017/5/6 - Changed floating point to character.
      WRITE(OUTP,770)
      DO 450 I=1,NGRP1,6
      II=I+5
      IF(II.GT.NGRP1) II=NGRP1
      J=0
      DO 440 III=I,II
      J=J+1
      CALL OUT9G(EGROUP(III),FIELDX(1,J))
  440 CONTINUE
      WRITE(OUTP,780) ((FIELDX(M,JJ),M=1,11),JJ=1,J)
  450 CONTINUE
C-----INSURE GROUP BOUNDARIES ARE IN ASCENDING ENERGY ORDER.
  460 DO 470 I=1,NGR
c-----2020/8/6 - Define average group energy
      EAV(I) = 0.5d0*(EGROUP(I) + EGROUP(I+1))
      IF(EGROUP(I).LT.EGROUP(I+1)) GO TO 470
      KERR=1
      CALL OUT9G(EGROUP(I)  ,FIELDX(1,1))
      CALL OUT9G(EGROUP(I+1),FIELDX(1,2))
      WRITE(OUTP,710) I,((FIELDX(M,KKK),M=1,11),KKK=1,2)
  470 CONTINUE
      IF(KERR.gt.0) go to 560
C-----------------------------------------------------------------------
C
C     DEFINE ENERGY DEPENDENT WEIGHTING SPECTRUM. USE EITHER LINEARLY
C     INTERPOLABLE APPROXIMATION TO 1/E, CONSTANT OR READ ABRITRARY
C     WEIGHTING FUNCTION.
C
C-----------------------------------------------------------------------
      IF(MSPECT.eq.0) go to 490
      IF(MSPECT.gt.0) go to 500
c-----------------------------------------------------------------------
C
C     DEFINE LINEARLY INTERPOLABLE TABULATED SPECTRUM EITHER,
C     (1) 1/E, OR
C     (2) MAXWELLIAN, 1/E, FISSION, CONSTANT SPECTRUM
C
c-----------------------------------------------------------------------
      ELOW=EGROUP(1)
      EHIGH=EGROUP(NGRP1)
c-----------------------------------------------------------------------
C
C     2013/7/7 - Corrected Spectrum range to include ALL parts defined
C                below in OVERE and SPECTM.
C
c-----------------------------------------------------------------------
      IF(ELOW .gt.1.0D-05) ELOW  = 1.0D-05   ! 1.0D-5 eV
      IF(EHIGH.lt.2.0D+07) EHIGH = 2.0D+07   ! 20 MeV
c-----------------------------------------------------------------------
C
C     SELECT 1/E OR MAXWELLIAN, 1/E, FISSION, CONSTANT SPECTRUM.
C
c-----------------------------------------------------------------------
      IF(MSPECT.EQ.-2) GO TO 480
C-----CONSTRUCT LINEARLY INTERPOLABLE APPROXIMATION TO 1/E.
      NPTAB(1)=MSPTAB
      IXYLOW(1)=0
      IXYHI(1)=MSPTAB
      CALL OVERE(XPAGE(1,1),YPAGE(1,1),NPTAB(1),ELOW,EHIGH)
      GO TO 510
c-----------------------------------------------------------------------
C
C     CONSTRUCT LINEARLY INTERPOLABLE APPROXIMATION TO MAXWELLIAN, 1/E
C     FISSION AND CONSTANT SPECTRUM.
C
c-----------------------------------------------------------------------
  480 TEMPM=TEMPMIN
      WA=9.65D+5
      WB=2.29D-6
      ETAB(1)=ELOW
      ETAB(2)=4.0d0*TEMPM
      ETAB(3)=6.7D+04
      ETAB(4)=1.0D+07
      ETAB(5)=EHIGH      ! Note - EHIGH is at least 20 MeV.
c-----2019/8/18 - Added the below test.
      if(ETAB(5).lt.ETAB(4)) ETAB(5) = ETAB(4)
      NPTAB(1)=MSPTAB
      CALL SPECTM(XPAGE(1,1),YPAGE(1,1),NPTAB(1),ETAB,TEMPM,WA,WB)
      IXYLOW(1)=0
      IXYHI(1)=NPTAB(1)
      GO TO 510
c-----------------------------------------------------------------------
C
C     DEFINE CONSTANT WEIGHTING SPECTRUM THAT SPANS THE ENERGY GROUP
C
c-----------------------------------------------------------------------
  490 NPTAB(1)=2
      IXYLOW(1)=0
      IXYHI(1)=2
      YPAGE(1,1)=1.0d0
      YPAGE(2,1)=1.0d0
      XPAGE(1,1)=EGROUP(1)
      XPAGE(2,1)=EGROUP(NGRP1)
      GO TO 510
c-----------------------------------------------------------------------
C
C     LOAD ARBITRARY TABULATED SPECTRUM INTO PAGING SYSTEM.
C
c-----------------------------------------------------------------------
  500 NPTAB(1)=MSPECT
      CALL PAGIN5(INP,1,1)
C-----INSURE SPECTRUM SPANS ENERGY RANGE OF GROUPS.
      CALL XYPAGE(1,1,ELOWD,SHIGH)
      CALL XYPAGE(MSPECT,1,EHIGHD,SHIGH)
      IF(ELOWD.LE.EGROUP(1).AND.EHIGHD.GE.EGROUP(NGRP1)) GO TO 510
      CALL OUT9G(ELOWD        ,FIELDX(1,1))
      CALL OUT9G(EHIGHD       ,FIELDX(1,2))
      CALL OUT9G(EGROUP(1)    ,FIELDX(1,3))
      CALL OUT9G(EGROUP(NGRP1),FIELDX(1,4))
      WRITE(OUTP,740) ((FIELDX(M,I),M=1,11),I=1,4)
      GO TO 560
C-----OPEN EVALUATED DATA FILE AND IF REQUIRED CREATE MULTI-GROUP
C-----DATA FILE (BOTH USE THE ENDF/B FORMAT).
  510 NSECT=4
C-----INITIALIZE MAXIMUM ERROR VECTOR.
      IF(NBMAX.LT.1) GO TO 540
      DO 530 NB=1,MAXBAND
      DO 520 I=1,25
      ERLIB(I,NB)=0.0d0
  520 CONTINUE
  530 CONTINUE
C-----ALL INPUT DATA IS O.K.
  540 RETURN
c-----------------------------------------------------------------------
C
C     ERROR IN INPUT DATA. PRINT MESSAGE AND TERMINATE.
C
c-----------------------------------------------------------------------
  550 CALL ENDERROR
  560 WRITE(OUTP,760)
c-----Added on-line output
      WRITE(*   ,760)
      GO TO 550
  570 FORMAT(' Multi-Group and Multi-Band Parameters from',
     1 ' ENDF/B Data (GROUPIE 2021-1)'/1X,78('-'))
  580 FORMAT(' Retrieval Criteria------------',7X,A4/
     1       ' Number of Energy Groups-------',I11,1X,A16/
     2       ' Maximum Number of Bands/Group-',I11,1X,A28/
     3       ' Points in Weighting Spectrum--',I11,1X,A36/
     4       ' Band Selection Criteria-------',11A1,
     5 ' (No Longer Used)')
  590 FORMAT(1X,78('-')/
     1 ' Self-Shielded Listing---------',7X,A4,1X,A24/
     2 ' Multi-Band Listing------------',7X,A4/
     3 ' Multi-Band Library File-------',7X,A4/
     4 ' Unshielded Averages in ENDF/B-',7X,A4,1X,A16/
     5 ' Unshielded Averages Listing---',7X,A4,1X,A24)
  600 FORMAT(
     1 ' Maxwellian Temperature--------',1PE11.4,' eV')
  610 FORMAT(
     6 1X,78('-')/' Multi-Band Library Identification (no longer used)'/
     7 1x,78('-')/1X,A72/1X,78('-'))
  620 FORMAT(' MAT/MF/MT Ranges'/1X,78('-')/
     1 '    Minimum       Maximum'/
     2 '    MAT MF  MT    MAT MF  MT'/1X,78('-'))
  630 FORMAT(' ZA/MF/MT Ranges'/1X,78('-')/
     1 '    Minimum       Maximum'/
     2 '     ZA MF  MT     ZA MF  MT'/1X,78('-'))
  640 FORMAT(I7,I3,I4,I7,I3,I4)
  650 FORMAT(I7,I3,I4,I7,I3,I4,' (Default Option)')
  660 FORMAT(//' ERROR - Over 100 ranges----Execution Terminated')
  670 FORMAT(' Sigma-0 Definition------------',
     1 ' Multiple of Unshielded Total in Each Group')
  680 FORMAT(' Sigma-0 Definition------------',
     1 ' Same barns Values in Each Group')
  690 FORMAT(' High E Cross Section Extension',
     1 ' = Zero (ENDF Standard Definition)')
  700 FORMAT(' High E Cross Section Extension',
     1 ' = Input Ignored - will use = Zero (ENDF Standard)')
  710 FORMAT(/' Group Boundaries are NOT in Ascending Energy Order'/
     1 ' Group',I5,1X,11A1,' to ',11A1,' eV')
  720 FORMAT(/' Number of Groups=',I5,' (MUST be -19 to ',I5,')')
  730 FORMAT(/' Number of Groups=',I5,' (MUST be -19 to ',I5,')')
  740 FORMAT(/' Energy Spectrum from',11A1,' to ',11A1,' eV'/
     1 ' Does NOT Span the Group Range from',11A1,' to ',
     1 11A1,' eV')
  750 FORMAT(/' No Output Options Selected---Execution Terminated')
  760 FORMAT(' Execution Terminated')
  770 FORMAT(1X,78('-')/' Group Energy Boundaries'/1X,78('-')/
     1 6(3X,'Energy-eV')/1X,78('-'))
  780 FORMAT(6(1X,11A1))
  790 FORMAT(' Sigma0 values read as input'/1X,78('-')/
     1 1X,1P6E11.4/1X,1P6E11.4/1X,1P6E11.4/1X,1P3E11.4/1X,78('-'))
  800 FORMAT(' ERROR - Sigma0 NOT in DESCENDING value order',I5,
     1 1P2E11.4)
  810 FORMAT(1X,78('-')/' Execution terminated due to error in input'//)
      END
      SUBROUTINE NXTMAT
C=======================================================================
C
C     FIND NEXT REQUESTED MATERIAL BASED EITHER ON ZA OR MAT.
C
C=======================================================================
      INCLUDE 'implicit.h'
      CHARACTER*4 FMTHOL
      COMMON/HEADER/C1H,C2H,L1H,L2H,N1H,N2H,MATH,MFH,MTH,NOSEQ
      COMMON/WHATZA/ATWT,IZA,MATNOW,MFNOW
      COMMON/HOLFMT/FMTHOL
      COMMON/VERSES/TEMP3,IVERSE
      COMMON/RESCOM/RES1,RES2,URES1,URES2,LSSF,ICOMP,INTUNR,INPART
C-----READ NEXT CARD AND CHECK FOR END OF ENDF/B TAPE.
   10 CALL CONTIG
      IF(MFH.gt.0) go to 20
      IF(MATH.lt.0) go to 30
      go to 10
C-----DEFINE FIXED POINT ZA.
   20 IZA  = C1H
      ATWT = C2H
C-----DEFINED WHETHER OR NOT THIS SECTION IS REQUESTED.
      MMM = MYWANT(IZA,MATH,MFH,MTH)
      IF(MMM.lt.0) go to 30
      IF(MMM.gt.0) go to 40
C-----NOT REQUESTED. SKIP SECTION.
      CALL SKIPS
      GO TO 10
C-----END OF RUN. RETURN NEGATIVE MATH AS INDICATOR.
   30 MATH=-1
      MFH=0
      MTH=0
c-----Consistency check for preceding MAT, if any
      if(MATNOW.gt.0) CALL MAXIE3(1)
C-----THIS MATERIAL REQUESTED. IF A NEW MAT INITIALIZE PARAMETERS.
   40 IF(MATH.EQ.MATNOW) GO TO 50
c-----Consistency check for preceding MAT, if any
      if(MATNOW.gt.0) CALL MAXIE3(1)
      NOSEQ=1
      IVERSE=6
      FMTHOL=' '
      MATNOW=MATH
c-----2019/3/9 - Initisalize MT Table for new MAT
      CALL MAXIE0
C-----Initialize Resonance Region Boundaries.
      INPART= 1     ! Initialize to neutron (in case not ENDF6 format)
      RES1  = 0.0d0
      RES2  = 0.0d0
      URES1 = 0.0d0
      URES2 = 0.0d0
   50 MFNOW=MFH
      RETURN
      END
      INTEGER*4 FUNCTION MYWANT(IZA,MAT,MF,MT)
C=======================================================================
C
C     DEFINE WHETHER OR NOT THIS SECTION IS REQUESTED.
C
C=======================================================================
      INCLUDE 'implicit.h'
      COMMON/MATZA/MODGET,NMATZA,MATMIN(101),MFMIN(101),MTMIN(101),
     1 MATMAX(101),MFMAX(101),MTMAX(101)
      DIMENSION IZAMIN(101),IZAMAX(101)
      EQUIVALENCE (MATMIN(1),IZAMIN(1)),(MATMAX(1),IZAMAX(1))
      LOW=0
      IF(MODGET.NE.0) LOW=1
      DO 30 IMATZA=1,NMATZA
      IF(MODGET.NE.0) GO TO 10
c-----------------------------------------------------------------------
C
C     MAT RANGES.
C
c-----------------------------------------------------------------------
      IF(MAT.GT.MATMAX(IMATZA)) GO TO 30
      LOW=1
      IF(MAT.LT.MATMIN(IMATZA)) GO TO 30
      GO TO 20
c-----------------------------------------------------------------------
C
C     ZA RANGES.
C
c-----------------------------------------------------------------------
   10 IF(IZA.LT.IZAMIN(IMATZA).OR.IZA.GT.IZAMAX(IMATZA)) GO TO 30
c-----------------------------------------------------------------------
C
C     MF/MT RANGES.
C
c-----------------------------------------------------------------------
C-----COMPARE MF AND MT SELECTION CRITERIA.
   20 IF(MF.LT.MFMIN(IMATZA).OR.MF.GT.MFMAX(IMATZA)) GO TO 30
      IF(MT.LT.MTMIN(IMATZA).OR.MT.GT.MTMAX(IMATZA)) GO TO 30
c-----------------------------------------------------------------------
C
C     THIS SECTION IS REQUESTED.
C
c-----------------------------------------------------------------------
      GO TO 50
   30 CONTINUE
c-----------------------------------------------------------------------
C
C     THIS SECTION HAS NOT BEEN REQUESTED. IF BEYOND RANGE OF ALL
C     REQUESTS RUN IF COMPLETED. IF NOT SKIP TO NEXT SECTION.
C
c-----------------------------------------------------------------------
      IF(LOW.LE.0) GO TO 40
C-----NOT REQUESTED.
      MYWANT=0
      RETURN
C-----BEYOND THE RANGE OF ALL REQUESTS.
   40 MYWANT=-1
      RETURN
C-----REQUESTED.
   50 MYWANT=IMATZA
      RETURN
      END
      SUBROUTINE CONTIG
C=======================================================================
C
C     READ ONE ENDF/B CONTROL CARD.
C
C=======================================================================
      INCLUDE 'implicit.h'
      COMMON/HEADER/C1H,C2H,L1H,L2H,N1H,N2H,MATH,MFH,MTH,NOSEQ
C-----READ CARD.
   10 CALL CONTI
      IF(MTH .gt.0) go to 20     ! MTH > 0 = Start of SECTION
      IF(MFH .le.0) go to 30     ! MFH or MATH = 0 = End
      IF(MATH.eq.0) go to 30
      IF(MATH.lt.0) go to 50     ! MATH < 0 = TEND
      go to 10                   ! Skip SEND
C-----SKIP SECTION IF NOT REQUESTED.
   20 IZATRY=C1H
      MMM = MYWANT(IZATRY,MATH,MFH,MTH)
      IF(MMM.lt.0) go to 50
      IF(MMM.eq.0) go to 40
C-----REQUESTED OR END OF MF OR MAT.
   30 RETURN
C-----NOT REQUESTED. SKIP TO NEXT SECTION.
   40 CALL SKIPS
      GO TO 10
C-----END OF REQUESTED DATA.
   50 MATH=-1
      MFH=0
      MTH=0
      RETURN
      END
      SUBROUTINE CONTOG
C=======================================================================
C
C     WRITE ONE ENDF/B CONTROL RECORD.
C
C     PRECEED BY FEND, MEND AS NEEDED.
C
C=======================================================================
      INCLUDE 'implicit.h'
      INTEGER*4 OUTP,OTAPE
      COMMON/ENDFIO/INP,OUTP,ITAPE,OTAPE
      COMMON/HEADER/C1H,C2H,L1H,L2H,N1H,N2H,MATH,MFH,MTH,NOSEQ
      CHARACTER*4 CARDX(17)
      DIMENSION MFIELD(3)
      IF(OTAPE.LE.0) RETURN
C-----ADD FEND AND MEND LINES AS NEEDED.
      IF(LSTMAT.LE.0) GO TO 10
C-----ADD FEND LINE IF NEW MAT OR MF.
      IF(MATH.EQ.LSTMAT.AND.MFH.EQ.LSTMF) GO TO 10
      CALL OUTF(LSTMAT)
C-----ADD MEND LINE IF NEW MAT.
      IF(MATH.EQ.LSTMAT) GO TO 10
      CALL OUTM
      NOSEQ=1
   10 CALL CONTO
C-----SAVE LAST MAT/MF OUTPUT.
      LSTMAT = MATH
      LSTMF  = MFH
      RETURN
      ENTRY COPYFG
C=======================================================================
C
C     SAME AS COPYF, EXCEPT READ, BUT DO NOT OUTPUT FEND.
C     PLUS SAVE LAST MAT, MF OUTPUT.
C
C=======================================================================
   20 READ(ITAPE,30) CARDX,MFIELD
      IF(MFIELD(2).le.0) GO TO 40       ! If MF=0 return without write
      IF(OTAPE.LE.0) GO TO 20
      IF(MFIELD(3).le.0) then
      CALL OUTS(MFIELD(1),MFIELD(2))
      GO TO 20
      ENDIF
      WRITE(OTAPE,30) CARDX,MFIELD,NOSEQ
      NOSEQ = NXTSEQ(NOSEQ)
C-----SAVE LAST MAT/MF OUTPUT.
      LSTMAT = MFIELD(1)
      LSTMF  = MFIELD(2)
      GO TO 20
   30 FORMAT(16A4,A2,I4,I2,I3,I5)
   40 RETURN
      ENTRY COPYSG
C=======================================================================
C
C     SAME AS COPYS PLUS SAVE LAST MAT, MF OUTPUT
C
C=======================================================================
   50 READ(ITAPE,30) CARDX,MFIELD
      IF(OTAPE.LE.0) GO TO 60
      IF(MFIELD(3).gt.0) then
      WRITE(OTAPE,30) CARDX,MFIELD,NOSEQ
      NOSEQ = NXTSEQ(NOSEQ)
      else
      CALL OUTS(MFIELD(1),MFIELD(2))
      ENDIF
C-----SAVE LAST MAT/MF OUTPUT.
   60 LSTMAT = MFIELD(1)
      LSTMF  = MFIELD(2)
      IF(MFIELD(3).gt.0) go to 50
      RETURN
      ENTRY COPY1G
C=======================================================================
C
C     SAME AS COPY1 PLUS SAVE LAST MAT, MF OUTPUT
C
C=======================================================================
      READ(ITAPE,30) CARDX,MFIELD
      IF(OTAPE.LE.0) RETURN
      IF(MFIELD(3).gt.0) then
      WRITE(OTAPE,30) CARDX,MFIELD,NOSEQ
      NOSEQ = NXTSEQ(NOSEQ)
      else
      CALL OUTS(MFIELD(1),MFIELD(2))
      ENDIF
C-----SAVE LAST MAT/MF OUTPUT.
      LSTMAT = MFIELD(1)
      LSTMF  = MFIELD(2)
      RETURN
      END
      SUBROUTINE IBLOCK(ISCR,X,Y,IX)
C=======================================================================
C
C     READ A BLOCK OF WORDS FROM SCRATCH FILE.
C
C=======================================================================
      INCLUDE 'implicit.h'
      DIMENSION X(IX),Y(IX)
      READ(ISCR) X,Y
      RETURN
      END
      SUBROUTINE OBLOCK(ISCR,X,Y,IX)
C=======================================================================
C
C     WRITE A BLOCK OF WORDS TO SCRATCH FILE.
C
C=======================================================================
      INCLUDE 'implicit.h'
      DIMENSION X(IX),Y(IX)
      WRITE(ISCR) X,Y
      RETURN
      END
      SUBROUTINE BLOCK
C=======================================================================
C
C     INITIALIZE LABELLED COMMON.
C
C=======================================================================
      INCLUDE 'implicit.h'
      CHARACTER*8 SIGHL1,SIGHL2,SIGHX1,SIGHX2
      CHARACTER*4 TUNITS,TUNIS,TMPHOL,REAC2,REAC3
      COMMON/ELPASD/TUNITS(2,4),TMPHOL(3)
      COMMON/SIGGIE/SIGHL1(12),SIGHL2(12)
      INCLUDE 'groupie.h'
      DIMENSION SIGMAZ(25),SHIELX(25),REAC2(2,6),REAC3(2,6),TUNIS(2,4),
     1 SIGHX1(12),SIGHX2(12)
C-----DEFINE SIGMA0 TABLE AS MULTIPLES OF UNSHIELDED GROUP
C-----AVERAGED CROSS SECTION IN EACH GROUP.
      DATA SIGMAZ/
     1   0.0D+00,1024.0D+00, 512.0D+00, 256.0D+00, 128.0D+00,
     3  64.0D+00,  32.0D+00,  16.0D+00,   8.0D+00,   4.0D+00,
     3   2.0D+00,   1.0D+00, 13*0.0D+00/
C-----DEFINE SIGMAO TABLE AS ABSOLUTE NUMBERS.
      DATA SHIELX/
     1   0.0D+00,40000.0D+00,20000.0D+00,10000.0D+00, 7000.0D+00,
     2            4000.0D+00, 2000.0D+00, 1000.0D+00,  700.0D+00,
     3             400.0D+00,  200.0D+00,  100.0D+00,   70.0D+00,
     4              40.0D+00,   20.0D+00,   10.0D+00,    7.0D+00,
     5               4.0D+00,    2.0D+00,    1.0D+00,    0.7D+00,
     6               0.4D+00,    0.0D+00,    0.0D+00,    0.0D+00/
C-----DEFINE TITLES FOR ABOVE VALUES OF SIGMAO FOR LISTING.
      DATA SIGHX1/'Averages','     256',
     1            '      64','      16',
     1            '       4','       1',
     2            '     1/4','    1/16',
     2            '    1/64','   1/256',
     3            '  1/Tot ','1/Tot**2'/
      DATA SIGHX2/'Averages','   10000',
     1            '    4000','    1000',
     1            '     400','     100',
     2            '      40','      10',
     2            '       4','       1',
     3            '  1/Tot ','1/Tot**2'/
C-----DEFINE HOLLERITH EQUIVALENT OF REACTIONS.
      DATA REAC2/
     1 '    ','    ',
     2 '   T','otal',
     3 ' Ela','stic',
     4 ' Cap','ture',
     5 ' Fis','sion',
     6 '   O','ther'/
      DATA REAC3/
     1 '    ','    ',
     2 'Tota','l   ',
     3 'Elas','t   ',
     4 'Capt','.   ',
     5 'Fiss','.   ',
     6 'Othe','r   '/
C-----DEFINE TEMPERATURE OUTOUT UNITS.
      DATA TUNIS/'Kelv','in  ','eV  ',' ','keV ',' ','MeV ',' '/
      DO 10 I=1,25
      SIGMAB(I)=SIGMAZ(I)
      SHIELD(I)=SHIELX(I)
   10 CONTINUE
      DO 30 I=1,2
      DO 20 J=1,6
      REACT2(I,J)=REAC2(I,J)
   20 CONTINUE
   30 CONTINUE
      DO 50 I=1,2
      DO 40 J=1,6
      REACT3(I,J)=REAC3(I,J)
   40 CONTINUE
   50 CONTINUE
      DO 70 I=1,2
      DO 60 J=1,4
      TUNITS(I,J)=TUNIS(I,J)
   60 CONTINUE
   70 CONTINUE
      DO 80 I=1,12
      SIGHL1(I) = SIGHX1(I)
      SIGHL2(I) = SIGHX2(I)
   80 CONTINUE
      RETURN
      END
      SUBROUTINE INTOUT(INTX,FIELD,LENGTH)
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
      II=INTX
      DO 20 I=LENGTH,1,-1
      IF(II.LE.0) GO TO 30
      KK=II/10
      LL=II-10*KK
      FIELD(I)=DIGITS(LL)
      II=KK
   20 CONTINUE
   30 RETURN
      END
      SUBROUTINE FILIO1
C=======================================================================
C
C     DEFINE ALL I/O UNITS AND OPTIONALLY DEFINE FILE NAMES.
C
C=======================================================================
      INCLUDE 'implicit.h'
      INTEGER*4 OUTP,OTAPE,OTAPE2
      CHARACTER*72 NAMEIN,NAMEOUT
      COMMON/ENDFIO/INP,OUTP,ITAPE,OTAPE
      COMMON/UNITS/OTAPE2,NTAPE,LIST1,LIST2,LIST3,IPLOT
      COMMON/IOSTATUS/ISTAT1,ISTAT2
      COMMON/NAMEX/NAMEIN,NAMEOUT
      COMMON/INPAGE/IXYLOW(5),IXYHI(5),ISCR(5)
c-----------------------------------------------------------------------
c
C     DEFINE ALL I/O UNITS. THEY ARE,
C     INP     = INPUT FILE
C     OUTP    = OUTPUT LISTING
C     ITAPE   = ENDF/B FORMAT DATA TO BE AVERAGED
C     OTAPE   = ENDF/B FORMAT MULTIGROUP OUTPUT (OPTIONAL)
C     ------------------------------------------------------------------
C     OTAPE2  = MULTIBAND PARAMETERS FILE (OPTIONAL)
C     NTAPE   = ENDF Formatted URR data for NJOY/MCNP
C     LIST1   = SELF-SHIELDED CROSS SECTION LISTING (OPTIONAL)
C     LIST2   = MULTIBAND PARAMETERS LISTING (OPTIONAL)
C     LIST3   = UNSHIELDED CROSS SECTION LISTING (OPTIONAL)
C     IPLOT   = PLOTTAB OUTPUT
C     ------------------------------------------------------------------
C     ISCR(1) = SCRATCH FILE FOR SPECTRUM
C     ISCR(2) = SCRATCH FILE FOR TOTAL CROSS SECTION
C     ISCR(3) = SCRATCH FILE FOR ELASTIC CROSS SECTION
C     ISCR(4) = SCRATCH FILE FOR CAPTURE CROSS SECTION
C     ISCR(5) = SCRATCH FILE FOR FISSION CROSS SECTION
c
c-----------------------------------------------------------------------
      INP=2
      OUTP=3
      ITAPE=10
      OTAPE=11
c     ------------------------
      OTAPE2=31
      NTAPE =32
      LIST1 =33
      LIST2 =34
      LIST3 =35
      IPLOT =16
c     ------------------------
      ISCR(1)=8
      ISCR(2)=9
      ISCR(3)=12
      ISCR(4)=13
      ISCR(5)=14
C-----DEFINE ALL FILE NAMES.
      OPEN(OUTP,FILE='GROUPIE.LST',STATUS='UNKNOWN')
      CALL SCRATCH1(ISCR(1),'GROUPIE.001 ')
      CALL SCRATCH1(ISCR(2),'GROUPIE.002 ')
      CALL SCRATCH1(ISCR(3),'GROUPIE.003 ')
      CALL SCRATCH1(ISCR(4),'GROUPIE.004 ')
      CALL SCRATCH1(ISCR(5),'GROUPIE.005 ')
      OPEN(INP,FILE='GROUPIE.INP',STATUS='OLD',ERR=10)
      ISTAT1 = 0
      RETURN
   10 ISTAT1 = 1
      RETURN
      ENTRY FILIO2
c-----------------------------------------------------------------------
C
C     DEFINE FILES (BASED ON REQUESTED OUTPUT).
C
c-----------------------------------------------------------------------
      IF(ITAPE.GT.0)  OPEN(ITAPE ,FILE=NAMEIN,STATUS='OLD',ERR=20)
      IF(OTAPE.GT.0)  OPEN(OTAPE ,FILE=NAMEOUT,STATUS='UNKNOWN')
      ISTAT2 = 0
      RETURN
   20 ISTAT2 = 1
      RETURN
      END
      SUBROUTINE OUT8(Z,ZCHAR)
C=======================================================================
C
C     FORMAT SIGMA0 FOR OUTPUT IN 8 COLUMNS
C
C=======================================================================
      INCLUDE 'implicit.h'
      CHARACTER*1 ZCHAR   ,DIGITS
      DIMENSION   ZCHAR(8),DIGITS(0:9)
      DATA DIGITS/'0','1','2','3','4','5','6','7','8','9'/
      DO I=1,8
      ZCHAR(I) = ' '
      ENDDO
C-----INTEGER IF > 1
      IF(Z.LT.1.0) GO TO 20
c-----------------------------------------------------------------------
C
C     DIGITS LAST TO FIRST
C
c-----------------------------------------------------------------------
      II = Z
      DO 10 I=8,2,-1
      JJ = II/10
      KK = II - 10*JJ
      ZCHAR(I) = DIGITS(KK)
      IF(JJ.LE.0) RETURN
      II = JJ
   10 CONTINUE
      RETURN
c-----------------------------------------------------------------------
C
C     . FOLLOWED BY 6 DIGITS
C
c-----------------------------------------------------------------------
   20 ZCHAR(2) = '.'
      DO I=3,8
      ZCHAR(I) = '0'
      ENDDO
      II = 1.0D+6*Z
      DO 30 I=8,3,-1
      JJ = II/10
      KK = II - 10*JJ
      ZCHAR(I) = DIGITS(KK)
      IF(JJ.LE.0) RETURN
      II = JJ
   30 CONTINUE
      RETURN
      END
      subroutine ACEENDF
c=======================================================================
c
c     Define NJOY ENDF format output parameters,
c
c     MF/MT = 2/252 =
c     MF/MT = 2/253 =
c
c=======================================================================
      INCLUDE 'implicit.h'
      INTEGER*4 OUTP,OTAPE,OTAPE2
      CHARACTER*1  urr1,ZABCD
      CHARACTER*20 urr1file
      COMMON/WHATZA/ATWT,IZA,MATNOW,MFNOW
      COMMON/ELPASZ/ZABCD(12)
      COMMON/ENDFIO/INP,OUTP,ITAPE,OTAPE
      COMMON/UNITS/OTAPE2,NTAPE,LIST1,LIST2,LIST3,IPLOT
      COMMON/HEADER/C1H,C2H,L1H,L2H,N1H,N2H,MATH,MFH,MTH,NOSEQ
      common/leader/c1, c2, l1, l2, n1, n2, matx, mfx, mtx
      COMMON/TEMPO/TMPTAB(3),TEMP1,NTEMP
      COMMON/RESCOM/RES1,RES2,URES1,URES2,LSSF,ICOMP,INTUNR,INPART
      common/ACECOM/NUNR1,NUNR2,NUNROUT
      dimension urr1(20)
      equivalence (urr1file,urr1(1))
      INCLUDE 'groupie.h'
      data urr1file/'ZA000000.URR.ENDF   '/
c                      zzzaaa
c                    12345678901234567890
c-----------------------------------------------------------------------
c
c     Define URR ENDF Filename = ZAzzzaaa.URR.ENDF
c
c-----------------------------------------------------------------------
      call ZANAME(IZA,urr1(1))
c-----Re-Define standard ENDF Output unit and output ENDF TPID
      MYUNIT = OTAPE
      OTAPE  = NTAPE
      NOSEQ  = 0
      OPEN(OTAPE,file=urr1file)
      write(OTAPE,10) ZABCD
   10 format(12a1,' Unresolved Region 2-Band Data',
     1 '  PREPRO/GROUPIE(2021-1)8000 0  0    0')
c            12    345678901234567890123456789012
c               1         2         3         4
c       345678901234567890123456
c              5         6
c          5         6
c-----------------------------------------------------------------------
c
c     Define groups in URR
c
c-----------------------------------------------------------------------
c-----2019/6/23 - LSSF and INTUNR definitions
      LSSF   = 0 ! Always use LSSF=0 to forec only cross section -
      ! never f-factot output.
      INTUNR = 2 ! Interpolation code = not defined in NJOY manual
      ! NJOY uss 2 or 5 - here always use 2
c-----------------------------------------------------------------------
c
c     Output URR data to ENDF Format Filename = ZAzzzaaa.URR.ENDF
c
c-----------------------------------------------------------------------
      C1H = IZA              ! HEADER line
      C2H = ATWT
      L1H = 0
      L2H = 0
      N1H = 0
      N2H = 0
      c1  = TEMP1            ! LEADER line
      c2  = 0.0d0
      l1  = 0
      l2  = 0
      n1  = 0
      n2  = 0
c-----Define MAT and MF
      math = MATNOW
      mfh  = 2
c-----Move data to ourput arrays
      call finalout
c-----Output parameters in NJOY pseudo format
      call mf2mt152
      call mf2mt153
      call outf(math)
      call outm
      call outt
      CLOSE(OTAPE)
c-----Restore standard ENDF Output unit
      OTAPE  = MYUNIT
      return
      end
      subroutine finalout
c=======================================================================
c
c     Output MF/MT=2/152
c     Output distribution vs. energy across unresolved region
c     for 2 sigma-0 values,
c     1) Unshielded = Sigma0 = infinity (1.0d10)
c     2) Shielded   = Sigma0 = 0
c
c     Output for unshielded is always cross sections
c
c     2019/6/23 - GROUPIE Output is NOW ALWAYS cross sections -
c                 never f-factors - it sets LSSF = 0 for output.
c
c=======================================================================
      include 'implicit.h'
      common/header/c1h,c2h,l1h,l2h,n1h,n2h,math,mfh,mth,noseq
      common/leader/c1, c2, l1, l2, n1, n2, matx, mfx, mtx
      COMMON/RESCOM/RES1,RES2,URES1,URES2,LSSF,ICOMP,INTUNR,INPART
      INCLUDE 'groupie.h'
      common/ACECOM/NUNR1,NUNR2,NUNROUT
c-----------------------------------------------------------------------
c
c     XCALL  ---> XCUALL
c     XCBAND ---> XCUBAND
c
c-----------------------------------------------------------------------
      do ir=1,6
      XCUALL(1,ir,  1)     = XCALL( 1,ir,NGRP1) ! lower limit
      XCUALL(2,ir,  1)     = XCALL(23,ir,NGRP1)
      XCUALL(3,ir,  1)     = XCALL(24,ir,NGRP1)
      XCUBAND(ir,1, 1)     = XCBAND(ir,1,NGRP1)
      XCUBAND(ir,2, 1)     = XCBAND(ir,2,NGRP1)
      ii = 1
      do igr=NUNR1,NUNR2
      ii = ii + 1
      XCUALL(1,ir, ii)     = XCALL( 1,ir,igr)   ! inside
      XCUALL(2,ir, ii)     = XCALL(23,ir,igr)
      XCUALL(3,ir, ii)     = XCALL(24,ir,igr)
      XCUBAND(ir,1,ii)     = XCBAND(ir,1,igr)
      XCUBAND(ir,2,ii)     = XCBAND(ir,2,igr)
      enddo                ! group loop end
      ii = ii + 1
      XCUALL(1,ir, ii)     = XCALL( 1,ir,NGRP2) ! upper limit
      XCUALL(2,ir, ii)     = XCALL(23,ir,NGRP2) ! upper limit
      XCUALL(3,ir, ii)     = XCALL(24,ir,NGRP2) ! upper limit
      XCUBAND(ir,1,ii)     = XCBAND(ir,1,NGRP2)
      XCUBAND(ir,2,ii)     = XCBAND(ir,2,NGRP2)
      enddo                ! reaction loop end
c-----------------------------------------------------------------------
c
c     WTBAND     ---> WTUBAND
c
c-----------------------------------------------------------------------
      WTUBAND(1, 1) = WTBAND(1,NGRP1)              ! lower limit
      WTUBAND(2, 1) = WTBAND(2,NGRP1)
      ii = 1
      do igr=NUNR1,NUNR2
      ii = ii + 1
      WTUBAND(1,ii) = WTBAND(1,igr)                ! inside
      WTUBAND(2,ii) = WTBAND(2,igr)
      enddo                ! group loop end
      ii = ii + 1
      WTUBAND(1,ii) = WTBAND(1,NGRP2)              ! upper limit
      WTUBAND(2,ii) = WTBAND(2,NGRP2)
      return
      end
      subroutine mf2mt152
c=======================================================================
c
c     Output MF/MT=2/152
c     Output distribution vs. energy across unresolved region
c     for 2 sigma-0 values,
c     1) Unshielded = Sigma0 = infinity (1.0d10)
c     2) Shielded   = Sigma0 = 0
c
c     Output for unshielded is always cross section
c
c     2019/6/23 - GROUPIE Output is NOW ALWAYS cross sections -
c                 never f-factors - it sets LSSF = 0 for output.
c
c=======================================================================
      include 'implicit.h'
      common/header/c1h,c2h,l1h,l2h,n1h,n2h,math,mfh,mth,noseq
      common/leader/c1, c2, l1, l2, n1, n2, matx, mfx, mtx
      COMMON/RESCOM/RES1,RES2,URES1,URES2,LSSF,ICOMP,INTUNR,INPART
      INCLUDE 'groupie.h'
      common/ACECOM/NUNR1,NUNR2,NUNROUT
c-----Define 2 sihma0 values = infinity and 0
      dimension sigz(2)
      data nsigz/2/
      data sigz/1.0d10,0.0d0/
c-----Define MF and MT
      mfh = 2
      mth = 152
c-----Initialize HEADER and LEADER
      l1h = LSSF     ! LSSF = 0 for output
      l2h = 0
      n1h = 0
      n2h = INTUNR   ! INTUNR = interpolation code = NJOY uses 2 or 5?
c                    ! NJOY uses 2 or 5 -here always use 2
      l1  = 5        ! always 5 reactions (T, E, F, C, T Current)
      l2  = nsigz    ! always 2 sigma-0 values
c     n1  = 0        ! # of words = defined below
      n2  = NUNROUT
c--------------------------------------------------------
      nreac   = l1   ! 5 = T, E, F, C, T current
c-----------------------------------------------------------------------
c
c     Format.
c
c-----------------------------------------------------------------------
      ii = 0
c-----Sigma-0 values
      do isigz = 1,nsigz
      ii = ii + 1
      XOUT(ii) = sigz(isigz)
      enddo
c-----shield x/c = vs. energy range, reaction, sigma-0
      do iunrx = 1,NUNROUT          ! Energies
      ii = ii + 1
      XOUT(ii) = EAVURR(iunrx)      ! energy
      do ireac = 1,nreac            ! reaction: T, E, F, C, Current
      if(ireac.eq.1) ireac1 = 2     ! T (Flux)   Note change in
      if(ireac.eq.2) ireac1 = 3     ! E          order to ENDF
      if(ireac.eq.3) ireac1 = 5     ! F          MT order 1, 2, 18, 102
      if(ireac.eq.4) ireac1 = 4     ! C
      if(ireac.eq.5) ireac1 = 2     ! T (Current)
c-----Unshielded
      ii = ii + 1
      XOUT(ii) = XCUALL( 1,ireac1,iunrx)
c-----Shielded (Flux or Current) = Cross Section or F-Fsctor
      ii = ii + 1
      if(ireac.ne.5) K9=2                  ! Flux
      if(ireac.eq.5) K9=3                  ! Current
      XOUT(ii) = XCUALL(K9,ireac1,iunrx)   ! Flux or Current
      enddo
      enddo
c-----------------------------------------------------------------------
c
c     Output in ENDF format
c
c-----------------------------------------------------------------------
      n1 = ii
      call conto
      call cardo(c1,c2,l1,l2,n1,n2)
      call listo9(XOUT(1),n1)
      call outs(math,mfh)
      return
      end
      subroutine mf2mt153
c=======================================================================
c
c     Output MF/MT=2/153
c     Output 2 band parameters.
c
c     2019/6/23 - GROUPIE Output is NOW ALWAYS cross sections -
c                 never f-factors - it sets LSSF = 0 for output.
c
c=======================================================================
      include 'implicit.h'
      common/header/c1h,c2h,l1h,l2h,n1h,n2h,math,mfh,mth,noseq
      common/leader/c1, c2, l1, l2, n1, n2, matx, mfx, mtx
      COMMON/RESCOM/RES1,RES2,URES1,URES2,LSSF,ICOMP,INTUNR,INPART
      INCLUDE 'groupie.h'
      common/ACECOM/NUNR1,NUNR2,NUNROUT
c-----Define MF and MT
      mfh = 2
      mth = 153
c-----Initialize HEADER and LEADER
      l1h = 0
      l2h = 0
      n1h = INTUNR   ! not defined in NJOY manual = guess INTERP code
      n2h = 2        ! Always 2 bins (bands)
      l1  = LSSF     ! LSSF  = 0 for output
      l2  = ICOMP    ! ICOMP = what NJOY uses = Competitive MT).
c     n1  = 0        ! # of words - defined below
      n2  = NUNROUT  ! # of energies
c-----------------------------------------------------------------------
c
c     Always output 2 band GROUPIE results.
c
c-----------------------------------------------------------------------
c-----------------------------------------------------------------------
c
c     Output multi-band Data.
c
c-----------------------------------------------------------------------
      nbin = n2h                ! always 2 bins
      ii = 0
      do iunrx = 1,NUNROUT          ! Energies
      ii = ii + 1
      XOUT(ii) = EAVURR(iunrx)      ! energy
      do ipar=1,6               ! 6 parameters=P,T,E,F,C,Heat = 0
      do ibin=1,nbin            ! nbin bins
      ii = ii + 1
      if(ipar.eq.1) then
      XOUT(ii) = WTUBAND (ibin,iunrx)  ! P
      else
      if(ipar.eq.6) then
      XOUT(ii) = 0.0d0               ! Heat = 0
      else
      if(ipar.eq.2) ipar1 = 2        ! T  Note change of order
      if(ipar.eq.3) ipar1 = 3        ! E  to ENDF MT order: 1,2, 18,102
      if(ipar.eq.4) ipar1 = 5        ! F
      if(ipar.eq.5) ipar1 = 4        ! C
      XOUT(ii) = XCUBAND (ipar1,ibin,iunrx)
      endif
      endif
      enddo
      enddo
      enddo
c-----------------------------------------------------------------------
c
c     Output in ENDF format
c
c-----------------------------------------------------------------------
      n1 = ii
      call conto
      call cardo(c1,c2,l1,l2,n1,n2)
      call listo9(XOUT(1),n1)
      call outs(math,mfh)
      return
      end
