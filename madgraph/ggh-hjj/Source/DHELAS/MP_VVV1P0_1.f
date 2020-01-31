C     This File is Automatically generated by ALOHA 
C     The process calculated in this file is: 
C     P(3,1)*Metric(1,2) - P(3,2)*Metric(1,2) - P(2,1)*Metric(1,3) +
C      P(2,3)*Metric(1,3) + P(1,2)*Metric(2,3) - P(1,3)*Metric(2,3)
C     
      SUBROUTINE MP_VVV1P0_1(V2, V3, COUP, M1, W1,V1)
      IMPLICIT NONE
      COMPLEX*32 CI
      PARAMETER (CI=(0Q0,1Q0))
      COMPLEX*32 V2(*)
      COMPLEX*32 TMP2
      COMPLEX*32 V3(*)
      REAL*16 M1
      COMPLEX*32 TMP6
      COMPLEX*32 P2(0:3)
      REAL*16 W1
      COMPLEX*32 P3(0:3)
      COMPLEX*32 TMP4
      COMPLEX*32 TMP5
      COMPLEX*32 P1(0:3)
      COMPLEX*32 DENOM
      COMPLEX*32 COUP
      COMPLEX*32 V1(8)
      COMPLEX*32 TMP3
      P2(0) = V2(1)
      P2(1) = V2(2)
      P2(2) = V2(3)
      P2(3) = V2(4)
      P3(0) = V3(1)
      P3(1) = V3(2)
      P3(2) = V3(3)
      P3(3) = V3(4)
      V1(1) = +V2(1)+V3(1)
      V1(2) = +V2(2)+V3(2)
      V1(3) = +V2(3)+V3(3)
      V1(4) = +V2(4)+V3(4)
      P1(0) = -V1(1)
      P1(1) = -V1(2)
      P1(2) = -V1(3)
      P1(3) = -V1(4)
      TMP5 = (V2(5)*P3(0)-V2(6)*P3(1)-V2(7)*P3(2)-V2(8)*P3(3))
      TMP4 = (P1(0)*V2(5)-P1(1)*V2(6)-P1(2)*V2(7)-P1(3)*V2(8))
      TMP6 = (V3(5)*V2(5)-V3(6)*V2(6)-V3(7)*V2(7)-V3(8)*V2(8))
      TMP3 = (V3(5)*P2(0)-V3(6)*P2(1)-V3(7)*P2(2)-V3(8)*P2(3))
      TMP2 = (P1(0)*V3(5)-P1(1)*V3(6)-P1(2)*V3(7)-P1(3)*V3(8))
      DENOM = COUP/(P1(0)**2-P1(1)**2-P1(2)**2-P1(3)**2 - M1 * (M1 -CI
     $ * W1))
      V1(5)= DENOM*(TMP6*(-CI*(P2(0))+CI*(P3(0)))+(V2(5)*(-CI*(TMP2)
     $ +CI*(TMP3))+V3(5)*(-CI*(TMP5)+CI*(TMP4))))
      V1(6)= DENOM*(TMP6*(-CI*(P2(1))+CI*(P3(1)))+(V2(6)*(-CI*(TMP2)
     $ +CI*(TMP3))+V3(6)*(-CI*(TMP5)+CI*(TMP4))))
      V1(7)= DENOM*(TMP6*(-CI*(P2(2))+CI*(P3(2)))+(V2(7)*(-CI*(TMP2)
     $ +CI*(TMP3))+V3(7)*(-CI*(TMP5)+CI*(TMP4))))
      V1(8)= DENOM*(TMP6*(-CI*(P2(3))+CI*(P3(3)))+(V2(8)*(-CI*(TMP2)
     $ +CI*(TMP3))+V3(8)*(-CI*(TMP5)+CI*(TMP4))))
      END

