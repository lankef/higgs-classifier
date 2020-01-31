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
      PARAMETER (NLOOPS=39, NLOOPGROUPS=20, NCTAMPS=38)
      INTEGER    NLOOPAMPS
      PARAMETER (NLOOPAMPS=77)
      INTEGER    NWAVEFUNCS,NLOOPWAVEFUNCS
      PARAMETER (NWAVEFUNCS=15,NLOOPWAVEFUNCS=89)
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
      CALL FFV1L1P0_3(PL(0,0),W(1,6),GC_5,ZERO,ZERO,PL(0,1),COEFS)
      CALL UPDATE_WL_0_0(WL(1,0,1,0),4,COEFS,4,4,WL(1,0,1,1))
      CALL FFV1L3_2(PL(0,1),W(1,9),GC_5,ZERO,ZERO,PL(0,2),COEFS)
      CALL UPDATE_WL_0_1(WL(1,0,1,1),4,COEFS,4,4,WL(1,0,1,2))
      CALL CREATE_LOOP_COEFS(WL(1,0,1,2),1,4,1,1,1,39,H)
C     Coefficient construction for loop diagram with ID 4
      CALL FFV1L2P0_3(PL(0,0),W(1,5),GC_5,ZERO,ZERO,PL(0,3),COEFS)
      CALL UPDATE_WL_0_0(WL(1,0,1,0),4,COEFS,4,4,WL(1,0,1,3))
      CALL FFV1L3_1(PL(0,3),W(1,6),GC_5,ZERO,ZERO,PL(0,4),COEFS)
      CALL UPDATE_WL_0_1(WL(1,0,1,3),4,COEFS,4,4,WL(1,0,1,4))
      CALL FFV2_3L2_1(PL(0,4),W(1,7),-GC_22,GC_23,ZERO,ZERO,PL(0,5)
     $ ,COEFS)
      CALL UPDATE_WL_1_1(WL(1,0,1,4),4,COEFS,4,4,WL(1,0,1,5))
      CALL CREATE_LOOP_COEFS(WL(1,0,1,5),2,4,2,1,1,40,H)
C     Coefficient construction for loop diagram with ID 5
      CALL FFV1L3_1(PL(0,0),W(1,2),GC_5,ZERO,ZERO,PL(0,6),COEFS)
      CALL UPDATE_WL_0_1(WL(1,0,1,0),4,COEFS,4,4,WL(1,0,1,6))
      CALL FFV2_3L2_1(PL(0,6),W(1,7),-GC_22,GC_23,ZERO,ZERO,PL(0,7)
     $ ,COEFS)
      CALL UPDATE_WL_1_1(WL(1,0,1,6),4,COEFS,4,4,WL(1,0,1,7))
      CALL FFV1L2P0_3(PL(0,7),W(1,8),GC_5,ZERO,ZERO,PL(0,8),COEFS)
      CALL UPDATE_WL_2_0(WL(1,0,1,7),4,COEFS,4,4,WL(1,0,1,8))
      CALL CREATE_LOOP_COEFS(WL(1,0,1,8),2,4,3,1,1,41,H)
C     Coefficient construction for loop diagram with ID 6
      CALL FFV1L2P0_3(PL(0,0),W(1,8),GC_5,ZERO,ZERO,PL(0,9),COEFS)
      CALL UPDATE_WL_0_0(WL(1,0,1,0),4,COEFS,4,4,WL(1,0,1,9))
      CALL FFV1L3_1(PL(0,9),W(1,10),GC_5,ZERO,ZERO,PL(0,10),COEFS)
      CALL UPDATE_WL_0_1(WL(1,0,1,9),4,COEFS,4,4,WL(1,0,1,10))
      CALL CREATE_LOOP_COEFS(WL(1,0,1,10),1,4,4,1,1,42,H)
C     Coefficient construction for loop diagram with ID 7
      CALL FFV1L1_2(PL(0,0),W(1,1),GC_5,ZERO,ZERO,PL(0,11),COEFS)
      CALL UPDATE_WL_0_1(WL(1,0,1,0),4,COEFS,4,4,WL(1,0,1,11))
      CALL FFV2_3L1_2(PL(0,11),W(1,7),-GC_22,GC_23,ZERO,ZERO,PL(0,12)
     $ ,COEFS)
      CALL UPDATE_WL_1_1(WL(1,0,1,11),4,COEFS,4,4,WL(1,0,1,12))
      CALL FFV1L1_2(PL(0,12),W(1,11),GC_5,ZERO,ZERO,PL(0,13),COEFS)
      CALL UPDATE_WL_2_1(WL(1,0,1,12),4,COEFS,4,4,WL(1,0,1,13))
      CALL CREATE_LOOP_COEFS(WL(1,0,1,13),3,4,5,1,2,43,H)
C     Coefficient construction for loop diagram with ID 8
      CALL FFV1L2_1(PL(0,0),W(1,1),GC_5,ZERO,ZERO,PL(0,14),COEFS)
      CALL UPDATE_WL_0_1(WL(1,0,1,0),4,COEFS,4,4,WL(1,0,1,14))
      CALL FFV2_3L2_1(PL(0,14),W(1,7),-GC_22,GC_23,ZERO,ZERO,PL(0,15)
     $ ,COEFS)
      CALL UPDATE_WL_1_1(WL(1,0,1,14),4,COEFS,4,4,WL(1,0,1,15))
      CALL FFV1L2_1(PL(0,15),W(1,11),GC_5,ZERO,ZERO,PL(0,16),COEFS)
      CALL UPDATE_WL_2_1(WL(1,0,1,15),4,COEFS,4,4,WL(1,0,1,16))
      CALL CREATE_LOOP_COEFS(WL(1,0,1,16),3,4,5,1,2,44,H)
C     Coefficient construction for loop diagram with ID 9
      CALL FFV1L1P0_3(PL(0,11),W(1,2),GC_5,ZERO,ZERO,PL(0,17),COEFS)
      CALL UPDATE_WL_1_0(WL(1,0,1,11),4,COEFS,4,4,WL(1,0,1,17))
      CALL FFV1L3_2(PL(0,17),W(1,9),GC_5,ZERO,ZERO,PL(0,18),COEFS)
      CALL UPDATE_WL_1_1(WL(1,0,1,17),4,COEFS,4,4,WL(1,0,1,18))
      CALL CREATE_LOOP_COEFS(WL(1,0,1,18),2,4,6,1,1,45,H)
C     Coefficient construction for loop diagram with ID 10
      CALL FFV1L3_2(PL(0,17),W(1,5),GC_5,ZERO,ZERO,PL(0,19),COEFS)
      CALL UPDATE_WL_1_1(WL(1,0,1,17),4,COEFS,4,4,WL(1,0,1,19))
      CALL FFV2_3L1_2(PL(0,19),W(1,7),-GC_22,GC_23,ZERO,ZERO,PL(0,20)
     $ ,COEFS)
      CALL UPDATE_WL_2_1(WL(1,0,1,19),4,COEFS,4,4,WL(1,0,1,20))
      CALL CREATE_LOOP_COEFS(WL(1,0,1,20),3,4,7,1,1,46,H)
C     Coefficient construction for loop diagram with ID 11
      CALL FFV1L2P0_3(PL(0,14),W(1,5),GC_5,ZERO,ZERO,PL(0,21),COEFS)
      CALL UPDATE_WL_1_0(WL(1,0,1,14),4,COEFS,4,4,WL(1,0,1,21))
      CALL FFV1L3_1(PL(0,21),W(1,10),GC_5,ZERO,ZERO,PL(0,22),COEFS)
      CALL UPDATE_WL_1_1(WL(1,0,1,21),4,COEFS,4,4,WL(1,0,1,22))
      CALL CREATE_LOOP_COEFS(WL(1,0,1,22),2,4,8,1,1,47,H)
C     Coefficient construction for loop diagram with ID 12
      CALL FFV1L3_1(PL(0,21),W(1,2),GC_5,ZERO,ZERO,PL(0,23),COEFS)
      CALL UPDATE_WL_1_1(WL(1,0,1,21),4,COEFS,4,4,WL(1,0,1,23))
      CALL FFV2_3L2_1(PL(0,23),W(1,7),-GC_22,GC_23,ZERO,ZERO,PL(0,24)
     $ ,COEFS)
      CALL UPDATE_WL_2_1(WL(1,0,1,23),4,COEFS,4,4,WL(1,0,1,24))
      CALL CREATE_LOOP_COEFS(WL(1,0,1,24),3,4,9,1,1,48,H)
C     Coefficient construction for loop diagram with ID 13
      CALL VVV1L2P0_1(PL(0,0),W(1,1),GC_4,ZERO,ZERO,PL(0,25),COEFS)
      CALL UPDATE_WL_0_1(WL(1,0,1,0),4,COEFS,4,4,WL(1,0,1,25))
      CALL FFV1L3_1(PL(0,25),W(1,2),GC_5,ZERO,ZERO,PL(0,26),COEFS)
      CALL UPDATE_WL_1_1(WL(1,0,1,25),4,COEFS,4,4,WL(1,0,1,26))
      CALL FFV1L2P0_3(PL(0,26),W(1,9),GC_5,ZERO,ZERO,PL(0,27),COEFS)
      CALL UPDATE_WL_2_0(WL(1,0,1,26),4,COEFS,4,4,WL(1,0,1,27))
      CALL CREATE_LOOP_COEFS(WL(1,0,1,27),2,4,6,1,1,49,H)
C     Coefficient construction for loop diagram with ID 14
      CALL FFV2_3L2_1(PL(0,26),W(1,7),-GC_22,GC_23,ZERO,ZERO,PL(0,28)
     $ ,COEFS)
      CALL UPDATE_WL_2_1(WL(1,0,1,26),4,COEFS,4,4,WL(1,0,1,28))
      CALL FFV1L2P0_3(PL(0,28),W(1,5),GC_5,ZERO,ZERO,PL(0,29),COEFS)
      CALL UPDATE_WL_3_0(WL(1,0,1,28),4,COEFS,4,4,WL(1,0,1,29))
      CALL CREATE_LOOP_COEFS(WL(1,0,1,29),3,4,10,1,1,50,H)
C     Coefficient construction for loop diagram with ID 15
      CALL FFV1L3_2(PL(0,25),W(1,5),GC_5,ZERO,ZERO,PL(0,30),COEFS)
      CALL UPDATE_WL_1_1(WL(1,0,1,25),4,COEFS,4,4,WL(1,0,1,30))
      CALL FFV1L1P0_3(PL(0,30),W(1,10),GC_5,ZERO,ZERO,PL(0,31),COEFS)
      CALL UPDATE_WL_2_0(WL(1,0,1,30),4,COEFS,4,4,WL(1,0,1,31))
      CALL CREATE_LOOP_COEFS(WL(1,0,1,31),2,4,8,1,1,51,H)
C     Coefficient construction for loop diagram with ID 16
      CALL FFV1L1_2(PL(0,0),W(1,1),GC_5,ZERO,ZERO,PL(0,32),COEFS)
      CALL UPDATE_WL_0_1(WL(1,0,1,0),4,COEFS,4,4,WL(1,0,1,32))
      CALL FFV2_5L1_2(PL(0,32),W(1,7),GC_22,GC_23,ZERO,ZERO,PL(0,33)
     $ ,COEFS)
      CALL UPDATE_WL_1_1(WL(1,0,1,32),4,COEFS,4,4,WL(1,0,1,33))
      CALL FFV1L1_2(PL(0,33),W(1,11),GC_5,ZERO,ZERO,PL(0,34),COEFS)
      CALL UPDATE_WL_2_1(WL(1,0,1,33),4,COEFS,4,4,WL(1,0,1,34))
      CALL CREATE_LOOP_COEFS(WL(1,0,1,34),3,4,5,1,2,52,H)
C     Coefficient construction for loop diagram with ID 17
      CALL FFV1L2_1(PL(0,0),W(1,1),GC_5,ZERO,ZERO,PL(0,35),COEFS)
      CALL UPDATE_WL_0_1(WL(1,0,1,0),4,COEFS,4,4,WL(1,0,1,35))
      CALL FFV2_5L2_1(PL(0,35),W(1,7),GC_22,GC_23,ZERO,ZERO,PL(0,36)
     $ ,COEFS)
      CALL UPDATE_WL_1_1(WL(1,0,1,35),4,COEFS,4,4,WL(1,0,1,36))
      CALL FFV1L2_1(PL(0,36),W(1,11),GC_5,ZERO,ZERO,PL(0,37),COEFS)
      CALL UPDATE_WL_2_1(WL(1,0,1,36),4,COEFS,4,4,WL(1,0,1,37))
      CALL CREATE_LOOP_COEFS(WL(1,0,1,37),3,4,5,1,2,53,H)
C     Coefficient construction for loop diagram with ID 18
      CALL FFV1L2_1(PL(0,0),W(1,1),GC_5,MDL_MB,ZERO,PL(0,38),COEFS)
      CALL UPDATE_WL_0_1(WL(1,0,1,0),4,COEFS,4,4,WL(1,0,1,38))
      CALL FFS1L2_1(PL(0,38),W(1,3),GC_33,MDL_MB,ZERO,PL(0,39),COEFS)
      CALL UPDATE_WL_1_1(WL(1,0,1,38),4,COEFS,4,4,WL(1,0,1,39))
      CALL FFV1L2_1(PL(0,39),W(1,13),GC_5,MDL_MB,ZERO,PL(0,40),COEFS)
      CALL UPDATE_WL_2_1(WL(1,0,1,39),4,COEFS,4,4,WL(1,0,1,40))
      CALL CREATE_LOOP_COEFS(WL(1,0,1,40),3,4,11,1,1,54,H)
C     Coefficient construction for loop diagram with ID 19
      CALL FFV1L1_2(PL(0,0),W(1,1),GC_5,MDL_MB,ZERO,PL(0,41),COEFS)
      CALL UPDATE_WL_0_1(WL(1,0,1,0),4,COEFS,4,4,WL(1,0,1,41))
      CALL FFS1L1_2(PL(0,41),W(1,3),GC_33,MDL_MB,ZERO,PL(0,42),COEFS)
      CALL UPDATE_WL_1_1(WL(1,0,1,41),4,COEFS,4,4,WL(1,0,1,42))
      CALL FFV1L1_2(PL(0,42),W(1,13),GC_5,MDL_MB,ZERO,PL(0,43),COEFS)
      CALL UPDATE_WL_2_1(WL(1,0,1,42),4,COEFS,4,4,WL(1,0,1,43))
      CALL CREATE_LOOP_COEFS(WL(1,0,1,43),3,4,11,1,1,55,H)
C     Coefficient construction for loop diagram with ID 20
      CALL FFV2_3L2_1(PL(0,39),W(1,4),-GC_22,GC_23,MDL_MB,ZERO,PL(0,44)
     $ ,COEFS)
      CALL UPDATE_WL_2_1(WL(1,0,1,39),4,COEFS,4,4,WL(1,0,1,44))
      CALL FFV1L2_1(PL(0,44),W(1,11),GC_5,MDL_MB,ZERO,PL(0,45),COEFS)
      CALL UPDATE_WL_3_1(WL(1,0,1,44),4,COEFS,4,4,WL(1,0,1,45))
      CALL CREATE_LOOP_COEFS(WL(1,0,1,45),4,4,12,1,1,56,H)
C     Coefficient construction for loop diagram with ID 21
      CALL FFV2_3L2_1(PL(0,38),W(1,4),-GC_22,GC_23,MDL_MB,ZERO,PL(0,46)
     $ ,COEFS)
      CALL UPDATE_WL_1_1(WL(1,0,1,38),4,COEFS,4,4,WL(1,0,1,46))
      CALL FFS1L2_1(PL(0,46),W(1,3),GC_33,MDL_MB,ZERO,PL(0,47),COEFS)
      CALL UPDATE_WL_2_1(WL(1,0,1,46),4,COEFS,4,4,WL(1,0,1,47))
      CALL FFV1L2_1(PL(0,47),W(1,11),GC_5,MDL_MB,ZERO,PL(0,48),COEFS)
      CALL UPDATE_WL_3_1(WL(1,0,1,47),4,COEFS,4,4,WL(1,0,1,48))
      CALL CREATE_LOOP_COEFS(WL(1,0,1,48),4,4,13,1,1,57,H)
C     Coefficient construction for loop diagram with ID 22
      CALL FFV2_3L1_2(PL(0,41),W(1,7),-GC_22,GC_23,MDL_MB,ZERO,PL(0,49)
     $ ,COEFS)
      CALL UPDATE_WL_1_1(WL(1,0,1,41),4,COEFS,4,4,WL(1,0,1,49))
      CALL FFV1L1_2(PL(0,49),W(1,11),GC_5,MDL_MB,ZERO,PL(0,50),COEFS)
      CALL UPDATE_WL_2_1(WL(1,0,1,49),4,COEFS,4,4,WL(1,0,1,50))
      CALL CREATE_LOOP_COEFS(WL(1,0,1,50),3,4,14,1,1,58,H)
C     Coefficient construction for loop diagram with ID 23
      CALL FFV2_3L2_1(PL(0,38),W(1,7),-GC_22,GC_23,MDL_MB,ZERO,PL(0,51)
     $ ,COEFS)
      CALL UPDATE_WL_1_1(WL(1,0,1,38),4,COEFS,4,4,WL(1,0,1,51))
      CALL FFV1L2_1(PL(0,51),W(1,11),GC_5,MDL_MB,ZERO,PL(0,52),COEFS)
      CALL UPDATE_WL_2_1(WL(1,0,1,51),4,COEFS,4,4,WL(1,0,1,52))
      CALL CREATE_LOOP_COEFS(WL(1,0,1,52),3,4,14,1,1,59,H)
C     Coefficient construction for loop diagram with ID 24
      CALL FFV2_3L1_2(PL(0,42),W(1,4),-GC_22,GC_23,MDL_MB,ZERO,PL(0,53)
     $ ,COEFS)
      CALL UPDATE_WL_2_1(WL(1,0,1,42),4,COEFS,4,4,WL(1,0,1,53))
      CALL FFV1L1_2(PL(0,53),W(1,11),GC_5,MDL_MB,ZERO,PL(0,54),COEFS)
      CALL UPDATE_WL_3_1(WL(1,0,1,53),4,COEFS,4,4,WL(1,0,1,54))
      CALL CREATE_LOOP_COEFS(WL(1,0,1,54),4,4,12,1,1,60,H)
C     Coefficient construction for loop diagram with ID 25
      CALL FFV1L1_2(PL(0,42),W(1,11),GC_5,MDL_MB,ZERO,PL(0,55),COEFS)
      CALL UPDATE_WL_2_1(WL(1,0,1,42),4,COEFS,4,4,WL(1,0,1,55))
      CALL FFV2_3L1_2(PL(0,55),W(1,4),-GC_22,GC_23,MDL_MB,ZERO,PL(0,56)
     $ ,COEFS)
      CALL UPDATE_WL_3_1(WL(1,0,1,55),4,COEFS,4,4,WL(1,0,1,56))
      CALL CREATE_LOOP_COEFS(WL(1,0,1,56),4,4,15,1,1,61,H)
C     Coefficient construction for loop diagram with ID 26
      CALL FFV2_3L1_2(PL(0,41),W(1,4),-GC_22,GC_23,MDL_MB,ZERO,PL(0,57)
     $ ,COEFS)
      CALL UPDATE_WL_1_1(WL(1,0,1,41),4,COEFS,4,4,WL(1,0,1,57))
      CALL FFS1L1_2(PL(0,57),W(1,3),GC_33,MDL_MB,ZERO,PL(0,58),COEFS)
      CALL UPDATE_WL_2_1(WL(1,0,1,57),4,COEFS,4,4,WL(1,0,1,58))
      CALL FFV1L1_2(PL(0,58),W(1,11),GC_5,MDL_MB,ZERO,PL(0,59),COEFS)
      CALL UPDATE_WL_3_1(WL(1,0,1,58),4,COEFS,4,4,WL(1,0,1,59))
      CALL CREATE_LOOP_COEFS(WL(1,0,1,59),4,4,13,1,1,62,H)
C     Coefficient construction for loop diagram with ID 27
      CALL FFV1L2_1(PL(0,39),W(1,11),GC_5,MDL_MB,ZERO,PL(0,60),COEFS)
      CALL UPDATE_WL_2_1(WL(1,0,1,39),4,COEFS,4,4,WL(1,0,1,60))
      CALL FFV2_3L2_1(PL(0,60),W(1,4),-GC_22,GC_23,MDL_MB,ZERO,PL(0,61)
     $ ,COEFS)
      CALL UPDATE_WL_3_1(WL(1,0,1,60),4,COEFS,4,4,WL(1,0,1,61))
      CALL CREATE_LOOP_COEFS(WL(1,0,1,61),4,4,15,1,1,63,H)
C     Coefficient construction for loop diagram with ID 28
      CALL FFV1L1_2(PL(0,42),W(1,15),GC_5,MDL_MB,ZERO,PL(0,62),COEFS)
      CALL UPDATE_WL_2_1(WL(1,0,1,42),4,COEFS,4,4,WL(1,0,1,62))
      CALL CREATE_LOOP_COEFS(WL(1,0,1,62),3,4,11,1,1,64,H)
C     Coefficient construction for loop diagram with ID 29
      CALL FFV1L2_1(PL(0,39),W(1,15),GC_5,MDL_MB,ZERO,PL(0,63),COEFS)
      CALL UPDATE_WL_2_1(WL(1,0,1,39),4,COEFS,4,4,WL(1,0,1,63))
      CALL CREATE_LOOP_COEFS(WL(1,0,1,63),3,4,11,1,1,65,H)
C     Coefficient construction for loop diagram with ID 30
      CALL FFV1L2_1(PL(0,0),W(1,1),GC_5,MDL_MT,MDL_WT,PL(0,64),COEFS)
      CALL UPDATE_WL_0_1(WL(1,0,1,0),4,COEFS,4,4,WL(1,0,1,64))
      CALL FFS1L2_1(PL(0,64),W(1,3),GC_37,MDL_MT,MDL_WT,PL(0,65),COEFS)
      CALL UPDATE_WL_1_1(WL(1,0,1,64),4,COEFS,4,4,WL(1,0,1,65))
      CALL FFV1L2_1(PL(0,65),W(1,13),GC_5,MDL_MT,MDL_WT,PL(0,66),COEFS)
      CALL UPDATE_WL_2_1(WL(1,0,1,65),4,COEFS,4,4,WL(1,0,1,66))
      CALL CREATE_LOOP_COEFS(WL(1,0,1,66),3,4,16,1,1,66,H)
C     Coefficient construction for loop diagram with ID 31
      CALL FFV1L1_2(PL(0,0),W(1,1),GC_5,MDL_MT,MDL_WT,PL(0,67),COEFS)
      CALL UPDATE_WL_0_1(WL(1,0,1,0),4,COEFS,4,4,WL(1,0,1,67))
      CALL FFS1L1_2(PL(0,67),W(1,3),GC_37,MDL_MT,MDL_WT,PL(0,68),COEFS)
      CALL UPDATE_WL_1_1(WL(1,0,1,67),4,COEFS,4,4,WL(1,0,1,68))
      CALL FFV1L1_2(PL(0,68),W(1,13),GC_5,MDL_MT,MDL_WT,PL(0,69),COEFS)
      CALL UPDATE_WL_2_1(WL(1,0,1,68),4,COEFS,4,4,WL(1,0,1,69))
      CALL CREATE_LOOP_COEFS(WL(1,0,1,69),3,4,16,1,1,67,H)
C     Coefficient construction for loop diagram with ID 32
      CALL FFV2_5L2_1(PL(0,65),W(1,4),GC_22,GC_23,MDL_MT,MDL_WT,PL(0
     $ ,70),COEFS)
      CALL UPDATE_WL_2_1(WL(1,0,1,65),4,COEFS,4,4,WL(1,0,1,70))
      CALL FFV1L2_1(PL(0,70),W(1,11),GC_5,MDL_MT,MDL_WT,PL(0,71),COEFS)
      CALL UPDATE_WL_3_1(WL(1,0,1,70),4,COEFS,4,4,WL(1,0,1,71))
      CALL CREATE_LOOP_COEFS(WL(1,0,1,71),4,4,17,1,1,68,H)
C     Coefficient construction for loop diagram with ID 33
      CALL FFV2_5L2_1(PL(0,64),W(1,4),GC_22,GC_23,MDL_MT,MDL_WT,PL(0
     $ ,72),COEFS)
      CALL UPDATE_WL_1_1(WL(1,0,1,64),4,COEFS,4,4,WL(1,0,1,72))
      CALL FFS1L2_1(PL(0,72),W(1,3),GC_37,MDL_MT,MDL_WT,PL(0,73),COEFS)
      CALL UPDATE_WL_2_1(WL(1,0,1,72),4,COEFS,4,4,WL(1,0,1,73))
      CALL FFV1L2_1(PL(0,73),W(1,11),GC_5,MDL_MT,MDL_WT,PL(0,74),COEFS)
      CALL UPDATE_WL_3_1(WL(1,0,1,73),4,COEFS,4,4,WL(1,0,1,74))
      CALL CREATE_LOOP_COEFS(WL(1,0,1,74),4,4,18,1,1,69,H)
C     Coefficient construction for loop diagram with ID 34
      CALL FFV2_5L1_2(PL(0,67),W(1,7),GC_22,GC_23,MDL_MT,MDL_WT,PL(0
     $ ,75),COEFS)
      CALL UPDATE_WL_1_1(WL(1,0,1,67),4,COEFS,4,4,WL(1,0,1,75))
      CALL FFV1L1_2(PL(0,75),W(1,11),GC_5,MDL_MT,MDL_WT,PL(0,76),COEFS)
      CALL UPDATE_WL_2_1(WL(1,0,1,75),4,COEFS,4,4,WL(1,0,1,76))
      CALL CREATE_LOOP_COEFS(WL(1,0,1,76),3,4,19,1,1,70,H)
C     Coefficient construction for loop diagram with ID 35
      CALL FFV2_5L2_1(PL(0,64),W(1,7),GC_22,GC_23,MDL_MT,MDL_WT,PL(0
     $ ,77),COEFS)
      CALL UPDATE_WL_1_1(WL(1,0,1,64),4,COEFS,4,4,WL(1,0,1,77))
      CALL FFV1L2_1(PL(0,77),W(1,11),GC_5,MDL_MT,MDL_WT,PL(0,78),COEFS)
      CALL UPDATE_WL_2_1(WL(1,0,1,77),4,COEFS,4,4,WL(1,0,1,78))
      CALL CREATE_LOOP_COEFS(WL(1,0,1,78),3,4,19,1,1,71,H)
C     Coefficient construction for loop diagram with ID 36
      CALL FFV2_5L1_2(PL(0,68),W(1,4),GC_22,GC_23,MDL_MT,MDL_WT,PL(0
     $ ,79),COEFS)
      CALL UPDATE_WL_2_1(WL(1,0,1,68),4,COEFS,4,4,WL(1,0,1,79))
      CALL FFV1L1_2(PL(0,79),W(1,11),GC_5,MDL_MT,MDL_WT,PL(0,80),COEFS)
      CALL UPDATE_WL_3_1(WL(1,0,1,79),4,COEFS,4,4,WL(1,0,1,80))
      CALL CREATE_LOOP_COEFS(WL(1,0,1,80),4,4,17,1,1,72,H)
C     Coefficient construction for loop diagram with ID 37
      CALL FFV1L1_2(PL(0,68),W(1,11),GC_5,MDL_MT,MDL_WT,PL(0,81),COEFS)
      CALL UPDATE_WL_2_1(WL(1,0,1,68),4,COEFS,4,4,WL(1,0,1,81))
      CALL FFV2_5L1_2(PL(0,81),W(1,4),GC_22,GC_23,MDL_MT,MDL_WT,PL(0
     $ ,82),COEFS)
      CALL UPDATE_WL_3_1(WL(1,0,1,81),4,COEFS,4,4,WL(1,0,1,82))
      CALL CREATE_LOOP_COEFS(WL(1,0,1,82),4,4,20,1,1,73,H)
C     Coefficient construction for loop diagram with ID 38
      CALL FFV2_5L1_2(PL(0,67),W(1,4),GC_22,GC_23,MDL_MT,MDL_WT,PL(0
     $ ,83),COEFS)
      CALL UPDATE_WL_1_1(WL(1,0,1,67),4,COEFS,4,4,WL(1,0,1,83))
      CALL FFS1L1_2(PL(0,83),W(1,3),GC_37,MDL_MT,MDL_WT,PL(0,84),COEFS)
      CALL UPDATE_WL_2_1(WL(1,0,1,83),4,COEFS,4,4,WL(1,0,1,84))
      CALL FFV1L1_2(PL(0,84),W(1,11),GC_5,MDL_MT,MDL_WT,PL(0,85),COEFS)
      CALL UPDATE_WL_3_1(WL(1,0,1,84),4,COEFS,4,4,WL(1,0,1,85))
      CALL CREATE_LOOP_COEFS(WL(1,0,1,85),4,4,18,1,1,74,H)
C     Coefficient construction for loop diagram with ID 39
      CALL FFV1L2_1(PL(0,65),W(1,11),GC_5,MDL_MT,MDL_WT,PL(0,86),COEFS)
      CALL UPDATE_WL_2_1(WL(1,0,1,65),4,COEFS,4,4,WL(1,0,1,86))
      CALL FFV2_5L2_1(PL(0,86),W(1,4),GC_22,GC_23,MDL_MT,MDL_WT,PL(0
     $ ,87),COEFS)
      CALL UPDATE_WL_3_1(WL(1,0,1,86),4,COEFS,4,4,WL(1,0,1,87))
      CALL CREATE_LOOP_COEFS(WL(1,0,1,87),4,4,20,1,1,75,H)
C     Coefficient construction for loop diagram with ID 40
      CALL FFV1L1_2(PL(0,68),W(1,15),GC_5,MDL_MT,MDL_WT,PL(0,88),COEFS)
      CALL UPDATE_WL_2_1(WL(1,0,1,68),4,COEFS,4,4,WL(1,0,1,88))
      CALL CREATE_LOOP_COEFS(WL(1,0,1,88),3,4,16,1,1,76,H)
C     Coefficient construction for loop diagram with ID 41
      CALL FFV1L2_1(PL(0,65),W(1,15),GC_5,MDL_MT,MDL_WT,PL(0,89),COEFS)
      CALL UPDATE_WL_2_1(WL(1,0,1,65),4,COEFS,4,4,WL(1,0,1,89))
      CALL CREATE_LOOP_COEFS(WL(1,0,1,89),3,4,16,1,1,77,H)
C     At this point, all loop coefficients needed for (QCD=4), i.e. of
C      split order ID=1, are computed.
      IF(FILTER_SO.AND.SQSO_TARGET.EQ.1) GOTO 4000

      GOTO 1001
 4000 CONTINUE
      LOOP_REQ_SO_DONE=.TRUE.
 1001 CONTINUE
      END

