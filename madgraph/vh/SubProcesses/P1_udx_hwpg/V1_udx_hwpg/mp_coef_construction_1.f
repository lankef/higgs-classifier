      SUBROUTINE MP_COEF_CONSTRUCTION_1(P,NHEL,H,IC)
C     
      USE POLYNOMIAL_CONSTANTS
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
      REAL*16     ZERO
      PARAMETER (ZERO=0.0E0_16)
      COMPLEX*32     IZERO
      PARAMETER (IZERO=CMPLX(0.0E0_16,0.0E0_16,KIND=16))
C     These are constants related to the split orders
      INTEGER    NSO, NSQUAREDSO, NAMPSO
      PARAMETER (NSO=1, NSQUAREDSO=1, NAMPSO=2)
C     
C     ARGUMENTS
C     
      REAL*16 P(0:3,NEXTERNAL)
      INTEGER NHEL(NEXTERNAL), IC(NEXTERNAL)
      INTEGER H
C     
C     LOCAL VARIABLES
C     
      INTEGER I,J,K
      COMPLEX*32 COEFS(MAXLWFSIZE,0:VERTEXMAXCOEFS-1,MAXLWFSIZE)
C     
C     GLOBAL VARIABLES
C     
      INCLUDE 'mp_coupl_same_name.inc'

      INTEGER GOODHEL(NCOMB)
      LOGICAL GOODAMP(NSQUAREDSO,NLOOPGROUPS)
      COMMON/FILTERS/GOODAMP,GOODHEL

      INTEGER SQSO_TARGET
      COMMON/SOCHOICE/SQSO_TARGET

      LOGICAL UVCT_REQ_SO_DONE,MP_UVCT_REQ_SO_DONE,CT_REQ_SO_DONE
     $ ,MP_CT_REQ_SO_DONE,LOOP_REQ_SO_DONE,MP_LOOP_REQ_SO_DONE
     $ ,CTCALL_REQ_SO_DONE,FILTER_SO
      COMMON/SO_REQS/UVCT_REQ_SO_DONE,MP_UVCT_REQ_SO_DONE
     $ ,CT_REQ_SO_DONE,MP_CT_REQ_SO_DONE,LOOP_REQ_SO_DONE
     $ ,MP_LOOP_REQ_SO_DONE,CTCALL_REQ_SO_DONE,FILTER_SO

      COMPLEX*32 AMP(NBORNAMPS)
      COMMON/MP_AMPS/AMP
      COMPLEX*32 W(20,NWAVEFUNCS)
      COMMON/MP_W/W

      COMPLEX*32 WL(MAXLWFSIZE,0:LOOPMAXCOEFS-1,MAXLWFSIZE,
     $ -1:NLOOPWAVEFUNCS)
      COMPLEX*32 PL(0:3,-1:NLOOPWAVEFUNCS)
      COMMON/MP_WL/WL,PL

      COMPLEX*32 AMPL(3,NCTAMPS)
      COMMON/MP_AMPL/AMPL

C     
C     ----------
C     BEGIN CODE
C     ----------

C     The target squared split order contribution is already reached
C      if true.
      IF (FILTER_SO.AND.MP_LOOP_REQ_SO_DONE) THEN
        GOTO 1001
      ENDIF

C     Coefficient construction for loop diagram with ID 3
      CALL MP_FFV1L3_1(PL(0,0),W(1,2),GC_5,ZERO,ZERO,PL(0,1),COEFS)
      CALL MP_UPDATE_WL_0_1(WL(1,0,1,0),4,COEFS,4,4,WL(1,0,1,1))
      CALL MP_FFV2L2_1(PL(0,1),W(1,7),GC_47,ZERO,ZERO,PL(0,2),COEFS)
      CALL MP_UPDATE_WL_1_1(WL(1,0,1,1),4,COEFS,4,4,WL(1,0,1,2))
      CALL MP_FFV1L2P0_3(PL(0,2),W(1,6),GC_5,ZERO,ZERO,PL(0,3),COEFS)
      CALL MP_UPDATE_WL_2_0(WL(1,0,1,2),4,COEFS,4,4,WL(1,0,1,3))
      CALL MP_CREATE_LOOP_COEFS(WL(1,0,1,3),2,4,1,1,1,33,H)
C     Coefficient construction for loop diagram with ID 4
      CALL MP_FFV1L1P0_3(PL(0,0),W(1,8),GC_5,ZERO,ZERO,PL(0,4),COEFS)
      CALL MP_UPDATE_WL_0_0(WL(1,0,1,0),4,COEFS,4,4,WL(1,0,1,4))
      CALL MP_FFV1L3_2(PL(0,4),W(1,9),GC_5,ZERO,ZERO,PL(0,5),COEFS)
      CALL MP_UPDATE_WL_0_1(WL(1,0,1,4),4,COEFS,4,4,WL(1,0,1,5))
      CALL MP_CREATE_LOOP_COEFS(WL(1,0,1,5),1,4,2,1,1,34,H)
C     Coefficient construction for loop diagram with ID 5
      CALL MP_FFV1L3_2(PL(0,0),W(1,1),GC_5,ZERO,ZERO,PL(0,6),COEFS)
      CALL MP_UPDATE_WL_0_1(WL(1,0,1,0),4,COEFS,4,4,WL(1,0,1,6))
      CALL MP_FFV2L1_2(PL(0,6),W(1,7),GC_47,ZERO,ZERO,PL(0,7),COEFS)
      CALL MP_UPDATE_WL_1_1(WL(1,0,1,6),4,COEFS,4,4,WL(1,0,1,7))
      CALL MP_FFV1L1P0_3(PL(0,7),W(1,8),GC_5,ZERO,ZERO,PL(0,8),COEFS)
      CALL MP_UPDATE_WL_2_0(WL(1,0,1,7),4,COEFS,4,4,WL(1,0,1,8))
      CALL MP_CREATE_LOOP_COEFS(WL(1,0,1,8),2,4,3,1,1,35,H)
C     Coefficient construction for loop diagram with ID 6
      CALL MP_FFV1L2P0_3(PL(0,0),W(1,1),GC_5,ZERO,ZERO,PL(0,9),COEFS)
      CALL MP_UPDATE_WL_0_0(WL(1,0,1,0),4,COEFS,4,4,WL(1,0,1,9))
      CALL MP_FFV1L3_1(PL(0,9),W(1,2),GC_5,ZERO,ZERO,PL(0,10),COEFS)
      CALL MP_UPDATE_WL_0_1(WL(1,0,1,9),4,COEFS,4,4,WL(1,0,1,10))
      CALL MP_FFV2L2_1(PL(0,10),W(1,7),GC_47,ZERO,ZERO,PL(0,11),COEFS)
      CALL MP_UPDATE_WL_1_1(WL(1,0,1,10),4,COEFS,4,4,WL(1,0,1,11))
      CALL MP_FFV1L2_1(PL(0,11),W(1,5),GC_5,ZERO,ZERO,PL(0,12),COEFS)
      CALL MP_UPDATE_WL_2_1(WL(1,0,1,11),4,COEFS,4,4,WL(1,0,1,12))
      CALL MP_CREATE_LOOP_COEFS(WL(1,0,1,12),3,4,4,1,1,36,H)
C     Coefficient construction for loop diagram with ID 7
      CALL MP_FFV1L1P0_3(PL(0,0),W(1,2),GC_5,ZERO,ZERO,PL(0,13),COEFS)
      CALL MP_UPDATE_WL_0_0(WL(1,0,1,0),4,COEFS,4,4,WL(1,0,1,13))
      CALL MP_VVV1L2P0_1(PL(0,13),W(1,5),GC_4,ZERO,ZERO,PL(0,14),COEFS)
      CALL MP_UPDATE_WL_0_1(WL(1,0,1,13),4,COEFS,4,4,WL(1,0,1,14))
      CALL MP_FFV1L3_2(PL(0,14),W(1,9),GC_5,ZERO,ZERO,PL(0,15),COEFS)
      CALL MP_UPDATE_WL_1_1(WL(1,0,1,14),4,COEFS,4,4,WL(1,0,1,15))
      CALL MP_CREATE_LOOP_COEFS(WL(1,0,1,15),2,4,5,1,1,37,H)
C     Coefficient construction for loop diagram with ID 8
      CALL MP_VVV1L2P0_1(PL(0,9),W(1,5),GC_4,ZERO,ZERO,PL(0,16),COEFS)
      CALL MP_UPDATE_WL_0_1(WL(1,0,1,9),4,COEFS,4,4,WL(1,0,1,16))
      CALL MP_FFV1L3_1(PL(0,16),W(1,2),GC_5,ZERO,ZERO,PL(0,17),COEFS)
      CALL MP_UPDATE_WL_1_1(WL(1,0,1,16),4,COEFS,4,4,WL(1,0,1,17))
      CALL MP_FFV2L2_1(PL(0,17),W(1,7),GC_47,ZERO,ZERO,PL(0,18),COEFS)
      CALL MP_UPDATE_WL_2_1(WL(1,0,1,17),4,COEFS,4,4,WL(1,0,1,18))
      CALL MP_CREATE_LOOP_COEFS(WL(1,0,1,18),3,4,6,1,1,38,H)
C     Coefficient construction for loop diagram with ID 9
      CALL MP_FFV1L2_1(PL(0,10),W(1,5),GC_5,ZERO,ZERO,PL(0,19),COEFS)
      CALL MP_UPDATE_WL_1_1(WL(1,0,1,10),4,COEFS,4,4,WL(1,0,1,19))
      CALL MP_FFV2L2_1(PL(0,19),W(1,7),GC_47,ZERO,ZERO,PL(0,20),COEFS)
      CALL MP_UPDATE_WL_2_1(WL(1,0,1,19),4,COEFS,4,4,WL(1,0,1,20))
      CALL MP_CREATE_LOOP_COEFS(WL(1,0,1,20),3,4,7,1,1,39,H)
C     Coefficient construction for loop diagram with ID 10
      CALL MP_FFV1L2_1(PL(0,1),W(1,5),GC_5,ZERO,ZERO,PL(0,21),COEFS)
      CALL MP_UPDATE_WL_1_1(WL(1,0,1,1),4,COEFS,4,4,WL(1,0,1,21))
      CALL MP_FFV1L2P0_3(PL(0,21),W(1,9),GC_5,ZERO,ZERO,PL(0,22),COEFS)
      CALL MP_UPDATE_WL_2_0(WL(1,0,1,21),4,COEFS,4,4,WL(1,0,1,22))
      CALL MP_CREATE_LOOP_COEFS(WL(1,0,1,22),2,4,5,1,1,40,H)
C     Coefficient construction for loop diagram with ID 11
      CALL MP_FFV1L2P0_3(PL(0,0),W(1,6),GC_5,ZERO,ZERO,PL(0,23),COEFS)
      CALL MP_UPDATE_WL_0_0(WL(1,0,1,0),4,COEFS,4,4,WL(1,0,1,23))
      CALL MP_FFV1L3_1(PL(0,23),W(1,10),GC_5,ZERO,ZERO,PL(0,24),COEFS)
      CALL MP_UPDATE_WL_0_1(WL(1,0,1,23),4,COEFS,4,4,WL(1,0,1,24))
      CALL MP_CREATE_LOOP_COEFS(WL(1,0,1,24),1,4,8,1,1,41,H)
C     Coefficient construction for loop diagram with ID 12
      CALL MP_FFV1L3_1(PL(0,16),W(1,10),GC_5,ZERO,ZERO,PL(0,25),COEFS)
      CALL MP_UPDATE_WL_1_1(WL(1,0,1,16),4,COEFS,4,4,WL(1,0,1,25))
      CALL MP_CREATE_LOOP_COEFS(WL(1,0,1,25),2,4,9,1,1,42,H)
C     Coefficient construction for loop diagram with ID 13
      CALL MP_FFV1L1_2(PL(0,6),W(1,5),GC_5,ZERO,ZERO,PL(0,26),COEFS)
      CALL MP_UPDATE_WL_1_1(WL(1,0,1,6),4,COEFS,4,4,WL(1,0,1,26))
      CALL MP_FFV1L1P0_3(PL(0,26),W(1,10),GC_5,ZERO,ZERO,PL(0,27)
     $ ,COEFS)
      CALL MP_UPDATE_WL_2_0(WL(1,0,1,26),4,COEFS,4,4,WL(1,0,1,27))
      CALL MP_CREATE_LOOP_COEFS(WL(1,0,1,27),2,4,9,1,1,43,H)
C     Coefficient construction for loop diagram with ID 14
      CALL MP_FFS1L2_1(PL(0,0),W(1,3),GC_33,MDL_MB,ZERO,PL(0,28),COEFS)
      CALL MP_UPDATE_WL_0_1(WL(1,0,1,0),4,COEFS,4,4,WL(1,0,1,28))
      CALL MP_FFV1L2_1(PL(0,28),W(1,5),GC_5,MDL_MB,ZERO,PL(0,29),COEFS)
      CALL MP_UPDATE_WL_1_1(WL(1,0,1,28),4,COEFS,4,4,WL(1,0,1,29))
      CALL MP_FFV1L2_1(PL(0,29),W(1,12),GC_5,MDL_MB,ZERO,PL(0,30)
     $ ,COEFS)
      CALL MP_UPDATE_WL_2_1(WL(1,0,1,29),4,COEFS,4,4,WL(1,0,1,30))
      CALL MP_CREATE_LOOP_COEFS(WL(1,0,1,30),3,4,10,1,1,44,H)
C     Coefficient construction for loop diagram with ID 15
      CALL MP_FFS1L1_2(PL(0,0),W(1,3),GC_33,MDL_MB,ZERO,PL(0,31),COEFS)
      CALL MP_UPDATE_WL_0_1(WL(1,0,1,0),4,COEFS,4,4,WL(1,0,1,31))
      CALL MP_FFV1L1_2(PL(0,31),W(1,5),GC_5,MDL_MB,ZERO,PL(0,32),COEFS)
      CALL MP_UPDATE_WL_1_1(WL(1,0,1,31),4,COEFS,4,4,WL(1,0,1,32))
      CALL MP_FFV1L1_2(PL(0,32),W(1,12),GC_5,MDL_MB,ZERO,PL(0,33)
     $ ,COEFS)
      CALL MP_UPDATE_WL_2_1(WL(1,0,1,32),4,COEFS,4,4,WL(1,0,1,33))
      CALL MP_CREATE_LOOP_COEFS(WL(1,0,1,33),3,4,10,1,1,45,H)
C     Coefficient construction for loop diagram with ID 16
      CALL MP_FFV1L2_1(PL(0,29),W(1,14),GC_5,MDL_MB,ZERO,PL(0,34)
     $ ,COEFS)
      CALL MP_UPDATE_WL_2_1(WL(1,0,1,29),4,COEFS,4,4,WL(1,0,1,34))
      CALL MP_CREATE_LOOP_COEFS(WL(1,0,1,34),3,4,10,1,1,46,H)
C     Coefficient construction for loop diagram with ID 17
      CALL MP_FFV1L1_2(PL(0,32),W(1,14),GC_5,MDL_MB,ZERO,PL(0,35)
     $ ,COEFS)
      CALL MP_UPDATE_WL_2_1(WL(1,0,1,32),4,COEFS,4,4,WL(1,0,1,35))
      CALL MP_CREATE_LOOP_COEFS(WL(1,0,1,35),3,4,10,1,1,47,H)
C     Coefficient construction for loop diagram with ID 18
      CALL MP_FFS1L2_1(PL(0,0),W(1,3),GC_37,MDL_MT,MDL_WT,PL(0,36)
     $ ,COEFS)
      CALL MP_UPDATE_WL_0_1(WL(1,0,1,0),4,COEFS,4,4,WL(1,0,1,36))
      CALL MP_FFV1L2_1(PL(0,36),W(1,5),GC_5,MDL_MT,MDL_WT,PL(0,37)
     $ ,COEFS)
      CALL MP_UPDATE_WL_1_1(WL(1,0,1,36),4,COEFS,4,4,WL(1,0,1,37))
      CALL MP_FFV1L2_1(PL(0,37),W(1,12),GC_5,MDL_MT,MDL_WT,PL(0,38)
     $ ,COEFS)
      CALL MP_UPDATE_WL_2_1(WL(1,0,1,37),4,COEFS,4,4,WL(1,0,1,38))
      CALL MP_CREATE_LOOP_COEFS(WL(1,0,1,38),3,4,11,1,1,48,H)
C     Coefficient construction for loop diagram with ID 19
      CALL MP_FFS1L1_2(PL(0,0),W(1,3),GC_37,MDL_MT,MDL_WT,PL(0,39)
     $ ,COEFS)
      CALL MP_UPDATE_WL_0_1(WL(1,0,1,0),4,COEFS,4,4,WL(1,0,1,39))
      CALL MP_FFV1L1_2(PL(0,39),W(1,5),GC_5,MDL_MT,MDL_WT,PL(0,40)
     $ ,COEFS)
      CALL MP_UPDATE_WL_1_1(WL(1,0,1,39),4,COEFS,4,4,WL(1,0,1,40))
      CALL MP_FFV1L1_2(PL(0,40),W(1,12),GC_5,MDL_MT,MDL_WT,PL(0,41)
     $ ,COEFS)
      CALL MP_UPDATE_WL_2_1(WL(1,0,1,40),4,COEFS,4,4,WL(1,0,1,41))
      CALL MP_CREATE_LOOP_COEFS(WL(1,0,1,41),3,4,11,1,1,49,H)
C     Coefficient construction for loop diagram with ID 20
      CALL MP_FFV1L2_1(PL(0,37),W(1,14),GC_5,MDL_MT,MDL_WT,PL(0,42)
     $ ,COEFS)
      CALL MP_UPDATE_WL_2_1(WL(1,0,1,37),4,COEFS,4,4,WL(1,0,1,42))
      CALL MP_CREATE_LOOP_COEFS(WL(1,0,1,42),3,4,11,1,1,50,H)
C     Coefficient construction for loop diagram with ID 21
      CALL MP_FFV1L1_2(PL(0,40),W(1,14),GC_5,MDL_MT,MDL_WT,PL(0,43)
     $ ,COEFS)
      CALL MP_UPDATE_WL_2_1(WL(1,0,1,40),4,COEFS,4,4,WL(1,0,1,43))
      CALL MP_CREATE_LOOP_COEFS(WL(1,0,1,43),3,4,11,1,1,51,H)
C     At this point, all loop coefficients needed for (QCD=4), i.e. of
C      split order ID=1, are computed.
      IF(FILTER_SO.AND.SQSO_TARGET.EQ.1) GOTO 4000

      GOTO 1001
 4000 CONTINUE
      MP_LOOP_REQ_SO_DONE=.TRUE.
 1001 CONTINUE
      END

