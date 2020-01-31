C     This File is Automatically generated by ALOHA 
C     The process calculated in this file is: 
Coup(1) * (Gamma(3,2,-1)*ProjM(-1,1)) + Coup(2) * (Gamma(3,2,-1)*ProjM(-1,1) - 2*Gamma(3,2,-1)*ProjP(-1,1))
C     
      SUBROUTINE MP_FFV2_3_0(F1, F2, V3, COUP1, COUP2,VERTEX)
      IMPLICIT NONE
      COMPLEX*32 CI
      PARAMETER (CI=(0Q0,1Q0))
      COMPLEX*32 TMP2
      COMPLEX*32 V3(*)
      COMPLEX*32 COUP2
      COMPLEX*32 F1(*)
      COMPLEX*32 COUP1
      COMPLEX*32 F2(*)
      COMPLEX*32 VERTEX
      COMPLEX*32 TMP3
      TMP3 = (F1(7)*(F2(5)*(V3(5)-V3(8))-F2(6)*(V3(6)+CI*(V3(7))))
     $ +F1(8)*(F2(5)*(+CI*(V3(7))-V3(6))+F2(6)*(V3(5)+V3(8))))
      TMP2 = (F1(5)*(F2(7)*(V3(5)+V3(8))+F2(8)*(V3(6)+CI*(V3(7))))
     $ +F1(6)*(F2(7)*(V3(6)-CI*(V3(7)))+F2(8)*(V3(5)-V3(8))))
      VERTEX = (-1Q0)*(COUP2*(-2Q0 * CI*(TMP3)+CI*(TMP2))+CI*(TMP2
     $ *COUP1))
      END

