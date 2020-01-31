      SUBROUTINE ML5_0_4_6_MP_COEF_CONSTRUCTION_1(P,NHEL,H,IC)
C     
      USE ML5_0_4_6_POLYNOMIAL_CONSTANTS
      IMPLICIT NONE
C     
C     CONSTANTS
C     
      INTEGER    NEXTERNAL
      PARAMETER (NEXTERNAL=5)
      INTEGER    NCOMB
      PARAMETER (NCOMB=16)

      INTEGER    NLOOPS, NLOOPGROUPS, NCTAMPS
      PARAMETER (NLOOPS=4, NLOOPGROUPS=4, NCTAMPS=2)
      INTEGER    NLOOPAMPS
      PARAMETER (NLOOPAMPS=6)
      INTEGER    NWAVEFUNCS,NLOOPWAVEFUNCS
      PARAMETER (NWAVEFUNCS=7,NLOOPWAVEFUNCS=12)
      REAL*16     ZERO
      PARAMETER (ZERO=0.0E0_16)
      COMPLEX*32     IZERO
      PARAMETER (IZERO=CMPLX(0.0E0_16,0.0E0_16,KIND=16))
C     These are constants related to the split orders
      INTEGER    NSO, NSQUAREDSO, NAMPSO
      PARAMETER (NSO=1, NSQUAREDSO=1, NAMPSO=1)
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
      COMMON/ML5_0_4_6_FILTERS/GOODAMP,GOODHEL

      INTEGER SQSO_TARGET
      COMMON/ML5_0_4_6_SOCHOICE/SQSO_TARGET

      LOGICAL UVCT_REQ_SO_DONE,MP_UVCT_REQ_SO_DONE,CT_REQ_SO_DONE
     $ ,MP_CT_REQ_SO_DONE,LOOP_REQ_SO_DONE,MP_LOOP_REQ_SO_DONE
     $ ,CTCALL_REQ_SO_DONE,FILTER_SO
      COMMON/ML5_0_4_6_SO_REQS/UVCT_REQ_SO_DONE,MP_UVCT_REQ_SO_DONE
     $ ,CT_REQ_SO_DONE,MP_CT_REQ_SO_DONE,LOOP_REQ_SO_DONE
     $ ,MP_LOOP_REQ_SO_DONE,CTCALL_REQ_SO_DONE,FILTER_SO

      COMPLEX*32 W(20,NWAVEFUNCS)
      COMMON/ML5_0_4_6_MP_W/W

      COMPLEX*32 WL(MAXLWFSIZE,0:LOOPMAXCOEFS-1,MAXLWFSIZE,
     $ -1:NLOOPWAVEFUNCS)
      COMPLEX*32 PL(0:3,-1:NLOOPWAVEFUNCS)
      COMMON/ML5_0_4_6_MP_WL/WL,PL

      COMPLEX*32 AMPL(3,NLOOPAMPS)
      COMMON/ML5_0_4_6_MP_AMPL/AMPL

C     
C     ----------
C     BEGIN CODE
C     ----------

C     The target squared split order contribution is already reached
C      if true.
      IF (FILTER_SO.AND.MP_LOOP_REQ_SO_DONE) THEN
        GOTO 1001
      ENDIF

C     Coefficient construction for loop diagram with ID 1
      CALL MP_FFS1L1_2(PL(0,0),W(1,3),GC_33,MDL_MB,ZERO,PL(0,1),COEFS)
      CALL MP_ML5_0_4_6_UPDATE_WL_0_1(WL(1,0,1,0),4,COEFS,4,4,WL(1,0,1
     $ ,1))
      CALL MP_FFV1L1_2(PL(0,1),W(1,6),GC_5,MDL_MB,ZERO,PL(0,2),COEFS)
      CALL MP_ML5_0_4_6_UPDATE_WL_1_1(WL(1,0,1,1),4,COEFS,4,4,WL(1,0,1
     $ ,2))
      CALL MP_FFV1L1_2(PL(0,2),W(1,7),GC_5,MDL_MB,ZERO,PL(0,3),COEFS)
      CALL MP_ML5_0_4_6_UPDATE_WL_2_1(WL(1,0,1,2),4,COEFS,4,4,WL(1,0,1
     $ ,3))
      CALL MP_ML5_0_4_6_CREATE_LOOP_COEFS(WL(1,0,1,3),3,4,1,1,1,3)
C     Coefficient construction for loop diagram with ID 2
      CALL MP_FFS1L2_1(PL(0,0),W(1,3),GC_33,MDL_MB,ZERO,PL(0,4),COEFS)
      CALL MP_ML5_0_4_6_UPDATE_WL_0_1(WL(1,0,1,0),4,COEFS,4,4,WL(1,0,1
     $ ,4))
      CALL MP_FFV1L2_1(PL(0,4),W(1,6),GC_5,MDL_MB,ZERO,PL(0,5),COEFS)
      CALL MP_ML5_0_4_6_UPDATE_WL_1_1(WL(1,0,1,4),4,COEFS,4,4,WL(1,0,1
     $ ,5))
      CALL MP_FFV1L2_1(PL(0,5),W(1,7),GC_5,MDL_MB,ZERO,PL(0,6),COEFS)
      CALL MP_ML5_0_4_6_UPDATE_WL_2_1(WL(1,0,1,5),4,COEFS,4,4,WL(1,0,1
     $ ,6))
      CALL MP_ML5_0_4_6_CREATE_LOOP_COEFS(WL(1,0,1,6),3,4,2,1,1,4)
C     Coefficient construction for loop diagram with ID 3
      CALL MP_FFS1L1_2(PL(0,0),W(1,3),GC_37,MDL_MT,MDL_WT,PL(0,7)
     $ ,COEFS)
      CALL MP_ML5_0_4_6_UPDATE_WL_0_1(WL(1,0,1,0),4,COEFS,4,4,WL(1,0,1
     $ ,7))
      CALL MP_FFV1L1_2(PL(0,7),W(1,6),GC_5,MDL_MT,MDL_WT,PL(0,8),COEFS)
      CALL MP_ML5_0_4_6_UPDATE_WL_1_1(WL(1,0,1,7),4,COEFS,4,4,WL(1,0,1
     $ ,8))
      CALL MP_FFV1L1_2(PL(0,8),W(1,7),GC_5,MDL_MT,MDL_WT,PL(0,9),COEFS)
      CALL MP_ML5_0_4_6_UPDATE_WL_2_1(WL(1,0,1,8),4,COEFS,4,4,WL(1,0,1
     $ ,9))
      CALL MP_ML5_0_4_6_CREATE_LOOP_COEFS(WL(1,0,1,9),3,4,3,1,1,5)
C     Coefficient construction for loop diagram with ID 4
      CALL MP_FFS1L2_1(PL(0,0),W(1,3),GC_37,MDL_MT,MDL_WT,PL(0,10)
     $ ,COEFS)
      CALL MP_ML5_0_4_6_UPDATE_WL_0_1(WL(1,0,1,0),4,COEFS,4,4,WL(1,0,1
     $ ,10))
      CALL MP_FFV1L2_1(PL(0,10),W(1,6),GC_5,MDL_MT,MDL_WT,PL(0,11)
     $ ,COEFS)
      CALL MP_ML5_0_4_6_UPDATE_WL_1_1(WL(1,0,1,10),4,COEFS,4,4,WL(1,0
     $ ,1,11))
      CALL MP_FFV1L2_1(PL(0,11),W(1,7),GC_5,MDL_MT,MDL_WT,PL(0,12)
     $ ,COEFS)
      CALL MP_ML5_0_4_6_UPDATE_WL_2_1(WL(1,0,1,11),4,COEFS,4,4,WL(1,0
     $ ,1,12))
      CALL MP_ML5_0_4_6_CREATE_LOOP_COEFS(WL(1,0,1,12),3,4,4,1,1,6)
C     At this point, all loop coefficients needed for (QCD=8), i.e. of
C      split order ID=1, are computed.
      IF(FILTER_SO.AND.SQSO_TARGET.EQ.1) GOTO 4000

      GOTO 1001
 4000 CONTINUE
      MP_LOOP_REQ_SO_DONE=.TRUE.
 1001 CONTINUE
      END

