C     This File is Automatically generated by ALOHA 
C     The process calculated in this file is: 
C     Gamma(3,2,-1)*ProjM(-1,1) + 4*Gamma(3,2,-1)*ProjP(-1,1)
C     
      SUBROUTINE FFV5_0(F1, F2, V3, COUP,VERTEX)
      IMPLICIT NONE
      COMPLEX*16 CI
      PARAMETER (CI=(0D0,1D0))
      COMPLEX*16 TMP5
      COMPLEX*16 V3(*)
      COMPLEX*16 F1(*)
      COMPLEX*16 TMP6
      COMPLEX*16 F2(*)
      COMPLEX*16 VERTEX
      COMPLEX*16 COUP
      TMP5 = (F1(5)*(F2(7)*(V3(5)+V3(8))+F2(8)*(V3(6)+CI*(V3(7))))
     $ +F1(6)*(F2(7)*(V3(6)-CI*(V3(7)))+F2(8)*(V3(5)-V3(8))))
      TMP6 = (F1(7)*(F2(5)*(V3(5)-V3(8))-F2(6)*(V3(6)+CI*(V3(7))))
     $ +F1(8)*(F2(5)*(+CI*(V3(7))-V3(6))+F2(6)*(V3(5)+V3(8))))
      VERTEX = COUP*(-1D0)*(+CI*(TMP5)+4D0 * CI*(TMP6))
      END


