      SUBROUTINE ML5_0_2_1_COEF_CONSTRUCTION_1(P,NHEL,H,IC)
C     
C     Modules
C     
      USE ML5_0_2_1_POLYNOMIAL_CONSTANTS
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
      PARAMETER (NLOOPS=40, NLOOPGROUPS=40, NCTAMPS=14)
      INTEGER    NLOOPAMPS
      PARAMETER (NLOOPAMPS=54)
      INTEGER    NWAVEFUNCS,NLOOPWAVEFUNCS
      PARAMETER (NWAVEFUNCS=17,NLOOPWAVEFUNCS=76)
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
      COMMON/ML5_0_2_1_FILTERS/GOODAMP,GOODHEL,HELOFFSET

      LOGICAL CHECKPHASE
      LOGICAL HELDOUBLECHECKED
      COMMON/ML5_0_2_1_INIT/CHECKPHASE, HELDOUBLECHECKED

      INTEGER SQSO_TARGET
      COMMON/ML5_0_2_1_SOCHOICE/SQSO_TARGET

      LOGICAL UVCT_REQ_SO_DONE,MP_UVCT_REQ_SO_DONE,CT_REQ_SO_DONE
     $ ,MP_CT_REQ_SO_DONE,LOOP_REQ_SO_DONE,MP_LOOP_REQ_SO_DONE
     $ ,CTCALL_REQ_SO_DONE,FILTER_SO
      COMMON/ML5_0_2_1_SO_REQS/UVCT_REQ_SO_DONE,MP_UVCT_REQ_SO_DONE
     $ ,CT_REQ_SO_DONE,MP_CT_REQ_SO_DONE,LOOP_REQ_SO_DONE
     $ ,MP_LOOP_REQ_SO_DONE,CTCALL_REQ_SO_DONE,FILTER_SO

      INTEGER I_SO
      COMMON/ML5_0_2_1_I_SO/I_SO
      INTEGER I_LIB
      COMMON/ML5_0_2_1_I_LIB/I_LIB

      COMPLEX*16 W(20,NWAVEFUNCS)
      COMMON/ML5_0_2_1_W/W

      COMPLEX*16 WL(MAXLWFSIZE,0:LOOPMAXCOEFS-1,MAXLWFSIZE,
     $ -1:NLOOPWAVEFUNCS)
      COMPLEX*16 PL(0:3,-1:NLOOPWAVEFUNCS)
      COMMON/ML5_0_2_1_WL/WL,PL

      COMPLEX*16 AMPL(3,NLOOPAMPS)
      COMMON/ML5_0_2_1_AMPL/AMPL

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
      CALL FFS1L2_1(PL(0,0),W(1,3),GC_33,MDL_MB,ZERO,PL(0,1),COEFS)
      CALL ML5_0_2_1_UPDATE_WL_0_1(WL(1,0,1,0),4,COEFS,4,4,WL(1,0,1,1))
      CALL FFV1L2_1(PL(0,1),W(1,4),GC_5,MDL_MB,ZERO,PL(0,2),COEFS)
      CALL ML5_0_2_1_UPDATE_WL_1_1(WL(1,0,1,1),4,COEFS,4,4,WL(1,0,1,2))
      CALL FFV1L2_1(PL(0,2),W(1,7),GC_5,MDL_MB,ZERO,PL(0,3),COEFS)
      CALL ML5_0_2_1_UPDATE_WL_2_1(WL(1,0,1,2),4,COEFS,4,4,WL(1,0,1,3))
      CALL ML5_0_2_1_CREATE_LOOP_COEFS(WL(1,0,1,3),3,4,1,1,1,15)
C     Coefficient construction for loop diagram with ID 2
      CALL FFS1L1_2(PL(0,0),W(1,3),GC_33,MDL_MB,ZERO,PL(0,4),COEFS)
      CALL ML5_0_2_1_UPDATE_WL_0_1(WL(1,0,1,0),4,COEFS,4,4,WL(1,0,1,4))
      CALL FFV1L1_2(PL(0,4),W(1,4),GC_5,MDL_MB,ZERO,PL(0,5),COEFS)
      CALL ML5_0_2_1_UPDATE_WL_1_1(WL(1,0,1,4),4,COEFS,4,4,WL(1,0,1,5))
      CALL FFV1L1_2(PL(0,5),W(1,7),GC_5,MDL_MB,ZERO,PL(0,6),COEFS)
      CALL ML5_0_2_1_UPDATE_WL_2_1(WL(1,0,1,5),4,COEFS,4,4,WL(1,0,1,6))
      CALL ML5_0_2_1_CREATE_LOOP_COEFS(WL(1,0,1,6),3,4,2,1,1,16)
C     Coefficient construction for loop diagram with ID 3
      CALL FFV1L1_2(PL(0,4),W(1,8),GC_5,MDL_MB,ZERO,PL(0,7),COEFS)
      CALL ML5_0_2_1_UPDATE_WL_1_1(WL(1,0,1,4),4,COEFS,4,4,WL(1,0,1,7))
      CALL FFV1L1_2(PL(0,7),W(1,9),GC_5,MDL_MB,ZERO,PL(0,8),COEFS)
      CALL ML5_0_2_1_UPDATE_WL_2_1(WL(1,0,1,7),4,COEFS,4,4,WL(1,0,1,8))
      CALL ML5_0_2_1_CREATE_LOOP_COEFS(WL(1,0,1,8),3,4,3,1,1,17)
C     Coefficient construction for loop diagram with ID 4
      CALL FFV1L2_1(PL(0,1),W(1,8),GC_5,MDL_MB,ZERO,PL(0,9),COEFS)
      CALL ML5_0_2_1_UPDATE_WL_1_1(WL(1,0,1,1),4,COEFS,4,4,WL(1,0,1,9))
      CALL FFV1L2_1(PL(0,9),W(1,9),GC_5,MDL_MB,ZERO,PL(0,10),COEFS)
      CALL ML5_0_2_1_UPDATE_WL_2_1(WL(1,0,1,9),4,COEFS,4,4,WL(1,0,1,10)
     $ )
      CALL ML5_0_2_1_CREATE_LOOP_COEFS(WL(1,0,1,10),3,4,4,1,1,18)
C     Coefficient construction for loop diagram with ID 5
      CALL FFV1L2_1(PL(0,2),W(1,11),GC_5,MDL_MB,ZERO,PL(0,11),COEFS)
      CALL ML5_0_2_1_UPDATE_WL_2_1(WL(1,0,1,2),4,COEFS,4,4,WL(1,0,1,11)
     $ )
      CALL ML5_0_2_1_CREATE_LOOP_COEFS(WL(1,0,1,11),3,4,5,1,1,19)
C     Coefficient construction for loop diagram with ID 6
      CALL FFV1L1_2(PL(0,5),W(1,11),GC_5,MDL_MB,ZERO,PL(0,12),COEFS)
      CALL ML5_0_2_1_UPDATE_WL_2_1(WL(1,0,1,5),4,COEFS,4,4,WL(1,0,1,12)
     $ )
      CALL ML5_0_2_1_CREATE_LOOP_COEFS(WL(1,0,1,12),3,4,6,1,1,20)
C     Coefficient construction for loop diagram with ID 7
      CALL FFV1L2_1(PL(0,0),W(1,1),GC_5,MDL_MB,ZERO,PL(0,13),COEFS)
      CALL ML5_0_2_1_UPDATE_WL_0_1(WL(1,0,1,0),4,COEFS,4,4,WL(1,0,1,13)
     $ )
      CALL FFS1L2_1(PL(0,13),W(1,3),GC_33,MDL_MB,ZERO,PL(0,14),COEFS)
      CALL ML5_0_2_1_UPDATE_WL_1_1(WL(1,0,1,13),4,COEFS,4,4,WL(1,0,1
     $ ,14))
      CALL FFV1L2_1(PL(0,14),W(1,13),GC_5,MDL_MB,ZERO,PL(0,15),COEFS)
      CALL ML5_0_2_1_UPDATE_WL_2_1(WL(1,0,1,14),4,COEFS,4,4,WL(1,0,1
     $ ,15))
      CALL ML5_0_2_1_CREATE_LOOP_COEFS(WL(1,0,1,15),3,4,7,1,1,21)
C     Coefficient construction for loop diagram with ID 8
      CALL FFV1L1_2(PL(0,0),W(1,1),GC_5,MDL_MB,ZERO,PL(0,16),COEFS)
      CALL ML5_0_2_1_UPDATE_WL_0_1(WL(1,0,1,0),4,COEFS,4,4,WL(1,0,1,16)
     $ )
      CALL FFS1L1_2(PL(0,16),W(1,3),GC_33,MDL_MB,ZERO,PL(0,17),COEFS)
      CALL ML5_0_2_1_UPDATE_WL_1_1(WL(1,0,1,16),4,COEFS,4,4,WL(1,0,1
     $ ,17))
      CALL FFV1L1_2(PL(0,17),W(1,13),GC_5,MDL_MB,ZERO,PL(0,18),COEFS)
      CALL ML5_0_2_1_UPDATE_WL_2_1(WL(1,0,1,17),4,COEFS,4,4,WL(1,0,1
     $ ,18))
      CALL ML5_0_2_1_CREATE_LOOP_COEFS(WL(1,0,1,18),3,4,8,1,1,22)
C     Coefficient construction for loop diagram with ID 9
      CALL FFV1L2_1(PL(0,14),W(1,14),GC_5,MDL_MB,ZERO,PL(0,19),COEFS)
      CALL ML5_0_2_1_UPDATE_WL_2_1(WL(1,0,1,14),4,COEFS,4,4,WL(1,0,1
     $ ,19))
      CALL ML5_0_2_1_CREATE_LOOP_COEFS(WL(1,0,1,19),3,4,9,1,1,23)
C     Coefficient construction for loop diagram with ID 10
      CALL FFV1L2_1(PL(0,14),W(1,4),GC_5,MDL_MB,ZERO,PL(0,20),COEFS)
      CALL ML5_0_2_1_UPDATE_WL_2_1(WL(1,0,1,14),4,COEFS,4,4,WL(1,0,1
     $ ,20))
      CALL FFV1L2_1(PL(0,20),W(1,9),GC_5,MDL_MB,ZERO,PL(0,21),COEFS)
      CALL ML5_0_2_1_UPDATE_WL_3_1(WL(1,0,1,20),4,COEFS,4,4,WL(1,0,1
     $ ,21))
      CALL ML5_0_2_1_CREATE_LOOP_COEFS(WL(1,0,1,21),4,4,10,1,1,24)
C     Coefficient construction for loop diagram with ID 11
      CALL FFV1L2_1(PL(0,13),W(1,4),GC_5,MDL_MB,ZERO,PL(0,22),COEFS)
      CALL ML5_0_2_1_UPDATE_WL_1_1(WL(1,0,1,13),4,COEFS,4,4,WL(1,0,1
     $ ,22))
      CALL FFS1L2_1(PL(0,22),W(1,3),GC_33,MDL_MB,ZERO,PL(0,23),COEFS)
      CALL ML5_0_2_1_UPDATE_WL_2_1(WL(1,0,1,22),4,COEFS,4,4,WL(1,0,1
     $ ,23))
      CALL FFV1L2_1(PL(0,23),W(1,9),GC_5,MDL_MB,ZERO,PL(0,24),COEFS)
      CALL ML5_0_2_1_UPDATE_WL_3_1(WL(1,0,1,23),4,COEFS,4,4,WL(1,0,1
     $ ,24))
      CALL ML5_0_2_1_CREATE_LOOP_COEFS(WL(1,0,1,24),4,4,11,1,1,25)
C     Coefficient construction for loop diagram with ID 12
      CALL FFV1L1_2(PL(0,17),W(1,4),GC_5,MDL_MB,ZERO,PL(0,25),COEFS)
      CALL ML5_0_2_1_UPDATE_WL_2_1(WL(1,0,1,17),4,COEFS,4,4,WL(1,0,1
     $ ,25))
      CALL FFV1L1_2(PL(0,25),W(1,9),GC_5,MDL_MB,ZERO,PL(0,26),COEFS)
      CALL ML5_0_2_1_UPDATE_WL_3_1(WL(1,0,1,25),4,COEFS,4,4,WL(1,0,1
     $ ,26))
      CALL ML5_0_2_1_CREATE_LOOP_COEFS(WL(1,0,1,26),4,4,12,1,1,26)
C     Coefficient construction for loop diagram with ID 13
      CALL FFV1L1_2(PL(0,17),W(1,14),GC_5,MDL_MB,ZERO,PL(0,27),COEFS)
      CALL ML5_0_2_1_UPDATE_WL_2_1(WL(1,0,1,17),4,COEFS,4,4,WL(1,0,1
     $ ,27))
      CALL ML5_0_2_1_CREATE_LOOP_COEFS(WL(1,0,1,27),3,4,13,1,1,27)
C     Coefficient construction for loop diagram with ID 14
      CALL FFV1L1_2(PL(0,17),W(1,9),GC_5,MDL_MB,ZERO,PL(0,28),COEFS)
      CALL ML5_0_2_1_UPDATE_WL_2_1(WL(1,0,1,17),4,COEFS,4,4,WL(1,0,1
     $ ,28))
      CALL FFV1L1_2(PL(0,28),W(1,4),GC_5,MDL_MB,ZERO,PL(0,29),COEFS)
      CALL ML5_0_2_1_UPDATE_WL_3_1(WL(1,0,1,28),4,COEFS,4,4,WL(1,0,1
     $ ,29))
      CALL ML5_0_2_1_CREATE_LOOP_COEFS(WL(1,0,1,29),4,4,14,1,1,28)
C     Coefficient construction for loop diagram with ID 15
      CALL FFV1L1_2(PL(0,16),W(1,4),GC_5,MDL_MB,ZERO,PL(0,30),COEFS)
      CALL ML5_0_2_1_UPDATE_WL_1_1(WL(1,0,1,16),4,COEFS,4,4,WL(1,0,1
     $ ,30))
      CALL FFS1L1_2(PL(0,30),W(1,3),GC_33,MDL_MB,ZERO,PL(0,31),COEFS)
      CALL ML5_0_2_1_UPDATE_WL_2_1(WL(1,0,1,30),4,COEFS,4,4,WL(1,0,1
     $ ,31))
      CALL FFV1L1_2(PL(0,31),W(1,9),GC_5,MDL_MB,ZERO,PL(0,32),COEFS)
      CALL ML5_0_2_1_UPDATE_WL_3_1(WL(1,0,1,31),4,COEFS,4,4,WL(1,0,1
     $ ,32))
      CALL ML5_0_2_1_CREATE_LOOP_COEFS(WL(1,0,1,32),4,4,15,1,1,29)
C     Coefficient construction for loop diagram with ID 16
      CALL FFV1L2_1(PL(0,14),W(1,9),GC_5,MDL_MB,ZERO,PL(0,33),COEFS)
      CALL ML5_0_2_1_UPDATE_WL_2_1(WL(1,0,1,14),4,COEFS,4,4,WL(1,0,1
     $ ,33))
      CALL FFV1L2_1(PL(0,33),W(1,4),GC_5,MDL_MB,ZERO,PL(0,34),COEFS)
      CALL ML5_0_2_1_UPDATE_WL_3_1(WL(1,0,1,33),4,COEFS,4,4,WL(1,0,1
     $ ,34))
      CALL ML5_0_2_1_CREATE_LOOP_COEFS(WL(1,0,1,34),4,4,16,1,1,30)
C     Coefficient construction for loop diagram with ID 17
      CALL FFV1L1_2(PL(0,17),W(1,16),GC_5,MDL_MB,ZERO,PL(0,35),COEFS)
      CALL ML5_0_2_1_UPDATE_WL_2_1(WL(1,0,1,17),4,COEFS,4,4,WL(1,0,1
     $ ,35))
      CALL ML5_0_2_1_CREATE_LOOP_COEFS(WL(1,0,1,35),3,4,17,1,1,31)
C     Coefficient construction for loop diagram with ID 18
      CALL FFV1L2_1(PL(0,14),W(1,16),GC_5,MDL_MB,ZERO,PL(0,36),COEFS)
      CALL ML5_0_2_1_UPDATE_WL_2_1(WL(1,0,1,14),4,COEFS,4,4,WL(1,0,1
     $ ,36))
      CALL ML5_0_2_1_CREATE_LOOP_COEFS(WL(1,0,1,36),3,4,18,1,1,32)
C     Coefficient construction for loop diagram with ID 19
      CALL FFV1L2_1(PL(0,2),W(1,17),GC_5,MDL_MB,ZERO,PL(0,37),COEFS)
      CALL ML5_0_2_1_UPDATE_WL_2_1(WL(1,0,1,2),4,COEFS,4,4,WL(1,0,1,37)
     $ )
      CALL ML5_0_2_1_CREATE_LOOP_COEFS(WL(1,0,1,37),3,4,19,1,1,33)
C     Coefficient construction for loop diagram with ID 20
      CALL FFV1L1_2(PL(0,5),W(1,17),GC_5,MDL_MB,ZERO,PL(0,38),COEFS)
      CALL ML5_0_2_1_UPDATE_WL_2_1(WL(1,0,1,5),4,COEFS,4,4,WL(1,0,1,38)
     $ )
      CALL ML5_0_2_1_CREATE_LOOP_COEFS(WL(1,0,1,38),3,4,20,1,1,34)
C     Coefficient construction for loop diagram with ID 21
      CALL FFS1L2_1(PL(0,0),W(1,3),GC_37,MDL_MT,MDL_WT,PL(0,39),COEFS)
      CALL ML5_0_2_1_UPDATE_WL_0_1(WL(1,0,1,0),4,COEFS,4,4,WL(1,0,1,39)
     $ )
      CALL FFV1L2_1(PL(0,39),W(1,4),GC_5,MDL_MT,MDL_WT,PL(0,40),COEFS)
      CALL ML5_0_2_1_UPDATE_WL_1_1(WL(1,0,1,39),4,COEFS,4,4,WL(1,0,1
     $ ,40))
      CALL FFV1L2_1(PL(0,40),W(1,7),GC_5,MDL_MT,MDL_WT,PL(0,41),COEFS)
      CALL ML5_0_2_1_UPDATE_WL_2_1(WL(1,0,1,40),4,COEFS,4,4,WL(1,0,1
     $ ,41))
      CALL ML5_0_2_1_CREATE_LOOP_COEFS(WL(1,0,1,41),3,4,21,1,1,35)
C     Coefficient construction for loop diagram with ID 22
      CALL FFS1L1_2(PL(0,0),W(1,3),GC_37,MDL_MT,MDL_WT,PL(0,42),COEFS)
      CALL ML5_0_2_1_UPDATE_WL_0_1(WL(1,0,1,0),4,COEFS,4,4,WL(1,0,1,42)
     $ )
      CALL FFV1L1_2(PL(0,42),W(1,4),GC_5,MDL_MT,MDL_WT,PL(0,43),COEFS)
      CALL ML5_0_2_1_UPDATE_WL_1_1(WL(1,0,1,42),4,COEFS,4,4,WL(1,0,1
     $ ,43))
      CALL FFV1L1_2(PL(0,43),W(1,7),GC_5,MDL_MT,MDL_WT,PL(0,44),COEFS)
      CALL ML5_0_2_1_UPDATE_WL_2_1(WL(1,0,1,43),4,COEFS,4,4,WL(1,0,1
     $ ,44))
      CALL ML5_0_2_1_CREATE_LOOP_COEFS(WL(1,0,1,44),3,4,22,1,1,36)
C     Coefficient construction for loop diagram with ID 23
      CALL FFV1L1_2(PL(0,42),W(1,8),GC_5,MDL_MT,MDL_WT,PL(0,45),COEFS)
      CALL ML5_0_2_1_UPDATE_WL_1_1(WL(1,0,1,42),4,COEFS,4,4,WL(1,0,1
     $ ,45))
      CALL FFV1L1_2(PL(0,45),W(1,9),GC_5,MDL_MT,MDL_WT,PL(0,46),COEFS)
      CALL ML5_0_2_1_UPDATE_WL_2_1(WL(1,0,1,45),4,COEFS,4,4,WL(1,0,1
     $ ,46))
      CALL ML5_0_2_1_CREATE_LOOP_COEFS(WL(1,0,1,46),3,4,23,1,1,37)
C     Coefficient construction for loop diagram with ID 24
      CALL FFV1L2_1(PL(0,39),W(1,8),GC_5,MDL_MT,MDL_WT,PL(0,47),COEFS)
      CALL ML5_0_2_1_UPDATE_WL_1_1(WL(1,0,1,39),4,COEFS,4,4,WL(1,0,1
     $ ,47))
      CALL FFV1L2_1(PL(0,47),W(1,9),GC_5,MDL_MT,MDL_WT,PL(0,48),COEFS)
      CALL ML5_0_2_1_UPDATE_WL_2_1(WL(1,0,1,47),4,COEFS,4,4,WL(1,0,1
     $ ,48))
      CALL ML5_0_2_1_CREATE_LOOP_COEFS(WL(1,0,1,48),3,4,24,1,1,38)
C     Coefficient construction for loop diagram with ID 25
      CALL FFV1L2_1(PL(0,40),W(1,11),GC_5,MDL_MT,MDL_WT,PL(0,49),COEFS)
      CALL ML5_0_2_1_UPDATE_WL_2_1(WL(1,0,1,40),4,COEFS,4,4,WL(1,0,1
     $ ,49))
      CALL ML5_0_2_1_CREATE_LOOP_COEFS(WL(1,0,1,49),3,4,25,1,1,39)
C     Coefficient construction for loop diagram with ID 26
      CALL FFV1L1_2(PL(0,43),W(1,11),GC_5,MDL_MT,MDL_WT,PL(0,50),COEFS)
      CALL ML5_0_2_1_UPDATE_WL_2_1(WL(1,0,1,43),4,COEFS,4,4,WL(1,0,1
     $ ,50))
      CALL ML5_0_2_1_CREATE_LOOP_COEFS(WL(1,0,1,50),3,4,26,1,1,40)
C     Coefficient construction for loop diagram with ID 27
      CALL FFV1L2_1(PL(0,0),W(1,1),GC_5,MDL_MT,MDL_WT,PL(0,51),COEFS)
      CALL ML5_0_2_1_UPDATE_WL_0_1(WL(1,0,1,0),4,COEFS,4,4,WL(1,0,1,51)
     $ )
      CALL FFS1L2_1(PL(0,51),W(1,3),GC_37,MDL_MT,MDL_WT,PL(0,52),COEFS)
      CALL ML5_0_2_1_UPDATE_WL_1_1(WL(1,0,1,51),4,COEFS,4,4,WL(1,0,1
     $ ,52))
      CALL FFV1L2_1(PL(0,52),W(1,13),GC_5,MDL_MT,MDL_WT,PL(0,53),COEFS)
      CALL ML5_0_2_1_UPDATE_WL_2_1(WL(1,0,1,52),4,COEFS,4,4,WL(1,0,1
     $ ,53))
      CALL ML5_0_2_1_CREATE_LOOP_COEFS(WL(1,0,1,53),3,4,27,1,1,41)
C     Coefficient construction for loop diagram with ID 28
      CALL FFV1L1_2(PL(0,0),W(1,1),GC_5,MDL_MT,MDL_WT,PL(0,54),COEFS)
      CALL ML5_0_2_1_UPDATE_WL_0_1(WL(1,0,1,0),4,COEFS,4,4,WL(1,0,1,54)
     $ )
      CALL FFS1L1_2(PL(0,54),W(1,3),GC_37,MDL_MT,MDL_WT,PL(0,55),COEFS)
      CALL ML5_0_2_1_UPDATE_WL_1_1(WL(1,0,1,54),4,COEFS,4,4,WL(1,0,1
     $ ,55))
      CALL FFV1L1_2(PL(0,55),W(1,13),GC_5,MDL_MT,MDL_WT,PL(0,56),COEFS)
      CALL ML5_0_2_1_UPDATE_WL_2_1(WL(1,0,1,55),4,COEFS,4,4,WL(1,0,1
     $ ,56))
      CALL ML5_0_2_1_CREATE_LOOP_COEFS(WL(1,0,1,56),3,4,28,1,1,42)
C     Coefficient construction for loop diagram with ID 29
      CALL FFV1L2_1(PL(0,52),W(1,14),GC_5,MDL_MT,MDL_WT,PL(0,57),COEFS)
      CALL ML5_0_2_1_UPDATE_WL_2_1(WL(1,0,1,52),4,COEFS,4,4,WL(1,0,1
     $ ,57))
      CALL ML5_0_2_1_CREATE_LOOP_COEFS(WL(1,0,1,57),3,4,29,1,1,43)
C     Coefficient construction for loop diagram with ID 30
      CALL FFV1L2_1(PL(0,52),W(1,4),GC_5,MDL_MT,MDL_WT,PL(0,58),COEFS)
      CALL ML5_0_2_1_UPDATE_WL_2_1(WL(1,0,1,52),4,COEFS,4,4,WL(1,0,1
     $ ,58))
      CALL FFV1L2_1(PL(0,58),W(1,9),GC_5,MDL_MT,MDL_WT,PL(0,59),COEFS)
      CALL ML5_0_2_1_UPDATE_WL_3_1(WL(1,0,1,58),4,COEFS,4,4,WL(1,0,1
     $ ,59))
      CALL ML5_0_2_1_CREATE_LOOP_COEFS(WL(1,0,1,59),4,4,30,1,1,44)
C     Coefficient construction for loop diagram with ID 31
      CALL FFV1L2_1(PL(0,51),W(1,4),GC_5,MDL_MT,MDL_WT,PL(0,60),COEFS)
      CALL ML5_0_2_1_UPDATE_WL_1_1(WL(1,0,1,51),4,COEFS,4,4,WL(1,0,1
     $ ,60))
      CALL FFS1L2_1(PL(0,60),W(1,3),GC_37,MDL_MT,MDL_WT,PL(0,61),COEFS)
      CALL ML5_0_2_1_UPDATE_WL_2_1(WL(1,0,1,60),4,COEFS,4,4,WL(1,0,1
     $ ,61))
      CALL FFV1L2_1(PL(0,61),W(1,9),GC_5,MDL_MT,MDL_WT,PL(0,62),COEFS)
      CALL ML5_0_2_1_UPDATE_WL_3_1(WL(1,0,1,61),4,COEFS,4,4,WL(1,0,1
     $ ,62))
      CALL ML5_0_2_1_CREATE_LOOP_COEFS(WL(1,0,1,62),4,4,31,1,1,45)
C     Coefficient construction for loop diagram with ID 32
      CALL FFV1L1_2(PL(0,55),W(1,4),GC_5,MDL_MT,MDL_WT,PL(0,63),COEFS)
      CALL ML5_0_2_1_UPDATE_WL_2_1(WL(1,0,1,55),4,COEFS,4,4,WL(1,0,1
     $ ,63))
      CALL FFV1L1_2(PL(0,63),W(1,9),GC_5,MDL_MT,MDL_WT,PL(0,64),COEFS)
      CALL ML5_0_2_1_UPDATE_WL_3_1(WL(1,0,1,63),4,COEFS,4,4,WL(1,0,1
     $ ,64))
      CALL ML5_0_2_1_CREATE_LOOP_COEFS(WL(1,0,1,64),4,4,32,1,1,46)
C     Coefficient construction for loop diagram with ID 33
      CALL FFV1L1_2(PL(0,55),W(1,14),GC_5,MDL_MT,MDL_WT,PL(0,65),COEFS)
      CALL ML5_0_2_1_UPDATE_WL_2_1(WL(1,0,1,55),4,COEFS,4,4,WL(1,0,1
     $ ,65))
      CALL ML5_0_2_1_CREATE_LOOP_COEFS(WL(1,0,1,65),3,4,33,1,1,47)
C     Coefficient construction for loop diagram with ID 34
      CALL FFV1L1_2(PL(0,55),W(1,9),GC_5,MDL_MT,MDL_WT,PL(0,66),COEFS)
      CALL ML5_0_2_1_UPDATE_WL_2_1(WL(1,0,1,55),4,COEFS,4,4,WL(1,0,1
     $ ,66))
      CALL FFV1L1_2(PL(0,66),W(1,4),GC_5,MDL_MT,MDL_WT,PL(0,67),COEFS)
      CALL ML5_0_2_1_UPDATE_WL_3_1(WL(1,0,1,66),4,COEFS,4,4,WL(1,0,1
     $ ,67))
      CALL ML5_0_2_1_CREATE_LOOP_COEFS(WL(1,0,1,67),4,4,34,1,1,48)
C     Coefficient construction for loop diagram with ID 35
      CALL FFV1L1_2(PL(0,54),W(1,4),GC_5,MDL_MT,MDL_WT,PL(0,68),COEFS)
      CALL ML5_0_2_1_UPDATE_WL_1_1(WL(1,0,1,54),4,COEFS,4,4,WL(1,0,1
     $ ,68))
      CALL FFS1L1_2(PL(0,68),W(1,3),GC_37,MDL_MT,MDL_WT,PL(0,69),COEFS)
      CALL ML5_0_2_1_UPDATE_WL_2_1(WL(1,0,1,68),4,COEFS,4,4,WL(1,0,1
     $ ,69))
      CALL FFV1L1_2(PL(0,69),W(1,9),GC_5,MDL_MT,MDL_WT,PL(0,70),COEFS)
      CALL ML5_0_2_1_UPDATE_WL_3_1(WL(1,0,1,69),4,COEFS,4,4,WL(1,0,1
     $ ,70))
      CALL ML5_0_2_1_CREATE_LOOP_COEFS(WL(1,0,1,70),4,4,35,1,1,49)
C     Coefficient construction for loop diagram with ID 36
      CALL FFV1L2_1(PL(0,52),W(1,9),GC_5,MDL_MT,MDL_WT,PL(0,71),COEFS)
      CALL ML5_0_2_1_UPDATE_WL_2_1(WL(1,0,1,52),4,COEFS,4,4,WL(1,0,1
     $ ,71))
      CALL FFV1L2_1(PL(0,71),W(1,4),GC_5,MDL_MT,MDL_WT,PL(0,72),COEFS)
      CALL ML5_0_2_1_UPDATE_WL_3_1(WL(1,0,1,71),4,COEFS,4,4,WL(1,0,1
     $ ,72))
      CALL ML5_0_2_1_CREATE_LOOP_COEFS(WL(1,0,1,72),4,4,36,1,1,50)
C     Coefficient construction for loop diagram with ID 37
      CALL FFV1L1_2(PL(0,55),W(1,16),GC_5,MDL_MT,MDL_WT,PL(0,73),COEFS)
      CALL ML5_0_2_1_UPDATE_WL_2_1(WL(1,0,1,55),4,COEFS,4,4,WL(1,0,1
     $ ,73))
      CALL ML5_0_2_1_CREATE_LOOP_COEFS(WL(1,0,1,73),3,4,37,1,1,51)
C     Coefficient construction for loop diagram with ID 38
      CALL FFV1L2_1(PL(0,52),W(1,16),GC_5,MDL_MT,MDL_WT,PL(0,74),COEFS)
      CALL ML5_0_2_1_UPDATE_WL_2_1(WL(1,0,1,52),4,COEFS,4,4,WL(1,0,1
     $ ,74))
      CALL ML5_0_2_1_CREATE_LOOP_COEFS(WL(1,0,1,74),3,4,38,1,1,52)
C     Coefficient construction for loop diagram with ID 39
      CALL FFV1L2_1(PL(0,40),W(1,17),GC_5,MDL_MT,MDL_WT,PL(0,75),COEFS)
      CALL ML5_0_2_1_UPDATE_WL_2_1(WL(1,0,1,40),4,COEFS,4,4,WL(1,0,1
     $ ,75))
      CALL ML5_0_2_1_CREATE_LOOP_COEFS(WL(1,0,1,75),3,4,39,1,1,53)
C     Coefficient construction for loop diagram with ID 40
      CALL FFV1L1_2(PL(0,43),W(1,17),GC_5,MDL_MT,MDL_WT,PL(0,76),COEFS)
      CALL ML5_0_2_1_UPDATE_WL_2_1(WL(1,0,1,43),4,COEFS,4,4,WL(1,0,1
     $ ,76))
      CALL ML5_0_2_1_CREATE_LOOP_COEFS(WL(1,0,1,76),3,4,40,1,1,54)
C     At this point, all loop coefficients needed for (QCD=8), i.e. of
C      split order ID=1, are computed.
      IF(FILTER_SO.AND.SQSO_TARGET.EQ.1) GOTO 4000

      GOTO 1001
 4000 CONTINUE
      LOOP_REQ_SO_DONE=.TRUE.
 1001 CONTINUE
      END
