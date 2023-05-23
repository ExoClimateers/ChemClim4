      SUBROUTINE GASCON(T,PF,FO2,FI,CGAS,NST)
c      INCLUDE '../INCLUDE/header.inc'
c A. Zsom
      INCLUDE '../INCLUDECLIM/parNGS.inc'
      INCLUDE '../INCLUDECLIM/parND.inc'
      INCLUDE '../INCLUDECLIM/parNS1.inc'
C
C  NGS is the number of gases in the solar code. The order of gases in
C  this subroutine is: O2, H2O,CO2, O3, CH4. Note that CH4 is treated in
C  a funny way because Lisa simply replaced O3 with it in the main part
C  of the code. Consequently, we have to recopy it out from gas 3 to gas
C  5.
C
      DIMENSION T(ND),PF(ND),FI(NS1,ND),F(NGS,ND),FF(NGS,ND),
     2  CGAS(ND,NGS),CON(NGS)
      COMMON/CONSS/C,BK,G,PI,SM,DM
      DATA CON/1., 8.030E-4, 1.963E-3, 1., 1.e-5/
C
C        THIS SUBROUTINE CONVERTS VOLUME MIXING RATIOS OF THE VARIOUS
C   GASES INTO COLUMN CONCENTRATIONS WITHIN EACH LAYER.  O2 AND O3
C   COLUMN DEPTHS ARE EXPRESSED IN ATM CM; H2O AND CO2 ARE IN GM/CM2.
C
      ND1 = ND - 1
      BKMG = BK*273.15/(SM*G)
C
C-TF  FI(1,J) IS H2O 
C-TF  FI(2,J) IS CO2
      DO 1 I=1,2
      DO 1 J=1,ND
   1  F(I+1,J) = FI(I,J)
C
C-TF  F(2,J) IS H2O
C-TF  F(3,J) IS CO2
C
C *** ELIMINATE O3 FROM THE SOLAR CODE AND PUT CH4 INTO GAS 5 SLOT ***
C-TF  FI(3,J) IS CH4
C-TF  FI(4,J) IS O3
      DO 5 J = 1,ND
      F(4,J) = FI(4,J)
  5   F(5,J) = FI(3,J)
C-TF  F(4,J) IS O3
C-TF  F(5,J) IS CH4
C
      DO 2 J=1,ND
   2  F(1,J) = FO2*(1. - FI(1,J))
C-TF  HERE F(1,J) IS O2, FO2 IS SET UP TO SMALL VALUE IN
C-TF  CMIXING_RATIOS.DAT. SO THERE MAY BE SMALL INCONSISTENCY HERE.

      DO 3 I=1,NGS
      FF(I,1) = F(I,1)
      FF(I,ND) = F(I,ND)
      DO 3 J=2,ND1
   3  FF(I,J) = SQRT(F(I,J)*F(I,J-1))
C
      DO 4 I=1,NGS
      FACT = CON(I)*BKMG
      DO 4 J=1,ND1
   4  CGAS(J,I) = FACT * (PF(J+1) - PF(J)) * (FF(I,J) + 4.*F(I,J)
     2  + FF(I,J+1))/(6.*DM) 

 100  FORMAT(1X,1P10E12.5) 
      RETURN
      END
