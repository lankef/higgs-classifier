      SUBROUTINE COLLIERLOOP(CTMODE, NLOOPLINE,RANK,PL,PDEN,M2L
     $ ,TIRCOEFS,TIRCOEFSERRORS)
C     
C     Generated by MadGraph5_aMC@NLO v. 2.6.7, 2019-10-16
C     By the MadGraph5_aMC@NLO Development Team
C     Visit launchpad.net/madgraph5 and amcatnlo.web.cern.ch
C     
C     Interface between MG5 and COLLIER.
C     It supports any rank when 1 < NLOOPLINE < 7.
C     
C     Process: u~ u > h z QED<=2 WEIGHTED<=4 [ all = QCD ]
C     Process: c~ c > h z QED<=2 WEIGHTED<=4 [ all = QCD ]
C     
C     
C     MODULES
C     
      USE COLLIER
      IMPLICIT NONE
C     
C     CONSTANTS 
C     
      LOGICAL CHECKPCONSERVATION
      PARAMETER (CHECKPCONSERVATION=.TRUE.)
      REAL*8 PIVALUE
      PARAMETER(PIVALUE=3.14159265358979323846D0)
      INTEGER MAXRANK
      PARAMETER (MAXRANK=2)
      INTEGER NLOOPGROUPS
      PARAMETER (NLOOPGROUPS=1)
      INCLUDE 'loop_max_coefs.inc'
C     
C     ARGUMENTS 
C     
      INTEGER NLOOPLINE, RANK, CTMODE
      REAL*8 PL(0:3,NLOOPLINE)
      REAL*8 PDEN(0:3,NLOOPLINE-1)
      COMPLEX*16 M2L(NLOOPLINE)
      COMPLEX*16 RES(3)
      COMPLEX*16 TIRCOEFS(0:LOOPMAXCOEFS-1,3)
      COMPLEX*16 TIRCOEFSERRORS(0:LOOPMAXCOEFS-1,3)

C     
C     LOCAL VARIABLES 
C     
      INTEGER N, I, J, K, L
      INTEGER C0,C1,C2,C3
      INTEGER N_CACHES
      INTEGER CURR_RANK, SGN
      INTEGER CURR_INDEX
      INTEGER CURR_MAXCOEF
      REAL*8 RBUFF(0:3)

      INTEGER COEFMAP_ZERO(0:LOOPMAXCOEFS-1)
      INTEGER COEFMAP_ONE(0:LOOPMAXCOEFS-1)
      INTEGER COEFMAP_TWO(0:LOOPMAXCOEFS-1)
      INTEGER COEFMAP_THREE(0:LOOPMAXCOEFS-1)
      DATA (COEFMAP_ZERO(I),I=  0,  9) / 0, 1, 0, 0, 0, 2, 1, 0, 1, 0/
      DATA (COEFMAP_ZERO(I),I= 10, 14) / 0, 1, 0, 0, 0/
      DATA (COEFMAP_ONE(I),I=  0,  9) / 0, 0, 1, 0, 0, 0, 1, 2, 0, 1/
      DATA (COEFMAP_ONE(I),I= 10, 14) / 0, 0, 1, 0, 0/
      DATA (COEFMAP_TWO(I),I=  0,  9) / 0, 0, 0, 1, 0, 0, 0, 0, 1, 1/
      DATA (COEFMAP_TWO(I),I= 10, 14) / 2, 0, 0, 1, 0/
      DATA (COEFMAP_THREE(I),I=  0,  9) / 0, 0, 0, 0, 1, 0, 0, 0, 0, 0/
      DATA (COEFMAP_THREE(I),I= 10, 14) / 0, 1, 1, 1, 2/

      REAL*8 REF_NORMALIZATION

      DOUBLE COMPLEX M2LCOLLIER(0:NLOOPLINE-1)
      DOUBLE COMPLEX MOMVEC(0:3,NLOOPLINE-1)
      DOUBLE COMPLEX MOMINV((NLOOPLINE*(NLOOPLINE-1))/2)

      DOUBLE COMPLEX TNTEN(0:RANK,0:RANK,0:RANK,0:RANK)
      DOUBLE COMPLEX TNTENUV(0:RANK,0:RANK,0:RANK,0:RANK)
      DOUBLE PRECISION TNTENERR(0:RANK)

      REAL*8 MAXCOEFFORRANK(0:RANK)

C     These quantities are for the pole evaluation
      DOUBLE COMPLEX TNTEN_UV(0:RANK,0:RANK,0:RANK,0:RANK)
      DOUBLE COMPLEX TNTENUV_UV(0:RANK,0:RANK,0:RANK,0:RANK)
      DOUBLE PRECISION TNTENERR_UV(0:RANK)
      DOUBLE COMPLEX TNTEN_IR1(0:RANK,0:RANK,0:RANK,0:RANK)
      DOUBLE COMPLEX TNTENUV_IR1(0:RANK,0:RANK,0:RANK,0:RANK)
      DOUBLE PRECISION TNTENERR_IR1(0:RANK)
      DOUBLE COMPLEX TNTEN_IR2(0:RANK,0:RANK,0:RANK,0:RANK)
      DOUBLE COMPLEX TNTENUV_IR2(0:RANK,0:RANK,0:RANK,0:RANK)
      DOUBLE PRECISION TNTENERR_IR2(0:RANK)
C     
C     GLOBAL VARIABLES
C     
      INCLUDE 'coupl.inc'
      INCLUDE 'MadLoopParams.inc'
      INCLUDE 'unique_id.inc'
      INCLUDE 'global_specs.inc'

      INTEGER ID,SQSOINDEX,R
      COMMON/LOOP/ID,SQSOINDEX,R

C     
C     These global variables cache the coefficients already computed
C      by COLLIER
C     so that they can be reused. In particular, in CTMODE 2, the
C      cached ERROR 
C     quantities for eahc rank will be used to make use of COLLIER's
C      internal
C     assessment of the numerical accuracy.
C     
      LOGICAL LOOP_ID_DONE(NLOOPGROUPS)
      DATA LOOP_ID_DONE/NLOOPGROUPS*.FALSE./
      COMPLEX*16 TIR_COEFS_DIRECT_MODE(0:LOOPMAXCOEFS-1,3,NLOOPGROUPS)
      REAL*8 TIR_COEFS_ERROR(0:MAXRANK,NLOOPGROUPS)
      COMMON/COLLIER_TIR_COEFS/TIR_COEFS_DIRECT_MODE,TIR_COEFS_ERROR
     $ ,LOOP_ID_DONE

      INTEGER COLLIER_CACHE_ACTIVE, NCALLS_IN_CACHE(4),
     $  NCOLLIERCALLS(4)
      LOGICAL MUST_INIT_EVENT
      COMMON/COLLIER_CACHE_STATUS/COLLIER_CACHE_ACTIVE,NCALLS_IN_CACHE
     $ , NCOLLIERCALLS,MUST_INIT_EVENT

      LOGICAL CTINIT, TIRINIT, GOLEMINIT, SAMURAIINIT, NINJAINIT,
     $  COLLIERINIT
      COMMON/REDUCTIONCODEINIT/CTINIT, TIRINIT,GOLEMINIT,SAMURAIINIT
     $ ,NINJAINIT, COLLIERINIT

C     ----------
C     BEGIN CODE
C     ----------

      IF (COLLIERUSECACHEFORPOLES) THEN
        N_CACHES = 4
      ELSE
        N_CACHES =1
      ENDIF

C     Initialize COLLIER if needed 
      IF (COLLIERINIT) THEN
        COLLIERINIT=.FALSE.
        CALL INITCOLLIER()
      ENDIF

C     Initialize the event if it is the first time collier is called
C      on this PS point
      IF(MUST_INIT_EVENT) THEN
        MUST_INIT_EVENT = .FALSE.
        IF (COLLIERGLOBALCACHE.EQ.0) THEN
          CALL INITEVENT_CLL()
        ELSE
          DO I=1,N_CACHES
C           Record how many events where put in the cache. On the
C            first PS point.
            IF (NCALLS_IN_CACHE(I).EQ.-1.AND.NCOLLIERCALLS(I).GT.0)
     $        THEN
              NCALLS_IN_CACHE(I) = NCOLLIERCALLS(I)
            ENDIF
          ENDDO
          DO I=1,N_CACHES
C           Now apply a safety check that our last event had as many
C            calls as the cache is setup for.
C           The only case for now when it can be half of the calls
C            when we are doing the true loop-direction test with also
C            the computation of a rotated PS point (which is computed
C            for one mode only).
            IF (NCALLS_IN_CACHE(I).NE.-1.AND..NOT. ( NCOLLIERCALLS(I)
     $       .EQ.NCALLS_IN_CACHE(I).OR. ( CTMODERUN.EQ.
     $       -1.AND..NOT.COLLIERUSEINTERNALSTABILITYTEST.AND.NROTATIONS
     $_DP.GT.0.AND.MOD(NCALLS_IN_CACHE(I),2).EQ.0.AND.(NCALLS_IN_CACHE(
     $I)/2).EQ.NCOLLIERCALLS(I) ) ) ) THEN
              WRITE(*,*) 'WARNING: A consistency check in MadLoop'
     $         //' failed and, for safety, forced MadLoop to'
     $         //' reinitialize the global cache of COLLIER. Report'
     $         //' this to MadLoop authors. The problematic cache was'
     $         //' number ',I
              IF (COLLIERGLOBALCACHE.EQ.-1) THEN
                CALL INITCACHESYSTEM_CLL(N_CACHES*NPROCS,MAXNEXTERNAL)
              ELSE
                CALL INITCACHESYSTEM_CLL(N_CACHES*NPROCS
     $           ,COLLIERGLOBALCACHE)
              ENDIF
C             Make sure all caches are switched off at first.
              CALL SWITCHOFFCACHESYSTEM_CLL()
C             Reset the cache design property
              NCALLS_IN_CACHE(:) = -1
              NCOLLIERCALLS(:)   = 0
              IF (COLLIER_CACHE_ACTIVE.EQ.1) THEN
                CALL SWITCHONCACHE_CLL((UNIQUE_ID-1)*N_CACHES+1)
              ENDIF
C             No need to check the other caches since we already had
C              to reset here.
              EXIT
            ENDIF
          ENDDO
          CALL INITEVENT_CLL((UNIQUE_ID-1)*N_CACHES+1)
          NCOLLIERCALLS(1) = 0
          IF(COLLIERCOMPUTEUVPOLES.AND.COLLIERUSECACHEFORPOLES) THEN
            CALL INITEVENT_CLL((UNIQUE_ID-1)*N_CACHES+2)
            NCOLLIERCALLS(2) = 0
          ENDIF
          IF(COLLIERCOMPUTEIRPOLES.AND.COLLIERUSECACHEFORPOLES) THEN
            CALL INITEVENT_CLL((UNIQUE_ID-1)*N_CACHES+3)
            NCOLLIERCALLS(3) = 0
            CALL INITEVENT_CLL((UNIQUE_ID-1)*N_CACHES+4)
            NCOLLIERCALLS(4) = 0
          ENDIF
        ENDIF
        CALL SETDELTAIR_CLL(0.0D0,(PIVALUE**2)/6.0D0)
        CALL SETDELTAUV_CLL(0.0D0)
        CALL SETMUIR2_CLL(MU_R**2)
        CALL SETMUUV2_CLL(MU_R**2)
      ENDIF

C     Now really start the reduction with COLLIER

C     Number of coefficients for the current rank
      CURR_MAXCOEF = 0
      DO I=0,RANK
        CURR_MAXCOEF=CURR_MAXCOEF+(3+I)*(2+I)*(1+I)/6
      ENDDO

      IF (CTMODE.NE.1.AND.CTMODE.NE.2) THEN
        WRITE(*,*) 'ERROR: COLLIER only support the computational mode'
     $   //' CTMODE equal to 1 or 2, not',CTMODE
        STOP 'Incorrect computational mode specified to the COLLIER'
     $   //' MG5aMC interface.'
      ENDIF

      DO I=0,CURR_MAXCOEF-1
        DO K=1,3
          TIRCOEFSERRORS(I,K)=DCMPLX(0.0D0,0.0D0)
        ENDDO
      ENDDO

      IF (COLLIERUSEINTERNALSTABILITYTEST) THEN
C       Use MADLOOP internal cache dedicated to COLLIER that emulates
C        the CTMODE 2
        IF (LOOP_ID_DONE(ID)) THEN
          DO I=0,CURR_MAXCOEF-1
            DO K=1,3
              TIRCOEFS(I,K)=TIR_COEFS_DIRECT_MODE(I,K,ID)
            ENDDO
          ENDDO
          DO I=0,RANK
            MAXCOEFFORRANK(I) = 0.0D0
          ENDDO
          DO I=0,CURR_MAXCOEF-1
            CURR_RANK = COEFMAP_ZERO(I)+COEFMAP_ONE(I)+COEFMAP_TWO(I)
     $       +COEFMAP_THREE(I)
            MAXCOEFFORRANK(CURR_RANK)=MAX(MAXCOEFFORRANK(CURR_RANK)
     $       ,ABS(TIR_COEFS_DIRECT_MODE(I,1,ID)))
          ENDDO
          DO I=0,CURR_MAXCOEF-1
            CURR_RANK = COEFMAP_ZERO(I)+COEFMAP_ONE(I)+COEFMAP_TWO(I)
     $       +COEFMAP_THREE(I)
            IF (MAXCOEFFORRANK(CURR_RANK).NE.0.0D0) THEN
              DO K=1,3
C               The expression below is like taking the absolute value
C                when summing errors linearly
C               TIRCOEFSERRORS(I,K)=(TIR_COEFS_ERROR(CURR_RANK,ID)/MaxC
C               oefForRank(CURR_RANK))*DCMPLX( ABS(DBLE(TIRCOEFS(I,K)))
C               ,ABS(DIMAG(TIRCOEFS(I,K))) )
C               But empirically, I observed that retaining the
C                original complex phase leads to slightly more
C                accurate estimates
                TIRCOEFSERRORS(I,K)=(TIR_COEFS_ERROR(CURR_RANK,ID)
     $           /MAXCOEFFORRANK(CURR_RANK))*TIRCOEFS(I,K)
              ENDDO
            ENDIF
          ENDDO
          RETURN
        ENDIF
      ELSE
C       Apply the loop-direction switching here.
        CALL SWITCH_ORDER(CTMODE,NLOOPLINE,PL,PDEN,M2L)
      ENDIF

C     Make sure masses are complex 
      DO I=1,NLOOPLINE
        M2LCOLLIER(I-1)=DCMPLX(M2L(I))
      ENDDO

C     Now convert the loop offset momenta to COLLIER conventions
      DO I=0,3
        DO J=1,NLOOPLINE-1
          MOMVEC(I,J)=DCMPLX(PDEN(I,J),0.0D0)
        ENDDO
      ENDDO

C     This first do loop spans over 'N' in '\foreach_N'
C     //' \foreach_i(k_i+k_{i+1}+..+k_{i+N})^2'
      CURR_INDEX = 0
      DO N=0,NLOOPLINE-1
C       We stop whenever we reached the target number of invariants
        IF (CURR_INDEX.GE.((NLOOPLINE*(NLOOPLINE-1))/2)) THEN
          EXIT
        ENDIF
C       This do loop spans over 'i' in the expression above.
        DO I=1,NLOOPLINE
          IF (CURR_INDEX.GE.((NLOOPLINE*(NLOOPLINE-1))/2)) THEN
            EXIT
          ENDIF

          CURR_INDEX = CURR_INDEX+1
          RBUFF(:) = 0.0D0
          DO J=I,I+N
            RBUFF(:) = RBUFF(:) + PL(:,MOD(J-1,NLOOPLINE)+1)
          ENDDO
          MOMINV(CURR_INDEX) = DCMPLX(RBUFF(0)**2-RBUFF(1)**2-RBUFF(2)
     $     **2-RBUFF(3)**2,0.0D0)

C         Now regularize the onshell behavior of the kinematic
C          invarients
C         All loop masses are tested, but that might be a bit too
C          inclusive.
          DO K=1,NLOOPLINE
            IF(ABS(M2L(K)).NE.0.0D0) THEN
              IF(ABS((MOMINV(CURR_INDEX)-M2L(K))/M2L(K)).LT.OSTHRES)
     $          THEN
                MOMINV(CURR_INDEX)=DCMPLX(M2L(K))
              ENDIF
            ENDIF
          ENDDO
C         For the massless onshell-case, we base the threshold only on
C          the energy component
          REF_NORMALIZATION=0.0D0
          DO L=0,0
            REF_NORMALIZATION = REF_NORMALIZATION + ABS(RBUFF(L))
          ENDDO
          REF_NORMALIZATION = (REF_NORMALIZATION/(N+1))**2
          IF(REF_NORMALIZATION.NE.0.0D0)THEN
            IF(ABS(MOMINV(CURR_INDEX)/REF_NORMALIZATION).LT.OSTHRES)
     $       THEN
              MOMINV(CURR_INDEX)=DCMPLX(0.0D0,0.0D0)
            ENDIF
          ENDIF

        ENDDO
      ENDDO

C     We can now call COLLIER
      IF (NLOOPLINE.NE.1) THEN
        CALL TNTEN_CLL(TNTEN, TNTENUV, MOMVEC, MOMINV, M2LCOLLIER,
     $    NLOOPLINE, RANK, TNTENERR)
      ELSE
        CALL TNTEN_CLL(TNTEN, TNTENUV, M2LCOLLIER, NLOOPLINE, RANK,
     $    TNTENERR)
      ENDIF
      IF (COLLIER_CACHE_ACTIVE.EQ.1) THEN
        NCOLLIERCALLS(1) = NCOLLIERCALLS(1)+1
      ENDIF

C     Now compute the UV poles if asked for
      IF (COLLIERCOMPUTEUVPOLES) THEN
        IF(COLLIER_CACHE_ACTIVE.EQ.1) THEN
          CALL SWITCHOFFCACHE_CLL((UNIQUE_ID-1)*N_CACHES+1)
          IF(COLLIERUSECACHEFORPOLES) THEN
            CALL SWITCHONCACHE_CLL((UNIQUE_ID-1)*N_CACHES+2)
          ENDIF
        ENDIF
        CALL SETDELTAUV_CLL(1.0D0)
        IF (NLOOPLINE.NE.1) THEN
          CALL TNTEN_CLL(TNTEN_UV, TNTENUV_UV, MOMVEC, MOMINV,
     $      M2LCOLLIER, NLOOPLINE, RANK, TNTENERR_UV)
        ELSE
          CALL TNTEN_CLL(TNTEN_UV, TNTENUV_UV, M2LCOLLIER, NLOOPLINE,
     $      RANK, TNTENERR_UV)
        ENDIF
        IF (COLLIER_CACHE_ACTIVE.EQ.1) THEN
          NCOLLIERCALLS(2) = NCOLLIERCALLS(2)+1
        ENDIF
        IF(COLLIER_CACHE_ACTIVE.EQ.1) THEN
          IF(COLLIERUSECACHEFORPOLES) THEN
            CALL SWITCHOFFCACHE_CLL((UNIQUE_ID-1)*N_CACHES+2)
          ENDIF
          CALL SWITCHONCACHE_CLL((UNIQUE_ID-1)*N_CACHES+1)
        ENDIF
        CALL SETDELTAUV_CLL(0.0D0)
      ENDIF

C     Now compute the IR poles if asked for
      IF (COLLIERCOMPUTEIRPOLES) THEN
        IF(COLLIER_CACHE_ACTIVE.EQ.1) THEN
          CALL SWITCHOFFCACHE_CLL((UNIQUE_ID-1)*N_CACHES+1)
          IF(COLLIERUSECACHEFORPOLES) THEN
            CALL SWITCHONCACHE_CLL((UNIQUE_ID-1)*N_CACHES+3)
          ENDIF
        ENDIF
        CALL SETDELTAIR_CLL(1.0D0,(PIVALUE**2)/6.0D0)
        IF (NLOOPLINE.NE.1) THEN
          CALL TNTEN_CLL(TNTEN_IR1, TNTENUV_IR1, MOMVEC, MOMINV,
     $      M2LCOLLIER, NLOOPLINE, RANK, TNTENERR_IR1)
        ELSE
          CALL TNTEN_CLL(TNTEN_IR1, TNTENUV_IR1, M2LCOLLIER, NLOOPLINE
     $     , RANK, TNTENERR_IR1)
        ENDIF
        IF (COLLIER_CACHE_ACTIVE.EQ.1) THEN
          NCOLLIERCALLS(3) = NCOLLIERCALLS(3)+1
        ENDIF
        IF(COLLIER_CACHE_ACTIVE.EQ.1.AND.COLLIERUSECACHEFORPOLES) THEN
          CALL SWITCHOFFCACHE_CLL((UNIQUE_ID-1)*N_CACHES+3)
          CALL SWITCHONCACHE_CLL((UNIQUE_ID-1)*N_CACHES+4)
        ENDIF
        CALL SETDELTAIR_CLL(0.0D0,1.0D0+(PIVALUE**2)/6.0D0)
        IF (NLOOPLINE.NE.1) THEN
          CALL TNTEN_CLL(TNTEN_IR2, TNTENUV_IR2, MOMVEC, MOMINV,
     $      M2LCOLLIER, NLOOPLINE, RANK, TNTENERR_IR2)
        ELSE
          CALL TNTEN_CLL(TNTEN_IR2, TNTENUV_IR2, M2LCOLLIER, NLOOPLINE
     $     , RANK, TNTENERR_IR2)
        ENDIF
        IF (COLLIER_CACHE_ACTIVE.EQ.1) THEN
          NCOLLIERCALLS(4) = NCOLLIERCALLS(4)+1
        ENDIF
        IF(COLLIER_CACHE_ACTIVE.EQ.1) THEN
          IF(COLLIERUSECACHEFORPOLES) THEN
            CALL SWITCHOFFCACHE_CLL((UNIQUE_ID-1)*N_CACHES+4)
          ENDIF
          CALL SWITCHONCACHE_CLL((UNIQUE_ID-1)*N_CACHES+1)
        ENDIF
        CALL SETDELTAIR_CLL(0.0D0,(PIVALUE**2)/6.0D0)
      ENDIF

      DO I=0,(CURR_MAXCOEF-1)
        C0 = COEFMAP_ZERO(I)
        C1 = COEFMAP_ONE(I)
        C2 = COEFMAP_TWO(I)
        C3 = COEFMAP_THREE(I)
        CURR_RANK = C0+C1+C2+C3
C       Because we must set q -> -q, we apply a minus sign to coefs of
C        odd rank
        IF (MOD(CURR_RANK,2).EQ.1) THEN
          SGN = -1
        ELSE
          SGN = 1
        ENDIF
        TIRCOEFS(I,1) = SGN*TNTEN(C0,C1,C2,C3)
        IF (COLLIERCOMPUTEUVPOLES) THEN
          TIRCOEFS(I,2) = SGN*( TNTEN_UV(C0,C1,C2,C3)-TNTEN(C0,C1,C2
     $     ,C3) )
        ELSE
          TIRCOEFS(I,2) = DCMPLX(0.0D0,0.0D0)
        ENDIF
        IF (COLLIERCOMPUTEIRPOLES) THEN
          TIRCOEFS(I,2) = TIRCOEFS(I,2) + SGN*( TNTEN_IR1(C0,C1,C2,C3)
     $     -TNTEN(C0,C1,C2,C3) )
          TIRCOEFS(I,3) = SGN*( TNTEN_IR2(C0,C1,C2,C3)-TNTEN(C0,C1,C2
     $     ,C3) )
        ELSE
          TIRCOEFS(I,3) = DCMPLX(0.0D0,0.0D0)
        ENDIF
      ENDDO

      IF (COLLIERUSEINTERNALSTABILITYTEST) THEN
C       Finish by caching the coefficients and error just computed
        LOOP_ID_DONE(ID) = .TRUE.
        DO J=0,CURR_MAXCOEF-1
          DO K=1,3
            TIR_COEFS_DIRECT_MODE(J,K,ID) = TIRCOEFS(J,K)
          ENDDO
        ENDDO
        DO J=0,RANK
          TIR_COEFS_ERROR(J,ID)=TNTENERR(J)
        ENDDO

C       Now compute the errors on each coefficient
        DO I=0,RANK
          MAXCOEFFORRANK(I) = 0.0D0
        ENDDO
        DO I=0,CURR_MAXCOEF-1
          CURR_RANK = COEFMAP_ZERO(I)+COEFMAP_ONE(I)+COEFMAP_TWO(I)
     $     +COEFMAP_THREE(I)
          MAXCOEFFORRANK(CURR_RANK)=MAX(MAXCOEFFORRANK(CURR_RANK)
     $     ,ABS(TIRCOEFS(I,1)))
        ENDDO
        DO I=0,CURR_MAXCOEF-1
          CURR_RANK = COEFMAP_ZERO(I)+COEFMAP_ONE(I)+COEFMAP_TWO(I)
     $     +COEFMAP_THREE(I)
          IF (MAXCOEFFORRANK(CURR_RANK).NE.0.0D0) THEN
            DO K=1,3
C             The expression below is like taking the absolute value
C              when summing errors linearly
C             TIRCOEFSERRORS(I,K)=(TNtenerr(CURR_RANK)/MaxCoefForRank(C
C             URR_RANK))*DCMPLX( ABS(DBLE(TIRCOEFS(I,K))),ABS(DIMAG(TIR
C             COEFS(I,K))) )			
C             But empirically, I observed that retaining the original
C              complex phase leads to slightly more accurate estimates
              TIRCOEFSERRORS(I,K)=(TNTENERR(CURR_RANK)
     $         /MAXCOEFFORRANK(CURR_RANK))*TIRCOEFS(I,K)
            ENDDO
          ENDIF
        ENDDO

      ENDIF

      END SUBROUTINE COLLIERLOOP

      SUBROUTINE CLEAR_COLLIER_CACHE()

      USE COLLIER

      INCLUDE 'loop_max_coefs.inc'
      INTEGER NLOOPGROUPS
      PARAMETER (NLOOPGROUPS=1)
      INTEGER MAXRANK
      PARAMETER (MAXRANK=2)

      INTEGER I,J,K

      INCLUDE 'MadLoopParams.inc'

      LOGICAL LOOP_ID_DONE(NLOOPGROUPS)
      COMPLEX*16 TIR_COEFS_DIRECT_MODE(0:LOOPMAXCOEFS-1,3,NLOOPGROUPS)
      COMPLEX*16 TIR_COEFS_ERROR(0:MAXRANK,NLOOPGROUPS)
      COMMON/COLLIER_TIR_COEFS/TIR_COEFS_DIRECT_MODE,TIR_COEFS_ERROR
     $ ,LOOP_ID_DONE

      INTEGER COLLIER_CACHE_ACTIVE, NCALLS_IN_CACHE(4),
     $  NCOLLIERCALLS(4)
      LOGICAL MUST_INIT_EVENT
      COMMON/COLLIER_CACHE_STATUS/COLLIER_CACHE_ACTIVE,NCALLS_IN_CACHE
     $ , NCOLLIERCALLS,MUST_INIT_EVENT

C     Make sure that next time the COLLIER Subroutine is called it
C      will call the subroutine initEvent of Collier.
      MUST_INIT_EVENT = .TRUE.

C     Reinitialize the ML cache for COLLIER
      DO I=1,NLOOPGROUPS
        LOOP_ID_DONE(I) = .FALSE.
        DO J=0,LOOPMAXCOEFS-1
          DO K=1,3
            TIR_COEFS_DIRECT_MODE(J,K,I) = DCMPLX(0.0D0,0.0D0)
          ENDDO
        ENDDO
        DO J=0,MAXRANK
          TIR_COEFS_ERROR(J,I)=0.0D0
        ENDDO
      ENDDO

      END

      SUBROUTINE SET_COLLIER_GLOBAL_CACHE(ONOFF)
C     
C     This routine is used by loop_matrix.f to turn on the global
C     cache of COLLIER when it the main SLOOP subroutine starts and
C     turn it off when it ends.
C     However several checks are performed to verify that it is safe
C     to turn it on and to reinitialize it if necessary.
C     
C     MODULES
C     
      USE COLLIER
      IMPLICIT NONE
C     
C     ARGUMENTS
C     
      LOGICAL ONOFF
C     
C     LOCAL VARIABLES
C     
      LOGICAL NEED_REINITIALIZATION
      INTEGER N_CACHES
C     
C     GLOBAL VARIABLES
C     
C     
C     This common blocks saves the relevant ML parameters when
C      activating the
C     global cache of COLLIER so that we know when we must
C      reinitialize it.
C     COLLIER_CACHE_ACTIVE is set to -1 when it has never been turned
C      on yet and
C     to 1 for 'Active' and 0 for 'Inactive'.
C     The integer NCALLS_IN_CACHE saves how many calls the cache is
C      setup for, for each of the up to four caches.
C     When it is the first PS points, it is set to -1.
      INTEGER COLLIER_CACHE_ACTIVE, NCALLS_IN_CACHE(4),
     $  NCOLLIERCALLS(4)
      DATA COLLIER_CACHE_ACTIVE/-1/
      DATA NCALLS_IN_CACHE/-1,-1,-1,-1/
      DATA NCOLLIERCALLS/0,0,0,0/
C     This is a flag to tell the COLLIER subroutine that it must init
C      the event when called.
      LOGICAL MUST_INIT_EVENT
      DATA MUST_INIT_EVENT/.TRUE./
      COMMON/COLLIER_CACHE_STATUS/COLLIER_CACHE_ACTIVE,
     $  NCALLS_IN_CACHE, NCOLLIERCALLS,MUST_INIT_EVENT

      LOGICAL COLLIERUSEINTERNALSTABILITYTEST_BU
      INTEGER USERHEL_BU, SQSO_TARGET_BU, COLLIERMODE_BU,CTMODERUN_BU
      COMMON/COLLIER_CACHE_RELEVANT_PARAMS/USERHEL_BU,SQSO_TARGET_BU
     $ ,COLLIERMODE_BU,CTMODERUN_BU,COLLIERUSEINTERNALSTABILITYTEST_BU

C     The common blocks below are to retrieve the necessary
C      information about
C     MadLoop running mode and store it in the sCOLLIER_CACHE_RELEVANT_
C     PARAMS common block.

      INCLUDE 'MadLoopParams.inc'
      INCLUDE 'unique_id.inc'
      INCLUDE 'global_specs.inc'

      LOGICAL CTINIT, TIRINIT, GOLEMINIT, SAMURAIINIT, NINJAINIT,
     $  COLLIERINIT
      COMMON/REDUCTIONCODEINIT/CTINIT, TIRINIT,GOLEMINIT,SAMURAIINIT
     $ ,NINJAINIT, COLLIERINIT

      LOGICAL CHECKPHASE
      LOGICAL HELDOUBLECHECKED
      COMMON/INIT/CHECKPHASE, HELDOUBLECHECKED

      INTEGER USERHEL
      COMMON/USERCHOICE/USERHEL

      INTEGER SQSO_TARGET
      COMMON/SOCHOICE/SQSO_TARGET

C     
C     BEGIN CODE
C     

      IF (COLLIERUSECACHEFORPOLES) THEN
        N_CACHES = 4
      ELSE
        N_CACHES =1
      ENDIF

C     Do nothing if COLLIER still has to be initialized or if global
C      caches are disabled
      IF(COLLIERINIT.OR.COLLIERGLOBALCACHE.EQ.0) THEN
        RETURN
      ENDIF

C     Never activate anything in the checkphase
      IF (ONOFF.AND.CHECKPHASE) THEN
        RETURN
      ENDIF

C     Handle the request of turning off the caching
      IF (.NOT.ONOFF) THEN
        IF (COLLIER_CACHE_ACTIVE.EQ.1) THEN
          CALL SWITCHOFFCACHE_CLL((UNIQUE_ID-1)*4+1)
          COLLIER_CACHE_ACTIVE = 0
        ENDIF
C       If we were asked to turn the cache off but it was already so,
C        then do nothing		  
        RETURN
      ENDIF

C     Handle the request of turning on the caching

C     If asked to activate it but already active, then do nothing
      IF (ONOFF.AND.COLLIER_CACHE_ACTIVE.EQ.1) THEN
        RETURN
      ENDIF

C     We are now in the position where we are asked to activate the
C      global cache but it was *not* already active.

C     If we activate it for the first time, make sure to store the
C      value of the relevant parameters, activate and return.
      IF (COLLIER_CACHE_ACTIVE.EQ.-1) THEN
        USERHEL_BU         = USERHEL
        SQSO_TARGET_BU     = SQSO_TARGET
        COLLIERMODE_BU     = COLLIERMODE
        COLLIERUSEINTERNALSTABILITYTEST_BU = COLLIERUSEINTERNALSTABILIT
     $YTEST
        CTMODERUN_BU       = CTMODERUN
        CALL SWITCHONCACHE_CLL((UNIQUE_ID-1)*4+1)
        COLLIER_CACHE_ACTIVE = 1
        RETURN
      ENDIF

C     Now perform sanity check before the activation to decide if we
C      need to reinitialize the cache system first.
      NEED_REINITIALIZATION = .FALSE.

      IF (SQSO_TARGET.NE.SQSO_TARGET_BU) THEN
        NEED_REINITIALIZATION = .TRUE.
      ENDIF

      IF (COLLIERMODE.NE.COLLIERMODE_BU) THEN
        NEED_REINITIALIZATION = .TRUE.
      ENDIF

      IF (COLLIERUSEINTERNALSTABILITYTEST.NEQV.COLLIERUSEINTERNALSTABIL
     $ITYTEST_BU) THEN
        NEED_REINITIALIZATION = .TRUE.
      ENDIF

      IF (CTMODERUN_BU.NE.CTMODERUN.AND.(.NOT.COLLIERUSEINTERNALSTABILI
     $TYTEST)) THEN
        NEED_REINITIALIZATION = .TRUE.
      ENDIF

C     When doing amplitude reduction the parameter USERHEL does not
C      impact the number/order of COLLIER calls
C     except if the LoopFilter is ON which really shouldn't be the
C      case anymore.
      IF(USELOOPFILTER.AND.(USERHEL.NE.USERHEL_BU)) THEN
        NEED_REINITIALIZATION = .TRUE.
      ENDIF

      IF(NEED_REINITIALIZATION) THEN
C       Log the event because if it happens a lot of time and floods
C        the screen, the user must see it
C       and either change its usage of MadLoop or turnoff COLLIER cache
        WRITE(*,*) 'INFO: MadLoop detected that the global cache of'
     $   //' COLLIER had to be reset because of a change in your use'
     $   //' of MadLoop. This should not happend for each event.'
        USERHEL_BU         = USERHEL
        SQSO_TARGET_BU     = SQSO_TARGET
        COLLIERMODE_BU     = COLLIERMODE
        COLLIERUSEINTERNALSTABILITYTEST_BU = COLLIERUSEINTERNALSTABILIT
     $YTEST
        CTMODERUN_BU       = CTMODERUN
        IF (COLLIERGLOBALCACHE.EQ.-1) THEN
          CALL INITCACHESYSTEM_CLL(N_CACHES*NPROCS,MAXNEXTERNAL)
        ELSE
          CALL INITCACHESYSTEM_CLL(N_CACHES*NPROCS,COLLIERGLOBALCACHE)
        ENDIF
        NCOLLIERCALLS(:)   = 0
        NCALLS_IN_CACHE(:) = -1
C       Make sure all caches are switched off at first.
        CALL SWITCHOFFCACHESYSTEM_CLL()
      ENDIF

C     Now we can finally activate the cache
      CALL SWITCHONCACHE_CLL((UNIQUE_ID-1)*4+1)
      COLLIER_CACHE_ACTIVE = 1

      END

