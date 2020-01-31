      SUBROUTINE COEF_CONSTRUCTION_1(P,NHEL,H,IC)
C     
C     Modules
C     
      USE POLYNOMIAL_CONSTANTS
C     
      IMPLICIT NONE
C     
C     CONSTANTS
C     
      INTEGER    NEXTERNAL
      PARAMETER (NEXTERNAL=5)
      INTEGER    NCOMB
      PARAMETER (NCOMB=24)
      INTEGER NBORNAMPS
      PARAMETER (NBORNAMPS=2)
      INTEGER    NLOOPS, NLOOPGROUPS, NCTAMPS
      PARAMETER (NLOOPS=19, NLOOPGROUPS=11, NCTAMPS=32)
      INTEGER    NLOOPAMPS
      PARAMETER (NLOOPAMPS=51)
      INTEGER    NWAVEFUNCS,NLOOPWAVEFUNCS
      PARAMETER (NWAVEFUNCS=14,NLOOPWAVEFUNCS=43)
      REAL*8     ZERO
      PARAMETER (ZERO=0D0)
      REAL*16     MP__ZERO
      PARAMETER (MP__ZERO=0.0E0_16)
C     These are constants related to the split orders
      INTEGER    NSO, NSQUAREDSO, NAMPSO
      PARAMETER (NSO=1, NSQUAREDSO=1, NAMPSO=2)
C     
C     ARGUMENTS
C     
      REAL*8 P(0:3,NEXTERNAL)
      INTEGER NHEL(NEXTERNAL), IC(NEXTERNAL)
      INTEGER H
C     
C     LOCAL VARIABLES
C     
      INTEGER I,J,K
      COMPLEX*16 COEFS(MAXLWFSIZE,0:VERTEXMAXCOEFS-1,MAXLWFSIZE)

      LOGICAL DUMMYFALSE
      DATA DUMMYFALSE/.FALSE./
C     
C     GLOBAL VARIABLES
C     
      INCLUDE 'coupl.inc'
      INCLUDE 'mp_coupl.inc'

      INTEGER HELOFFSET
      INTEGER GOODHEL(NCOMB)
      LOGICAL GOODAMP(NSQUAREDSO,NLOOPGROUPS)
      COMMON/FILTERS/GOODAMP,GOODHEL,HELOFFSET

      LOGICAL CHECKPHASE
      LOGICAL HELDOUBLECHECKED
      COMMON/INIT/CHECKPHASE, HELDOUBLECHECKED

      INTEGER SQSO_TARGET
      COMMON/SOCHOICE/SQSO_TARGET

      LOGICAL UVCT_REQ_SO_DONE,MP_UVCT_REQ_SO_DONE,CT_REQ_SO_DONE
     $ ,MP_CT_REQ_SO_DONE,LOOP_REQ_SO_DONE,MP_LOOP_REQ_SO_DONE
     $ ,CTCALL_REQ_SO_DONE,FILTER_SO
      COMMON/SO_REQS/UVCT_REQ_SO_DONE,MP_UVCT_REQ_SO_DONE
     $ ,CT_REQ_SO_DONE,MP_CT_REQ_SO_DONE,LOOP_REQ_SO_DONE
     $ ,MP_LOOP_REQ_SO_DONE,CTCALL_REQ_SO_DONE,FILTER_SO

      INTEGER I_SO
      COMMON/I_SO/I_SO
      INTEGER I_LIB
      COMMON/I_LIB/I_LIB

      COMPLEX*16 AMP(NBORNAMPS)
      COMMON/AMPS/AMP
      COMPLEX*16 W(20,NWAVEFUNCS)
      COMMON/W/W

      COMPLEX*16 WL(MAXLWFSIZE,0:LOOPMAXCOEFS-1,MAXLWFSIZE,
     $ -1:NLOOPWAVEFUNCS)
      COMPLEX*16 PL(0:3,-1:NLOOPWAVEFUNCS)
      COMMON/WL/WL,PL

      COMPLEX*16 AMPL(3,NCTAMPS)
      COMMON/AMPL/AMPL

C     
C     ----------
C     BEGIN CODE
C     ----------

C     The target squared split order contribution is already reached
C      if true.
      IF (FILTER_SO.AND.LOOP_REQ_SO_DONE) THEN
        GOTO 1001
      ENDIF

C     Coefficient construction for loop diagram with ID 3
      CALL FFV1L2P0_3(PL(0,0),W(1,6),GC_5,ZERO,ZERO,PL(0,1),COEFS)
      CALL UPDATE_WL_0_0(WL(1,0,1,0),4,COEFS,4,4,WL(1,0,1,1))
      CALL FFV1L3_1(PL(0,1),W(1,9),GC_5,ZERO,ZERO,PL(0,2),COEFS)
      CALL UPDATE_WL_0_1(WL(1,0,1,1),4,COEFS,4,4,WL(1,0,1,2))
      CALL CREATE_LOOP_COEFS(WL(1,0,1,2),1,4,1,1,1,33,H)
C     Coefficient construction for loop diagram with ID 4
      CALL FFV1L1P0_3(PL(0,0),W(1,5),GC_5,ZERO,ZERO,PL(0,3),COEFS)
      CALL UPDATE_WL_0_0(WL(1,0,1,0),4,COEFS,4,4,WL(1,0,1,3))
      CALL FFV1L3_2(PL(0,3),W(1,6),GC_5,ZERO,ZERO,PL(0,4),COEFS)
      CALL UPDATE_WL_0_1(WL(1,0,1,3),4,COEFS,4,4,WL(1,0,1,4))
      CALL FFV2L1_2(PL(0,4),W(1,7),GC_47,ZERO,ZERO,PL(0,5),COEFS)
      CALL UPDATE_WL_1_1(WL(1,0,1,4),4,COEFS,4,4,WL(1,0,1,5))
      CALL CREATE_LOOP_COEFS(WL(1,0,1,5),2,4,2,1,1,34,H)
C     Coefficient construction for loop diagram with ID 5
      CALL FFV1L3_2(PL(0,0),W(1,2),GC_5,ZERO,ZERO,PL(0,6),COEFS)
      CALL UPDATE_WL_0_1(WL(1,0,1,0),4,COEFS,4,4,WL(1,0,1,6))
      CALL FFV2L1_2(PL(0,6),W(1,7),GC_47,ZERO,ZERO,PL(0,7),COEFS)
      CALL UPDATE_WL_1_1(WL(1,0,1,6),4,COEFS,4,4,WL(1,0,1,7))
      CALL FFV1L1P0_3(PL(0,7),W(1,8),GC_5,ZERO,ZERO,PL(0,8),COEFS)
      CALL UPDATE_WL_2_0(WL(1,0,1,7),4,COEFS,4,4,WL(1,0,1,8))
      CALL CREATE_LOOP_COEFS(WL(1,0,1,8),2,4,3,1,1,35,H)
C     Coefficient construction for loop diagram with ID 6
      CALL FFV1L2_1(PL(0,0),W(1,1),GC_5,ZERO,ZERO,PL(0,9),COEFS)
      CALL UPDATE_WL_0_1(WL(1,0,1,0),4,COEFS,4,4,WL(1,0,1,9))
      CALL FFV1L2P0_3(PL(0,9),W(1,2),GC_5,ZERO,ZERO,PL(0,10),COEFS)
      CALL UPDATE_WL_1_0(WL(1,0,1,9),4,COEFS,4,4,WL(1,0,1,10))
      CALL FFV1L3_1(PL(0,10),W(1,9),GC_5,ZERO,ZERO,PL(0,11),COEFS)
      CALL UPDATE_WL_1_1(WL(1,0,1,10),4,COEFS,4,4,WL(1,0,1,11))
      CALL CREATE_LOOP_COEFS(WL(1,0,1,11),2,4,4,1,1,36,H)
C     Coefficient construction for loop diagram with ID 7
      CALL FFV1L3_1(PL(0,10),W(1,5),GC_5,ZERO,ZERO,PL(0,12),COEFS)
      CALL UPDATE_WL_1_1(WL(1,0,1,10),4,COEFS,4,4,WL(1,0,1,12))
      CALL FFV2L2_1(PL(0,12),W(1,7),GC_47,ZERO,ZERO,PL(0,13),COEFS)
      CALL UPDATE_WL_2_1(WL(1,0,1,12),4,COEFS,4,4,WL(1,0,1,13))
      CALL CREATE_LOOP_COEFS(WL(1,0,1,13),3,4,5,1,1,37,H)
C     Coefficient construction for loop diagram with ID 8
      CALL VVV1L2P0_1(PL(0,0),W(1,1),GC_4,ZERO,ZERO,PL(0,14),COEFS)
      CALL UPDATE_WL_0_1(WL(1,0,1,0),4,COEFS,4,4,WL(1,0,1,14))
      CALL FFV1L3_2(PL(0,14),W(1,2),GC_5,ZERO,ZERO,PL(0,15),COEFS)
      CALL UPDATE_WL_1_1(WL(1,0,1,14),4,COEFS,4,4,WL(1,0,1,15))
      CALL FFV1L1P0_3(PL(0,15),W(1,9),GC_5,ZERO,ZERO,PL(0,16),COEFS)
      CALL UPDATE_WL_2_0(WL(1,0,1,15),4,COEFS,4,4,WL(1,0,1,16))
      CALL CREATE_LOOP_COEFS(WL(1,0,1,16),2,4,4,1,1,38,H)
C     Coefficient construction for loop diagram with ID 9
      CALL FFV2L1_2(PL(0,15),W(1,7),GC_47,ZERO,ZERO,PL(0,17),COEFS)
      CALL UPDATE_WL_2_1(WL(1,0,1,15),4,COEFS,4,4,WL(1,0,1,17))
      CALL FFV1L1P0_3(PL(0,17),W(1,5),GC_5,ZERO,ZERO,PL(0,18),COEFS)
      CALL UPDATE_WL_3_0(WL(1,0,1,17),4,COEFS,4,4,WL(1,0,1,18))
      CALL CREATE_LOOP_COEFS(WL(1,0,1,18),3,4,6,1,1,39,H)
C     Coefficient construction for loop diagram with ID 10
      CALL FFV1L1_2(PL(0,0),W(1,1),GC_5,ZERO,ZERO,PL(0,19),COEFS)
      CALL UPDATE_WL_0_1(WL(1,0,1,0),4,COEFS,4,4,WL(1,0,1,19))
      CALL FFV1L1P0_3(PL(0,19),W(1,5),GC_5,ZERO,ZERO,PL(0,20),COEFS)
      CALL UPDATE_WL_1_0(WL(1,0,1,19),4,COEFS,4,4,WL(1,0,1,20))
      CALL FFV1L3_2(PL(0,20),W(1,2),GC_5,ZERO,ZERO,PL(0,21),COEFS)
      CALL UPDATE_WL_1_1(WL(1,0,1,20),4,COEFS,4,4,WL(1,0,1,21))
      CALL FFV2L1_2(PL(0,21),W(1,7),GC_47,ZERO,ZERO,PL(0,22),COEFS)
      CALL UPDATE_WL_2_1(WL(1,0,1,21),4,COEFS,4,4,WL(1,0,1,22))
      CALL CREATE_LOOP_COEFS(WL(1,0,1,22),3,4,7,1,1,40,H)
C     Coefficient construction for loop diagram with ID 11
      CALL FFV1L1P0_3(PL(0,0),W(1,8),GC_5,ZERO,ZERO,PL(0,23),COEFS)
      CALL UPDATE_WL_0_0(WL(1,0,1,0),4,COEFS,4,4,WL(1,0,1,23))
      CALL FFV1L3_2(PL(0,23),W(1,10),GC_5,ZERO,ZERO,PL(0,24),COEFS)
      CALL UPDATE_WL_0_1(WL(1,0,1,23),4,COEFS,4,4,WL(1,0,1,24))
      CALL CREATE_LOOP_COEFS(WL(1,0,1,24),1,4,8,1,1,41,H)
C     Coefficient construction for loop diagram with ID 12
      CALL FFV1L3_2(PL(0,20),W(1,10),GC_5,ZERO,ZERO,PL(0,25),COEFS)
      CALL UPDATE_WL_1_1(WL(1,0,1,20),4,COEFS,4,4,WL(1,0,1,25))
      CALL CREATE_LOOP_COEFS(WL(1,0,1,25),2,4,9,1,1,42,H)
C     Coefficient construction for loop diagram with ID 13
      CALL FFV1L3_1(PL(0,14),W(1,5),GC_5,ZERO,ZERO,PL(0,26),COEFS)
      CALL UPDATE_WL_1_1(WL(1,0,1,14),4,COEFS,4,4,WL(1,0,1,26))
      CALL FFV1L2P0_3(PL(0,26),W(1,10),GC_5,ZERO,ZERO,PL(0,27),COEFS)
      CALL UPDATE_WL_2_0(WL(1,0,1,26),4,COEFS,4,4,WL(1,0,1,27))
      CALL CREATE_LOOP_COEFS(WL(1,0,1,27),2,4,9,1,1,43,H)
C     Coefficient construction for loop diagram with ID 14
      CALL FFV1L2_1(PL(0,0),W(1,1),GC_5,MDL_MB,ZERO,PL(0,28),COEFS)
      CALL UPDATE_WL_0_1(WL(1,0,1,0),4,COEFS,4,4,WL(1,0,1,28))
      CALL FFS1L2_1(PL(0,28),W(1,3),GC_33,MDL_MB,ZERO,PL(0,29),COEFS)
      CALL UPDATE_WL_1_1(WL(1,0,1,28),4,COEFS,4,4,WL(1,0,1,29))
      CALL FFV1L2_1(PL(0,29),W(1,12),GC_5,MDL_MB,ZERO,PL(0,30),COEFS)
      CALL UPDATE_WL_2_1(WL(1,0,1,29),4,COEFS,4,4,WL(1,0,1,30))
      CALL CREATE_LOOP_COEFS(WL(1,0,1,30),3,4,10,1,1,44,H)
C     Coefficient construction for loop diagram with ID 15
      CALL FFV1L1_2(PL(0,0),W(1,1),GC_5,MDL_MB,ZERO,PL(0,31),COEFS)
      CALL UPDATE_WL_0_1(WL(1,0,1,0),4,COEFS,4,4,WL(1,0,1,31))
      CALL FFS1L1_2(PL(0,31),W(1,3),GC_33,MDL_MB,ZERO,PL(0,32),COEFS)
      CALL UPDATE_WL_1_1(WL(1,0,1,31),4,COEFS,4,4,WL(1,0,1,32))
      CALL FFV1L1_2(PL(0,32),W(1,12),GC_5,MDL_MB,ZERO,PL(0,33),COEFS)
      CALL UPDATE_WL_2_1(WL(1,0,1,32),4,COEFS,4,4,WL(1,0,1,33))
      CALL CREATE_LOOP_COEFS(WL(1,0,1,33),3,4,10,1,1,45,H)
C     Coefficient construction for loop diagram with ID 16
      CALL FFV1L1_2(PL(0,32),W(1,14),GC_5,MDL_MB,ZERO,PL(0,34),COEFS)
      CALL UPDATE_WL_2_1(WL(1,0,1,32),4,COEFS,4,4,WL(1,0,1,34))
      CALL CREATE_LOOP_COEFS(WL(1,0,1,34),3,4,10,1,1,46,H)
C     Coefficient construction for loop diagram with ID 17
      CALL FFV1L2_1(PL(0,29),W(1,14),GC_5,MDL_MB,ZERO,PL(0,35),COEFS)
      CALL UPDATE_WL_2_1(WL(1,0,1,29),4,COEFS,4,4,WL(1,0,1,35))
      CALL CREATE_LOOP_COEFS(WL(1,0,1,35),3,4,10,1,1,47,H)
C     Coefficient construction for loop diagram with ID 18
      CALL FFV1L2_1(PL(0,0),W(1,1),GC_5,MDL_MT,MDL_WT,PL(0,36),COEFS)
      CALL UPDATE_WL_0_1(WL(1,0,1,0),4,COEFS,4,4,WL(1,0,1,36))
      CALL FFS1L2_1(PL(0,36),W(1,3),GC_37,MDL_MT,MDL_WT,PL(0,37),COEFS)
      CALL UPDATE_WL_1_1(WL(1,0,1,36),4,COEFS,4,4,WL(1,0,1,37))
      CALL FFV1L2_1(PL(0,37),W(1,12),GC_5,MDL_MT,MDL_WT,PL(0,38),COEFS)
      CALL UPDATE_WL_2_1(WL(1,0,1,37),4,COEFS,4,4,WL(1,0,1,38))
      CALL CREATE_LOOP_COEFS(WL(1,0,1,38),3,4,11,1,1,48,H)
C     Coefficient construction for loop diagram with ID 19
      CALL FFV1L1_2(PL(0,0),W(1,1),GC_5,MDL_MT,MDL_WT,PL(0,39),COEFS)
      CALL UPDATE_WL_0_1(WL(1,0,1,0),4,COEFS,4,4,WL(1,0,1,39))
      CALL FFS1L1_2(PL(0,39),W(1,3),GC_37,MDL_MT,MDL_WT,PL(0,40),COEFS)
      CALL UPDATE_WL_1_1(WL(1,0,1,39),4,COEFS,4,4,WL(1,0,1,40))
      CALL FFV1L1_2(PL(0,40),W(1,12),GC_5,MDL_MT,MDL_WT,PL(0,41),COEFS)
      CALL UPDATE_WL_2_1(WL(1,0,1,40),4,COEFS,4,4,WL(1,0,1,41))
      CALL CREATE_LOOP_COEFS(WL(1,0,1,41),3,4,11,1,1,49,H)
C     Coefficient construction for loop diagram with ID 20
      CALL FFV1L1_2(PL(0,40),W(1,14),GC_5,MDL_MT,MDL_WT,PL(0,42),COEFS)
      CALL UPDATE_WL_2_1(WL(1,0,1,40),4,COEFS,4,4,WL(1,0,1,42))
      CALL CREATE_LOOP_COEFS(WL(1,0,1,42),3,4,11,1,1,50,H)
C     Coefficient construction for loop diagram with ID 21
      CALL FFV1L2_1(PL(0,37),W(1,14),GC_5,MDL_MT,MDL_WT,PL(0,43),COEFS)
      CALL UPDATE_WL_2_1(WL(1,0,1,37),4,COEFS,4,4,WL(1,0,1,43))
      CALL CREATE_LOOP_COEFS(WL(1,0,1,43),3,4,11,1,1,51,H)
C     At this point, all loop coefficients needed for (QCD=4), i.e. of
C      split order ID=1, are computed.
      IF(FILTER_SO.AND.SQSO_TARGET.EQ.1) GOTO 4000

      GOTO 1001
 4000 CONTINUE
      LOOP_REQ_SO_DONE=.TRUE.
 1001 CONTINUE
      END

