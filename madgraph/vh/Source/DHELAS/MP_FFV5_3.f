C     This File is Automatically generated by ALOHA 
C     The process calculated in this file is: 
C     Gamma(3,2,-1)*ProjM(-1,1) + 4*Gamma(3,2,-1)*ProjP(-1,1)
C     
      SUBROUTINE MP_FFV5_3(F1, F2, COUP, M3, W3,V3)
      IMPLICIT NONE
      COMPLEX*32 CI
      PARAMETER (CI=(0Q0,1Q0))
      COMPLEX*32 DENOM
      COMPLEX*32 V3(8)
      REAL*16 W3
      COMPLEX*32 TMP7
      REAL*16 M3
      COMPLEX*32 F1(*)
      COMPLEX*32 P3(0:3)
      COMPLEX*32 F2(*)
      REAL*16 OM3
      COMPLEX*32 TMP4
      COMPLEX*32 COUP
      OM3 = 0Q0
      IF (M3.NE.0Q0) OM3=1Q0/M3**2
      V3(1) = +F1(1)+F2(1)
      V3(2) = +F1(2)+F2(2)
      V3(3) = +F1(3)+F2(3)
      V3(4) = +F1(4)+F2(4)
      P3(0) = -V3(1)
      P3(1) = -V3(2)
      P3(2) = -V3(3)
      P3(3) = -V3(4)
      TMP4 = (F1(5)*(F2(7)*(P3(0)+P3(3))+F2(8)*(P3(1)+CI*(P3(2))))
     $ +F1(6)*(F2(7)*(P3(1)-CI*(P3(2)))+F2(8)*(P3(0)-P3(3))))
      TMP7 = (F1(7)*(F2(5)*(P3(0)-P3(3))-F2(6)*(P3(1)+CI*(P3(2))))
     $ +F1(8)*(F2(5)*(+CI*(P3(2))-P3(1))+F2(6)*(P3(0)+P3(3))))
      DENOM = COUP/(P3(0)**2-P3(1)**2-P3(2)**2-P3(3)**2 - M3 * (M3 -CI
     $ * W3))
      V3(5)= DENOM*(-4Q0 * CI)*(OM3*-1Q0/4Q0 * P3(0)*(TMP4+4Q0*(TMP7))
     $ +(+1Q0/4Q0*(F2(7)*F1(5)+F2(8)*F1(6))+F2(5)*F1(7)+F2(6)*F1(8)))
      V3(6)= DENOM*(-4Q0 * CI)*(OM3*-1Q0/4Q0 * P3(1)*(TMP4+4Q0*(TMP7))
     $ +(-1Q0/4Q0*(F2(8)*F1(5)+F2(7)*F1(6))+F2(6)*F1(7)+F2(5)*F1(8)))
      V3(7)= DENOM*4Q0 * CI*(OM3*1Q0/4Q0 * P3(2)*(TMP4+4Q0*(TMP7))+(
     $ +1Q0/4Q0 * CI*(F2(8)*F1(5))-1Q0/4Q0 * CI*(F2(7)*F1(6))-CI*(F2(6)
     $ *F1(7))+CI*(F2(5)*F1(8))))
      V3(8)= DENOM*4Q0 * CI*(OM3*1Q0/4Q0 * P3(3)*(TMP4+4Q0*(TMP7))+(
     $ +1Q0/4Q0*(F2(7)*F1(5))-1Q0/4Q0*(F2(8)*F1(6))-F2(5)*F1(7)+F2(6)
     $ *F1(8)))
      END


