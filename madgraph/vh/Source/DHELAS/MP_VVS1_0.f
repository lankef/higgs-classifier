C     This File is Automatically generated by ALOHA 
C     The process calculated in this file is: 
C     Metric(1,2)
C     
      SUBROUTINE MP_VVS1_0(V1, V2, S3, COUP,VERTEX)
      IMPLICIT NONE
      COMPLEX*32 CI
      PARAMETER (CI=(0Q0,1Q0))
      COMPLEX*32 V2(*)
      COMPLEX*32 S3(*)
      COMPLEX*32 VERTEX
      COMPLEX*32 COUP
      COMPLEX*32 V1(*)
      COMPLEX*32 TMP13
      TMP13 = (V2(5)*V1(5)-V2(6)*V1(6)-V2(7)*V1(7)-V2(8)*V1(8))
      VERTEX = COUP*(-CI * TMP13*S3(5))
      END


