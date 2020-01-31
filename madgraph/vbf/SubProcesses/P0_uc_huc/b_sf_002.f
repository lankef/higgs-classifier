      SUBROUTINE SB_SF_002(P1,ANS)
C     
C     Generated by MadGraph5_aMC@NLO v. 2.6.7, 2019-10-16
C     By the MadGraph5_aMC@NLO Development Team
C     Visit launchpad.net/madgraph5 and amcatnlo.web.cern.ch
C     
C     RETURNS AMPLITUDE SQUARED SUMMED/AVG OVER COLORS
C     AND HELICITIES
C     FOR THE POINT IN PHASE SPACE P(0:3,NEXTERNAL-1)
C     
C     Process: u c > h u c QED<=3 [ all = QCD ]
C     Process: c u > h c u QED<=3 [ all = QCD ]
C     spectators: 1 4 

C     
      IMPLICIT NONE
C     
C     CONSTANTS
C     
      INCLUDE 'nexternal.inc'
      INTEGER     NCOMB
      PARAMETER ( NCOMB=  16 )
      INTEGER    THEL
      PARAMETER (THEL=NCOMB*6)
      INTEGER NGRAPHS
      PARAMETER (NGRAPHS=   1)
C     
C     ARGUMENTS 
C     
      REAL*8 P1(0:3,NEXTERNAL-1),ANS
C     
C     LOCAL VARIABLES 
C     
      INTEGER IHEL,IDEN,J
      REAL*8 B_SF_002
      INTEGER IDEN_VALUES(6)
      DATA IDEN_VALUES /36, 36, 36, 36, 36, 36/
C     
C     GLOBAL VARIABLES
C     
      LOGICAL GOODHEL(NCOMB,6)
      COMMON /C_GOODHEL/ GOODHEL
      DOUBLE PRECISION SAVEMOM(NEXTERNAL-1,2)
      COMMON/TO_SAVEMOM/SAVEMOM
      LOGICAL CALCULATEDBORN
      COMMON/CCALCULATEDBORN/CALCULATEDBORN
      INTEGER NFKSPROCESS
      COMMON/C_NFKSPROCESS/NFKSPROCESS
C     ----------
C     BEGIN CODE
C     ----------
      IDEN=IDEN_VALUES(NFKSPROCESS)
      IF (CALCULATEDBORN) THEN
        DO J=1,NEXTERNAL-1
          IF (SAVEMOM(J,1).NE.P1(0,J) .OR. SAVEMOM(J,2).NE.P1(3,J))
     $      THEN
            CALCULATEDBORN=.FALSE.
            WRITE(*,*) 'Error in sb_sf: momenta not the same in the'
     $       //' born'
            STOP
          ENDIF
        ENDDO
      ELSE
        WRITE(*,*) 'Error in sb_sf: color_linked borns should be'
     $   //' called only with calculatedborn = true'
        STOP
      ENDIF
      ANS = 0D0
      DO IHEL=1,NCOMB
        IF (GOODHEL(IHEL,NFKSPROCESS)) THEN
          ANS=ANS+B_SF_002(P1,IHEL)
        ENDIF
      ENDDO
      ANS=ANS/DBLE(IDEN)
      END


      REAL*8 FUNCTION B_SF_002(P,HELL)
C     
C     Generated by MadGraph5_aMC@NLO v. 2.6.7, 2019-10-16
C     By the MadGraph5_aMC@NLO Development Team
C     Visit launchpad.net/madgraph5 and amcatnlo.web.cern.ch
C     RETURNS AMPLITUDE SQUARED SUMMED/AVG OVER COLORS
C     FOR THE POINT WITH EXTERNAL LINES W(0:6,NEXTERNAL-1)

C     Process: u c > h u c QED<=3 [ all = QCD ]
C     Process: c u > h c u QED<=3 [ all = QCD ]
C     spectators: 1 4 

C     
      IMPLICIT NONE
C     
C     CONSTANTS
C     
      INTEGER     NGRAPHS
      PARAMETER ( NGRAPHS = 1 )
      INTEGER NCOLOR1, NCOLOR2
      PARAMETER (NCOLOR1=1, NCOLOR2=1)
      REAL*8     ZERO
      PARAMETER (ZERO=0D0)
      COMPLEX*16 IMAG1
      PARAMETER (IMAG1 = (0D0,1D0))
      INCLUDE 'nexternal.inc'
      INCLUDE 'born_nhel.inc'
C     
C     ARGUMENTS 
C     
      REAL*8 P(0:3,NEXTERNAL-1)
      INTEGER HELL
C     
C     LOCAL VARIABLES 
C     
      INTEGER I,J
      REAL*8 DENOM(NCOLOR1), CF(NCOLOR2,NCOLOR1)
      COMPLEX*16 ZTEMP, AMP(NGRAPHS), JAMP1(NCOLOR1), JAMP2(NCOLOR2)
C     
C     GLOBAL VARIABLES
C     
      DOUBLE COMPLEX SAVEAMP(NGRAPHS,MAX_BHEL)
      COMMON/TO_SAVEAMP/SAVEAMP
      LOGICAL CALCULATEDBORN
      COMMON/CCALCULATEDBORN/CALCULATEDBORN
C     
C     COLOR DATA
C     
      DATA DENOM(1)/1/
      DATA (CF(I,  1),I=  1,  1) /    9/
C     ----------
C     BEGIN CODE
C     ----------
      IF (.NOT. CALCULATEDBORN) THEN
        WRITE(*,*) 'Error in b_sf: color_linked borns should be called'
     $   //' only with calculatedborn = true'
        STOP
      ELSEIF (CALCULATEDBORN) THEN
        DO I=1,NGRAPHS
          AMP(I)=SAVEAMP(I,HELL)
        ENDDO
      ENDIF
      JAMP1(1)=-AMP(1)
      JAMP2(1)=+1D0/2D0*(+3D0*AMP(1)-1D0/3D0*AMP(1))
      B_SF_002 = 0.D0
      DO I = 1, NCOLOR1
        ZTEMP = (0.D0,0.D0)
        DO J = 1, NCOLOR2
          ZTEMP = ZTEMP + CF(J,I)*JAMP2(J)
        ENDDO
        B_SF_002 =B_SF_002+ZTEMP*DCONJG(JAMP1(I))/DENOM(I)
      ENDDO
      END


