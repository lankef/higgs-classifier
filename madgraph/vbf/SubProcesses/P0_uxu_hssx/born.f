      SUBROUTINE SBORN(P1,ANS)
C     
C     Generated by MadGraph5_aMC@NLO v. 2.6.7, 2019-10-16
C     By the MadGraph5_aMC@NLO Development Team
C     Visit launchpad.net/madgraph5 and amcatnlo.web.cern.ch
C     
C     RETURNS AMPLITUDE SQUARED SUMMED/AVG OVER COLORS
C     AND HELICITIES
C     FOR THE POINT IN PHASE SPACE P1(0:3,NEXTERNAL-1)
C     
C     Process: u~ u > h s s~ QED<=3 [ all = QCD ]
C     Process: c~ c > h d d~ QED<=3 [ all = QCD ]
C     
      IMPLICIT NONE
C     
C     CONSTANTS
C     
      INCLUDE 'nexternal.inc'
      INCLUDE 'born_nhel.inc'
      INTEGER     NCOMB
      PARAMETER ( NCOMB=  16 )
      INTEGER    THEL
      PARAMETER (THEL=NCOMB*6)
      INTEGER NGRAPHS
      PARAMETER (NGRAPHS=   1)
C     
C     ARGUMENTS 
C     
      REAL*8 P1(0:3,NEXTERNAL-1)
      COMPLEX*16 ANS(2)
C     
C     LOCAL VARIABLES 
C     
      INTEGER IHEL,IDEN,I,J,JJ,GLU_IJ
      REAL*8 BORN,BORNS(2)
      COMPLEX*16 BORNTILDE
      INTEGER NTRY(6)
      DATA NTRY /6*0/
      INTEGER NHEL(NEXTERNAL-1,NCOMB)
      DATA (NHEL(I,   1),I=1,5) /-1, 1, 0,-1, 1/
      DATA (NHEL(I,   2),I=1,5) /-1, 1, 0,-1,-1/
      DATA (NHEL(I,   3),I=1,5) /-1, 1, 0, 1, 1/
      DATA (NHEL(I,   4),I=1,5) /-1, 1, 0, 1,-1/
      DATA (NHEL(I,   5),I=1,5) /-1,-1, 0,-1, 1/
      DATA (NHEL(I,   6),I=1,5) /-1,-1, 0,-1,-1/
      DATA (NHEL(I,   7),I=1,5) /-1,-1, 0, 1, 1/
      DATA (NHEL(I,   8),I=1,5) /-1,-1, 0, 1,-1/
      DATA (NHEL(I,   9),I=1,5) / 1, 1, 0,-1, 1/
      DATA (NHEL(I,  10),I=1,5) / 1, 1, 0,-1,-1/
      DATA (NHEL(I,  11),I=1,5) / 1, 1, 0, 1, 1/
      DATA (NHEL(I,  12),I=1,5) / 1, 1, 0, 1,-1/
      DATA (NHEL(I,  13),I=1,5) / 1,-1, 0,-1, 1/
      DATA (NHEL(I,  14),I=1,5) / 1,-1, 0,-1,-1/
      DATA (NHEL(I,  15),I=1,5) / 1,-1, 0, 1, 1/
      DATA (NHEL(I,  16),I=1,5) / 1,-1, 0, 1,-1/
      INTEGER IDEN_VALUES(6)
      DATA IDEN_VALUES /36, 36, 36, 36, 36, 36/
      INTEGER IJ_VALUES(6)
      DATA IJ_VALUES /1, 2, 4, 5, 1, 2/
C     
C     GLOBAL VARIABLES
C     
      DOUBLE PRECISION AMP2(1), JAMP2(0:1)
      COMMON/TO_AMPS/  AMP2,       JAMP2
      DATA JAMP2(0) /   1/
      LOGICAL GOODHEL(NCOMB,6)
      COMMON /C_GOODHEL/GOODHEL
      DOUBLE COMPLEX SAVEAMP(NGRAPHS,MAX_BHEL)
      COMMON/TO_SAVEAMP/SAVEAMP
      DOUBLE PRECISION SAVEMOM(NEXTERNAL-1,2)
      COMMON/TO_SAVEMOM/SAVEMOM
      DOUBLE PRECISION HEL_FAC
      INTEGER GET_HEL,SKIP(6)
      COMMON/CBORN/HEL_FAC,GET_HEL,SKIP
      LOGICAL CALCULATEDBORN
      COMMON/CCALCULATEDBORN/CALCULATEDBORN
      INTEGER NFKSPROCESS
      COMMON/C_NFKSPROCESS/NFKSPROCESS
      DOUBLE PRECISION       WGT_ME_BORN,WGT_ME_REAL
      COMMON /C_WGT_ME_TREE/ WGT_ME_BORN,WGT_ME_REAL
      LOGICAL COND_IJ
C     ----------
C     BEGIN CODE
C     ----------
      IDEN=IDEN_VALUES(NFKSPROCESS)
      GLU_IJ = IJ_VALUES(NFKSPROCESS)
      NTRY(NFKSPROCESS)=NTRY(NFKSPROCESS)+1
      IF (NTRY(NFKSPROCESS).LT.2) THEN
        IF (GLU_IJ.EQ.0) THEN
          SKIP(NFKSPROCESS)=0
        ELSE
          SKIP(NFKSPROCESS)=1
          DO WHILE(NHEL(GLU_IJ ,SKIP(NFKSPROCESS)).NE.-NHEL(GLU_IJ ,1))
            SKIP(NFKSPROCESS)=SKIP(NFKSPROCESS)+1
          ENDDO
          SKIP(NFKSPROCESS)=SKIP(NFKSPROCESS)-1
        ENDIF
      ENDIF
      DO JJ=1,NGRAPHS
        AMP2(JJ)=0D0
      ENDDO
      DO JJ=1,INT(JAMP2(0))
        JAMP2(JJ)=0D0
      ENDDO
      IF (CALCULATEDBORN) THEN
        DO J=1,NEXTERNAL-1
          IF (SAVEMOM(J,1).NE.P1(0,J) .OR. SAVEMOM(J,2).NE.P1(3,J))
     $      THEN
            CALCULATEDBORN=.FALSE.
            WRITE (*,*) 'momenta not the same in Born'
            STOP
          ENDIF
        ENDDO
      ENDIF
      IF (.NOT.CALCULATEDBORN) THEN
        DO J=1,NEXTERNAL-1
          SAVEMOM(J,1)=P1(0,J)
          SAVEMOM(J,2)=P1(3,J)
        ENDDO
        DO J=1,MAX_BHEL
          DO JJ=1,NGRAPHS
            SAVEAMP(JJ,J)=(0D0,0D0)
          ENDDO
        ENDDO
      ENDIF
      ANS(1) = 0D0
      ANS(2) = 0D0
      HEL_FAC=1D0
      DO IHEL=1,NCOMB
          ! the following lines are to avoid segfaults when glu_ij=0
        COND_IJ=SKIP(NFKSPROCESS).EQ.0
        IF (.NOT.COND_IJ) COND_IJ=COND_IJ.OR.NHEL(GLU_IJ,IHEL)
     $   .EQ.NHEL(GLU_IJ,1)
          !if (nhel(glu_ij,ihel).EQ.NHEL(GLU_IJ,1).or.skip(nfksprocess).eq.0) then
        IF (COND_IJ) THEN
          IF ((GOODHEL(IHEL,NFKSPROCESS) .OR. GOODHEL(IHEL
     $     +SKIP(NFKSPROCESS),NFKSPROCESS) .OR. NTRY(NFKSPROCESS) .LT.
     $      2) ) THEN
            ANS(1)=ANS(1)+BORN(P1,NHEL(1,IHEL),IHEL,BORNTILDE,BORNS)
            ANS(2)=ANS(2)+BORNTILDE
            IF ( BORNS(1).NE.0D0 .AND. .NOT. GOODHEL(IHEL,NFKSPROCESS)
     $        ) THEN
              GOODHEL(IHEL,NFKSPROCESS)=.TRUE.
            ENDIF
            IF ( BORNS(2).NE.0D0 .AND. .NOT. GOODHEL(IHEL
     $       +SKIP(NFKSPROCESS),NFKSPROCESS) ) THEN
              GOODHEL(IHEL+SKIP(NFKSPROCESS),NFKSPROCESS)=.TRUE.
            ENDIF
          ENDIF
        ENDIF
      ENDDO
      ANS(1)=ANS(1)/DBLE(IDEN)
      ANS(2)=ANS(2)/DBLE(IDEN)
      WGT_ME_BORN=DBLE(ANS(1))
      CALCULATEDBORN=.TRUE.
      END


      REAL*8 FUNCTION BORN(P,NHEL,HELL,BORNTILDE,BORNS)
C     
C     Generated by MadGraph5_aMC@NLO v. 2.6.7, 2019-10-16
C     By the MadGraph5_aMC@NLO Development Team
C     Visit launchpad.net/madgraph5 and amcatnlo.web.cern.ch
C     RETURNS AMPLITUDE SQUARED SUMMED/AVG OVER COLORS
C     FOR THE POINT WITH EXTERNAL LINES W(0:6,NEXTERNAL-1)

C     Process: u~ u > h s s~ QED<=3 [ all = QCD ]
C     Process: c~ c > h d d~ QED<=3 [ all = QCD ]
C     
      IMPLICIT NONE
C     
C     CONSTANTS
C     
      INTEGER    NGRAPHS,    NEIGEN
      PARAMETER (NGRAPHS=   1,NEIGEN=  1)
      INTEGER    NWAVEFUNCS, NCOLOR
      PARAMETER (NWAVEFUNCS=7, NCOLOR=1)
      REAL*8     ZERO
      PARAMETER (ZERO=0D0)
      COMPLEX*16 IMAG1
      PARAMETER (IMAG1 = (0D0,1D0))
      INCLUDE 'nexternal.inc'
      INCLUDE 'born_nhel.inc'
      INCLUDE 'coupl.inc'
C     
C     ARGUMENTS 
C     
      REAL*8 P(0:3,NEXTERNAL-1),BORNS(2)
      INTEGER NHEL(NEXTERNAL-1), HELL
      COMPLEX*16 BORNTILDE
C     
C     LOCAL VARIABLES 
C     
      INTEGER I,J,IHEL,BACK_HEL,GLU_IJ
      INTEGER IC(NEXTERNAL-1),NMO
      PARAMETER (NMO=NEXTERNAL-1)
      DATA IC /NMO*1/
      REAL*8 DENOM(NCOLOR), CF(NCOLOR,NCOLOR)
      COMPLEX*16 ZTEMP, AMP(NGRAPHS), JAMP(NCOLOR), W(8,NWAVEFUNCS),
     $  JAMPH(2, NCOLOR)
C     
C     GLOBAL VARIABLES
C     
      DOUBLE PRECISION AMP2(NGRAPHS), JAMP2(0:NCOLOR)
      COMMON/TO_AMPS/  AMP2,       JAMP2
      DOUBLE COMPLEX SAVEAMP(NGRAPHS,MAX_BHEL)
      COMMON/TO_SAVEAMP/SAVEAMP
      DOUBLE PRECISION HEL_FAC
      INTEGER GET_HEL,SKIP(6)
      COMMON/CBORN/HEL_FAC,GET_HEL,SKIP
      LOGICAL CALCULATEDBORN
      COMMON/CCALCULATEDBORN/CALCULATEDBORN
      INTEGER NFKSPROCESS
      COMMON/C_NFKSPROCESS/NFKSPROCESS
      INTEGER STEP_HEL
      LOGICAL COND_IJ
      INTEGER IJ_VALUES(6)
      DATA IJ_VALUES /1, 2, 4, 5, 1, 2/
C     
C     COLOR DATA
C     
      DATA DENOM(1)/1/
      DATA (CF(I,  1),I=  1,  1) /    9/
C     1 T(1,2) T(4,5)
C     ----------
C     BEGIN CODE
C     ----------
      GLU_IJ = IJ_VALUES(NFKSPROCESS)
      BORN = 0D0
      BORNTILDE = (0D0,0D0)
      BACK_HEL = NHEL(GLU_IJ)
      BORNS(1) = 0D0
      BORNS(2) = 0D0
      IF (GLU_IJ.NE.0) THEN
        BACK_HEL = NHEL(GLU_IJ)
        IF (BACK_HEL.NE.0) THEN
          STEP_HEL=-2*BACK_HEL
        ELSE
          STEP_HEL=1
        ENDIF
      ELSE
        BACK_HEL=0
        STEP_HEL=1
      ENDIF
      DO IHEL=BACK_HEL,-BACK_HEL,STEP_HEL
        IF (GLU_IJ.NE.0) THEN
          COND_IJ=IHEL.EQ.BACK_HEL.OR.NHEL(GLU_IJ).NE.0
        ELSE
          COND_IJ=IHEL.EQ.BACK_HEL
        ENDIF
        IF (COND_IJ) THEN
          IF (GLU_IJ.NE.0) THEN
            IF (NHEL(GLU_IJ).NE.0) NHEL(GLU_IJ) = IHEL
          ENDIF
          IF (.NOT. CALCULATEDBORN) THEN
            CALL OXXXXX(P(0,1),ZERO,NHEL(1),-1*IC(1),W(1,1))
            CALL IXXXXX(P(0,2),ZERO,NHEL(2),+1*IC(2),W(1,2))
            CALL SXXXXX(P(0,3),+1*IC(3),W(1,3))
            CALL OXXXXX(P(0,4),ZERO,NHEL(4),+1*IC(4),W(1,4))
            CALL IXXXXX(P(0,5),ZERO,NHEL(5),-1*IC(5),W(1,5))
            CALL FFV2_5_3(W(1,2),W(1,1),GC_22,GC_23,MDL_MZ,MDL_WZ,W(1
     $       ,6))
            CALL FFV2_3_3(W(1,5),W(1,4),-GC_22,GC_23,MDL_MZ,MDL_WZ,W(1
     $       ,2))
C           Amplitude(s) for diagram number 1
            CALL VVS1_0(W(1,6),W(1,2),W(1,3),GC_32,AMP(1))
            DO I=1,NGRAPHS
              IF(IHEL.EQ.BACK_HEL)THEN
                SAVEAMP(I,HELL)=AMP(I)
              ELSEIF(IHEL.EQ.-BACK_HEL)THEN
                SAVEAMP(I,HELL+SKIP(NFKSPROCESS))=AMP(I)
              ELSE
                WRITE(*,*) 'ERROR #1 in born.f'
                STOP
              ENDIF
            ENDDO
          ELSEIF (CALCULATEDBORN) THEN
            DO I=1,NGRAPHS
              IF(IHEL.EQ.BACK_HEL)THEN
                AMP(I)=SAVEAMP(I,HELL)
              ELSEIF(IHEL.EQ.-BACK_HEL)THEN
                AMP(I)=SAVEAMP(I,HELL+SKIP(NFKSPROCESS))
              ELSE
                WRITE(*,*) 'ERROR #1 in born.f'
                STOP
              ENDIF
            ENDDO
          ENDIF
          JAMP(1)=+AMP(1)
          DO I = 1, NCOLOR
            ZTEMP = (0.D0,0.D0)
            DO J = 1, NCOLOR
              ZTEMP = ZTEMP + CF(J,I)*JAMP(J)
            ENDDO
            BORNS(2-(1+BACK_HEL*IHEL)/2)=BORNS(2-(1+BACK_HEL*IHEL)/2)
     $       +ZTEMP*DCONJG(JAMP(I))/DENOM(I)
          ENDDO
          DO I = 1, NGRAPHS
            AMP2(I)=AMP2(I)+AMP(I)*DCONJG(AMP(I))
          ENDDO
          DO I = 1, NCOLOR
            JAMP2(I)=JAMP2(I)+JAMP(I)*DCONJG(JAMP(I))
            JAMPH(2-(1+BACK_HEL*IHEL)/2,I)=JAMP(I)
          ENDDO
        ENDIF
      ENDDO
      BORN=BORNS(1)+BORNS(2)
      DO I = 1, NCOLOR
        ZTEMP = (0.D0,0.D0)
        DO J = 1, NCOLOR
          ZTEMP = ZTEMP + CF(J,I)*JAMPH(2,J)
        ENDDO
        BORNTILDE = BORNTILDE + ZTEMP*DCONJG(JAMPH(1,I))/DENOM(I)
      ENDDO
      IF (GLU_IJ.NE.0) NHEL(GLU_IJ) = BACK_HEL
      END


      BLOCK DATA GOODHELS
      INTEGER     NCOMB
      PARAMETER ( NCOMB=  16 )
      INTEGER    THEL
      PARAMETER (THEL=NCOMB*6)
      LOGICAL GOODHEL(NCOMB,6)
      COMMON /C_GOODHEL/GOODHEL
      DATA GOODHEL/THEL*.FALSE./
      END

