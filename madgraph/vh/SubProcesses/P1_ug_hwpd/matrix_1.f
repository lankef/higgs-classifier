      SUBROUTINE SMATRIX_1(P,ANS)
C     
C     Generated by MadGraph5_aMC@NLO v. 2.6.7, 2019-10-16
C     By the MadGraph5_aMC@NLO Development Team
C     Visit launchpad.net/madgraph5 and amcatnlo.web.cern.ch
C     
C     Returns amplitude squared summed/avg over colors
C     and helicities
C     for the point in phase space P(0:3,NEXTERNAL)
C     
C     Process: u g > h w+ d g WEIGHTED<=6 [ all = QCD ] @1
C     Process: c g > h w+ s g WEIGHTED<=6 [ all = QCD ] @1
C     
      IMPLICIT NONE
C     
C     CONSTANTS
C     
      INCLUDE 'nexternal.inc'
      INTEGER     NCOMB
      PARAMETER ( NCOMB=48)
C     
C     ARGUMENTS 
C     
      REAL*8 P(0:3,NEXTERNAL),ANS
      DOUBLE PRECISION       WGT_ME_BORN,WGT_ME_REAL
      COMMON /C_WGT_ME_TREE/ WGT_ME_BORN,WGT_ME_REAL
C     
C     LOCAL VARIABLES 
C     
      INTEGER IHEL,IDEN,I,T_IDENT(NCOMB)
      REAL*8 MATRIX_1
      REAL*8 T,T_SAVE(NCOMB)
      SAVE T_SAVE,T_IDENT
      INTEGER NHEL(NEXTERNAL,NCOMB)
      DATA (NHEL(I,   1),I=1,6) / 1,-1, 0,-1,-1,-1/
      DATA (NHEL(I,   2),I=1,6) / 1,-1, 0,-1,-1, 1/
      DATA (NHEL(I,   3),I=1,6) / 1,-1, 0,-1, 1,-1/
      DATA (NHEL(I,   4),I=1,6) / 1,-1, 0,-1, 1, 1/
      DATA (NHEL(I,   5),I=1,6) / 1,-1, 0, 0,-1,-1/
      DATA (NHEL(I,   6),I=1,6) / 1,-1, 0, 0,-1, 1/
      DATA (NHEL(I,   7),I=1,6) / 1,-1, 0, 0, 1,-1/
      DATA (NHEL(I,   8),I=1,6) / 1,-1, 0, 0, 1, 1/
      DATA (NHEL(I,   9),I=1,6) / 1,-1, 0, 1,-1,-1/
      DATA (NHEL(I,  10),I=1,6) / 1,-1, 0, 1,-1, 1/
      DATA (NHEL(I,  11),I=1,6) / 1,-1, 0, 1, 1,-1/
      DATA (NHEL(I,  12),I=1,6) / 1,-1, 0, 1, 1, 1/
      DATA (NHEL(I,  13),I=1,6) / 1, 1, 0,-1,-1,-1/
      DATA (NHEL(I,  14),I=1,6) / 1, 1, 0,-1,-1, 1/
      DATA (NHEL(I,  15),I=1,6) / 1, 1, 0,-1, 1,-1/
      DATA (NHEL(I,  16),I=1,6) / 1, 1, 0,-1, 1, 1/
      DATA (NHEL(I,  17),I=1,6) / 1, 1, 0, 0,-1,-1/
      DATA (NHEL(I,  18),I=1,6) / 1, 1, 0, 0,-1, 1/
      DATA (NHEL(I,  19),I=1,6) / 1, 1, 0, 0, 1,-1/
      DATA (NHEL(I,  20),I=1,6) / 1, 1, 0, 0, 1, 1/
      DATA (NHEL(I,  21),I=1,6) / 1, 1, 0, 1,-1,-1/
      DATA (NHEL(I,  22),I=1,6) / 1, 1, 0, 1,-1, 1/
      DATA (NHEL(I,  23),I=1,6) / 1, 1, 0, 1, 1,-1/
      DATA (NHEL(I,  24),I=1,6) / 1, 1, 0, 1, 1, 1/
      DATA (NHEL(I,  25),I=1,6) /-1,-1, 0,-1,-1,-1/
      DATA (NHEL(I,  26),I=1,6) /-1,-1, 0,-1,-1, 1/
      DATA (NHEL(I,  27),I=1,6) /-1,-1, 0,-1, 1,-1/
      DATA (NHEL(I,  28),I=1,6) /-1,-1, 0,-1, 1, 1/
      DATA (NHEL(I,  29),I=1,6) /-1,-1, 0, 0,-1,-1/
      DATA (NHEL(I,  30),I=1,6) /-1,-1, 0, 0,-1, 1/
      DATA (NHEL(I,  31),I=1,6) /-1,-1, 0, 0, 1,-1/
      DATA (NHEL(I,  32),I=1,6) /-1,-1, 0, 0, 1, 1/
      DATA (NHEL(I,  33),I=1,6) /-1,-1, 0, 1,-1,-1/
      DATA (NHEL(I,  34),I=1,6) /-1,-1, 0, 1,-1, 1/
      DATA (NHEL(I,  35),I=1,6) /-1,-1, 0, 1, 1,-1/
      DATA (NHEL(I,  36),I=1,6) /-1,-1, 0, 1, 1, 1/
      DATA (NHEL(I,  37),I=1,6) /-1, 1, 0,-1,-1,-1/
      DATA (NHEL(I,  38),I=1,6) /-1, 1, 0,-1,-1, 1/
      DATA (NHEL(I,  39),I=1,6) /-1, 1, 0,-1, 1,-1/
      DATA (NHEL(I,  40),I=1,6) /-1, 1, 0,-1, 1, 1/
      DATA (NHEL(I,  41),I=1,6) /-1, 1, 0, 0,-1,-1/
      DATA (NHEL(I,  42),I=1,6) /-1, 1, 0, 0,-1, 1/
      DATA (NHEL(I,  43),I=1,6) /-1, 1, 0, 0, 1,-1/
      DATA (NHEL(I,  44),I=1,6) /-1, 1, 0, 0, 1, 1/
      DATA (NHEL(I,  45),I=1,6) /-1, 1, 0, 1,-1,-1/
      DATA (NHEL(I,  46),I=1,6) /-1, 1, 0, 1,-1, 1/
      DATA (NHEL(I,  47),I=1,6) /-1, 1, 0, 1, 1,-1/
      DATA (NHEL(I,  48),I=1,6) /-1, 1, 0, 1, 1, 1/
      LOGICAL GOODHEL(NCOMB)
      DATA GOODHEL/NCOMB*.FALSE./
      INTEGER NTRY
      DATA NTRY/0/
      DATA IDEN/96/
C     ----------
C     BEGIN CODE
C     ----------
      NTRY=NTRY+1
      ANS = 0D0
      DO IHEL=1,NCOMB
        IF (GOODHEL(IHEL) .OR. NTRY .LT. 2) THEN
          IF (NTRY.LT.2) THEN
C           for the first ps-point, check for helicities that give
C           identical matrix elements
            T=MATRIX_1(P ,NHEL(1,IHEL))
            T_SAVE(IHEL)=T
            T_IDENT(IHEL)=-1
            DO I=1,IHEL-1
              IF (T.EQ.0D0) EXIT
              IF (T_SAVE(I).EQ.0D0) CYCLE
              IF (ABS(T/T_SAVE(I)-1D0) .LT. 1D-12) THEN
C               WRITE (*,*) 'FOUND IDENTICAL',T,IHEL,T_SAVE(I),I
                T_IDENT(IHEL) = I
              ENDIF
            ENDDO
          ELSE
            IF (T_IDENT(IHEL).GT.0) THEN
C             if two helicity states are identical, dont recompute
              T=T_SAVE(T_IDENT(IHEL))
              T_SAVE(IHEL)=T
            ELSE
              T=MATRIX_1(P ,NHEL(1,IHEL))
              T_SAVE(IHEL)=T
            ENDIF
          ENDIF
C         add to the sum of helicities
          ANS=ANS+T
          IF (T .NE. 0D0 .AND. .NOT. GOODHEL(IHEL)) THEN
            GOODHEL(IHEL)=.TRUE.
          ENDIF
        ENDIF
      ENDDO
      ANS=ANS/DBLE(IDEN)
      WGT_ME_REAL=ANS
      END


      REAL*8 FUNCTION MATRIX_1(P,NHEL)
C     
C     Generated by MadGraph5_aMC@NLO v. 2.6.7, 2019-10-16
C     By the MadGraph5_aMC@NLO Development Team
C     Visit launchpad.net/madgraph5 and amcatnlo.web.cern.ch
C     
C     Returns amplitude squared summed/avg over colors
C     for the point with external lines W(0:6,NEXTERNAL)
C     
C     Process: u g > h w+ d g WEIGHTED<=6 [ all = QCD ] @1
C     Process: c g > h w+ s g WEIGHTED<=6 [ all = QCD ] @1
C     
      IMPLICIT NONE
C     
C     CONSTANTS
C     
      INTEGER    NGRAPHS
      PARAMETER (NGRAPHS=8)
      INTEGER    NWAVEFUNCS, NCOLOR
      PARAMETER (NWAVEFUNCS=9, NCOLOR=2)
      REAL*8     ZERO
      PARAMETER (ZERO=0D0)
      COMPLEX*16 IMAG1
      PARAMETER (IMAG1=(0D0,1D0))
      INCLUDE 'nexternal.inc'
      INCLUDE 'coupl.inc'
C     
C     ARGUMENTS 
C     
      REAL*8 P(0:3,NEXTERNAL)
      INTEGER NHEL(NEXTERNAL)
C     
C     LOCAL VARIABLES 
C     
      INTEGER I,J
      INTEGER IC(NEXTERNAL)
      DATA IC /NEXTERNAL*1/
      REAL*8 DENOM(NCOLOR), CF(NCOLOR,NCOLOR)
      COMPLEX*16 ZTEMP, AMP(NGRAPHS), JAMP(NCOLOR), W(8,NWAVEFUNCS)
C     
C     COLOR DATA
C     
      DATA DENOM(1)/3/
      DATA (CF(I,  1),I=  1,  2) /   16,   -2/
C     1 T(2,6,5,1)
      DATA DENOM(2)/3/
      DATA (CF(I,  2),I=  1,  2) /   -2,   16/
C     1 T(6,2,5,1)
C     ----------
C     BEGIN CODE
C     ----------
      CALL IXXXXX(P(0,1),ZERO,NHEL(1),+1*IC(1),W(1,1))
      CALL VXXXXX(P(0,2),ZERO,NHEL(2),-1*IC(2),W(1,2))
      CALL SXXXXX(P(0,3),+1*IC(3),W(1,3))
      CALL VXXXXX(P(0,4),MDL_MW,NHEL(4),+1*IC(4),W(1,4))
      CALL OXXXXX(P(0,5),ZERO,NHEL(5),+1*IC(5),W(1,5))
      CALL VXXXXX(P(0,6),ZERO,NHEL(6),+1*IC(6),W(1,6))
      CALL FFV1_2(W(1,1),W(1,2),GC_5,ZERO,ZERO,W(1,7))
      CALL VVS1_1(W(1,4),W(1,3),GC_31,MDL_MW,MDL_WW,W(1,8))
      CALL FFV1_2(W(1,7),W(1,6),GC_5,ZERO,ZERO,W(1,4))
C     Amplitude(s) for diagram number 1
      CALL FFV2_0(W(1,4),W(1,5),W(1,8),GC_47,AMP(1))
      CALL FFV1_1(W(1,5),W(1,6),GC_5,ZERO,ZERO,W(1,4))
C     Amplitude(s) for diagram number 2
      CALL FFV2_0(W(1,7),W(1,4),W(1,8),GC_47,AMP(2))
      CALL FFV1_2(W(1,1),W(1,6),GC_5,ZERO,ZERO,W(1,7))
      CALL FFV1_1(W(1,5),W(1,2),GC_5,ZERO,ZERO,W(1,3))
C     Amplitude(s) for diagram number 3
      CALL FFV2_0(W(1,7),W(1,3),W(1,8),GC_47,AMP(3))
      CALL FFV1_2(W(1,7),W(1,2),GC_5,ZERO,ZERO,W(1,9))
C     Amplitude(s) for diagram number 4
      CALL FFV2_0(W(1,9),W(1,5),W(1,8),GC_47,AMP(4))
      CALL FFV2_2(W(1,1),W(1,8),GC_47,ZERO,ZERO,W(1,9))
C     Amplitude(s) for diagram number 5
      CALL FFV1_0(W(1,9),W(1,3),W(1,6),GC_5,AMP(5))
      CALL VVV1P0_1(W(1,2),W(1,6),GC_4,ZERO,ZERO,W(1,3))
      CALL FFV1_2(W(1,1),W(1,3),GC_5,ZERO,ZERO,W(1,6))
C     Amplitude(s) for diagram number 6
      CALL FFV2_0(W(1,6),W(1,5),W(1,8),GC_47,AMP(6))
C     Amplitude(s) for diagram number 7
      CALL FFV1_0(W(1,9),W(1,5),W(1,3),GC_5,AMP(7))
C     Amplitude(s) for diagram number 8
      CALL FFV1_0(W(1,9),W(1,4),W(1,2),GC_5,AMP(8))
      JAMP(1)=+AMP(3)+AMP(4)+AMP(5)-IMAG1*AMP(6)-IMAG1*AMP(7)
      JAMP(2)=+AMP(1)+AMP(2)+IMAG1*AMP(6)+IMAG1*AMP(7)+AMP(8)
      MATRIX_1 = 0.D0
      DO I = 1, NCOLOR
        ZTEMP = (0.D0,0.D0)
        DO J = 1, NCOLOR
          ZTEMP = ZTEMP + CF(J,I)*JAMP(J)
        ENDDO
        MATRIX_1 = MATRIX_1+ZTEMP*DCONJG(JAMP(I))/DENOM(I)
      ENDDO
      END

