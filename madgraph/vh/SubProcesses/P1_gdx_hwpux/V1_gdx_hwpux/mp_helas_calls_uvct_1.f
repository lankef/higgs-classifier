      SUBROUTINE MP_HELAS_CALLS_UVCT_1(P,NHEL,H,IC)
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
      IF (FILTER_SO.AND.MP_UVCT_REQ_SO_DONE) THEN
        GOTO 1001
      ENDIF

C     Amplitude(s) for UVCT diagram with ID 22
      CALL MP_FFV2_0(W(1,5),W(1,6),W(1,7),GC_47,AMPL(1,29))
      AMPL(1,29)=AMPL(1,29)*(1.0D0*UVWFCT_G_2+1.0D0*UVWFCT_G_1)
C     Amplitude(s) for UVCT diagram with ID 23
      CALL MP_FFV2_0(W(1,5),W(1,6),W(1,7),GC_47,AMPL(2,30))
      AMPL(2,30)=AMPL(2,30)*(2.0D0*UVWFCT_G_2_1EPS)
C     Amplitude(s) for UVCT diagram with ID 24
      CALL MP_FFV2_0(W(1,8),W(1,2),W(1,7),GC_47,AMPL(1,31))
      AMPL(1,31)=AMPL(1,31)*(1.0D0*UVWFCT_G_2+1.0D0*UVWFCT_G_1)
C     Amplitude(s) for UVCT diagram with ID 25
      CALL MP_FFV2_0(W(1,8),W(1,2),W(1,7),GC_47,AMPL(2,32))
      AMPL(2,32)=AMPL(2,32)*(2.0D0*UVWFCT_G_2_1EPS)
C     At this point, all UVCT amps needed for (QCD=4), i.e. of split
C      order ID=1, are computed.
      IF(FILTER_SO.AND.SQSO_TARGET.EQ.1) GOTO 3000

      GOTO 1001
 3000 CONTINUE
      MP_UVCT_REQ_SO_DONE=.TRUE.
 1001 CONTINUE
      END

