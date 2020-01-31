      SUBROUTINE ML5_0_4_3_COEF_CONSTRUCTION_1(P,NHEL,H,IC)
C     
C     Modules
C     
      USE ML5_0_4_3_POLYNOMIAL_CONSTANTS
C     
      IMPLICIT NONE
C     
C     CONSTANTS
C     
      INTEGER    NEXTERNAL
      PARAMETER (NEXTERNAL=5)
      INTEGER    NCOMB
      PARAMETER (NCOMB=16)
      INTEGER    NLOOPS, NLOOPGROUPS, NCTAMPS
      PARAMETER (NLOOPS=8, NLOOPGROUPS=8, NCTAMPS=4)
      INTEGER    NLOOPAMPS
      PARAMETER (NLOOPAMPS=12)
      INTEGER    NWAVEFUNCS,NLOOPWAVEFUNCS
      PARAMETER (NWAVEFUNCS=9,NLOOPWAVEFUNCS=20)
      REAL*8     ZERO
      PARAMETER (ZERO=0D0)
      REAL*16     MP__ZERO
      PARAMETER (MP__ZERO=0.0E0_16)
C     These are constants related to the split orders
      INTEGER    NSO, NSQUAREDSO, NAMPSO
      PARAMETER (NSO=1, NSQUAREDSO=1, NAMPSO=1)
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
      COMMON/ML5_0_4_3_FILTERS/GOODAMP,GOODHEL,HELOFFSET

      LOGICAL CHECKPHASE
      LOGICAL HELDOUBLECHECKED
      COMMON/ML5_0_4_3_INIT/CHECKPHASE, HELDOUBLECHECKED

      INTEGER SQSO_TARGET
      COMMON/ML5_0_4_3_SOCHOICE/SQSO_TARGET

      LOGICAL UVCT_REQ_SO_DONE,MP_UVCT_REQ_SO_DONE,CT_REQ_SO_DONE
     $ ,MP_CT_REQ_SO_DONE,LOOP_REQ_SO_DONE,MP_LOOP_REQ_SO_DONE
     $ ,CTCALL_REQ_SO_DONE,FILTER_SO
      COMMON/ML5_0_4_3_SO_REQS/UVCT_REQ_SO_DONE,MP_UVCT_REQ_SO_DONE
     $ ,CT_REQ_SO_DONE,MP_CT_REQ_SO_DONE,LOOP_REQ_SO_DONE
     $ ,MP_LOOP_REQ_SO_DONE,CTCALL_REQ_SO_DONE,FILTER_SO

      INTEGER I_SO
      COMMON/ML5_0_4_3_I_SO/I_SO
      INTEGER I_LIB
      COMMON/ML5_0_4_3_I_LIB/I_LIB

      COMPLEX*16 W(20,NWAVEFUNCS)
      COMMON/ML5_0_4_3_W/W

      COMPLEX*16 WL(MAXLWFSIZE,0:LOOPMAXCOEFS-1,MAXLWFSIZE,
     $ -1:NLOOPWAVEFUNCS)
      COMPLEX*16 PL(0:3,-1:NLOOPWAVEFUNCS)
      COMMON/ML5_0_4_3_WL/WL,PL

      COMPLEX*16 AMPL(3,NLOOPAMPS)
      COMMON/ML5_0_4_3_AMPL/AMPL

C     
C     ----------
C     BEGIN CODE
C     ----------

C     The target squared split order contribution is already reached
C      if true.
      IF (FILTER_SO.AND.LOOP_REQ_SO_DONE) THEN
        GOTO 1001
      ENDIF

C     Coefficient construction for loop diagram with ID 1
      CALL FFS1L1_2(PL(0,0),W(1,3),GC_33,MDL_MB,ZERO,PL(0,1),COEFS)
      CALL ML5_0_4_3_UPDATE_WL_0_1(WL(1,0,1,0),4,COEFS,4,4,WL(1,0,1,1))
      CALL FFV1L1_2(PL(0,1),W(1,6),GC_5,MDL_MB,ZERO,PL(0,2),COEFS)
      CALL ML5_0_4_3_UPDATE_WL_1_1(WL(1,0,1,1),4,COEFS,4,4,WL(1,0,1,2))
      CALL FFV1L1_2(PL(0,2),W(1,7),GC_5,MDL_MB,ZERO,PL(0,3),COEFS)
      CALL ML5_0_4_3_UPDATE_WL_2_1(WL(1,0,1,2),4,COEFS,4,4,WL(1,0,1,3))
      CALL ML5_0_4_3_CREATE_LOOP_COEFS(WL(1,0,1,3),3,4,1,1,1,5)
C     Coefficient construction for loop diagram with ID 2
      CALL FFS1L2_1(PL(0,0),W(1,3),GC_33,MDL_MB,ZERO,PL(0,4),COEFS)
      CALL ML5_0_4_3_UPDATE_WL_0_1(WL(1,0,1,0),4,COEFS,4,4,WL(1,0,1,4))
      CALL FFV1L2_1(PL(0,4),W(1,6),GC_5,MDL_MB,ZERO,PL(0,5),COEFS)
      CALL ML5_0_4_3_UPDATE_WL_1_1(WL(1,0,1,4),4,COEFS,4,4,WL(1,0,1,5))
      CALL FFV1L2_1(PL(0,5),W(1,7),GC_5,MDL_MB,ZERO,PL(0,6),COEFS)
      CALL ML5_0_4_3_UPDATE_WL_2_1(WL(1,0,1,5),4,COEFS,4,4,WL(1,0,1,6))
      CALL ML5_0_4_3_CREATE_LOOP_COEFS(WL(1,0,1,6),3,4,2,1,1,6)
C     Coefficient construction for loop diagram with ID 3
      CALL FFV1L2_1(PL(0,4),W(1,8),GC_5,MDL_MB,ZERO,PL(0,7),COEFS)
      CALL ML5_0_4_3_UPDATE_WL_1_1(WL(1,0,1,4),4,COEFS,4,4,WL(1,0,1,7))
      CALL FFV1L2_1(PL(0,7),W(1,9),GC_5,MDL_MB,ZERO,PL(0,8),COEFS)
      CALL ML5_0_4_3_UPDATE_WL_2_1(WL(1,0,1,7),4,COEFS,4,4,WL(1,0,1,8))
      CALL ML5_0_4_3_CREATE_LOOP_COEFS(WL(1,0,1,8),3,4,3,1,1,7)
C     Coefficient construction for loop diagram with ID 4
      CALL FFV1L1_2(PL(0,1),W(1,8),GC_5,MDL_MB,ZERO,PL(0,9),COEFS)
      CALL ML5_0_4_3_UPDATE_WL_1_1(WL(1,0,1,1),4,COEFS,4,4,WL(1,0,1,9))
      CALL FFV1L1_2(PL(0,9),W(1,9),GC_5,MDL_MB,ZERO,PL(0,10),COEFS)
      CALL ML5_0_4_3_UPDATE_WL_2_1(WL(1,0,1,9),4,COEFS,4,4,WL(1,0,1,10)
     $ )
      CALL ML5_0_4_3_CREATE_LOOP_COEFS(WL(1,0,1,10),3,4,4,1,1,8)
C     Coefficient construction for loop diagram with ID 5
      CALL FFS1L1_2(PL(0,0),W(1,3),GC_37,MDL_MT,MDL_WT,PL(0,11),COEFS)
      CALL ML5_0_4_3_UPDATE_WL_0_1(WL(1,0,1,0),4,COEFS,4,4,WL(1,0,1,11)
     $ )
      CALL FFV1L1_2(PL(0,11),W(1,6),GC_5,MDL_MT,MDL_WT,PL(0,12),COEFS)
      CALL ML5_0_4_3_UPDATE_WL_1_1(WL(1,0,1,11),4,COEFS,4,4,WL(1,0,1
     $ ,12))
      CALL FFV1L1_2(PL(0,12),W(1,7),GC_5,MDL_MT,MDL_WT,PL(0,13),COEFS)
      CALL ML5_0_4_3_UPDATE_WL_2_1(WL(1,0,1,12),4,COEFS,4,4,WL(1,0,1
     $ ,13))
      CALL ML5_0_4_3_CREATE_LOOP_COEFS(WL(1,0,1,13),3,4,5,1,1,9)
C     Coefficient construction for loop diagram with ID 6
      CALL FFS1L2_1(PL(0,0),W(1,3),GC_37,MDL_MT,MDL_WT,PL(0,14),COEFS)
      CALL ML5_0_4_3_UPDATE_WL_0_1(WL(1,0,1,0),4,COEFS,4,4,WL(1,0,1,14)
     $ )
      CALL FFV1L2_1(PL(0,14),W(1,6),GC_5,MDL_MT,MDL_WT,PL(0,15),COEFS)
      CALL ML5_0_4_3_UPDATE_WL_1_1(WL(1,0,1,14),4,COEFS,4,4,WL(1,0,1
     $ ,15))
      CALL FFV1L2_1(PL(0,15),W(1,7),GC_5,MDL_MT,MDL_WT,PL(0,16),COEFS)
      CALL ML5_0_4_3_UPDATE_WL_2_1(WL(1,0,1,15),4,COEFS,4,4,WL(1,0,1
     $ ,16))
      CALL ML5_0_4_3_CREATE_LOOP_COEFS(WL(1,0,1,16),3,4,6,1,1,10)
C     Coefficient construction for loop diagram with ID 7
      CALL FFV1L2_1(PL(0,14),W(1,8),GC_5,MDL_MT,MDL_WT,PL(0,17),COEFS)
      CALL ML5_0_4_3_UPDATE_WL_1_1(WL(1,0,1,14),4,COEFS,4,4,WL(1,0,1
     $ ,17))
      CALL FFV1L2_1(PL(0,17),W(1,9),GC_5,MDL_MT,MDL_WT,PL(0,18),COEFS)
      CALL ML5_0_4_3_UPDATE_WL_2_1(WL(1,0,1,17),4,COEFS,4,4,WL(1,0,1
     $ ,18))
      CALL ML5_0_4_3_CREATE_LOOP_COEFS(WL(1,0,1,18),3,4,7,1,1,11)
C     Coefficient construction for loop diagram with ID 8
      CALL FFV1L1_2(PL(0,11),W(1,8),GC_5,MDL_MT,MDL_WT,PL(0,19),COEFS)
      CALL ML5_0_4_3_UPDATE_WL_1_1(WL(1,0,1,11),4,COEFS,4,4,WL(1,0,1
     $ ,19))
      CALL FFV1L1_2(PL(0,19),W(1,9),GC_5,MDL_MT,MDL_WT,PL(0,20),COEFS)
      CALL ML5_0_4_3_UPDATE_WL_2_1(WL(1,0,1,19),4,COEFS,4,4,WL(1,0,1
     $ ,20))
      CALL ML5_0_4_3_CREATE_LOOP_COEFS(WL(1,0,1,20),3,4,8,1,1,12)
C     At this point, all loop coefficients needed for (QCD=8), i.e. of
C      split order ID=1, are computed.
      IF(FILTER_SO.AND.SQSO_TARGET.EQ.1) GOTO 4000

      GOTO 1001
 4000 CONTINUE
      LOOP_REQ_SO_DONE=.TRUE.
 1001 CONTINUE
      END

