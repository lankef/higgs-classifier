C     This File is Automatically generated by ALOHA 
C     The process calculated in this file is: 
C     Identity(2,1)
C     
      SUBROUTINE FFS1L2_1(P2, S3, COUP, M1, W1, P1, COEFF)
      IMPLICIT NONE
      COMPLEX*16 CI
      PARAMETER (CI=(0D0,1D0))
      COMPLEX*16 S3(*)
      REAL*8 M1
      INCLUDE 'coef_specs.inc'
      COMPLEX*16 COEFF(MAXLWFSIZE,0:VERTEXMAXCOEFS-1,MAXLWFSIZE)
      COMPLEX*16 P2(0:3)
      REAL*8 W1
      COMPLEX*16 P1(0:3)
      COMPLEX*16 COUP
      P1(0) = +P2(0)+S3(1)
      P1(1) = +P2(1)+S3(2)
      P1(2) = +P2(2)+S3(3)
      P1(3) = +P2(3)+S3(4)
      COEFF(1,0,1)= COUP*CI * M1*S3(5)
      COEFF(2,0,1)= 0D0
      COEFF(3,0,1)= COUP*S3(5)*(-CI*(P1(3))+CI*(P1(0)))
      COEFF(4,0,1)= COUP*-S3(5)*(P1(2)+CI*(P1(1)))
      COEFF(1,1,1)= 0D0
      COEFF(2,1,1)= 0D0
      COEFF(3,1,1)= COUP*CI * S3(5)
      COEFF(4,1,1)= 0D0
      COEFF(1,2,1)= 0D0
      COEFF(2,2,1)= 0D0
      COEFF(3,2,1)= 0D0
      COEFF(4,2,1)= COUP*-CI * S3(5)
      COEFF(1,3,1)= 0D0
      COEFF(2,3,1)= 0D0
      COEFF(3,3,1)= 0D0
      COEFF(4,3,1)= COUP*-S3(5)
      COEFF(1,4,1)= 0D0
      COEFF(2,4,1)= 0D0
      COEFF(3,4,1)= COUP*-CI * S3(5)
      COEFF(4,4,1)= 0D0
      COEFF(1,0,2)= 0D0
      COEFF(2,0,2)= COUP*CI * M1*S3(5)
      COEFF(3,0,2)= COUP*-S3(5)*(+CI*(P1(1))-P1(2))
      COEFF(4,0,2)= COUP*S3(5)*(+CI*(P1(0)+P1(3)))
      COEFF(1,1,2)= 0D0
      COEFF(2,1,2)= 0D0
      COEFF(3,1,2)= 0D0
      COEFF(4,1,2)= COUP*CI * S3(5)
      COEFF(1,2,2)= 0D0
      COEFF(2,2,2)= 0D0
      COEFF(3,2,2)= COUP*-CI * S3(5)
      COEFF(4,2,2)= 0D0
      COEFF(1,3,2)= 0D0
      COEFF(2,3,2)= 0D0
      COEFF(3,3,2)= COUP*S3(5)
      COEFF(4,3,2)= 0D0
      COEFF(1,4,2)= 0D0
      COEFF(2,4,2)= 0D0
      COEFF(3,4,2)= 0D0
      COEFF(4,4,2)= COUP*CI * S3(5)
      COEFF(1,0,3)= COUP*S3(5)*(+CI*(P1(0)+P1(3)))
      COEFF(2,0,3)= COUP*S3(5)*(P1(2)+CI*(P1(1)))
      COEFF(3,0,3)= COUP*CI * M1*S3(5)
      COEFF(4,0,3)= 0D0
      COEFF(1,1,3)= COUP*CI * S3(5)
      COEFF(2,1,3)= 0D0
      COEFF(3,1,3)= 0D0
      COEFF(4,1,3)= 0D0
      COEFF(1,2,3)= 0D0
      COEFF(2,2,3)= COUP*CI * S3(5)
      COEFF(3,2,3)= 0D0
      COEFF(4,2,3)= 0D0
      COEFF(1,3,3)= 0D0
      COEFF(2,3,3)= COUP*S3(5)
      COEFF(3,3,3)= 0D0
      COEFF(4,3,3)= 0D0
      COEFF(1,4,3)= COUP*CI * S3(5)
      COEFF(2,4,3)= 0D0
      COEFF(3,4,3)= 0D0
      COEFF(4,4,3)= 0D0
      COEFF(1,0,4)= COUP*S3(5)*(+CI*(P1(1))-P1(2))
      COEFF(2,0,4)= COUP*S3(5)*(-CI*(P1(3))+CI*(P1(0)))
      COEFF(3,0,4)= 0D0
      COEFF(4,0,4)= COUP*CI * M1*S3(5)
      COEFF(1,1,4)= 0D0
      COEFF(2,1,4)= COUP*CI * S3(5)
      COEFF(3,1,4)= 0D0
      COEFF(4,1,4)= 0D0
      COEFF(1,2,4)= COUP*CI * S3(5)
      COEFF(2,2,4)= 0D0
      COEFF(3,2,4)= 0D0
      COEFF(4,2,4)= 0D0
      COEFF(1,3,4)= COUP*-S3(5)
      COEFF(2,3,4)= 0D0
      COEFF(3,3,4)= 0D0
      COEFF(4,3,4)= 0D0
      COEFF(1,4,4)= 0D0
      COEFF(2,4,4)= COUP*-CI * S3(5)
      COEFF(3,4,4)= 0D0
      COEFF(4,4,4)= 0D0
      END


