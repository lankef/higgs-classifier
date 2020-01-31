      SUBROUTINE HELAS_CALLS_UVCT_1(P,NHEL,H,IC)
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
      PARAMETER (NWAVEFUNCS=15,NLOOPWAVEFUNCS=91)
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
      IF (FILTER_SO.AND.UVCT_REQ_SO_DONE) THEN
        GOTO 1001
      ENDIF

C     Amplitude(s) for UVCT diagram with ID 42
      CALL FFV2_5_0(W(1,5),W(1,6),W(1,7),GC_22,GC_23,AMPL(1,35))
      AMPL(1,35)=AMPL(1,35)*(1.0D0*UVWFCT_G_2+1.0D0*UVWFCT_G_1)
C     Amplitude(s) for UVCT diagram with ID 43
      CALL FFV2_5_0(W(1,5),W(1,6),W(1,7),GC_22,GC_23,AMPL(2,36))
      AMPL(2,36)=AMPL(2,36)*(2.0D0*UVWFCT_G_2_1EPS)
C     Amplitude(s) for UVCT diagram with ID 44
      CALL FFV2_5_0(W(1,8),W(1,1),W(1,7),GC_22,GC_23,AMPL(1,37))
      AMPL(1,37)=AMPL(1,37)*(1.0D0*UVWFCT_G_2+1.0D0*UVWFCT_G_1)
C     Amplitude(s) for UVCT diagram with ID 45
      CALL FFV2_5_0(W(1,8),W(1,1),W(1,7),GC_22,GC_23,AMPL(2,38))
      AMPL(2,38)=AMPL(2,38)*(2.0D0*UVWFCT_G_2_1EPS)
C     At this point, all UVCT amps needed for (QCD=4), i.e. of split
C      order ID=1, are computed.
      IF(FILTER_SO.AND.SQSO_TARGET.EQ.1) GOTO 3000

      GOTO 1001
 3000 CONTINUE
      UVCT_REQ_SO_DONE=.TRUE.
 1001 CONTINUE
      END

