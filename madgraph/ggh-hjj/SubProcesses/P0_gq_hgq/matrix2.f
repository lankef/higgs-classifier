      SUBROUTINE SMATRIX2(P,ANS)
C     
C     Generated by MadGraph5_aMC@NLO v. 2.6.7, 2019-10-16
C     By the MadGraph5_aMC@NLO Development Team
C     Visit launchpad.net/madgraph5 and amcatnlo.web.cern.ch
C     
C     MadGraph5_aMC@NLO for Madevent Version
C     
C     Returns amplitude squared summed/avg over colors
C     and helicities
C     for the point in phase space P(0:3,NEXTERNAL)
C     
C     Process: g u~ > h g u~ QED<=2 [ noborn = QCD ]
C     Process: g c~ > h g c~ QED<=2 [ noborn = QCD ]
C     Process: g d~ > h g d~ QED<=2 [ noborn = QCD ]
C     Process: g s~ > h g s~ QED<=2 [ noborn = QCD ]
C     
      USE DISCRETESAMPLER
      IMPLICIT NONE
C     
C     CONSTANTS
C     
      INCLUDE 'genps.inc'
      INCLUDE 'maxconfigs.inc'
      INCLUDE 'nexternal.inc'
      INCLUDE 'maxamps.inc'
C     Below is the maximum config ID for multichannels which is always
C      less than
C     the number of loop diagrams, so we use the latter.
      INTEGER    NLOOPDIAGRAMS
      PARAMETER (NLOOPDIAGRAMS=40)
C     Below is the number of multi-channel actually contributing to
C      this process
      INTEGER    NMULTICHANNELS
      PARAMETER (NMULTICHANNELS=7)
      INTEGER    NLOOPFLOWS
      PARAMETER (NLOOPFLOWS=3)
      INTEGER                 NCOMB
      PARAMETER (             NCOMB=16)
      INTEGER    THEL
      PARAMETER (THEL=2*NCOMB)
      INTEGER HEL_AVERAGE_FACTOR
      PARAMETER (HEL_AVERAGE_FACTOR=4)
C     It can be that all '|A_i|^2' are zero, in which case one wants
C      to effectively set multichannel factors to be flat.
C     This behavior will occur when  Sum_i(|A_i|^2)/Full_ME <
C      MULTICHANNEL_THRES. 
C     When set negative, the security above is removed
      DOUBLE PRECISION MULTICHANNEL_THRES
      PARAMETER (MULTICHANNEL_THRES=1.0D-5)

C     
C     global (due to reading writting) 
C     
      LOGICAL GOODHEL(NCOMB,2)
      INTEGER NTRY(2)
      COMMON/BLOCK_GOODHEL/NTRY,GOODHEL
C     
C     ARGUMENTS 
C     
      REAL*8 P(0:3,NEXTERNAL),ANS
C     
C     LOCAL VARIABLES 
C     
      INTEGER NHEL(NEXTERNAL,NCOMB)
      INTEGER I, II, J ,JJ
      INTEGER ISHEL(2)
      REAL*8 R,SUMHEL,TS(NCOMB), T
      REAL*8 HWGT,XTOT
      INTEGER NGOOD(2), IGOOD(NCOMB,2)
      INTEGER JHEL(2)
      DATA NGOOD /0,0/
      DATA ISHEL/0,0/
C     This stores the different between the full matrix element
C      squared and the sum of multi-channeling factors '|A_i|^2'.
      DOUBLE PRECISION INTERFERENCE_CONTRIB

      REAL T_BEFORE

C     This is just to temporarily store the reference grid for
C      helicity of the DiscreteSampler so as to obtain its number of
C      entries with ref_helicity_grid%n_tot_entries
      TYPE(SAMPLEDDIMENSION) REF_HELICITY_GRID

      REAL*8 , ALLOCATABLE :: ANS_ML(:,:)
      REAL*8 , ALLOCATABLE :: PREC_FOUND(:)
      INTEGER ML_RET_CODE
      INTEGER ML_ANS_DIMENSION
C     Prec_found ans ans_ml are saved so that they don't have to be
C      re-allocated everytime
      SAVE ML_ANS_DIMENSION,ANS_ML,PREC_FOUND

      SAVE IGOOD, JHEL

      LOGICAL INIT_MADLOOP
      DATA INIT_MADLOOP/.FALSE./
C     
C     GLOBAL VARIABLES
C     
      LOGICAL FORCE_ML_HELICITY_SUM
      COMMON/TO_ML_CONTROL/FORCE_ML_HELICITY_SUM


      DOUBLE PRECISION AMP2(MAXAMPS), JAMP2(0:MAXFLOW)
      COMMON/TO_AMPS/  AMP2,       JAMP2

      CHARACTER*101         HEL_BUFF
      COMMON/TO_HELICITY/  HEL_BUFF

      REAL*8 ML_JAMP2(NLOOPFLOWS)
      COMMON/ML5_0_2_2_JAMP2/ML_JAMP2

      REAL*8 ML_AMP2(NLOOPDIAGRAMS)
      COMMON/ML5_0_2_2_AMP2/ML_AMP2


      INTEGER IMIRROR
      COMMON/TO_MIRROR/ IMIRROR

      REAL*8 POL(2)
      COMMON/TO_POLARIZATION/ POL

      INTEGER          ISUM_HEL
      LOGICAL                    MULTI_CHANNEL
      COMMON/TO_MATRIX/ISUM_HEL, MULTI_CHANNEL

      LOGICAL READ_GRID_FILE
      COMMON/READ_GRID_FILE/READ_GRID_FILE

      INTEGER MAPCONFIG(0:LMAXCONFIGS), ICONFIG
      COMMON/TO_MCONFIGS/MAPCONFIG, ICONFIG
      INTEGER SUBDIAG(MAXSPROC),IB(2)
      COMMON/TO_SUB_DIAG/SUBDIAG,IB
      DATA (NHEL(I,   1),I=1,5) /-1,-1, 0,-1, 1/
      DATA (NHEL(I,   2),I=1,5) /-1,-1, 0,-1,-1/
      DATA (NHEL(I,   3),I=1,5) /-1,-1, 0, 1, 1/
      DATA (NHEL(I,   4),I=1,5) /-1,-1, 0, 1,-1/
      DATA (NHEL(I,   5),I=1,5) /-1, 1, 0,-1, 1/
      DATA (NHEL(I,   6),I=1,5) /-1, 1, 0,-1,-1/
      DATA (NHEL(I,   7),I=1,5) /-1, 1, 0, 1, 1/
      DATA (NHEL(I,   8),I=1,5) /-1, 1, 0, 1,-1/
      DATA (NHEL(I,   9),I=1,5) / 1,-1, 0,-1, 1/
      DATA (NHEL(I,  10),I=1,5) / 1,-1, 0,-1,-1/
      DATA (NHEL(I,  11),I=1,5) / 1,-1, 0, 1, 1/
      DATA (NHEL(I,  12),I=1,5) / 1,-1, 0, 1,-1/
      DATA (NHEL(I,  13),I=1,5) / 1, 1, 0,-1, 1/
      DATA (NHEL(I,  14),I=1,5) / 1, 1, 0,-1,-1/
      DATA (NHEL(I,  15),I=1,5) / 1, 1, 0, 1, 1/
      DATA (NHEL(I,  16),I=1,5) / 1, 1, 0, 1,-1/

C     To be able to control when the matrix<i> subroutine can add
C      entries to the grid for the MC over helicity configuration
      LOGICAL ALLOW_HELICITY_GRID_ENTRIES
      COMMON/TO_ALLOW_HELICITY_GRID_ENTRIES/ALLOW_HELICITY_GRID_ENTRIES

C     ----------
C     BEGIN CODE
C     ----------

C     Notice that when forcing helicity sum directly in MadLoop then'
C     //' one doesn't have access to the weights of individual Hel.
C      Configs so that they cannot be specified in the event file. We
C      turned this option off by default.
      FORCE_ML_HELICITY_SUM = (ISUM_HEL.EQ.0.AND..FALSE.)

      IF(NLOOPDIAGRAMS.GT.MAXAMPS) THEN
        STOP 'MAXAMPS smaller than NLOOPDIAGRAMS in matrix.f'
      ENDIF

      IF(.NOT.INIT_MADLOOP) THEN
        INIT_MADLOOP = .TRUE.
C       We don't use the poles, so let's not compute them with COLLIER
        CALL ML5_0_2_2_COLLIER_COMPUTE_UV_POLES(.FALSE.)
        CALL ML5_0_2_2_COLLIER_COMPUTE_IR_POLES(.FALSE.)
C       Unless this is the first iteration, make sure to never double
C        check the helicity filter again
        IF (READ_GRID_FILE) THEN
          CALL SET_FORBID_HEL_DOUBLECHECK(.TRUE.)
        ELSE
C         The double check is turned off here even for the first
C          iteration because the further iteration would anyway be
C          wrong since the new HelFilter is not output. We keep it
C          here as it can be used for diagnostics, for example by
C          triggering a crash if the double-check fails instead of
C          trying to recompute the filter.
          CALL SET_FORBID_HEL_DOUBLECHECK(.TRUE.)
        ENDIF
C       So that TIR integrals can be reused accross helicity
C        configuration.
C       Notice that ITR integrals for rotated PS points (i.e. which is'
C       //' part of MadLoop's default stabiliy test procedure), will
C        not work. This is why one should always keep the MadLoop
C        parameter 'NRotations_DP' set to 0 in this case.
C       Of course this is only necessary when using MadLoop for
C        several helicity for the same PS point
        IF ((.NOT.FORCE_ML_HELICITY_SUM).AND.ISUM_HEL.EQ.0) THEN
          CALL ML5_0_2_2_SET_AUTOMATIC_CACHE_CLEARING(.FALSE.)
        ENDIF
        CALL ML5_0_2_2_GET_ANSWER_DIMENSION(ML_ANS_DIMENSION)
C       In case there is an initialization phase for MadLoop (i.e.
C        everytime except when MC over helicity and disabling the Loop
C        filter, which is the default.
        CALL ML5_0_2_2_FORCE_STABILITY_CHECK(.TRUE.)
        ALLOCATE(ANS_ML(0:3,0:ML_ANS_DIMENSION))
        ALLOCATE(PREC_FOUND(0:ML_ANS_DIMENSION))
      ENDIF

      IF ((.NOT.FORCE_ML_HELICITY_SUM).AND.ISUM_HEL.EQ.0) THEN
C       But then we must clear the cache by hand at the beginning of
C        the computation of each new PS point
C       This is of course only necessary if the automatic TIR Cache
C        clearing was turned off.
        CALL ML5_0_2_2_CLEAR_CACHES()
      ENDIF

      NTRY(IMIRROR)=NTRY(IMIRROR)+1

      IF (MULTI_CHANNEL) THEN
        DO I=1,NLOOPDIAGRAMS
          AMP2(I)=0D0
        ENDDO
        JAMP2(0)=3
        DO I=1,INT(JAMP2(0))
          JAMP2(I)=0D0
        ENDDO
      ENDIF


      ANS = 0D0
      WRITE(HEL_BUFF,'(20I5)') (0,I=1,NEXTERNAL)

      DO I=1,NCOMB
        TS(I)=0D0
      ENDDO

      IF (FORCE_ML_HELICITY_SUM)THEN
C       Of course this option can also not be used for polarized beams.
        DO JJ=1,NINCOMING
          IF (POL(JJ).NE.1D0) FORCE_ML_HELICITY_SUM = .FALSE.
        ENDDO
      ENDIF


      IF(FORCE_ML_HELICITY_SUM )THEN

        CALL CPU_TIME(T_BEFORE)
        CALL ML5_0_2_2_SLOOPMATRIX_THRES(P,ANS_ML,-1.0D0,PREC_FOUND
     $   ,ML_RET_CODE)
        CALL PROCESS_MADLOOP_OUTPUT2(P,T_BEFORE,ANS,ANS_ML(1,0)
     $   ,ANS_ML(2,0),ANS_ML(3,0),PREC_FOUND(0),ML_RET_CODE)

      ELSE
          !   If the helicity grid status is 0, this means that it is not yet initialized.
          !   If HEL_PICKED==-1, this means that calls to other matrix<i> where in initialization mode as well for the helicity.
        IF ((ISHEL(IMIRROR).EQ.0.AND.ISUM_HEL.EQ.0).OR.(DS_GET_DIM_STAT
     $US('Helicity').EQ.0).OR.(HEL_PICKED.EQ.-1)) THEN
          DO I=1,NCOMB
            IF (GOODHEL(I,IMIRROR) .OR. NTRY(IMIRROR)
     $       .LE.MAXTRIES.OR.ISUM_HEL.NE.0) THEN

              CALL CPU_TIME(T_BEFORE)
              CALL ML5_0_2_2_SLOOPMATRIXHEL_THRES(P,I,ANS_ML,-1.0D0
     $         ,PREC_FOUND,ML_RET_CODE)
              CALL PROCESS_MADLOOP_OUTPUT2(P,T_BEFORE,T,ANS_ML(1,0)
     $         ,ANS_ML(2,0),ANS_ML(3,0),PREC_FOUND(0),ML_RET_CODE)

              DO JJ=1,JAMP2(0)
                JAMP2(JJ) = JAMP2(JJ) + ML_JAMP2(JJ)
              ENDDO
              DO JJ=1,NLOOPDIAGRAMS
                AMP2(JJ) = AMP2(JJ)+ ML_AMP2(JJ)
              ENDDO

              DO JJ=1,NINCOMING
                IF(POL(JJ).NE.1D0.AND.NHEL(JJ,I).EQ.INT(SIGN(1D0
     $           ,POL(JJ)))) THEN
                  T=T*ABS(POL(JJ))
                ELSE IF(POL(JJ).NE.1D0)THEN
                  T=T*(2D0-ABS(POL(JJ)))
                ENDIF
              ENDDO
              IF (ISUM_HEL.NE.0.AND.DS_GET_DIM_STATUS('Helicity')
     $         .EQ.0.AND.ALLOW_HELICITY_GRID_ENTRIES) THEN
                CALL DS_ADD_ENTRY('Helicity',I,T)
              ENDIF
              ANS=ANS+DABS(T)
              TS(I)=T
            ENDIF
          ENDDO

          IF (ISUM_HEL.NE.0) THEN
              !         We set HEL_PICKED to -1 here so that later on, the call to DS_add_point in dsample.f does not add anything to the grid since it was already done here.
            HEL_PICKED = -1
              !         For safety, hardset the helicity sampling jacobian to 0.0d0 to make sure it is not .
            HEL_JACOBIAN   = 1.0D0
              !         We don't want to re-update the helicity grid if it was already updated by another matrix<i>, so we make sure that the reference grid is empty.
            REF_HELICITY_GRID = DS_GET_DIMENSION(REF_GRID,'Helicity')
            IF((DS_GET_DIM_STATUS('Helicity').EQ.1).AND.(REF_HELICITY_G
     $RID%N_TOT_ENTRIES.EQ.0)) THEN
                !           If we finished the initialization we can update the grid so as to start sampling over it.
                !           However the grid will now be filled by dsample with different kind of weights (including pdf, flux, etc...) so by setting the grid_mode of the reference grid to 'initialization' we make sure it will be overwritten (as opposed to 'combined') by the running grid at the next update.
              CALL DS_UPDATE_GRID('Helicity')
              CALL DS_SET_GRID_MODE('Helicity','init')
              CALL RESET_CUMULATIVE_VARIABLE()  ! avoid biais of the initialization
            ENDIF
          ELSE
            JHEL(IMIRROR) = 1
            IF(NTRY(IMIRROR).LE.MAXTRIES)THEN
              DO I=1,NCOMB
                IF (.NOT.GOODHEL(I,IMIRROR) .AND. (DABS(TS(I)).GT.ANS
     $           *LIMHEL/NCOMB)) THEN
                  GOODHEL(I,IMIRROR)=.TRUE.
                  NGOOD(IMIRROR) = NGOOD(IMIRROR) +1
                  IGOOD(NGOOD(IMIRROR),IMIRROR) = I
                  PRINT *,'Added good helicity ',I,TS(I)*NCOMB/ANS,
     $             ' in event ',NTRY(IMIRROR)
                ENDIF
              ENDDO
            ENDIF
            IF(NTRY(IMIRROR).EQ.MAXTRIES)THEN
              ISHEL(IMIRROR)=MIN(ISUM_HEL,NGOOD(IMIRROR))
            ENDIF
            IF(NTRY(IMIRROR).EQ.(MAXTRIES+1)) THEN
              CALL RESET_CUMULATIVE_VARIABLE()  ! avoid biais of the initialization
            ENDIF

          ENDIF
        ELSE  ! random helicity
C         The helicity configuration was chosen already by genps and
C          put in a common block defined in genps.inc.
          I = HEL_PICKED

          CALL CPU_TIME(T_BEFORE)
          CALL ML5_0_2_2_SLOOPMATRIXHEL_THRES(P,I,ANS_ML,-1.0D0
     $     ,PREC_FOUND,ML_RET_CODE)
          CALL PROCESS_MADLOOP_OUTPUT2(P,T_BEFORE,T,ANS_ML(1,0)
     $     ,ANS_ML(2,0),ANS_ML(3,0),PREC_FOUND(0),ML_RET_CODE)

          DO JJ=1,JAMP2(0)
            JAMP2(JJ) = JAMP2(JJ) + ML_JAMP2(JJ)
          ENDDO
          DO JJ=1,NLOOPDIAGRAMS
            AMP2(JJ) = AMP2(JJ)+ ML_AMP2(JJ)
          ENDDO

          DO JJ=1,NINCOMING
            IF(POL(JJ).NE.1D0.AND.NHEL(JJ,I).EQ.INT(SIGN(1D0,POL(JJ))))
     $        THEN
              T=T*ABS(POL(JJ))
            ELSE IF(POL(JJ).NE.1D0)THEN
              T=T*(2D0-ABS(POL(JJ)))
            ENDIF
          ENDDO

C         Always one helicity at a time
          ANS = T
C         Include the Jacobian from helicity sampling
          ANS = ANS * HEL_JACOBIAN

          WRITE(HEL_BUFF,'(20i5)')(NHEL(II,I),II=1,NEXTERNAL)
        ENDIF
        IF (ANS.NE.0D0.AND.(ISUM_HEL .NE. 1.OR.(HEL_PICKED.EQ.-1)))
     $    THEN
          CALL RANMAR(R)
          SUMHEL=0D0
          DO I=1,NCOMB
            SUMHEL=SUMHEL+DABS(TS(I))/ANS
            IF(R.LT.SUMHEL)THEN
              WRITE(HEL_BUFF,'(20i5)')(NHEL(II,I),II=1,NEXTERNAL)
C             Set right sign for ANS, based on sign of chosen helicity
              ANS=DSIGN(ANS,TS(I))
              GOTO 10
            ENDIF
          ENDDO
 10       CONTINUE
        ENDIF
      ENDIF

      IF (MULTI_CHANNEL) THEN
        XTOT=0D0
        DO I=1,NLOOPDIAGRAMS
          XTOT=XTOT+AMP2(I)
        ENDDO
        IF (MULTICHANNEL_THRES.GE.0.0D0) THEN
          IF (XTOT.LT.MULTICHANNEL_THRES*(DABS(ANS)/HEL_JACOBIAN)) THEN
            INTERFERENCE_CONTRIB = (MULTICHANNEL_THRES*(DABS(ANS)
     $       /HEL_JACOBIAN))
            AMP2(SUBDIAG(2)) = AMP2(SUBDIAG(2)) + (INTERFERENCE_CONTRIB
     $       /NMULTICHANNELS)
            XTOT = XTOT + INTERFERENCE_CONTRIB
          ENDIF
        ENDIF
        IF (XTOT.NE.0D0) THEN
          ANS=ANS*AMP2(SUBDIAG(2))/XTOT
        ELSE IF (ANS.NE.0D0) THEN
          WRITE(*,*) 'Problem in the multi-channeling. All amp2 are'
     $     //' zero but not the total matrix-element'
          STOP 1
        ENDIF
      ENDIF
      IF(.NOT.FORCE_ML_HELICITY_SUM )THEN
        ANS = ANS/ HEL_AVERAGE_FACTOR
      ENDIF

C     Amplitude(s) for diagram number 40
C     This last line is a tag do not remove it. 
      END

      SUBROUTINE PROCESS_MADLOOP_OUTPUT2(P,TIME_BEFORE, ME_ANSWER,
     $  FINITE, ONEEPS, TWOEPS, PREC, RETURN_CODE)
C     
C     Simply registers the madloop return code and timing into the
C     global variables
C     
      IMPLICIT NONE
C     
C     Constants
C     
      INCLUDE 'nexternal.inc'
C     
C     Arguments
C     
      REAL*8 P(0:3,NEXTERNAL)
      REAL TIME_BEFORE
      INTEGER RETURN_CODE
      DOUBLE PRECISION ME_ANSWER, FINITE, ONEEPS, TWOEPS, PREC
C     
C     Local variables
C     
      REAL TIME_AFTER
      INTEGER U,T,H
C     
C     Global variables
C     
C     To monitor MadLoop computational aspects.
      INTEGER U_RETURN_CODES(0:9)
      INTEGER T_RETURN_CODES(0:9)
      INTEGER H_RETURN_CODES(0:9)
      DOUBLE PRECISION AVG_TIMING
      DOUBLE PRECISION MAX_PREC, MIN_PREC
      INTEGER N_EVALS
      COMMON/MADLOOPSTATS/AVG_TIMING,MAX_PREC,MIN_PREC,N_EVALS
     $ ,U_RETURN_CODES,T_RETURN_CODES,H_RETURN_CODES

      INTEGER WARNING_COUNTERS(2)
      DATA WARNING_COUNTERS/2*0/

C     ----
C     Begin code
C     ----

      CALL CPU_TIME(TIME_AFTER)
      AVG_TIMING = (AVG_TIMING * N_EVALS + (TIME_AFTER-TIME_BEFORE)) /
     $  DBLE(N_EVALS+1)
      N_EVALS = N_EVALS + 1

      U = MOD(RETURN_CODE,10)
      U_RETURN_CODES(U) = U_RETURN_CODES(U)+1
      T = (MOD(RETURN_CODE,100)-U)/10
      T_RETURN_CODES(T) = T_RETURN_CODES(T)+1
      H = (MOD(RETURN_CODE,1000)-10*T-U)/100
      H_RETURN_CODES(H) = H_RETURN_CODES(H)+1

      MAX_PREC = MAX(PREC, MAX_PREC)
      MIN_PREC = MIN(PREC, MIN_PREC)

      IF (H.EQ.4) THEN
        WARNING_COUNTERS(1) = WARNING_COUNTERS(1) + 1
        IF (WARNING_COUNTERS(1).LE.10) THEN
          WRITE(*,*) 'WARNING :: MadLoop encountered an exceptional'
     $     //' unstable PS point. Its weight is set to 0. Details'
     $     //' should be provided by MadLoop before in this log file.'
        ENDIF
        IF (WARNING_COUNTERS(1).EQ.10) THEN
          WRITE(*,*) 'WARNING :: Further warnings about exceptional'
     $     //' unstable PS points now suppressed (past the first 10).'
        ENDIF
        ME_ANSWER = 0.0D0
        RETURN
      ENDIF

      ME_ANSWER = FINITE

      IF (FINITE.EQ.0.0D0) THEN
        RETURN
      ENDIF

      IF (U.NE.7.AND.((ONEEPS+TWOEPS)/FINITE).GT.(1000D0*PREC)
     $ .AND.(((ONEEPS+TWOEPS)/FINITE).GT.1.0D-5)) THEN
        WARNING_COUNTERS(2) = WARNING_COUNTERS(2) + 1
        IF (WARNING_COUNTERS(2).LE.10) THEN
          WRITE(*,*) 'WARNING : The residue of the single and double'
     $     //' pole of the loop matrix element being integrated does'
     $     //' not seem to vanish.'
          WRITE(*,*) '          Its contribution relative to the'
     $     //' finite part is : ',((ONEEPS+TWOEPS)/FINITE)
          WRITE(*,*) '          while the estimated numerical accuracy'
     $     //' is       : ',PREC
          WRITE(*,*) '          MadLoop results (fin, 1eps, 2eps)     '
     $     //'          : ',FINITE, ONEEPS, TWOEPS
          WRITE(*,*) ' The warning above was triggered when processing'
     $     //' the following phase space point:'
          CALL ML5_0_2_2_WRITE_MOM(P)
        ENDIF
        IF (WARNING_COUNTERS(2).EQ.10) THEN
          WRITE(*,*) 'WARNING :: Further warnings about the relative'
     $     //' size of pole residues are now suppressed (past first 10'
     $     //').'
        ENDIF
      ENDIF

      END

