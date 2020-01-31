      SUBROUTINE ML5_0_0_1_MP_COEF_CONSTRUCTION_1(P,NHEL,H,IC)
C     
      USE ML5_0_0_1_POLYNOMIAL_CONSTANTS
      IMPLICIT NONE
C     
C     CONSTANTS
C     
      INTEGER    NEXTERNAL
      PARAMETER (NEXTERNAL=5)
      INTEGER    NCOMB
      PARAMETER (NCOMB=16)

      INTEGER    NLOOPS, NLOOPGROUPS, NCTAMPS
      PARAMETER (NLOOPS=228, NLOOPGROUPS=228, NCTAMPS=54)
      INTEGER    NLOOPAMPS
      PARAMETER (NLOOPAMPS=282)
      INTEGER    NWAVEFUNCS,NLOOPWAVEFUNCS
      PARAMETER (NWAVEFUNCS=35,NLOOPWAVEFUNCS=420)
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
      COMMON/ML5_0_0_1_FILTERS/GOODAMP,GOODHEL

      INTEGER SQSO_TARGET
      COMMON/ML5_0_0_1_SOCHOICE/SQSO_TARGET

      LOGICAL UVCT_REQ_SO_DONE,MP_UVCT_REQ_SO_DONE,CT_REQ_SO_DONE
     $ ,MP_CT_REQ_SO_DONE,LOOP_REQ_SO_DONE,MP_LOOP_REQ_SO_DONE
     $ ,CTCALL_REQ_SO_DONE,FILTER_SO
      COMMON/ML5_0_0_1_SO_REQS/UVCT_REQ_SO_DONE,MP_UVCT_REQ_SO_DONE
     $ ,CT_REQ_SO_DONE,MP_CT_REQ_SO_DONE,LOOP_REQ_SO_DONE
     $ ,MP_LOOP_REQ_SO_DONE,CTCALL_REQ_SO_DONE,FILTER_SO

      COMPLEX*32 W(20,NWAVEFUNCS)
      COMMON/ML5_0_0_1_MP_W/W

      COMPLEX*32 WL(MAXLWFSIZE,0:LOOPMAXCOEFS-1,MAXLWFSIZE,
     $ -1:NLOOPWAVEFUNCS)
      COMPLEX*32 PL(0:3,-1:NLOOPWAVEFUNCS)
      COMMON/ML5_0_0_1_MP_WL/WL,PL

      COMPLEX*32 AMPL(3,NLOOPAMPS)
      COMMON/ML5_0_0_1_MP_AMPL/AMPL

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
      CALL MP_FFS1L2_1(PL(0,0),W(1,3),GC_33,MDL_MB,ZERO,PL(0,1),COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_0_1(WL(1,0,1,0),4,COEFS,4,4,WL(1,0,1
     $ ,1))
      CALL MP_FFV1L2_1(PL(0,1),W(1,5),GC_5,MDL_MB,ZERO,PL(0,2),COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_1_1(WL(1,0,1,1),4,COEFS,4,4,WL(1,0,1
     $ ,2))
      CALL MP_FFV1L2_1(PL(0,2),W(1,7),GC_5,MDL_MB,ZERO,PL(0,3),COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,2),4,COEFS,4,4,WL(1,0,1
     $ ,3))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,3),3,4,1,1,1,55)
C     Coefficient construction for loop diagram with ID 2
      CALL MP_FFV1L2_1(PL(0,1),W(1,4),GC_5,MDL_MB,ZERO,PL(0,4),COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_1_1(WL(1,0,1,1),4,COEFS,4,4,WL(1,0,1
     $ ,4))
      CALL MP_FFV1L2_1(PL(0,4),W(1,8),GC_5,MDL_MB,ZERO,PL(0,5),COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,4),4,COEFS,4,4,WL(1,0,1
     $ ,5))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,5),3,4,2,1,1,56)
C     Coefficient construction for loop diagram with ID 3
      CALL MP_FFV1L2_1(PL(0,4),W(1,5),GC_5,MDL_MB,ZERO,PL(0,6),COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,4),4,COEFS,4,4,WL(1,0,1
     $ ,6))
      CALL MP_FFV1L2_1(PL(0,6),W(1,6),GC_5,MDL_MB,ZERO,PL(0,7),COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,6),4,COEFS,4,4,WL(1,0,1
     $ ,7))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,7),4,4,3,1,1,57)
C     Coefficient construction for loop diagram with ID 4
      CALL MP_FFV1L2_1(PL(0,2),W(1,4),GC_5,MDL_MB,ZERO,PL(0,8),COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,2),4,COEFS,4,4,WL(1,0,1
     $ ,8))
      CALL MP_FFV1L2_1(PL(0,8),W(1,6),GC_5,MDL_MB,ZERO,PL(0,9),COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,8),4,COEFS,4,4,WL(1,0,1
     $ ,9))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,9),4,4,4,1,1,58)
C     Coefficient construction for loop diagram with ID 5
      CALL MP_FFV1L2_1(PL(0,1),W(1,6),GC_5,MDL_MB,ZERO,PL(0,10),COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_1_1(WL(1,0,1,1),4,COEFS,4,4,WL(1,0,1
     $ ,10))
      CALL MP_FFV1L2_1(PL(0,10),W(1,9),GC_5,MDL_MB,ZERO,PL(0,11),COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,10),4,COEFS,4,4,WL(1,0
     $ ,1,11))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,11),3,4,5,1,1,59)
C     Coefficient construction for loop diagram with ID 6
      CALL MP_FFS1L1_2(PL(0,0),W(1,3),GC_33,MDL_MB,ZERO,PL(0,12),COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_0_1(WL(1,0,1,0),4,COEFS,4,4,WL(1,0,1
     $ ,12))
      CALL MP_FFV1L1_2(PL(0,12),W(1,6),GC_5,MDL_MB,ZERO,PL(0,13),COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_1_1(WL(1,0,1,12),4,COEFS,4,4,WL(1,0
     $ ,1,13))
      CALL MP_FFV1L1_2(PL(0,13),W(1,9),GC_5,MDL_MB,ZERO,PL(0,14),COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,13),4,COEFS,4,4,WL(1,0
     $ ,1,14))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,14),3,4,6,1,1,60)
C     Coefficient construction for loop diagram with ID 7
      CALL MP_FFV1L1_2(PL(0,12),W(1,4),GC_5,MDL_MB,ZERO,PL(0,15),COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_1_1(WL(1,0,1,12),4,COEFS,4,4,WL(1,0
     $ ,1,15))
      CALL MP_FFV1L1_2(PL(0,15),W(1,5),GC_5,MDL_MB,ZERO,PL(0,16),COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,15),4,COEFS,4,4,WL(1,0
     $ ,1,16))
      CALL MP_FFV1L1_2(PL(0,16),W(1,6),GC_5,MDL_MB,ZERO,PL(0,17),COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,16),4,COEFS,4,4,WL(1,0
     $ ,1,17))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,17),4,4,7,1,1,61)
C     Coefficient construction for loop diagram with ID 8
      CALL MP_FFV1L1_2(PL(0,15),W(1,6),GC_5,MDL_MB,ZERO,PL(0,18),COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,15),4,COEFS,4,4,WL(1,0
     $ ,1,18))
      CALL MP_FFV1L1_2(PL(0,18),W(1,5),GC_5,MDL_MB,ZERO,PL(0,19),COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,18),4,COEFS,4,4,WL(1,0
     $ ,1,19))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,19),4,4,8,1,1,62)
C     Coefficient construction for loop diagram with ID 9
      CALL MP_FFV1L1_2(PL(0,15),W(1,8),GC_5,MDL_MB,ZERO,PL(0,20),COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,15),4,COEFS,4,4,WL(1,0
     $ ,1,20))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,20),3,4,9,1,1,63)
C     Coefficient construction for loop diagram with ID 10
      CALL MP_FFV1L1_2(PL(0,12),W(1,5),GC_5,MDL_MB,ZERO,PL(0,21),COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_1_1(WL(1,0,1,12),4,COEFS,4,4,WL(1,0
     $ ,1,21))
      CALL MP_FFV1L1_2(PL(0,21),W(1,4),GC_5,MDL_MB,ZERO,PL(0,22),COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,21),4,COEFS,4,4,WL(1,0
     $ ,1,22))
      CALL MP_FFV1L1_2(PL(0,22),W(1,6),GC_5,MDL_MB,ZERO,PL(0,23),COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,22),4,COEFS,4,4,WL(1,0
     $ ,1,23))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,23),4,4,10,1,1,64)
C     Coefficient construction for loop diagram with ID 11
      CALL MP_FFV1L1_2(PL(0,21),W(1,7),GC_5,MDL_MB,ZERO,PL(0,24),COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,21),4,COEFS,4,4,WL(1,0
     $ ,1,24))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,24),3,4,11,1,1,65)
C     Coefficient construction for loop diagram with ID 12
      CALL MP_FFV1L2_1(PL(0,4),W(1,6),GC_5,MDL_MB,ZERO,PL(0,25),COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,4),4,COEFS,4,4,WL(1,0,1
     $ ,25))
      CALL MP_FFV1L2_1(PL(0,25),W(1,5),GC_5,MDL_MB,ZERO,PL(0,26),COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,25),4,COEFS,4,4,WL(1,0
     $ ,1,26))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,26),4,4,12,1,1,66)
C     Coefficient construction for loop diagram with ID 13
      CALL MP_FFV1L1_2(PL(0,12),W(1,10),GC_5,MDL_MB,ZERO,PL(0,27)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_1_1(WL(1,0,1,12),4,COEFS,4,4,WL(1,0
     $ ,1,27))
      CALL MP_FFV1L1_2(PL(0,27),W(1,11),GC_5,MDL_MB,ZERO,PL(0,28)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,27),4,COEFS,4,4,WL(1,0
     $ ,1,28))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,28),3,4,13,1,1,67)
C     Coefficient construction for loop diagram with ID 14
      CALL MP_FFV1L2_1(PL(0,1),W(1,10),GC_5,MDL_MB,ZERO,PL(0,29),COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_1_1(WL(1,0,1,1),4,COEFS,4,4,WL(1,0,1
     $ ,29))
      CALL MP_FFV1L2_1(PL(0,29),W(1,11),GC_5,MDL_MB,ZERO,PL(0,30)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,29),4,COEFS,4,4,WL(1,0
     $ ,1,30))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,30),3,4,14,1,1,68)
C     Coefficient construction for loop diagram with ID 15
      CALL MP_FFV1L2_1(PL(0,0),W(1,2),GC_5,MDL_MB,ZERO,PL(0,31),COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_0_1(WL(1,0,1,0),4,COEFS,4,4,WL(1,0,1
     $ ,31))
      CALL MP_FFS1L2_1(PL(0,31),W(1,3),GC_33,MDL_MB,ZERO,PL(0,32)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_1_1(WL(1,0,1,31),4,COEFS,4,4,WL(1,0
     $ ,1,32))
      CALL MP_FFV1L2_1(PL(0,32),W(1,12),GC_5,MDL_MB,ZERO,PL(0,33)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,32),4,COEFS,4,4,WL(1,0
     $ ,1,33))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,33),3,4,15,1,1,69)
C     Coefficient construction for loop diagram with ID 16
      CALL MP_FFV1L2_1(PL(0,32),W(1,5),GC_5,MDL_MB,ZERO,PL(0,34),COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,32),4,COEFS,4,4,WL(1,0
     $ ,1,34))
      CALL MP_FFV1L2_1(PL(0,34),W(1,10),GC_5,MDL_MB,ZERO,PL(0,35)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,34),4,COEFS,4,4,WL(1,0
     $ ,1,35))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,35),4,4,16,1,1,70)
C     Coefficient construction for loop diagram with ID 17
      CALL MP_FFV1L2_1(PL(0,31),W(1,5),GC_5,MDL_MB,ZERO,PL(0,36),COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_1_1(WL(1,0,1,31),4,COEFS,4,4,WL(1,0
     $ ,1,36))
      CALL MP_FFS1L2_1(PL(0,36),W(1,3),GC_33,MDL_MB,ZERO,PL(0,37)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,36),4,COEFS,4,4,WL(1,0
     $ ,1,37))
      CALL MP_FFV1L2_1(PL(0,37),W(1,10),GC_5,MDL_MB,ZERO,PL(0,38)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,37),4,COEFS,4,4,WL(1,0
     $ ,1,38))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,38),4,4,17,1,1,71)
C     Coefficient construction for loop diagram with ID 18
      CALL MP_FFV1L1_2(PL(0,0),W(1,2),GC_5,MDL_MB,ZERO,PL(0,39),COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_0_1(WL(1,0,1,0),4,COEFS,4,4,WL(1,0,1
     $ ,39))
      CALL MP_FFS1L1_2(PL(0,39),W(1,3),GC_33,MDL_MB,ZERO,PL(0,40)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_1_1(WL(1,0,1,39),4,COEFS,4,4,WL(1,0
     $ ,1,40))
      CALL MP_FFV1L1_2(PL(0,40),W(1,5),GC_5,MDL_MB,ZERO,PL(0,41),COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,40),4,COEFS,4,4,WL(1,0
     $ ,1,41))
      CALL MP_FFV1L1_2(PL(0,41),W(1,10),GC_5,MDL_MB,ZERO,PL(0,42)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,41),4,COEFS,4,4,WL(1,0
     $ ,1,42))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,42),4,4,18,1,1,72)
C     Coefficient construction for loop diagram with ID 19
      CALL MP_FFV1L1_2(PL(0,40),W(1,10),GC_5,MDL_MB,ZERO,PL(0,43)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,40),4,COEFS,4,4,WL(1,0
     $ ,1,43))
      CALL MP_FFV1L1_2(PL(0,43),W(1,5),GC_5,MDL_MB,ZERO,PL(0,44),COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,43),4,COEFS,4,4,WL(1,0
     $ ,1,44))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,44),4,4,19,1,1,73)
C     Coefficient construction for loop diagram with ID 20
      CALL MP_FFV1L1_2(PL(0,40),W(1,12),GC_5,MDL_MB,ZERO,PL(0,45)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,40),4,COEFS,4,4,WL(1,0
     $ ,1,45))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,45),3,4,20,1,1,74)
C     Coefficient construction for loop diagram with ID 21
      CALL MP_FFV1L1_2(PL(0,39),W(1,5),GC_5,MDL_MB,ZERO,PL(0,46),COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_1_1(WL(1,0,1,39),4,COEFS,4,4,WL(1,0
     $ ,1,46))
      CALL MP_FFS1L1_2(PL(0,46),W(1,3),GC_33,MDL_MB,ZERO,PL(0,47)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,46),4,COEFS,4,4,WL(1,0
     $ ,1,47))
      CALL MP_FFV1L1_2(PL(0,47),W(1,10),GC_5,MDL_MB,ZERO,PL(0,48)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,47),4,COEFS,4,4,WL(1,0
     $ ,1,48))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,48),4,4,21,1,1,75)
C     Coefficient construction for loop diagram with ID 22
      CALL MP_FFV1L2_1(PL(0,32),W(1,10),GC_5,MDL_MB,ZERO,PL(0,49)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,32),4,COEFS,4,4,WL(1,0
     $ ,1,49))
      CALL MP_FFV1L2_1(PL(0,49),W(1,5),GC_5,MDL_MB,ZERO,PL(0,50),COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,49),4,COEFS,4,4,WL(1,0
     $ ,1,50))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,50),4,4,22,1,1,76)
C     Coefficient construction for loop diagram with ID 23
      CALL MP_FFV1L2_1(PL(0,2),W(1,13),GC_5,MDL_MB,ZERO,PL(0,51),COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,2),4,COEFS,4,4,WL(1,0,1
     $ ,51))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,51),3,4,23,1,1,77)
C     Coefficient construction for loop diagram with ID 24
      CALL MP_FFV1L1_2(PL(0,21),W(1,13),GC_5,MDL_MB,ZERO,PL(0,52)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,21),4,COEFS,4,4,WL(1,0
     $ ,1,52))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,52),3,4,24,1,1,78)
C     Coefficient construction for loop diagram with ID 25
      CALL MP_FFV1L2_1(PL(0,1),W(1,14),GC_5,MDL_MB,ZERO,PL(0,53),COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_1_1(WL(1,0,1,1),4,COEFS,4,4,WL(1,0,1
     $ ,53))
      CALL MP_FFV1L2_1(PL(0,53),W(1,15),GC_5,MDL_MB,ZERO,PL(0,54)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,53),4,COEFS,4,4,WL(1,0
     $ ,1,54))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,54),3,4,25,1,1,79)
C     Coefficient construction for loop diagram with ID 26
      CALL MP_FFV1L1_2(PL(0,12),W(1,14),GC_5,MDL_MB,ZERO,PL(0,55)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_1_1(WL(1,0,1,12),4,COEFS,4,4,WL(1,0
     $ ,1,55))
      CALL MP_FFV1L1_2(PL(0,55),W(1,15),GC_5,MDL_MB,ZERO,PL(0,56)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,55),4,COEFS,4,4,WL(1,0
     $ ,1,56))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,56),3,4,26,1,1,80)
C     Coefficient construction for loop diagram with ID 27
      CALL MP_FFV1L2_1(PL(0,32),W(1,16),GC_5,MDL_MB,ZERO,PL(0,57)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,32),4,COEFS,4,4,WL(1,0
     $ ,1,57))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,57),3,4,27,1,1,81)
C     Coefficient construction for loop diagram with ID 28
      CALL MP_FFV1L2_1(PL(0,32),W(1,4),GC_5,MDL_MB,ZERO,PL(0,58),COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,32),4,COEFS,4,4,WL(1,0
     $ ,1,58))
      CALL MP_FFV1L2_1(PL(0,58),W(1,15),GC_5,MDL_MB,ZERO,PL(0,59)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,58),4,COEFS,4,4,WL(1,0
     $ ,1,59))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,59),4,4,28,1,1,82)
C     Coefficient construction for loop diagram with ID 29
      CALL MP_FFV1L2_1(PL(0,31),W(1,4),GC_5,MDL_MB,ZERO,PL(0,60),COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_1_1(WL(1,0,1,31),4,COEFS,4,4,WL(1,0
     $ ,1,60))
      CALL MP_FFS1L2_1(PL(0,60),W(1,3),GC_33,MDL_MB,ZERO,PL(0,61)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,60),4,COEFS,4,4,WL(1,0
     $ ,1,61))
      CALL MP_FFV1L2_1(PL(0,61),W(1,15),GC_5,MDL_MB,ZERO,PL(0,62)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,61),4,COEFS,4,4,WL(1,0
     $ ,1,62))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,62),4,4,29,1,1,83)
C     Coefficient construction for loop diagram with ID 30
      CALL MP_FFV1L1_2(PL(0,40),W(1,4),GC_5,MDL_MB,ZERO,PL(0,63),COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,40),4,COEFS,4,4,WL(1,0
     $ ,1,63))
      CALL MP_FFV1L1_2(PL(0,63),W(1,15),GC_5,MDL_MB,ZERO,PL(0,64)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,63),4,COEFS,4,4,WL(1,0
     $ ,1,64))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,64),4,4,30,1,1,84)
C     Coefficient construction for loop diagram with ID 31
      CALL MP_FFV1L1_2(PL(0,40),W(1,15),GC_5,MDL_MB,ZERO,PL(0,65)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,40),4,COEFS,4,4,WL(1,0
     $ ,1,65))
      CALL MP_FFV1L1_2(PL(0,65),W(1,4),GC_5,MDL_MB,ZERO,PL(0,66),COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,65),4,COEFS,4,4,WL(1,0
     $ ,1,66))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,66),4,4,31,1,1,85)
C     Coefficient construction for loop diagram with ID 32
      CALL MP_FFV1L1_2(PL(0,40),W(1,16),GC_5,MDL_MB,ZERO,PL(0,67)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,40),4,COEFS,4,4,WL(1,0
     $ ,1,67))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,67),3,4,32,1,1,86)
C     Coefficient construction for loop diagram with ID 33
      CALL MP_FFV1L1_2(PL(0,39),W(1,4),GC_5,MDL_MB,ZERO,PL(0,68),COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_1_1(WL(1,0,1,39),4,COEFS,4,4,WL(1,0
     $ ,1,68))
      CALL MP_FFS1L1_2(PL(0,68),W(1,3),GC_33,MDL_MB,ZERO,PL(0,69)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,68),4,COEFS,4,4,WL(1,0
     $ ,1,69))
      CALL MP_FFV1L1_2(PL(0,69),W(1,15),GC_5,MDL_MB,ZERO,PL(0,70)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,69),4,COEFS,4,4,WL(1,0
     $ ,1,70))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,70),4,4,33,1,1,87)
C     Coefficient construction for loop diagram with ID 34
      CALL MP_FFV1L2_1(PL(0,32),W(1,15),GC_5,MDL_MB,ZERO,PL(0,71)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,32),4,COEFS,4,4,WL(1,0
     $ ,1,71))
      CALL MP_FFV1L2_1(PL(0,71),W(1,4),GC_5,MDL_MB,ZERO,PL(0,72),COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,71),4,COEFS,4,4,WL(1,0
     $ ,1,72))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,72),4,4,34,1,1,88)
C     Coefficient construction for loop diagram with ID 35
      CALL MP_FFV1L2_1(PL(0,4),W(1,17),GC_5,MDL_MB,ZERO,PL(0,73),COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,4),4,COEFS,4,4,WL(1,0,1
     $ ,73))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,73),3,4,35,1,1,89)
C     Coefficient construction for loop diagram with ID 36
      CALL MP_FFV1L1_2(PL(0,15),W(1,17),GC_5,MDL_MB,ZERO,PL(0,74)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,15),4,COEFS,4,4,WL(1,0
     $ ,1,74))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,74),3,4,36,1,1,90)
C     Coefficient construction for loop diagram with ID 37
      CALL MP_FFV1L2_1(PL(0,0),W(1,1),GC_5,MDL_MB,ZERO,PL(0,75),COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_0_1(WL(1,0,1,0),4,COEFS,4,4,WL(1,0,1
     $ ,75))
      CALL MP_FFS1L2_1(PL(0,75),W(1,3),GC_33,MDL_MB,ZERO,PL(0,76)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_1_1(WL(1,0,1,75),4,COEFS,4,4,WL(1,0
     $ ,1,76))
      CALL MP_FFV1L2_1(PL(0,76),W(1,18),GC_5,MDL_MB,ZERO,PL(0,77)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,76),4,COEFS,4,4,WL(1,0
     $ ,1,77))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,77),3,4,37,1,1,91)
C     Coefficient construction for loop diagram with ID 38
      CALL MP_FFV1L2_1(PL(0,76),W(1,5),GC_5,MDL_MB,ZERO,PL(0,78),COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,76),4,COEFS,4,4,WL(1,0
     $ ,1,78))
      CALL MP_FFV1L2_1(PL(0,78),W(1,14),GC_5,MDL_MB,ZERO,PL(0,79)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,78),4,COEFS,4,4,WL(1,0
     $ ,1,79))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,79),4,4,38,1,1,92)
C     Coefficient construction for loop diagram with ID 39
      CALL MP_FFV1L2_1(PL(0,75),W(1,5),GC_5,MDL_MB,ZERO,PL(0,80),COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_1_1(WL(1,0,1,75),4,COEFS,4,4,WL(1,0
     $ ,1,80))
      CALL MP_FFS1L2_1(PL(0,80),W(1,3),GC_33,MDL_MB,ZERO,PL(0,81)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,80),4,COEFS,4,4,WL(1,0
     $ ,1,81))
      CALL MP_FFV1L2_1(PL(0,81),W(1,14),GC_5,MDL_MB,ZERO,PL(0,82)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,81),4,COEFS,4,4,WL(1,0
     $ ,1,82))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,82),4,4,39,1,1,93)
C     Coefficient construction for loop diagram with ID 40
      CALL MP_FFV1L1_2(PL(0,0),W(1,1),GC_5,MDL_MB,ZERO,PL(0,83),COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_0_1(WL(1,0,1,0),4,COEFS,4,4,WL(1,0,1
     $ ,83))
      CALL MP_FFS1L1_2(PL(0,83),W(1,3),GC_33,MDL_MB,ZERO,PL(0,84)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_1_1(WL(1,0,1,83),4,COEFS,4,4,WL(1,0
     $ ,1,84))
      CALL MP_FFV1L1_2(PL(0,84),W(1,5),GC_5,MDL_MB,ZERO,PL(0,85),COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,84),4,COEFS,4,4,WL(1,0
     $ ,1,85))
      CALL MP_FFV1L1_2(PL(0,85),W(1,14),GC_5,MDL_MB,ZERO,PL(0,86)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,85),4,COEFS,4,4,WL(1,0
     $ ,1,86))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,86),4,4,40,1,1,94)
C     Coefficient construction for loop diagram with ID 41
      CALL MP_FFV1L1_2(PL(0,84),W(1,18),GC_5,MDL_MB,ZERO,PL(0,87)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,84),4,COEFS,4,4,WL(1,0
     $ ,1,87))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,87),3,4,41,1,1,95)
C     Coefficient construction for loop diagram with ID 42
      CALL MP_FFV1L1_2(PL(0,84),W(1,14),GC_5,MDL_MB,ZERO,PL(0,88)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,84),4,COEFS,4,4,WL(1,0
     $ ,1,88))
      CALL MP_FFV1L1_2(PL(0,88),W(1,5),GC_5,MDL_MB,ZERO,PL(0,89),COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,88),4,COEFS,4,4,WL(1,0
     $ ,1,89))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,89),4,4,42,1,1,96)
C     Coefficient construction for loop diagram with ID 43
      CALL MP_FFV1L1_2(PL(0,83),W(1,5),GC_5,MDL_MB,ZERO,PL(0,90),COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_1_1(WL(1,0,1,83),4,COEFS,4,4,WL(1,0
     $ ,1,90))
      CALL MP_FFS1L1_2(PL(0,90),W(1,3),GC_33,MDL_MB,ZERO,PL(0,91)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,90),4,COEFS,4,4,WL(1,0
     $ ,1,91))
      CALL MP_FFV1L1_2(PL(0,91),W(1,14),GC_5,MDL_MB,ZERO,PL(0,92)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,91),4,COEFS,4,4,WL(1,0
     $ ,1,92))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,92),4,4,43,1,1,97)
C     Coefficient construction for loop diagram with ID 44
      CALL MP_FFV1L2_1(PL(0,76),W(1,14),GC_5,MDL_MB,ZERO,PL(0,93)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,76),4,COEFS,4,4,WL(1,0
     $ ,1,93))
      CALL MP_FFV1L2_1(PL(0,93),W(1,5),GC_5,MDL_MB,ZERO,PL(0,94),COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,93),4,COEFS,4,4,WL(1,0
     $ ,1,94))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,94),4,4,44,1,1,98)
C     Coefficient construction for loop diagram with ID 45
      CALL MP_FFV1L2_1(PL(0,76),W(1,19),GC_5,MDL_MB,ZERO,PL(0,95)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,76),4,COEFS,4,4,WL(1,0
     $ ,1,95))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,95),3,4,45,1,1,99)
C     Coefficient construction for loop diagram with ID 46
      CALL MP_FFV1L2_1(PL(0,76),W(1,4),GC_5,MDL_MB,ZERO,PL(0,96),COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,76),4,COEFS,4,4,WL(1,0
     $ ,1,96))
      CALL MP_FFV1L2_1(PL(0,96),W(1,11),GC_5,MDL_MB,ZERO,PL(0,97)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,96),4,COEFS,4,4,WL(1,0
     $ ,1,97))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,97),4,4,46,1,1,100)
C     Coefficient construction for loop diagram with ID 47
      CALL MP_FFV1L2_1(PL(0,75),W(1,4),GC_5,MDL_MB,ZERO,PL(0,98),COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_1_1(WL(1,0,1,75),4,COEFS,4,4,WL(1,0
     $ ,1,98))
      CALL MP_FFS1L2_1(PL(0,98),W(1,3),GC_33,MDL_MB,ZERO,PL(0,99)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,98),4,COEFS,4,4,WL(1,0
     $ ,1,99))
      CALL MP_FFV1L2_1(PL(0,99),W(1,11),GC_5,MDL_MB,ZERO,PL(0,100)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,99),4,COEFS,4,4,WL(1,0
     $ ,1,100))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,100),4,4,47,1,1,101)
C     Coefficient construction for loop diagram with ID 48
      CALL MP_FFV1L1_2(PL(0,84),W(1,4),GC_5,MDL_MB,ZERO,PL(0,101)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,84),4,COEFS,4,4,WL(1,0
     $ ,1,101))
      CALL MP_FFV1L1_2(PL(0,101),W(1,11),GC_5,MDL_MB,ZERO,PL(0,102)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,101),4,COEFS,4,4,WL(1,0
     $ ,1,102))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,102),4,4,48,1,1,102)
C     Coefficient construction for loop diagram with ID 49
      CALL MP_FFV1L1_2(PL(0,84),W(1,19),GC_5,MDL_MB,ZERO,PL(0,103)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,84),4,COEFS,4,4,WL(1,0
     $ ,1,103))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,103),3,4,49,1,1,103)
C     Coefficient construction for loop diagram with ID 50
      CALL MP_FFV1L1_2(PL(0,84),W(1,11),GC_5,MDL_MB,ZERO,PL(0,104)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,84),4,COEFS,4,4,WL(1,0
     $ ,1,104))
      CALL MP_FFV1L1_2(PL(0,104),W(1,4),GC_5,MDL_MB,ZERO,PL(0,105)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,104),4,COEFS,4,4,WL(1,0
     $ ,1,105))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,105),4,4,50,1,1,104)
C     Coefficient construction for loop diagram with ID 51
      CALL MP_FFV1L1_2(PL(0,83),W(1,4),GC_5,MDL_MB,ZERO,PL(0,106)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_1_1(WL(1,0,1,83),4,COEFS,4,4,WL(1,0
     $ ,1,106))
      CALL MP_FFS1L1_2(PL(0,106),W(1,3),GC_33,MDL_MB,ZERO,PL(0,107)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,106),4,COEFS,4,4,WL(1,0
     $ ,1,107))
      CALL MP_FFV1L1_2(PL(0,107),W(1,11),GC_5,MDL_MB,ZERO,PL(0,108)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,107),4,COEFS,4,4,WL(1,0
     $ ,1,108))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,108),4,4,51,1,1,105)
C     Coefficient construction for loop diagram with ID 52
      CALL MP_FFV1L2_1(PL(0,76),W(1,11),GC_5,MDL_MB,ZERO,PL(0,109)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,76),4,COEFS,4,4,WL(1,0
     $ ,1,109))
      CALL MP_FFV1L2_1(PL(0,109),W(1,4),GC_5,MDL_MB,ZERO,PL(0,110)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,109),4,COEFS,4,4,WL(1,0
     $ ,1,110))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,110),4,4,52,1,1,106)
C     Coefficient construction for loop diagram with ID 53
      CALL MP_FFV1L1_2(PL(0,83),W(1,2),GC_5,MDL_MB,ZERO,PL(0,111)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_1_1(WL(1,0,1,83),4,COEFS,4,4,WL(1,0
     $ ,1,111))
      CALL MP_FFV1L1_2(PL(0,111),W(1,4),GC_5,MDL_MB,ZERO,PL(0,112)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,111),4,COEFS,4,4,WL(1,0
     $ ,1,112))
      CALL MP_FFV1L1_2(PL(0,112),W(1,5),GC_5,MDL_MB,ZERO,PL(0,113)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,112),4,COEFS,4,4,WL(1,0
     $ ,1,113))
      CALL MP_FFS1L1_2(PL(0,113),W(1,3),GC_33,MDL_MB,ZERO,PL(0,114)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_4_1(WL(1,0,1,113),4,COEFS,4,4,WL(1,0
     $ ,1,114))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,114),5,4,53,1,1,107)
C     Coefficient construction for loop diagram with ID 54
      CALL MP_FFV1L1_2(PL(0,111),W(1,5),GC_5,MDL_MB,ZERO,PL(0,115)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,111),4,COEFS,4,4,WL(1,0
     $ ,1,115))
      CALL MP_FFV1L1_2(PL(0,115),W(1,4),GC_5,MDL_MB,ZERO,PL(0,116)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,115),4,COEFS,4,4,WL(1,0
     $ ,1,116))
      CALL MP_FFS1L1_2(PL(0,116),W(1,3),GC_33,MDL_MB,ZERO,PL(0,117)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_4_1(WL(1,0,1,116),4,COEFS,4,4,WL(1,0
     $ ,1,117))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,117),5,4,54,1,1,108)
C     Coefficient construction for loop diagram with ID 55
      CALL MP_FFS1L1_2(PL(0,111),W(1,3),GC_33,MDL_MB,ZERO,PL(0,118)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,111),4,COEFS,4,4,WL(1,0
     $ ,1,118))
      CALL MP_FFV1L1_2(PL(0,118),W(1,5),GC_5,MDL_MB,ZERO,PL(0,119)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,118),4,COEFS,4,4,WL(1,0
     $ ,1,119))
      CALL MP_FFV1L1_2(PL(0,119),W(1,4),GC_5,MDL_MB,ZERO,PL(0,120)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_4_1(WL(1,0,1,119),4,COEFS,4,4,WL(1,0
     $ ,1,120))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,120),5,4,55,1,1,109)
C     Coefficient construction for loop diagram with ID 56
      CALL MP_FFS1L1_2(PL(0,115),W(1,3),GC_33,MDL_MB,ZERO,PL(0,121)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,115),4,COEFS,4,4,WL(1,0
     $ ,1,121))
      CALL MP_FFV1L1_2(PL(0,121),W(1,4),GC_5,MDL_MB,ZERO,PL(0,122)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_4_1(WL(1,0,1,121),4,COEFS,4,4,WL(1,0
     $ ,1,122))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,122),5,4,56,1,1,110)
C     Coefficient construction for loop diagram with ID 57
      CALL MP_FFV1L1_2(PL(0,118),W(1,4),GC_5,MDL_MB,ZERO,PL(0,123)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,118),4,COEFS,4,4,WL(1,0
     $ ,1,123))
      CALL MP_FFV1L1_2(PL(0,123),W(1,5),GC_5,MDL_MB,ZERO,PL(0,124)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_4_1(WL(1,0,1,123),4,COEFS,4,4,WL(1,0
     $ ,1,124))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,124),5,4,57,1,1,111)
C     Coefficient construction for loop diagram with ID 58
      CALL MP_FFS1L1_2(PL(0,112),W(1,3),GC_33,MDL_MB,ZERO,PL(0,125)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,112),4,COEFS,4,4,WL(1,0
     $ ,1,125))
      CALL MP_FFV1L1_2(PL(0,125),W(1,5),GC_5,MDL_MB,ZERO,PL(0,126)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_4_1(WL(1,0,1,125),4,COEFS,4,4,WL(1,0
     $ ,1,126))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,126),5,4,58,1,1,112)
C     Coefficient construction for loop diagram with ID 59
      CALL MP_FFV1L1_2(PL(0,111),W(1,9),GC_5,MDL_MB,ZERO,PL(0,127)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,111),4,COEFS,4,4,WL(1,0
     $ ,1,127))
      CALL MP_FFS1L1_2(PL(0,127),W(1,3),GC_33,MDL_MB,ZERO,PL(0,128)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,127),4,COEFS,4,4,WL(1,0
     $ ,1,128))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,128),4,4,59,1,1,113)
C     Coefficient construction for loop diagram with ID 60
      CALL MP_FFV1L1_2(PL(0,118),W(1,9),GC_5,MDL_MB,ZERO,PL(0,129)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,118),4,COEFS,4,4,WL(1,0
     $ ,1,129))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,129),4,4,60,1,1,114)
C     Coefficient construction for loop diagram with ID 61
      CALL MP_FFV1L2_1(PL(0,75),W(1,2),GC_5,MDL_MB,ZERO,PL(0,130)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_1_1(WL(1,0,1,75),4,COEFS,4,4,WL(1,0
     $ ,1,130))
      CALL MP_FFV1L2_1(PL(0,130),W(1,5),GC_5,MDL_MB,ZERO,PL(0,131)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,130),4,COEFS,4,4,WL(1,0
     $ ,1,131))
      CALL MP_FFV1L2_1(PL(0,131),W(1,4),GC_5,MDL_MB,ZERO,PL(0,132)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,131),4,COEFS,4,4,WL(1,0
     $ ,1,132))
      CALL MP_FFS1L2_1(PL(0,132),W(1,3),GC_33,MDL_MB,ZERO,PL(0,133)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_4_1(WL(1,0,1,132),4,COEFS,4,4,WL(1,0
     $ ,1,133))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,133),5,4,61,1,1,115)
C     Coefficient construction for loop diagram with ID 62
      CALL MP_FFV1L2_1(PL(0,130),W(1,4),GC_5,MDL_MB,ZERO,PL(0,134)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,130),4,COEFS,4,4,WL(1,0
     $ ,1,134))
      CALL MP_FFV1L2_1(PL(0,134),W(1,5),GC_5,MDL_MB,ZERO,PL(0,135)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,134),4,COEFS,4,4,WL(1,0
     $ ,1,135))
      CALL MP_FFS1L2_1(PL(0,135),W(1,3),GC_33,MDL_MB,ZERO,PL(0,136)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_4_1(WL(1,0,1,135),4,COEFS,4,4,WL(1,0
     $ ,1,136))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,136),5,4,62,1,1,116)
C     Coefficient construction for loop diagram with ID 63
      CALL MP_FFV1L1_2(PL(0,84),W(1,2),GC_5,MDL_MB,ZERO,PL(0,137)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,84),4,COEFS,4,4,WL(1,0
     $ ,1,137))
      CALL MP_FFV1L1_2(PL(0,137),W(1,5),GC_5,MDL_MB,ZERO,PL(0,138)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,137),4,COEFS,4,4,WL(1,0
     $ ,1,138))
      CALL MP_FFV1L1_2(PL(0,138),W(1,4),GC_5,MDL_MB,ZERO,PL(0,139)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_4_1(WL(1,0,1,138),4,COEFS,4,4,WL(1,0
     $ ,1,139))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,139),5,4,63,1,1,117)
C     Coefficient construction for loop diagram with ID 64
      CALL MP_FFV1L1_2(PL(0,85),W(1,2),GC_5,MDL_MB,ZERO,PL(0,140)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,85),4,COEFS,4,4,WL(1,0
     $ ,1,140))
      CALL MP_FFV1L1_2(PL(0,140),W(1,4),GC_5,MDL_MB,ZERO,PL(0,141)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_4_1(WL(1,0,1,140),4,COEFS,4,4,WL(1,0
     $ ,1,141))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,141),5,4,64,1,1,118)
C     Coefficient construction for loop diagram with ID 65
      CALL MP_FFV1L1_2(PL(0,137),W(1,4),GC_5,MDL_MB,ZERO,PL(0,142)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,137),4,COEFS,4,4,WL(1,0
     $ ,1,142))
      CALL MP_FFV1L1_2(PL(0,142),W(1,5),GC_5,MDL_MB,ZERO,PL(0,143)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_4_1(WL(1,0,1,142),4,COEFS,4,4,WL(1,0
     $ ,1,143))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,143),5,4,65,1,1,119)
C     Coefficient construction for loop diagram with ID 66
      CALL MP_FFV1L1_2(PL(0,101),W(1,2),GC_5,MDL_MB,ZERO,PL(0,144)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,101),4,COEFS,4,4,WL(1,0
     $ ,1,144))
      CALL MP_FFV1L1_2(PL(0,144),W(1,5),GC_5,MDL_MB,ZERO,PL(0,145)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_4_1(WL(1,0,1,144),4,COEFS,4,4,WL(1,0
     $ ,1,145))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,145),5,4,66,1,1,120)
C     Coefficient construction for loop diagram with ID 67
      CALL MP_FFV1L2_1(PL(0,130),W(1,9),GC_5,MDL_MB,ZERO,PL(0,146)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,130),4,COEFS,4,4,WL(1,0
     $ ,1,146))
      CALL MP_FFS1L2_1(PL(0,146),W(1,3),GC_33,MDL_MB,ZERO,PL(0,147)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,146),4,COEFS,4,4,WL(1,0
     $ ,1,147))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,147),4,4,67,1,1,121)
C     Coefficient construction for loop diagram with ID 68
      CALL MP_FFV1L1_2(PL(0,84),W(1,20),GC_5,MDL_MB,ZERO,PL(0,148)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,84),4,COEFS,4,4,WL(1,0
     $ ,1,148))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,148),3,4,68,1,1,122)
C     Coefficient construction for loop diagram with ID 69
      CALL MP_FFV1L1_2(PL(0,137),W(1,9),GC_5,MDL_MB,ZERO,PL(0,149)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,137),4,COEFS,4,4,WL(1,0
     $ ,1,149))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,149),4,4,69,1,1,123)
C     Coefficient construction for loop diagram with ID 70
      CALL MP_FFS1L2_1(PL(0,130),W(1,3),GC_33,MDL_MB,ZERO,PL(0,150)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,130),4,COEFS,4,4,WL(1,0
     $ ,1,150))
      CALL MP_FFV1L2_1(PL(0,150),W(1,9),GC_5,MDL_MB,ZERO,PL(0,151)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,150),4,COEFS,4,4,WL(1,0
     $ ,1,151))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,151),4,4,70,1,1,124)
C     Coefficient construction for loop diagram with ID 71
      CALL MP_FFV1L2_1(PL(0,76),W(1,20),GC_5,MDL_MB,ZERO,PL(0,152)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,76),4,COEFS,4,4,WL(1,0
     $ ,1,152))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,152),3,4,71,1,1,125)
C     Coefficient construction for loop diagram with ID 72
      CALL MP_FFV1L2_1(PL(0,76),W(1,2),GC_5,MDL_MB,ZERO,PL(0,153)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,76),4,COEFS,4,4,WL(1,0
     $ ,1,153))
      CALL MP_FFV1L2_1(PL(0,153),W(1,9),GC_5,MDL_MB,ZERO,PL(0,154)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,153),4,COEFS,4,4,WL(1,0
     $ ,1,154))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,154),4,4,72,1,1,126)
C     Coefficient construction for loop diagram with ID 73
      CALL MP_FFS1L2_1(PL(0,131),W(1,3),GC_33,MDL_MB,ZERO,PL(0,155)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,131),4,COEFS,4,4,WL(1,0
     $ ,1,155))
      CALL MP_FFV1L2_1(PL(0,155),W(1,4),GC_5,MDL_MB,ZERO,PL(0,156)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_4_1(WL(1,0,1,155),4,COEFS,4,4,WL(1,0
     $ ,1,156))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,156),5,4,73,1,1,127)
C     Coefficient construction for loop diagram with ID 74
      CALL MP_FFV1L2_1(PL(0,150),W(1,5),GC_5,MDL_MB,ZERO,PL(0,157)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,150),4,COEFS,4,4,WL(1,0
     $ ,1,157))
      CALL MP_FFV1L2_1(PL(0,157),W(1,4),GC_5,MDL_MB,ZERO,PL(0,158)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_4_1(WL(1,0,1,157),4,COEFS,4,4,WL(1,0
     $ ,1,158))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,158),5,4,74,1,1,128)
C     Coefficient construction for loop diagram with ID 75
      CALL MP_FFV1L2_1(PL(0,78),W(1,2),GC_5,MDL_MB,ZERO,PL(0,159)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,78),4,COEFS,4,4,WL(1,0
     $ ,1,159))
      CALL MP_FFV1L2_1(PL(0,159),W(1,4),GC_5,MDL_MB,ZERO,PL(0,160)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_4_1(WL(1,0,1,159),4,COEFS,4,4,WL(1,0
     $ ,1,160))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,160),5,4,75,1,1,129)
C     Coefficient construction for loop diagram with ID 76
      CALL MP_FFV1L2_1(PL(0,153),W(1,5),GC_5,MDL_MB,ZERO,PL(0,161)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,153),4,COEFS,4,4,WL(1,0
     $ ,1,161))
      CALL MP_FFV1L2_1(PL(0,161),W(1,4),GC_5,MDL_MB,ZERO,PL(0,162)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_4_1(WL(1,0,1,161),4,COEFS,4,4,WL(1,0
     $ ,1,162))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,162),5,4,76,1,1,130)
C     Coefficient construction for loop diagram with ID 77
      CALL MP_FFV1L1_2(PL(0,106),W(1,2),GC_5,MDL_MB,ZERO,PL(0,163)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,106),4,COEFS,4,4,WL(1,0
     $ ,1,163))
      CALL MP_FFS1L1_2(PL(0,163),W(1,3),GC_33,MDL_MB,ZERO,PL(0,164)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,163),4,COEFS,4,4,WL(1,0
     $ ,1,164))
      CALL MP_FFV1L1_2(PL(0,164),W(1,5),GC_5,MDL_MB,ZERO,PL(0,165)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_4_1(WL(1,0,1,164),4,COEFS,4,4,WL(1,0
     $ ,1,165))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,165),5,4,77,1,1,131)
C     Coefficient construction for loop diagram with ID 78
      CALL MP_FFV1L1_2(PL(0,107),W(1,2),GC_5,MDL_MB,ZERO,PL(0,166)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,107),4,COEFS,4,4,WL(1,0
     $ ,1,166))
      CALL MP_FFV1L1_2(PL(0,166),W(1,5),GC_5,MDL_MB,ZERO,PL(0,167)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_4_1(WL(1,0,1,166),4,COEFS,4,4,WL(1,0
     $ ,1,167))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,167),5,4,78,1,1,132)
C     Coefficient construction for loop diagram with ID 79
      CALL MP_FFS1L2_1(PL(0,134),W(1,3),GC_33,MDL_MB,ZERO,PL(0,168)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,134),4,COEFS,4,4,WL(1,0
     $ ,1,168))
      CALL MP_FFV1L2_1(PL(0,168),W(1,5),GC_5,MDL_MB,ZERO,PL(0,169)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_4_1(WL(1,0,1,168),4,COEFS,4,4,WL(1,0
     $ ,1,169))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,169),5,4,79,1,1,133)
C     Coefficient construction for loop diagram with ID 80
      CALL MP_FFV1L2_1(PL(0,150),W(1,4),GC_5,MDL_MB,ZERO,PL(0,170)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,150),4,COEFS,4,4,WL(1,0
     $ ,1,170))
      CALL MP_FFV1L2_1(PL(0,170),W(1,5),GC_5,MDL_MB,ZERO,PL(0,171)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_4_1(WL(1,0,1,170),4,COEFS,4,4,WL(1,0
     $ ,1,171))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,171),5,4,80,1,1,134)
C     Coefficient construction for loop diagram with ID 81
      CALL MP_FFV1L2_1(PL(0,96),W(1,2),GC_5,MDL_MB,ZERO,PL(0,172)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,96),4,COEFS,4,4,WL(1,0
     $ ,1,172))
      CALL MP_FFV1L2_1(PL(0,172),W(1,5),GC_5,MDL_MB,ZERO,PL(0,173)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_4_1(WL(1,0,1,172),4,COEFS,4,4,WL(1,0
     $ ,1,173))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,173),5,4,81,1,1,135)
C     Coefficient construction for loop diagram with ID 82
      CALL MP_FFV1L2_1(PL(0,153),W(1,4),GC_5,MDL_MB,ZERO,PL(0,174)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,153),4,COEFS,4,4,WL(1,0
     $ ,1,174))
      CALL MP_FFV1L2_1(PL(0,174),W(1,5),GC_5,MDL_MB,ZERO,PL(0,175)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_4_1(WL(1,0,1,174),4,COEFS,4,4,WL(1,0
     $ ,1,175))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,175),5,4,82,1,1,136)
C     Coefficient construction for loop diagram with ID 83
      CALL MP_FFV1L2_1(PL(0,99),W(1,2),GC_5,MDL_MB,ZERO,PL(0,176)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,99),4,COEFS,4,4,WL(1,0
     $ ,1,176))
      CALL MP_FFV1L2_1(PL(0,176),W(1,5),GC_5,MDL_MB,ZERO,PL(0,177)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_4_1(WL(1,0,1,176),4,COEFS,4,4,WL(1,0
     $ ,1,177))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,177),5,4,83,1,1,137)
C     Coefficient construction for loop diagram with ID 84
      CALL MP_FFV1L2_1(PL(0,98),W(1,2),GC_5,MDL_MB,ZERO,PL(0,178)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,98),4,COEFS,4,4,WL(1,0
     $ ,1,178))
      CALL MP_FFS1L2_1(PL(0,178),W(1,3),GC_33,MDL_MB,ZERO,PL(0,179)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,178),4,COEFS,4,4,WL(1,0
     $ ,1,179))
      CALL MP_FFV1L2_1(PL(0,179),W(1,5),GC_5,MDL_MB,ZERO,PL(0,180)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_4_1(WL(1,0,1,179),4,COEFS,4,4,WL(1,0
     $ ,1,180))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,180),5,4,84,1,1,138)
C     Coefficient construction for loop diagram with ID 85
      CALL MP_FFV1L2_1(PL(0,76),W(1,21),GC_5,MDL_MB,ZERO,PL(0,181)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,76),4,COEFS,4,4,WL(1,0
     $ ,1,181))
      CALL MP_FFV1L2_1(PL(0,76),W(1,22),GC_5,MDL_MB,ZERO,PL(0,182)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,76),4,COEFS,4,4,WL(1,0
     $ ,1,182))
      CALL MP_FFV1L2_1(PL(0,76),W(1,23),GC_5,MDL_MB,ZERO,PL(0,183)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,76),4,COEFS,4,4,WL(1,0
     $ ,1,183))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,181),3,4,85,1,1,139)
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,182),3,4,86,1,1,140)
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,183),3,4,87,1,1,141)
C     Coefficient construction for loop diagram with ID 86
      CALL MP_FFV1L1_2(PL(0,84),W(1,21),GC_5,MDL_MB,ZERO,PL(0,184)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,84),4,COEFS,4,4,WL(1,0
     $ ,1,184))
      CALL MP_FFV1L1_2(PL(0,84),W(1,22),GC_5,MDL_MB,ZERO,PL(0,185)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,84),4,COEFS,4,4,WL(1,0
     $ ,1,185))
      CALL MP_FFV1L1_2(PL(0,84),W(1,23),GC_5,MDL_MB,ZERO,PL(0,186)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,84),4,COEFS,4,4,WL(1,0
     $ ,1,186))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,184),3,4,88,1,1,142)
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,185),3,4,89,1,1,143)
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,186),3,4,90,1,1,144)
C     Coefficient construction for loop diagram with ID 87
      CALL MP_FFV1L2_1(PL(0,2),W(1,24),GC_5,MDL_MB,ZERO,PL(0,187)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,2),4,COEFS,4,4,WL(1,0,1
     $ ,187))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,187),3,4,91,1,1,145)
C     Coefficient construction for loop diagram with ID 88
      CALL MP_FFV1L1_2(PL(0,21),W(1,24),GC_5,MDL_MB,ZERO,PL(0,188)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,21),4,COEFS,4,4,WL(1,0
     $ ,1,188))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,188),3,4,92,1,1,146)
C     Coefficient construction for loop diagram with ID 89
      CALL MP_FFV1L2_1(PL(0,4),W(1,25),GC_5,MDL_MB,ZERO,PL(0,189)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,4),4,COEFS,4,4,WL(1,0,1
     $ ,189))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,189),3,4,93,1,1,147)
C     Coefficient construction for loop diagram with ID 90
      CALL MP_FFV1L1_2(PL(0,15),W(1,25),GC_5,MDL_MB,ZERO,PL(0,190)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,15),4,COEFS,4,4,WL(1,0
     $ ,1,190))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,190),3,4,94,1,1,148)
C     Coefficient construction for loop diagram with ID 91
      CALL MP_FFV1L1_2(PL(0,40),W(1,26),GC_5,MDL_MB,ZERO,PL(0,191)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,40),4,COEFS,4,4,WL(1,0
     $ ,1,191))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,191),3,4,95,1,1,149)
C     Coefficient construction for loop diagram with ID 92
      CALL MP_FFV1L2_1(PL(0,32),W(1,26),GC_5,MDL_MB,ZERO,PL(0,192)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,32),4,COEFS,4,4,WL(1,0
     $ ,1,192))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,192),3,4,96,1,1,150)
C     Coefficient construction for loop diagram with ID 93
      CALL MP_FFV1L2_1(PL(0,2),W(1,27),GC_5,MDL_MB,ZERO,PL(0,193)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,2),4,COEFS,4,4,WL(1,0,1
     $ ,193))
      CALL MP_FFV1L2_1(PL(0,2),W(1,28),GC_5,MDL_MB,ZERO,PL(0,194)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,2),4,COEFS,4,4,WL(1,0,1
     $ ,194))
      CALL MP_FFV1L2_1(PL(0,2),W(1,29),GC_5,MDL_MB,ZERO,PL(0,195)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,2),4,COEFS,4,4,WL(1,0,1
     $ ,195))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,193),3,4,97,1,1,151)
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,194),3,4,98,1,1,152)
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,195),3,4,99,1,1,153)
C     Coefficient construction for loop diagram with ID 94
      CALL MP_FFV1L1_2(PL(0,21),W(1,27),GC_5,MDL_MB,ZERO,PL(0,196)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,21),4,COEFS,4,4,WL(1,0
     $ ,1,196))
      CALL MP_FFV1L1_2(PL(0,21),W(1,28),GC_5,MDL_MB,ZERO,PL(0,197)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,21),4,COEFS,4,4,WL(1,0
     $ ,1,197))
      CALL MP_FFV1L1_2(PL(0,21),W(1,29),GC_5,MDL_MB,ZERO,PL(0,198)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,21),4,COEFS,4,4,WL(1,0
     $ ,1,198))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,196),3,4,100,1,1
     $ ,154)
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,197),3,4,101,1,1
     $ ,155)
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,198),3,4,102,1,1
     $ ,156)
C     Coefficient construction for loop diagram with ID 95
      CALL MP_FFV1L2_1(PL(0,4),W(1,30),GC_5,MDL_MB,ZERO,PL(0,199)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,4),4,COEFS,4,4,WL(1,0,1
     $ ,199))
      CALL MP_FFV1L2_1(PL(0,4),W(1,31),GC_5,MDL_MB,ZERO,PL(0,200)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,4),4,COEFS,4,4,WL(1,0,1
     $ ,200))
      CALL MP_FFV1L2_1(PL(0,4),W(1,32),GC_5,MDL_MB,ZERO,PL(0,201)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,4),4,COEFS,4,4,WL(1,0,1
     $ ,201))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,199),3,4,103,1,1
     $ ,157)
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,200),3,4,104,1,1
     $ ,158)
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,201),3,4,105,1,1
     $ ,159)
C     Coefficient construction for loop diagram with ID 96
      CALL MP_FFV1L1_2(PL(0,15),W(1,30),GC_5,MDL_MB,ZERO,PL(0,202)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,15),4,COEFS,4,4,WL(1,0
     $ ,1,202))
      CALL MP_FFV1L1_2(PL(0,15),W(1,31),GC_5,MDL_MB,ZERO,PL(0,203)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,15),4,COEFS,4,4,WL(1,0
     $ ,1,203))
      CALL MP_FFV1L1_2(PL(0,15),W(1,32),GC_5,MDL_MB,ZERO,PL(0,204)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,15),4,COEFS,4,4,WL(1,0
     $ ,1,204))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,202),3,4,106,1,1
     $ ,160)
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,203),3,4,107,1,1
     $ ,161)
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,204),3,4,108,1,1
     $ ,162)
C     Coefficient construction for loop diagram with ID 97
      CALL MP_FFV1L2_1(PL(0,32),W(1,33),GC_5,MDL_MB,ZERO,PL(0,205)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,32),4,COEFS,4,4,WL(1,0
     $ ,1,205))
      CALL MP_FFV1L2_1(PL(0,32),W(1,34),GC_5,MDL_MB,ZERO,PL(0,206)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,32),4,COEFS,4,4,WL(1,0
     $ ,1,206))
      CALL MP_FFV1L2_1(PL(0,32),W(1,35),GC_5,MDL_MB,ZERO,PL(0,207)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,32),4,COEFS,4,4,WL(1,0
     $ ,1,207))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,205),3,4,109,1,1
     $ ,163)
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,206),3,4,110,1,1
     $ ,164)
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,207),3,4,111,1,1
     $ ,165)
C     Coefficient construction for loop diagram with ID 98
      CALL MP_FFV1L1_2(PL(0,40),W(1,33),GC_5,MDL_MB,ZERO,PL(0,208)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,40),4,COEFS,4,4,WL(1,0
     $ ,1,208))
      CALL MP_FFV1L1_2(PL(0,40),W(1,34),GC_5,MDL_MB,ZERO,PL(0,209)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,40),4,COEFS,4,4,WL(1,0
     $ ,1,209))
      CALL MP_FFV1L1_2(PL(0,40),W(1,35),GC_5,MDL_MB,ZERO,PL(0,210)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,40),4,COEFS,4,4,WL(1,0
     $ ,1,210))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,208),3,4,112,1,1
     $ ,166)
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,209),3,4,113,1,1
     $ ,167)
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,210),3,4,114,1,1
     $ ,168)
C     Coefficient construction for loop diagram with ID 99
      CALL MP_FFS1L2_1(PL(0,0),W(1,3),GC_37,MDL_MT,MDL_WT,PL(0,211)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_0_1(WL(1,0,1,0),4,COEFS,4,4,WL(1,0,1
     $ ,211))
      CALL MP_FFV1L2_1(PL(0,211),W(1,5),GC_5,MDL_MT,MDL_WT,PL(0,212)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_1_1(WL(1,0,1,211),4,COEFS,4,4,WL(1,0
     $ ,1,212))
      CALL MP_FFV1L2_1(PL(0,212),W(1,7),GC_5,MDL_MT,MDL_WT,PL(0,213)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,212),4,COEFS,4,4,WL(1,0
     $ ,1,213))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,213),3,4,115,1,1
     $ ,169)
C     Coefficient construction for loop diagram with ID 100
      CALL MP_FFV1L2_1(PL(0,211),W(1,4),GC_5,MDL_MT,MDL_WT,PL(0,214)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_1_1(WL(1,0,1,211),4,COEFS,4,4,WL(1,0
     $ ,1,214))
      CALL MP_FFV1L2_1(PL(0,214),W(1,8),GC_5,MDL_MT,MDL_WT,PL(0,215)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,214),4,COEFS,4,4,WL(1,0
     $ ,1,215))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,215),3,4,116,1,1
     $ ,170)
C     Coefficient construction for loop diagram with ID 101
      CALL MP_FFV1L2_1(PL(0,214),W(1,5),GC_5,MDL_MT,MDL_WT,PL(0,216)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,214),4,COEFS,4,4,WL(1,0
     $ ,1,216))
      CALL MP_FFV1L2_1(PL(0,216),W(1,6),GC_5,MDL_MT,MDL_WT,PL(0,217)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,216),4,COEFS,4,4,WL(1,0
     $ ,1,217))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,217),4,4,117,1,1
     $ ,171)
C     Coefficient construction for loop diagram with ID 102
      CALL MP_FFV1L2_1(PL(0,212),W(1,4),GC_5,MDL_MT,MDL_WT,PL(0,218)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,212),4,COEFS,4,4,WL(1,0
     $ ,1,218))
      CALL MP_FFV1L2_1(PL(0,218),W(1,6),GC_5,MDL_MT,MDL_WT,PL(0,219)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,218),4,COEFS,4,4,WL(1,0
     $ ,1,219))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,219),4,4,118,1,1
     $ ,172)
C     Coefficient construction for loop diagram with ID 103
      CALL MP_FFV1L2_1(PL(0,211),W(1,6),GC_5,MDL_MT,MDL_WT,PL(0,220)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_1_1(WL(1,0,1,211),4,COEFS,4,4,WL(1,0
     $ ,1,220))
      CALL MP_FFV1L2_1(PL(0,220),W(1,9),GC_5,MDL_MT,MDL_WT,PL(0,221)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,220),4,COEFS,4,4,WL(1,0
     $ ,1,221))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,221),3,4,119,1,1
     $ ,173)
C     Coefficient construction for loop diagram with ID 104
      CALL MP_FFS1L1_2(PL(0,0),W(1,3),GC_37,MDL_MT,MDL_WT,PL(0,222)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_0_1(WL(1,0,1,0),4,COEFS,4,4,WL(1,0,1
     $ ,222))
      CALL MP_FFV1L1_2(PL(0,222),W(1,6),GC_5,MDL_MT,MDL_WT,PL(0,223)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_1_1(WL(1,0,1,222),4,COEFS,4,4,WL(1,0
     $ ,1,223))
      CALL MP_FFV1L1_2(PL(0,223),W(1,9),GC_5,MDL_MT,MDL_WT,PL(0,224)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,223),4,COEFS,4,4,WL(1,0
     $ ,1,224))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,224),3,4,120,1,1
     $ ,174)
C     Coefficient construction for loop diagram with ID 105
      CALL MP_FFV1L1_2(PL(0,222),W(1,4),GC_5,MDL_MT,MDL_WT,PL(0,225)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_1_1(WL(1,0,1,222),4,COEFS,4,4,WL(1,0
     $ ,1,225))
      CALL MP_FFV1L1_2(PL(0,225),W(1,5),GC_5,MDL_MT,MDL_WT,PL(0,226)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,225),4,COEFS,4,4,WL(1,0
     $ ,1,226))
      CALL MP_FFV1L1_2(PL(0,226),W(1,6),GC_5,MDL_MT,MDL_WT,PL(0,227)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,226),4,COEFS,4,4,WL(1,0
     $ ,1,227))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,227),4,4,121,1,1
     $ ,175)
C     Coefficient construction for loop diagram with ID 106
      CALL MP_FFV1L1_2(PL(0,225),W(1,6),GC_5,MDL_MT,MDL_WT,PL(0,228)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,225),4,COEFS,4,4,WL(1,0
     $ ,1,228))
      CALL MP_FFV1L1_2(PL(0,228),W(1,5),GC_5,MDL_MT,MDL_WT,PL(0,229)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,228),4,COEFS,4,4,WL(1,0
     $ ,1,229))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,229),4,4,122,1,1
     $ ,176)
C     Coefficient construction for loop diagram with ID 107
      CALL MP_FFV1L1_2(PL(0,225),W(1,8),GC_5,MDL_MT,MDL_WT,PL(0,230)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,225),4,COEFS,4,4,WL(1,0
     $ ,1,230))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,230),3,4,123,1,1
     $ ,177)
C     Coefficient construction for loop diagram with ID 108
      CALL MP_FFV1L1_2(PL(0,222),W(1,5),GC_5,MDL_MT,MDL_WT,PL(0,231)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_1_1(WL(1,0,1,222),4,COEFS,4,4,WL(1,0
     $ ,1,231))
      CALL MP_FFV1L1_2(PL(0,231),W(1,4),GC_5,MDL_MT,MDL_WT,PL(0,232)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,231),4,COEFS,4,4,WL(1,0
     $ ,1,232))
      CALL MP_FFV1L1_2(PL(0,232),W(1,6),GC_5,MDL_MT,MDL_WT,PL(0,233)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,232),4,COEFS,4,4,WL(1,0
     $ ,1,233))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,233),4,4,124,1,1
     $ ,178)
C     Coefficient construction for loop diagram with ID 109
      CALL MP_FFV1L1_2(PL(0,231),W(1,7),GC_5,MDL_MT,MDL_WT,PL(0,234)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,231),4,COEFS,4,4,WL(1,0
     $ ,1,234))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,234),3,4,125,1,1
     $ ,179)
C     Coefficient construction for loop diagram with ID 110
      CALL MP_FFV1L2_1(PL(0,214),W(1,6),GC_5,MDL_MT,MDL_WT,PL(0,235)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,214),4,COEFS,4,4,WL(1,0
     $ ,1,235))
      CALL MP_FFV1L2_1(PL(0,235),W(1,5),GC_5,MDL_MT,MDL_WT,PL(0,236)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,235),4,COEFS,4,4,WL(1,0
     $ ,1,236))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,236),4,4,126,1,1
     $ ,180)
C     Coefficient construction for loop diagram with ID 111
      CALL MP_FFV1L1_2(PL(0,222),W(1,10),GC_5,MDL_MT,MDL_WT,PL(0,237)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_1_1(WL(1,0,1,222),4,COEFS,4,4,WL(1,0
     $ ,1,237))
      CALL MP_FFV1L1_2(PL(0,237),W(1,11),GC_5,MDL_MT,MDL_WT,PL(0,238)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,237),4,COEFS,4,4,WL(1,0
     $ ,1,238))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,238),3,4,127,1,1
     $ ,181)
C     Coefficient construction for loop diagram with ID 112
      CALL MP_FFV1L2_1(PL(0,211),W(1,10),GC_5,MDL_MT,MDL_WT,PL(0,239)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_1_1(WL(1,0,1,211),4,COEFS,4,4,WL(1,0
     $ ,1,239))
      CALL MP_FFV1L2_1(PL(0,239),W(1,11),GC_5,MDL_MT,MDL_WT,PL(0,240)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,239),4,COEFS,4,4,WL(1,0
     $ ,1,240))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,240),3,4,128,1,1
     $ ,182)
C     Coefficient construction for loop diagram with ID 113
      CALL MP_FFV1L2_1(PL(0,0),W(1,2),GC_5,MDL_MT,MDL_WT,PL(0,241)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_0_1(WL(1,0,1,0),4,COEFS,4,4,WL(1,0,1
     $ ,241))
      CALL MP_FFS1L2_1(PL(0,241),W(1,3),GC_37,MDL_MT,MDL_WT,PL(0,242)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_1_1(WL(1,0,1,241),4,COEFS,4,4,WL(1,0
     $ ,1,242))
      CALL MP_FFV1L2_1(PL(0,242),W(1,12),GC_5,MDL_MT,MDL_WT,PL(0,243)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,242),4,COEFS,4,4,WL(1,0
     $ ,1,243))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,243),3,4,129,1,1
     $ ,183)
C     Coefficient construction for loop diagram with ID 114
      CALL MP_FFV1L2_1(PL(0,242),W(1,5),GC_5,MDL_MT,MDL_WT,PL(0,244)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,242),4,COEFS,4,4,WL(1,0
     $ ,1,244))
      CALL MP_FFV1L2_1(PL(0,244),W(1,10),GC_5,MDL_MT,MDL_WT,PL(0,245)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,244),4,COEFS,4,4,WL(1,0
     $ ,1,245))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,245),4,4,130,1,1
     $ ,184)
C     Coefficient construction for loop diagram with ID 115
      CALL MP_FFV1L2_1(PL(0,241),W(1,5),GC_5,MDL_MT,MDL_WT,PL(0,246)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_1_1(WL(1,0,1,241),4,COEFS,4,4,WL(1,0
     $ ,1,246))
      CALL MP_FFS1L2_1(PL(0,246),W(1,3),GC_37,MDL_MT,MDL_WT,PL(0,247)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,246),4,COEFS,4,4,WL(1,0
     $ ,1,247))
      CALL MP_FFV1L2_1(PL(0,247),W(1,10),GC_5,MDL_MT,MDL_WT,PL(0,248)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,247),4,COEFS,4,4,WL(1,0
     $ ,1,248))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,248),4,4,131,1,1
     $ ,185)
C     Coefficient construction for loop diagram with ID 116
      CALL MP_FFV1L1_2(PL(0,0),W(1,2),GC_5,MDL_MT,MDL_WT,PL(0,249)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_0_1(WL(1,0,1,0),4,COEFS,4,4,WL(1,0,1
     $ ,249))
      CALL MP_FFS1L1_2(PL(0,249),W(1,3),GC_37,MDL_MT,MDL_WT,PL(0,250)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_1_1(WL(1,0,1,249),4,COEFS,4,4,WL(1,0
     $ ,1,250))
      CALL MP_FFV1L1_2(PL(0,250),W(1,5),GC_5,MDL_MT,MDL_WT,PL(0,251)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,250),4,COEFS,4,4,WL(1,0
     $ ,1,251))
      CALL MP_FFV1L1_2(PL(0,251),W(1,10),GC_5,MDL_MT,MDL_WT,PL(0,252)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,251),4,COEFS,4,4,WL(1,0
     $ ,1,252))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,252),4,4,132,1,1
     $ ,186)
C     Coefficient construction for loop diagram with ID 117
      CALL MP_FFV1L1_2(PL(0,250),W(1,10),GC_5,MDL_MT,MDL_WT,PL(0,253)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,250),4,COEFS,4,4,WL(1,0
     $ ,1,253))
      CALL MP_FFV1L1_2(PL(0,253),W(1,5),GC_5,MDL_MT,MDL_WT,PL(0,254)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,253),4,COEFS,4,4,WL(1,0
     $ ,1,254))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,254),4,4,133,1,1
     $ ,187)
C     Coefficient construction for loop diagram with ID 118
      CALL MP_FFV1L1_2(PL(0,250),W(1,12),GC_5,MDL_MT,MDL_WT,PL(0,255)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,250),4,COEFS,4,4,WL(1,0
     $ ,1,255))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,255),3,4,134,1,1
     $ ,188)
C     Coefficient construction for loop diagram with ID 119
      CALL MP_FFV1L1_2(PL(0,249),W(1,5),GC_5,MDL_MT,MDL_WT,PL(0,256)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_1_1(WL(1,0,1,249),4,COEFS,4,4,WL(1,0
     $ ,1,256))
      CALL MP_FFS1L1_2(PL(0,256),W(1,3),GC_37,MDL_MT,MDL_WT,PL(0,257)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,256),4,COEFS,4,4,WL(1,0
     $ ,1,257))
      CALL MP_FFV1L1_2(PL(0,257),W(1,10),GC_5,MDL_MT,MDL_WT,PL(0,258)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,257),4,COEFS,4,4,WL(1,0
     $ ,1,258))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,258),4,4,135,1,1
     $ ,189)
C     Coefficient construction for loop diagram with ID 120
      CALL MP_FFV1L2_1(PL(0,242),W(1,10),GC_5,MDL_MT,MDL_WT,PL(0,259)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,242),4,COEFS,4,4,WL(1,0
     $ ,1,259))
      CALL MP_FFV1L2_1(PL(0,259),W(1,5),GC_5,MDL_MT,MDL_WT,PL(0,260)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,259),4,COEFS,4,4,WL(1,0
     $ ,1,260))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,260),4,4,136,1,1
     $ ,190)
C     Coefficient construction for loop diagram with ID 121
      CALL MP_FFV1L2_1(PL(0,212),W(1,13),GC_5,MDL_MT,MDL_WT,PL(0,261)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,212),4,COEFS,4,4,WL(1,0
     $ ,1,261))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,261),3,4,137,1,1
     $ ,191)
C     Coefficient construction for loop diagram with ID 122
      CALL MP_FFV1L1_2(PL(0,231),W(1,13),GC_5,MDL_MT,MDL_WT,PL(0,262)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,231),4,COEFS,4,4,WL(1,0
     $ ,1,262))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,262),3,4,138,1,1
     $ ,192)
C     Coefficient construction for loop diagram with ID 123
      CALL MP_FFV1L2_1(PL(0,211),W(1,14),GC_5,MDL_MT,MDL_WT,PL(0,263)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_1_1(WL(1,0,1,211),4,COEFS,4,4,WL(1,0
     $ ,1,263))
      CALL MP_FFV1L2_1(PL(0,263),W(1,15),GC_5,MDL_MT,MDL_WT,PL(0,264)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,263),4,COEFS,4,4,WL(1,0
     $ ,1,264))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,264),3,4,139,1,1
     $ ,193)
C     Coefficient construction for loop diagram with ID 124
      CALL MP_FFV1L1_2(PL(0,222),W(1,14),GC_5,MDL_MT,MDL_WT,PL(0,265)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_1_1(WL(1,0,1,222),4,COEFS,4,4,WL(1,0
     $ ,1,265))
      CALL MP_FFV1L1_2(PL(0,265),W(1,15),GC_5,MDL_MT,MDL_WT,PL(0,266)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,265),4,COEFS,4,4,WL(1,0
     $ ,1,266))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,266),3,4,140,1,1
     $ ,194)
C     Coefficient construction for loop diagram with ID 125
      CALL MP_FFV1L2_1(PL(0,242),W(1,16),GC_5,MDL_MT,MDL_WT,PL(0,267)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,242),4,COEFS,4,4,WL(1,0
     $ ,1,267))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,267),3,4,141,1,1
     $ ,195)
C     Coefficient construction for loop diagram with ID 126
      CALL MP_FFV1L2_1(PL(0,242),W(1,4),GC_5,MDL_MT,MDL_WT,PL(0,268)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,242),4,COEFS,4,4,WL(1,0
     $ ,1,268))
      CALL MP_FFV1L2_1(PL(0,268),W(1,15),GC_5,MDL_MT,MDL_WT,PL(0,269)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,268),4,COEFS,4,4,WL(1,0
     $ ,1,269))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,269),4,4,142,1,1
     $ ,196)
C     Coefficient construction for loop diagram with ID 127
      CALL MP_FFV1L2_1(PL(0,241),W(1,4),GC_5,MDL_MT,MDL_WT,PL(0,270)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_1_1(WL(1,0,1,241),4,COEFS,4,4,WL(1,0
     $ ,1,270))
      CALL MP_FFS1L2_1(PL(0,270),W(1,3),GC_37,MDL_MT,MDL_WT,PL(0,271)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,270),4,COEFS,4,4,WL(1,0
     $ ,1,271))
      CALL MP_FFV1L2_1(PL(0,271),W(1,15),GC_5,MDL_MT,MDL_WT,PL(0,272)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,271),4,COEFS,4,4,WL(1,0
     $ ,1,272))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,272),4,4,143,1,1
     $ ,197)
C     Coefficient construction for loop diagram with ID 128
      CALL MP_FFV1L1_2(PL(0,250),W(1,4),GC_5,MDL_MT,MDL_WT,PL(0,273)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,250),4,COEFS,4,4,WL(1,0
     $ ,1,273))
      CALL MP_FFV1L1_2(PL(0,273),W(1,15),GC_5,MDL_MT,MDL_WT,PL(0,274)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,273),4,COEFS,4,4,WL(1,0
     $ ,1,274))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,274),4,4,144,1,1
     $ ,198)
C     Coefficient construction for loop diagram with ID 129
      CALL MP_FFV1L1_2(PL(0,250),W(1,15),GC_5,MDL_MT,MDL_WT,PL(0,275)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,250),4,COEFS,4,4,WL(1,0
     $ ,1,275))
      CALL MP_FFV1L1_2(PL(0,275),W(1,4),GC_5,MDL_MT,MDL_WT,PL(0,276)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,275),4,COEFS,4,4,WL(1,0
     $ ,1,276))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,276),4,4,145,1,1
     $ ,199)
C     Coefficient construction for loop diagram with ID 130
      CALL MP_FFV1L1_2(PL(0,250),W(1,16),GC_5,MDL_MT,MDL_WT,PL(0,277)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,250),4,COEFS,4,4,WL(1,0
     $ ,1,277))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,277),3,4,146,1,1
     $ ,200)
C     Coefficient construction for loop diagram with ID 131
      CALL MP_FFV1L1_2(PL(0,249),W(1,4),GC_5,MDL_MT,MDL_WT,PL(0,278)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_1_1(WL(1,0,1,249),4,COEFS,4,4,WL(1,0
     $ ,1,278))
      CALL MP_FFS1L1_2(PL(0,278),W(1,3),GC_37,MDL_MT,MDL_WT,PL(0,279)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,278),4,COEFS,4,4,WL(1,0
     $ ,1,279))
      CALL MP_FFV1L1_2(PL(0,279),W(1,15),GC_5,MDL_MT,MDL_WT,PL(0,280)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,279),4,COEFS,4,4,WL(1,0
     $ ,1,280))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,280),4,4,147,1,1
     $ ,201)
C     Coefficient construction for loop diagram with ID 132
      CALL MP_FFV1L2_1(PL(0,242),W(1,15),GC_5,MDL_MT,MDL_WT,PL(0,281)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,242),4,COEFS,4,4,WL(1,0
     $ ,1,281))
      CALL MP_FFV1L2_1(PL(0,281),W(1,4),GC_5,MDL_MT,MDL_WT,PL(0,282)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,281),4,COEFS,4,4,WL(1,0
     $ ,1,282))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,282),4,4,148,1,1
     $ ,202)
C     Coefficient construction for loop diagram with ID 133
      CALL MP_FFV1L2_1(PL(0,214),W(1,17),GC_5,MDL_MT,MDL_WT,PL(0,283)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,214),4,COEFS,4,4,WL(1,0
     $ ,1,283))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,283),3,4,149,1,1
     $ ,203)
C     Coefficient construction for loop diagram with ID 134
      CALL MP_FFV1L1_2(PL(0,225),W(1,17),GC_5,MDL_MT,MDL_WT,PL(0,284)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,225),4,COEFS,4,4,WL(1,0
     $ ,1,284))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,284),3,4,150,1,1
     $ ,204)
C     Coefficient construction for loop diagram with ID 135
      CALL MP_FFV1L2_1(PL(0,0),W(1,1),GC_5,MDL_MT,MDL_WT,PL(0,285)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_0_1(WL(1,0,1,0),4,COEFS,4,4,WL(1,0,1
     $ ,285))
      CALL MP_FFS1L2_1(PL(0,285),W(1,3),GC_37,MDL_MT,MDL_WT,PL(0,286)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_1_1(WL(1,0,1,285),4,COEFS,4,4,WL(1,0
     $ ,1,286))
      CALL MP_FFV1L2_1(PL(0,286),W(1,18),GC_5,MDL_MT,MDL_WT,PL(0,287)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,286),4,COEFS,4,4,WL(1,0
     $ ,1,287))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,287),3,4,151,1,1
     $ ,205)
C     Coefficient construction for loop diagram with ID 136
      CALL MP_FFV1L2_1(PL(0,286),W(1,5),GC_5,MDL_MT,MDL_WT,PL(0,288)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,286),4,COEFS,4,4,WL(1,0
     $ ,1,288))
      CALL MP_FFV1L2_1(PL(0,288),W(1,14),GC_5,MDL_MT,MDL_WT,PL(0,289)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,288),4,COEFS,4,4,WL(1,0
     $ ,1,289))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,289),4,4,152,1,1
     $ ,206)
C     Coefficient construction for loop diagram with ID 137
      CALL MP_FFV1L2_1(PL(0,285),W(1,5),GC_5,MDL_MT,MDL_WT,PL(0,290)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_1_1(WL(1,0,1,285),4,COEFS,4,4,WL(1,0
     $ ,1,290))
      CALL MP_FFS1L2_1(PL(0,290),W(1,3),GC_37,MDL_MT,MDL_WT,PL(0,291)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,290),4,COEFS,4,4,WL(1,0
     $ ,1,291))
      CALL MP_FFV1L2_1(PL(0,291),W(1,14),GC_5,MDL_MT,MDL_WT,PL(0,292)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,291),4,COEFS,4,4,WL(1,0
     $ ,1,292))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,292),4,4,153,1,1
     $ ,207)
C     Coefficient construction for loop diagram with ID 138
      CALL MP_FFV1L1_2(PL(0,0),W(1,1),GC_5,MDL_MT,MDL_WT,PL(0,293)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_0_1(WL(1,0,1,0),4,COEFS,4,4,WL(1,0,1
     $ ,293))
      CALL MP_FFS1L1_2(PL(0,293),W(1,3),GC_37,MDL_MT,MDL_WT,PL(0,294)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_1_1(WL(1,0,1,293),4,COEFS,4,4,WL(1,0
     $ ,1,294))
      CALL MP_FFV1L1_2(PL(0,294),W(1,5),GC_5,MDL_MT,MDL_WT,PL(0,295)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,294),4,COEFS,4,4,WL(1,0
     $ ,1,295))
      CALL MP_FFV1L1_2(PL(0,295),W(1,14),GC_5,MDL_MT,MDL_WT,PL(0,296)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,295),4,COEFS,4,4,WL(1,0
     $ ,1,296))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,296),4,4,154,1,1
     $ ,208)
C     Coefficient construction for loop diagram with ID 139
      CALL MP_FFV1L1_2(PL(0,294),W(1,18),GC_5,MDL_MT,MDL_WT,PL(0,297)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,294),4,COEFS,4,4,WL(1,0
     $ ,1,297))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,297),3,4,155,1,1
     $ ,209)
C     Coefficient construction for loop diagram with ID 140
      CALL MP_FFV1L1_2(PL(0,294),W(1,14),GC_5,MDL_MT,MDL_WT,PL(0,298)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,294),4,COEFS,4,4,WL(1,0
     $ ,1,298))
      CALL MP_FFV1L1_2(PL(0,298),W(1,5),GC_5,MDL_MT,MDL_WT,PL(0,299)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,298),4,COEFS,4,4,WL(1,0
     $ ,1,299))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,299),4,4,156,1,1
     $ ,210)
C     Coefficient construction for loop diagram with ID 141
      CALL MP_FFV1L1_2(PL(0,293),W(1,5),GC_5,MDL_MT,MDL_WT,PL(0,300)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_1_1(WL(1,0,1,293),4,COEFS,4,4,WL(1,0
     $ ,1,300))
      CALL MP_FFS1L1_2(PL(0,300),W(1,3),GC_37,MDL_MT,MDL_WT,PL(0,301)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,300),4,COEFS,4,4,WL(1,0
     $ ,1,301))
      CALL MP_FFV1L1_2(PL(0,301),W(1,14),GC_5,MDL_MT,MDL_WT,PL(0,302)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,301),4,COEFS,4,4,WL(1,0
     $ ,1,302))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,302),4,4,157,1,1
     $ ,211)
C     Coefficient construction for loop diagram with ID 142
      CALL MP_FFV1L2_1(PL(0,286),W(1,14),GC_5,MDL_MT,MDL_WT,PL(0,303)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,286),4,COEFS,4,4,WL(1,0
     $ ,1,303))
      CALL MP_FFV1L2_1(PL(0,303),W(1,5),GC_5,MDL_MT,MDL_WT,PL(0,304)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,303),4,COEFS,4,4,WL(1,0
     $ ,1,304))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,304),4,4,158,1,1
     $ ,212)
C     Coefficient construction for loop diagram with ID 143
      CALL MP_FFV1L2_1(PL(0,286),W(1,19),GC_5,MDL_MT,MDL_WT,PL(0,305)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,286),4,COEFS,4,4,WL(1,0
     $ ,1,305))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,305),3,4,159,1,1
     $ ,213)
C     Coefficient construction for loop diagram with ID 144
      CALL MP_FFV1L2_1(PL(0,286),W(1,4),GC_5,MDL_MT,MDL_WT,PL(0,306)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,286),4,COEFS,4,4,WL(1,0
     $ ,1,306))
      CALL MP_FFV1L2_1(PL(0,306),W(1,11),GC_5,MDL_MT,MDL_WT,PL(0,307)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,306),4,COEFS,4,4,WL(1,0
     $ ,1,307))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,307),4,4,160,1,1
     $ ,214)
C     Coefficient construction for loop diagram with ID 145
      CALL MP_FFV1L2_1(PL(0,285),W(1,4),GC_5,MDL_MT,MDL_WT,PL(0,308)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_1_1(WL(1,0,1,285),4,COEFS,4,4,WL(1,0
     $ ,1,308))
      CALL MP_FFS1L2_1(PL(0,308),W(1,3),GC_37,MDL_MT,MDL_WT,PL(0,309)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,308),4,COEFS,4,4,WL(1,0
     $ ,1,309))
      CALL MP_FFV1L2_1(PL(0,309),W(1,11),GC_5,MDL_MT,MDL_WT,PL(0,310)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,309),4,COEFS,4,4,WL(1,0
     $ ,1,310))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,310),4,4,161,1,1
     $ ,215)
C     Coefficient construction for loop diagram with ID 146
      CALL MP_FFV1L1_2(PL(0,294),W(1,4),GC_5,MDL_MT,MDL_WT,PL(0,311)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,294),4,COEFS,4,4,WL(1,0
     $ ,1,311))
      CALL MP_FFV1L1_2(PL(0,311),W(1,11),GC_5,MDL_MT,MDL_WT,PL(0,312)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,311),4,COEFS,4,4,WL(1,0
     $ ,1,312))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,312),4,4,162,1,1
     $ ,216)
C     Coefficient construction for loop diagram with ID 147
      CALL MP_FFV1L1_2(PL(0,294),W(1,19),GC_5,MDL_MT,MDL_WT,PL(0,313)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,294),4,COEFS,4,4,WL(1,0
     $ ,1,313))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,313),3,4,163,1,1
     $ ,217)
C     Coefficient construction for loop diagram with ID 148
      CALL MP_FFV1L1_2(PL(0,294),W(1,11),GC_5,MDL_MT,MDL_WT,PL(0,314)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,294),4,COEFS,4,4,WL(1,0
     $ ,1,314))
      CALL MP_FFV1L1_2(PL(0,314),W(1,4),GC_5,MDL_MT,MDL_WT,PL(0,315)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,314),4,COEFS,4,4,WL(1,0
     $ ,1,315))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,315),4,4,164,1,1
     $ ,218)
C     Coefficient construction for loop diagram with ID 149
      CALL MP_FFV1L1_2(PL(0,293),W(1,4),GC_5,MDL_MT,MDL_WT,PL(0,316)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_1_1(WL(1,0,1,293),4,COEFS,4,4,WL(1,0
     $ ,1,316))
      CALL MP_FFS1L1_2(PL(0,316),W(1,3),GC_37,MDL_MT,MDL_WT,PL(0,317)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,316),4,COEFS,4,4,WL(1,0
     $ ,1,317))
      CALL MP_FFV1L1_2(PL(0,317),W(1,11),GC_5,MDL_MT,MDL_WT,PL(0,318)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,317),4,COEFS,4,4,WL(1,0
     $ ,1,318))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,318),4,4,165,1,1
     $ ,219)
C     Coefficient construction for loop diagram with ID 150
      CALL MP_FFV1L2_1(PL(0,286),W(1,11),GC_5,MDL_MT,MDL_WT,PL(0,319)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,286),4,COEFS,4,4,WL(1,0
     $ ,1,319))
      CALL MP_FFV1L2_1(PL(0,319),W(1,4),GC_5,MDL_MT,MDL_WT,PL(0,320)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,319),4,COEFS,4,4,WL(1,0
     $ ,1,320))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,320),4,4,166,1,1
     $ ,220)
C     Coefficient construction for loop diagram with ID 151
      CALL MP_FFV1L1_2(PL(0,293),W(1,2),GC_5,MDL_MT,MDL_WT,PL(0,321)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_1_1(WL(1,0,1,293),4,COEFS,4,4,WL(1,0
     $ ,1,321))
      CALL MP_FFV1L1_2(PL(0,321),W(1,4),GC_5,MDL_MT,MDL_WT,PL(0,322)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,321),4,COEFS,4,4,WL(1,0
     $ ,1,322))
      CALL MP_FFV1L1_2(PL(0,322),W(1,5),GC_5,MDL_MT,MDL_WT,PL(0,323)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,322),4,COEFS,4,4,WL(1,0
     $ ,1,323))
      CALL MP_FFS1L1_2(PL(0,323),W(1,3),GC_37,MDL_MT,MDL_WT,PL(0,324)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_4_1(WL(1,0,1,323),4,COEFS,4,4,WL(1,0
     $ ,1,324))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,324),5,4,167,1,1
     $ ,221)
C     Coefficient construction for loop diagram with ID 152
      CALL MP_FFV1L1_2(PL(0,321),W(1,5),GC_5,MDL_MT,MDL_WT,PL(0,325)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,321),4,COEFS,4,4,WL(1,0
     $ ,1,325))
      CALL MP_FFV1L1_2(PL(0,325),W(1,4),GC_5,MDL_MT,MDL_WT,PL(0,326)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,325),4,COEFS,4,4,WL(1,0
     $ ,1,326))
      CALL MP_FFS1L1_2(PL(0,326),W(1,3),GC_37,MDL_MT,MDL_WT,PL(0,327)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_4_1(WL(1,0,1,326),4,COEFS,4,4,WL(1,0
     $ ,1,327))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,327),5,4,168,1,1
     $ ,222)
C     Coefficient construction for loop diagram with ID 153
      CALL MP_FFS1L1_2(PL(0,321),W(1,3),GC_37,MDL_MT,MDL_WT,PL(0,328)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,321),4,COEFS,4,4,WL(1,0
     $ ,1,328))
      CALL MP_FFV1L1_2(PL(0,328),W(1,5),GC_5,MDL_MT,MDL_WT,PL(0,329)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,328),4,COEFS,4,4,WL(1,0
     $ ,1,329))
      CALL MP_FFV1L1_2(PL(0,329),W(1,4),GC_5,MDL_MT,MDL_WT,PL(0,330)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_4_1(WL(1,0,1,329),4,COEFS,4,4,WL(1,0
     $ ,1,330))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,330),5,4,169,1,1
     $ ,223)
C     Coefficient construction for loop diagram with ID 154
      CALL MP_FFS1L1_2(PL(0,325),W(1,3),GC_37,MDL_MT,MDL_WT,PL(0,331)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,325),4,COEFS,4,4,WL(1,0
     $ ,1,331))
      CALL MP_FFV1L1_2(PL(0,331),W(1,4),GC_5,MDL_MT,MDL_WT,PL(0,332)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_4_1(WL(1,0,1,331),4,COEFS,4,4,WL(1,0
     $ ,1,332))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,332),5,4,170,1,1
     $ ,224)
C     Coefficient construction for loop diagram with ID 155
      CALL MP_FFV1L1_2(PL(0,328),W(1,4),GC_5,MDL_MT,MDL_WT,PL(0,333)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,328),4,COEFS,4,4,WL(1,0
     $ ,1,333))
      CALL MP_FFV1L1_2(PL(0,333),W(1,5),GC_5,MDL_MT,MDL_WT,PL(0,334)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_4_1(WL(1,0,1,333),4,COEFS,4,4,WL(1,0
     $ ,1,334))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,334),5,4,171,1,1
     $ ,225)
C     Coefficient construction for loop diagram with ID 156
      CALL MP_FFS1L1_2(PL(0,322),W(1,3),GC_37,MDL_MT,MDL_WT,PL(0,335)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,322),4,COEFS,4,4,WL(1,0
     $ ,1,335))
      CALL MP_FFV1L1_2(PL(0,335),W(1,5),GC_5,MDL_MT,MDL_WT,PL(0,336)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_4_1(WL(1,0,1,335),4,COEFS,4,4,WL(1,0
     $ ,1,336))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,336),5,4,172,1,1
     $ ,226)
C     Coefficient construction for loop diagram with ID 157
      CALL MP_FFV1L1_2(PL(0,321),W(1,9),GC_5,MDL_MT,MDL_WT,PL(0,337)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,321),4,COEFS,4,4,WL(1,0
     $ ,1,337))
      CALL MP_FFS1L1_2(PL(0,337),W(1,3),GC_37,MDL_MT,MDL_WT,PL(0,338)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,337),4,COEFS,4,4,WL(1,0
     $ ,1,338))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,338),4,4,173,1,1
     $ ,227)
C     Coefficient construction for loop diagram with ID 158
      CALL MP_FFV1L1_2(PL(0,328),W(1,9),GC_5,MDL_MT,MDL_WT,PL(0,339)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,328),4,COEFS,4,4,WL(1,0
     $ ,1,339))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,339),4,4,174,1,1
     $ ,228)
C     Coefficient construction for loop diagram with ID 159
      CALL MP_FFV1L2_1(PL(0,285),W(1,2),GC_5,MDL_MT,MDL_WT,PL(0,340)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_1_1(WL(1,0,1,285),4,COEFS,4,4,WL(1,0
     $ ,1,340))
      CALL MP_FFV1L2_1(PL(0,340),W(1,5),GC_5,MDL_MT,MDL_WT,PL(0,341)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,340),4,COEFS,4,4,WL(1,0
     $ ,1,341))
      CALL MP_FFV1L2_1(PL(0,341),W(1,4),GC_5,MDL_MT,MDL_WT,PL(0,342)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,341),4,COEFS,4,4,WL(1,0
     $ ,1,342))
      CALL MP_FFS1L2_1(PL(0,342),W(1,3),GC_37,MDL_MT,MDL_WT,PL(0,343)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_4_1(WL(1,0,1,342),4,COEFS,4,4,WL(1,0
     $ ,1,343))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,343),5,4,175,1,1
     $ ,229)
C     Coefficient construction for loop diagram with ID 160
      CALL MP_FFV1L2_1(PL(0,340),W(1,4),GC_5,MDL_MT,MDL_WT,PL(0,344)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,340),4,COEFS,4,4,WL(1,0
     $ ,1,344))
      CALL MP_FFV1L2_1(PL(0,344),W(1,5),GC_5,MDL_MT,MDL_WT,PL(0,345)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,344),4,COEFS,4,4,WL(1,0
     $ ,1,345))
      CALL MP_FFS1L2_1(PL(0,345),W(1,3),GC_37,MDL_MT,MDL_WT,PL(0,346)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_4_1(WL(1,0,1,345),4,COEFS,4,4,WL(1,0
     $ ,1,346))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,346),5,4,176,1,1
     $ ,230)
C     Coefficient construction for loop diagram with ID 161
      CALL MP_FFV1L1_2(PL(0,294),W(1,2),GC_5,MDL_MT,MDL_WT,PL(0,347)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,294),4,COEFS,4,4,WL(1,0
     $ ,1,347))
      CALL MP_FFV1L1_2(PL(0,347),W(1,5),GC_5,MDL_MT,MDL_WT,PL(0,348)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,347),4,COEFS,4,4,WL(1,0
     $ ,1,348))
      CALL MP_FFV1L1_2(PL(0,348),W(1,4),GC_5,MDL_MT,MDL_WT,PL(0,349)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_4_1(WL(1,0,1,348),4,COEFS,4,4,WL(1,0
     $ ,1,349))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,349),5,4,177,1,1
     $ ,231)
C     Coefficient construction for loop diagram with ID 162
      CALL MP_FFV1L1_2(PL(0,295),W(1,2),GC_5,MDL_MT,MDL_WT,PL(0,350)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,295),4,COEFS,4,4,WL(1,0
     $ ,1,350))
      CALL MP_FFV1L1_2(PL(0,350),W(1,4),GC_5,MDL_MT,MDL_WT,PL(0,351)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_4_1(WL(1,0,1,350),4,COEFS,4,4,WL(1,0
     $ ,1,351))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,351),5,4,178,1,1
     $ ,232)
C     Coefficient construction for loop diagram with ID 163
      CALL MP_FFV1L1_2(PL(0,347),W(1,4),GC_5,MDL_MT,MDL_WT,PL(0,352)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,347),4,COEFS,4,4,WL(1,0
     $ ,1,352))
      CALL MP_FFV1L1_2(PL(0,352),W(1,5),GC_5,MDL_MT,MDL_WT,PL(0,353)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_4_1(WL(1,0,1,352),4,COEFS,4,4,WL(1,0
     $ ,1,353))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,353),5,4,179,1,1
     $ ,233)
C     Coefficient construction for loop diagram with ID 164
      CALL MP_FFV1L1_2(PL(0,311),W(1,2),GC_5,MDL_MT,MDL_WT,PL(0,354)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,311),4,COEFS,4,4,WL(1,0
     $ ,1,354))
      CALL MP_FFV1L1_2(PL(0,354),W(1,5),GC_5,MDL_MT,MDL_WT,PL(0,355)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_4_1(WL(1,0,1,354),4,COEFS,4,4,WL(1,0
     $ ,1,355))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,355),5,4,180,1,1
     $ ,234)
C     Coefficient construction for loop diagram with ID 165
      CALL MP_FFV1L2_1(PL(0,340),W(1,9),GC_5,MDL_MT,MDL_WT,PL(0,356)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,340),4,COEFS,4,4,WL(1,0
     $ ,1,356))
      CALL MP_FFS1L2_1(PL(0,356),W(1,3),GC_37,MDL_MT,MDL_WT,PL(0,357)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,356),4,COEFS,4,4,WL(1,0
     $ ,1,357))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,357),4,4,181,1,1
     $ ,235)
C     Coefficient construction for loop diagram with ID 166
      CALL MP_FFV1L1_2(PL(0,294),W(1,20),GC_5,MDL_MT,MDL_WT,PL(0,358)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,294),4,COEFS,4,4,WL(1,0
     $ ,1,358))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,358),3,4,182,1,1
     $ ,236)
C     Coefficient construction for loop diagram with ID 167
      CALL MP_FFV1L1_2(PL(0,347),W(1,9),GC_5,MDL_MT,MDL_WT,PL(0,359)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,347),4,COEFS,4,4,WL(1,0
     $ ,1,359))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,359),4,4,183,1,1
     $ ,237)
C     Coefficient construction for loop diagram with ID 168
      CALL MP_FFS1L2_1(PL(0,340),W(1,3),GC_37,MDL_MT,MDL_WT,PL(0,360)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,340),4,COEFS,4,4,WL(1,0
     $ ,1,360))
      CALL MP_FFV1L2_1(PL(0,360),W(1,9),GC_5,MDL_MT,MDL_WT,PL(0,361)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,360),4,COEFS,4,4,WL(1,0
     $ ,1,361))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,361),4,4,184,1,1
     $ ,238)
C     Coefficient construction for loop diagram with ID 169
      CALL MP_FFV1L2_1(PL(0,286),W(1,20),GC_5,MDL_MT,MDL_WT,PL(0,362)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,286),4,COEFS,4,4,WL(1,0
     $ ,1,362))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,362),3,4,185,1,1
     $ ,239)
C     Coefficient construction for loop diagram with ID 170
      CALL MP_FFV1L2_1(PL(0,286),W(1,2),GC_5,MDL_MT,MDL_WT,PL(0,363)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,286),4,COEFS,4,4,WL(1,0
     $ ,1,363))
      CALL MP_FFV1L2_1(PL(0,363),W(1,9),GC_5,MDL_MT,MDL_WT,PL(0,364)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,363),4,COEFS,4,4,WL(1,0
     $ ,1,364))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,364),4,4,186,1,1
     $ ,240)
C     Coefficient construction for loop diagram with ID 171
      CALL MP_FFS1L2_1(PL(0,341),W(1,3),GC_37,MDL_MT,MDL_WT,PL(0,365)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,341),4,COEFS,4,4,WL(1,0
     $ ,1,365))
      CALL MP_FFV1L2_1(PL(0,365),W(1,4),GC_5,MDL_MT,MDL_WT,PL(0,366)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_4_1(WL(1,0,1,365),4,COEFS,4,4,WL(1,0
     $ ,1,366))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,366),5,4,187,1,1
     $ ,241)
C     Coefficient construction for loop diagram with ID 172
      CALL MP_FFV1L2_1(PL(0,360),W(1,5),GC_5,MDL_MT,MDL_WT,PL(0,367)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,360),4,COEFS,4,4,WL(1,0
     $ ,1,367))
      CALL MP_FFV1L2_1(PL(0,367),W(1,4),GC_5,MDL_MT,MDL_WT,PL(0,368)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_4_1(WL(1,0,1,367),4,COEFS,4,4,WL(1,0
     $ ,1,368))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,368),5,4,188,1,1
     $ ,242)
C     Coefficient construction for loop diagram with ID 173
      CALL MP_FFV1L2_1(PL(0,288),W(1,2),GC_5,MDL_MT,MDL_WT,PL(0,369)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,288),4,COEFS,4,4,WL(1,0
     $ ,1,369))
      CALL MP_FFV1L2_1(PL(0,369),W(1,4),GC_5,MDL_MT,MDL_WT,PL(0,370)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_4_1(WL(1,0,1,369),4,COEFS,4,4,WL(1,0
     $ ,1,370))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,370),5,4,189,1,1
     $ ,243)
C     Coefficient construction for loop diagram with ID 174
      CALL MP_FFV1L2_1(PL(0,363),W(1,5),GC_5,MDL_MT,MDL_WT,PL(0,371)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,363),4,COEFS,4,4,WL(1,0
     $ ,1,371))
      CALL MP_FFV1L2_1(PL(0,371),W(1,4),GC_5,MDL_MT,MDL_WT,PL(0,372)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_4_1(WL(1,0,1,371),4,COEFS,4,4,WL(1,0
     $ ,1,372))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,372),5,4,190,1,1
     $ ,244)
C     Coefficient construction for loop diagram with ID 175
      CALL MP_FFV1L1_2(PL(0,316),W(1,2),GC_5,MDL_MT,MDL_WT,PL(0,373)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,316),4,COEFS,4,4,WL(1,0
     $ ,1,373))
      CALL MP_FFS1L1_2(PL(0,373),W(1,3),GC_37,MDL_MT,MDL_WT,PL(0,374)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,373),4,COEFS,4,4,WL(1,0
     $ ,1,374))
      CALL MP_FFV1L1_2(PL(0,374),W(1,5),GC_5,MDL_MT,MDL_WT,PL(0,375)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_4_1(WL(1,0,1,374),4,COEFS,4,4,WL(1,0
     $ ,1,375))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,375),5,4,191,1,1
     $ ,245)
C     Coefficient construction for loop diagram with ID 176
      CALL MP_FFV1L1_2(PL(0,317),W(1,2),GC_5,MDL_MT,MDL_WT,PL(0,376)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,317),4,COEFS,4,4,WL(1,0
     $ ,1,376))
      CALL MP_FFV1L1_2(PL(0,376),W(1,5),GC_5,MDL_MT,MDL_WT,PL(0,377)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_4_1(WL(1,0,1,376),4,COEFS,4,4,WL(1,0
     $ ,1,377))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,377),5,4,192,1,1
     $ ,246)
C     Coefficient construction for loop diagram with ID 177
      CALL MP_FFS1L2_1(PL(0,344),W(1,3),GC_37,MDL_MT,MDL_WT,PL(0,378)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,344),4,COEFS,4,4,WL(1,0
     $ ,1,378))
      CALL MP_FFV1L2_1(PL(0,378),W(1,5),GC_5,MDL_MT,MDL_WT,PL(0,379)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_4_1(WL(1,0,1,378),4,COEFS,4,4,WL(1,0
     $ ,1,379))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,379),5,4,193,1,1
     $ ,247)
C     Coefficient construction for loop diagram with ID 178
      CALL MP_FFV1L2_1(PL(0,360),W(1,4),GC_5,MDL_MT,MDL_WT,PL(0,380)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,360),4,COEFS,4,4,WL(1,0
     $ ,1,380))
      CALL MP_FFV1L2_1(PL(0,380),W(1,5),GC_5,MDL_MT,MDL_WT,PL(0,381)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_4_1(WL(1,0,1,380),4,COEFS,4,4,WL(1,0
     $ ,1,381))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,381),5,4,194,1,1
     $ ,248)
C     Coefficient construction for loop diagram with ID 179
      CALL MP_FFV1L2_1(PL(0,306),W(1,2),GC_5,MDL_MT,MDL_WT,PL(0,382)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,306),4,COEFS,4,4,WL(1,0
     $ ,1,382))
      CALL MP_FFV1L2_1(PL(0,382),W(1,5),GC_5,MDL_MT,MDL_WT,PL(0,383)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_4_1(WL(1,0,1,382),4,COEFS,4,4,WL(1,0
     $ ,1,383))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,383),5,4,195,1,1
     $ ,249)
C     Coefficient construction for loop diagram with ID 180
      CALL MP_FFV1L2_1(PL(0,363),W(1,4),GC_5,MDL_MT,MDL_WT,PL(0,384)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,363),4,COEFS,4,4,WL(1,0
     $ ,1,384))
      CALL MP_FFV1L2_1(PL(0,384),W(1,5),GC_5,MDL_MT,MDL_WT,PL(0,385)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_4_1(WL(1,0,1,384),4,COEFS,4,4,WL(1,0
     $ ,1,385))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,385),5,4,196,1,1
     $ ,250)
C     Coefficient construction for loop diagram with ID 181
      CALL MP_FFV1L2_1(PL(0,309),W(1,2),GC_5,MDL_MT,MDL_WT,PL(0,386)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,309),4,COEFS,4,4,WL(1,0
     $ ,1,386))
      CALL MP_FFV1L2_1(PL(0,386),W(1,5),GC_5,MDL_MT,MDL_WT,PL(0,387)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_4_1(WL(1,0,1,386),4,COEFS,4,4,WL(1,0
     $ ,1,387))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,387),5,4,197,1,1
     $ ,251)
C     Coefficient construction for loop diagram with ID 182
      CALL MP_FFV1L2_1(PL(0,308),W(1,2),GC_5,MDL_MT,MDL_WT,PL(0,388)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,308),4,COEFS,4,4,WL(1,0
     $ ,1,388))
      CALL MP_FFS1L2_1(PL(0,388),W(1,3),GC_37,MDL_MT,MDL_WT,PL(0,389)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_3_1(WL(1,0,1,388),4,COEFS,4,4,WL(1,0
     $ ,1,389))
      CALL MP_FFV1L2_1(PL(0,389),W(1,5),GC_5,MDL_MT,MDL_WT,PL(0,390)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_4_1(WL(1,0,1,389),4,COEFS,4,4,WL(1,0
     $ ,1,390))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,390),5,4,198,1,1
     $ ,252)
C     Coefficient construction for loop diagram with ID 183
      CALL MP_FFV1L2_1(PL(0,286),W(1,21),GC_5,MDL_MT,MDL_WT,PL(0,391)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,286),4,COEFS,4,4,WL(1,0
     $ ,1,391))
      CALL MP_FFV1L2_1(PL(0,286),W(1,22),GC_5,MDL_MT,MDL_WT,PL(0,392)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,286),4,COEFS,4,4,WL(1,0
     $ ,1,392))
      CALL MP_FFV1L2_1(PL(0,286),W(1,23),GC_5,MDL_MT,MDL_WT,PL(0,393)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,286),4,COEFS,4,4,WL(1,0
     $ ,1,393))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,391),3,4,199,1,1
     $ ,253)
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,392),3,4,200,1,1
     $ ,254)
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,393),3,4,201,1,1
     $ ,255)
C     Coefficient construction for loop diagram with ID 184
      CALL MP_FFV1L1_2(PL(0,294),W(1,21),GC_5,MDL_MT,MDL_WT,PL(0,394)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,294),4,COEFS,4,4,WL(1,0
     $ ,1,394))
      CALL MP_FFV1L1_2(PL(0,294),W(1,22),GC_5,MDL_MT,MDL_WT,PL(0,395)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,294),4,COEFS,4,4,WL(1,0
     $ ,1,395))
      CALL MP_FFV1L1_2(PL(0,294),W(1,23),GC_5,MDL_MT,MDL_WT,PL(0,396)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,294),4,COEFS,4,4,WL(1,0
     $ ,1,396))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,394),3,4,202,1,1
     $ ,256)
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,395),3,4,203,1,1
     $ ,257)
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,396),3,4,204,1,1
     $ ,258)
C     Coefficient construction for loop diagram with ID 185
      CALL MP_FFV1L2_1(PL(0,212),W(1,24),GC_5,MDL_MT,MDL_WT,PL(0,397)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,212),4,COEFS,4,4,WL(1,0
     $ ,1,397))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,397),3,4,205,1,1
     $ ,259)
C     Coefficient construction for loop diagram with ID 186
      CALL MP_FFV1L1_2(PL(0,231),W(1,24),GC_5,MDL_MT,MDL_WT,PL(0,398)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,231),4,COEFS,4,4,WL(1,0
     $ ,1,398))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,398),3,4,206,1,1
     $ ,260)
C     Coefficient construction for loop diagram with ID 187
      CALL MP_FFV1L2_1(PL(0,214),W(1,25),GC_5,MDL_MT,MDL_WT,PL(0,399)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,214),4,COEFS,4,4,WL(1,0
     $ ,1,399))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,399),3,4,207,1,1
     $ ,261)
C     Coefficient construction for loop diagram with ID 188
      CALL MP_FFV1L1_2(PL(0,225),W(1,25),GC_5,MDL_MT,MDL_WT,PL(0,400)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,225),4,COEFS,4,4,WL(1,0
     $ ,1,400))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,400),3,4,208,1,1
     $ ,262)
C     Coefficient construction for loop diagram with ID 189
      CALL MP_FFV1L1_2(PL(0,250),W(1,26),GC_5,MDL_MT,MDL_WT,PL(0,401)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,250),4,COEFS,4,4,WL(1,0
     $ ,1,401))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,401),3,4,209,1,1
     $ ,263)
C     Coefficient construction for loop diagram with ID 190
      CALL MP_FFV1L2_1(PL(0,242),W(1,26),GC_5,MDL_MT,MDL_WT,PL(0,402)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,242),4,COEFS,4,4,WL(1,0
     $ ,1,402))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,402),3,4,210,1,1
     $ ,264)
C     Coefficient construction for loop diagram with ID 191
      CALL MP_FFV1L2_1(PL(0,212),W(1,27),GC_5,MDL_MT,MDL_WT,PL(0,403)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,212),4,COEFS,4,4,WL(1,0
     $ ,1,403))
      CALL MP_FFV1L2_1(PL(0,212),W(1,28),GC_5,MDL_MT,MDL_WT,PL(0,404)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,212),4,COEFS,4,4,WL(1,0
     $ ,1,404))
      CALL MP_FFV1L2_1(PL(0,212),W(1,29),GC_5,MDL_MT,MDL_WT,PL(0,405)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,212),4,COEFS,4,4,WL(1,0
     $ ,1,405))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,403),3,4,211,1,1
     $ ,265)
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,404),3,4,212,1,1
     $ ,266)
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,405),3,4,213,1,1
     $ ,267)
C     Coefficient construction for loop diagram with ID 192
      CALL MP_FFV1L1_2(PL(0,231),W(1,27),GC_5,MDL_MT,MDL_WT,PL(0,406)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,231),4,COEFS,4,4,WL(1,0
     $ ,1,406))
      CALL MP_FFV1L1_2(PL(0,231),W(1,28),GC_5,MDL_MT,MDL_WT,PL(0,407)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,231),4,COEFS,4,4,WL(1,0
     $ ,1,407))
      CALL MP_FFV1L1_2(PL(0,231),W(1,29),GC_5,MDL_MT,MDL_WT,PL(0,408)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,231),4,COEFS,4,4,WL(1,0
     $ ,1,408))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,406),3,4,214,1,1
     $ ,268)
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,407),3,4,215,1,1
     $ ,269)
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,408),3,4,216,1,1
     $ ,270)
C     Coefficient construction for loop diagram with ID 193
      CALL MP_FFV1L2_1(PL(0,214),W(1,30),GC_5,MDL_MT,MDL_WT,PL(0,409)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,214),4,COEFS,4,4,WL(1,0
     $ ,1,409))
      CALL MP_FFV1L2_1(PL(0,214),W(1,31),GC_5,MDL_MT,MDL_WT,PL(0,410)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,214),4,COEFS,4,4,WL(1,0
     $ ,1,410))
      CALL MP_FFV1L2_1(PL(0,214),W(1,32),GC_5,MDL_MT,MDL_WT,PL(0,411)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,214),4,COEFS,4,4,WL(1,0
     $ ,1,411))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,409),3,4,217,1,1
     $ ,271)
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,410),3,4,218,1,1
     $ ,272)
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,411),3,4,219,1,1
     $ ,273)
C     Coefficient construction for loop diagram with ID 194
      CALL MP_FFV1L1_2(PL(0,225),W(1,30),GC_5,MDL_MT,MDL_WT,PL(0,412)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,225),4,COEFS,4,4,WL(1,0
     $ ,1,412))
      CALL MP_FFV1L1_2(PL(0,225),W(1,31),GC_5,MDL_MT,MDL_WT,PL(0,413)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,225),4,COEFS,4,4,WL(1,0
     $ ,1,413))
      CALL MP_FFV1L1_2(PL(0,225),W(1,32),GC_5,MDL_MT,MDL_WT,PL(0,414)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,225),4,COEFS,4,4,WL(1,0
     $ ,1,414))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,412),3,4,220,1,1
     $ ,274)
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,413),3,4,221,1,1
     $ ,275)
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,414),3,4,222,1,1
     $ ,276)
C     Coefficient construction for loop diagram with ID 195
      CALL MP_FFV1L2_1(PL(0,242),W(1,33),GC_5,MDL_MT,MDL_WT,PL(0,415)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,242),4,COEFS,4,4,WL(1,0
     $ ,1,415))
      CALL MP_FFV1L2_1(PL(0,242),W(1,34),GC_5,MDL_MT,MDL_WT,PL(0,416)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,242),4,COEFS,4,4,WL(1,0
     $ ,1,416))
      CALL MP_FFV1L2_1(PL(0,242),W(1,35),GC_5,MDL_MT,MDL_WT,PL(0,417)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,242),4,COEFS,4,4,WL(1,0
     $ ,1,417))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,415),3,4,223,1,1
     $ ,277)
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,416),3,4,224,1,1
     $ ,278)
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,417),3,4,225,1,1
     $ ,279)
C     Coefficient construction for loop diagram with ID 196
      CALL MP_FFV1L1_2(PL(0,250),W(1,33),GC_5,MDL_MT,MDL_WT,PL(0,418)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,250),4,COEFS,4,4,WL(1,0
     $ ,1,418))
      CALL MP_FFV1L1_2(PL(0,250),W(1,34),GC_5,MDL_MT,MDL_WT,PL(0,419)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,250),4,COEFS,4,4,WL(1,0
     $ ,1,419))
      CALL MP_FFV1L1_2(PL(0,250),W(1,35),GC_5,MDL_MT,MDL_WT,PL(0,420)
     $ ,COEFS)
      CALL MP_ML5_0_0_1_UPDATE_WL_2_1(WL(1,0,1,250),4,COEFS,4,4,WL(1,0
     $ ,1,420))
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,418),3,4,226,1,1
     $ ,280)
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,419),3,4,227,1,1
     $ ,281)
      CALL MP_ML5_0_0_1_CREATE_LOOP_COEFS(WL(1,0,1,420),3,4,228,1,1
     $ ,282)
C     At this point, all loop coefficients needed for (QCD=8), i.e. of
C      split order ID=1, are computed.
      IF(FILTER_SO.AND.SQSO_TARGET.EQ.1) GOTO 4000

      GOTO 1001
 4000 CONTINUE
      MP_LOOP_REQ_SO_DONE=.TRUE.
 1001 CONTINUE
      END

