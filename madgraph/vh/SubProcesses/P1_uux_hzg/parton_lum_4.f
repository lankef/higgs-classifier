      SUBROUTINE DLUM_4(LUM)
C     ****************************************************            
C         
C     Generated by MadGraph5_aMC@NLO v. 2.6.7, 2019-10-16
C     By the MadGraph5_aMC@NLO Development Team
C     Visit launchpad.net/madgraph5 and amcatnlo.web.cern.ch
C     RETURNS PARTON LUMINOSITIES FOR MADFKS                          
C        
C     
C     Process: u u~ > h z d d~ WEIGHTED<=6 [ all = QCD ] @1
C     Process: u u~ > h z s s~ WEIGHTED<=6 [ all = QCD ] @1
C     Process: c c~ > h z d d~ WEIGHTED<=6 [ all = QCD ] @1
C     Process: c c~ > h z s s~ WEIGHTED<=6 [ all = QCD ] @1
C     
C     ****************************************************            
C         
      IMPLICIT NONE
C     
C     CONSTANTS                                                       
C         
C     
      INCLUDE 'genps.inc'
      INCLUDE 'nexternal.inc'
      DOUBLE PRECISION       CONV
      PARAMETER (CONV=389379660D0)  !CONV TO PICOBARNS             
C     
C     ARGUMENTS                                                       
C         
C     
      DOUBLE PRECISION PP(0:3,NEXTERNAL), LUM
C     
C     LOCAL VARIABLES                                                 
C         
C     
      INTEGER I, ICROSS,ITYPE,LP
      DOUBLE PRECISION P1(0:3,NEXTERNAL)
      DOUBLE PRECISION U1,C1
      DOUBLE PRECISION CX2,UX2
      DOUBLE PRECISION XPQ(-7:7)
C     
C     EXTERNAL FUNCTIONS                                              
C         
C     
      DOUBLE PRECISION ALPHAS2,REWGT,PDG2PDF
C     
C     GLOBAL VARIABLES                                                
C         
C     
      INTEGER              IPROC
      DOUBLE PRECISION PD(0:MAXPROC)
      COMMON /SUBPROC/ PD, IPROC
      INCLUDE 'coupl.inc'
      INCLUDE 'run.inc'
      INTEGER IMIRROR
      COMMON/CMIRROR/IMIRROR
C     
C     DATA                                                            
C         
C     
      DATA U1,C1/2*1D0/
      DATA CX2,UX2/2*1D0/
      DATA ICROSS/1/
C     ----------                                                      
C         
C     BEGIN CODE                                                      
C         
C     ----------                                                      
C         
      LUM = 0D0
      IF (IMIRROR.EQ.2) THEN
        IF (ABS(LPP(2)) .GE. 1) THEN
          LP=SIGN(1,LPP(2))
          U1=PDG2PDF(ABS(LPP(2)),2*LP,XBK(2),DSQRT(Q2FACT(2)))
          C1=PDG2PDF(ABS(LPP(2)),4*LP,XBK(2),DSQRT(Q2FACT(2)))
        ENDIF
        IF (ABS(LPP(1)) .GE. 1) THEN
          LP=SIGN(1,LPP(1))
          CX2=PDG2PDF(ABS(LPP(1)),-4*LP,XBK(1),DSQRT(Q2FACT(1)))
          UX2=PDG2PDF(ABS(LPP(1)),-2*LP,XBK(1),DSQRT(Q2FACT(1)))
        ENDIF
        PD(0) = 0D0
        IPROC = 0
        IPROC=IPROC+1  ! u u~ > h z d d~
        PD(IPROC) = U1*UX2
        IPROC=IPROC+1  ! u u~ > h z s s~
        PD(IPROC) = U1*UX2
        IPROC=IPROC+1  ! c c~ > h z d d~
        PD(IPROC) = C1*CX2
        IPROC=IPROC+1  ! c c~ > h z s s~
        PD(IPROC) = C1*CX2
      ELSE
        IF (ABS(LPP(1)) .GE. 1) THEN
          LP=SIGN(1,LPP(1))
          U1=PDG2PDF(ABS(LPP(1)),2*LP,XBK(1),DSQRT(Q2FACT(1)))
          C1=PDG2PDF(ABS(LPP(1)),4*LP,XBK(1),DSQRT(Q2FACT(1)))
        ENDIF
        IF (ABS(LPP(2)) .GE. 1) THEN
          LP=SIGN(1,LPP(2))
          CX2=PDG2PDF(ABS(LPP(2)),-4*LP,XBK(2),DSQRT(Q2FACT(2)))
          UX2=PDG2PDF(ABS(LPP(2)),-2*LP,XBK(2),DSQRT(Q2FACT(2)))
        ENDIF
        PD(0) = 0D0
        IPROC = 0
        IPROC=IPROC+1  ! u u~ > h z d d~
        PD(IPROC) = U1*UX2
        IPROC=IPROC+1  ! u u~ > h z s s~
        PD(IPROC) = U1*UX2
        IPROC=IPROC+1  ! c c~ > h z d d~
        PD(IPROC) = C1*CX2
        IPROC=IPROC+1  ! c c~ > h z s s~
        PD(IPROC) = C1*CX2
      ENDIF
      DO I=1,IPROC
        IF (NINCOMING.EQ.2) THEN
          LUM = LUM + PD(I) * CONV
        ELSE
          LUM = LUM + PD(I)
        ENDIF
      ENDDO
      RETURN
      END

