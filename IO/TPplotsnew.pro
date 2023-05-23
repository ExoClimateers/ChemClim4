pro tpchem

loadct, 39

numjunk1=78
nummix=8
junk=strarr(1)
junk1=strarr(numjunk1)
junk4=strarr(4)
junk127=strarr(127)

f0=fltarr(4,52)
mixf0=fltarr(nummix,64)
ozonef0=fltarr(5,64)
openr, 1, "./output_couple_F0star.dat"
readf, 1, junk1
readf, 1, mixf0  ;Z (km) P H2O  H2 CH4  CO  N2O   CH3CL 
readf, 1, junk4
readf, 1, ozonef0
readf, 1, junk127
readf, 1, f0 ;;press alt temp divf
close, 1


f2=fltarr(4,52)
mixf2=fltarr(nummix,64)
ozonef2=fltarr(5,64)
openr, 1, "./output_couple_F2star.dat"
readf, 1, junk1
readf, 1, mixf2  ;Z (km)P H2O  H2 CH4  CO  N2O  ; CH3CL O3  HNO3  OH  O 
readf, 1, junk4
readf, 1, ozonef2
readf, 1, junk127
readf, 1, f2 ;;press alt temp divf
close, 1

f2a=fltarr(4,52)
mixf2a=fltarr(nummix,64)
ozonef2a=fltarr(5,64)
openr, 1, "./output_couple_F2antistar.dat"
readf, 1, junk1
readf, 1, mixf2a  ;Z (km) H2O  H2 CH4  CO  N2O ;;  CH3CL O3  HNO3  OH  O 
readf, 1, junk4
readf, 1, ozonef2a
readf, 1, junk127
readf, 1, f2a ;;press alt temp divf
close, 1

f5=fltarr(4,52)
mixf5=fltarr(nummix,64)
ozonef5=fltarr(5,64)
openr, 1, "./output_couple_F5star.dat"
readf, 1, junk1
readf, 1, mixf5  ;Z (km) H2O  H2 CH4  CO  N2O ;;  CH3CL O3  HNO3  OH  O 
readf, 1, junk4
readf, 1, ozonef5
readf, 1, junk127
readf, 1, f5 ;;press alt temp divf
close, 1

;; f6500=fltarr(4,52)
;; mixf6500=fltarr(nummix,64)
;; openr, 1, "./output_couple_6500Kstar.dat"
;; readf, 1, junk1
;; readf, 1, mixf6500  ;Z (km) H2O  H2 CH4  CO  N2O ;;  CH3CL O3  HNO3  OH  O 
;; readf, 1, junk195
;; readf, 1, f6500 ;;press alt temp divf
;; close, 1

f9=fltarr(4,52)
mixf9=fltarr(nummix,64)
ozonef9=fltarr(5,64)
openr, 1, "./output_couple_F9star.dat"
readf, 1, junk1
readf, 1, mixf9  ;Z (km) H2O  H2 CH4  CO  N2O ;;  CH3CL O3  HNO3  OH  O 
readf, 1, junk4
readf, 1, ozonef9
readf, 1, junk127
readf, 1, f9 ;;press alt temp divf
close, 1

junksun=strarr(79)
sun=fltarr(4,52)
mixsun=fltarr(nummix,64)
ozonesun=fltarr(5,64)
openr, 1, "./output_couple_SUN.dat"
readf, 1, junksun
readf, 1, mixsun  ;Z (km) H2O  H2 CH4  CO  N2O  CH3CL O3  HNO3  OH  O
readf, 1, junk4
readf, 1, ozonesun 
readf, 1, junk127
readf, 1, sun ;;press alt temp divf
close, 1

g2=fltarr(4,52)
mixg2=fltarr(nummix,64)
ozoneg2=fltarr(5,64)
openr, 1, "./output_couple_G2star.dat"
readf, 1, junk1
readf, 1, mixg2  ;Z (km) H2O  H2 CH4  CO  N2O  CH3CL O3  HNO3  OH  O 
readf, 1, junk4
readf, 1, ozoneg2
readf, 1, junk127
readf, 1, g2 ;;press alt temp divf
close, 1

g2a=fltarr(4,52)
mixg2a=fltarr(nummix,64)
ozoneg2a=fltarr(5,64)
openr, 1, "./output_couple_G2antistar.dat"
readf, 1, junk1
readf, 1, mixg2a  ;Z (km) H2O  H2 CH4  CO  N2O  CH3CL O3  HNO3  OH  O 
readf, 1, junk4
readf, 1, ozoneg2a
readf, 1, junk127
readf, 1, g2a ;;press alt temp divf
close, 1

g8=fltarr(4,52)
mixg8=fltarr(nummix,64)
ozoneg8=fltarr(5,64)
openr, 1, "./output_couple_G8star.dat"
readf, 1, junk1
readf, 1, mixg8  ;Z (km) H2O  H2 CH4  CO  N2O  CH3CL O3  HNO3  OH  O 
readf, 1, junk4
readf, 1, ozoneg8
readf, 1, junk127
readf, 1, g8 ;;press alt temp divf
close, 1

k2=fltarr(4,52)
mixk2=fltarr(nummix,64)
ozonek2=fltarr(5,64)
openr, 1, "./output_couple_K2star.dat"
readf, 1, junk1
readf, 1, mixk2  ;Z (km) H2O  H2 CH4  CO  N2O  CH3CL O3  HNO3  OH  O 
readf, 1, junk4
readf, 1, ozonek2
readf, 1, junk127
readf, 1, k2 ;;press alt temp divf
close, 1

k2a=fltarr(4,52)
mixk2a=fltarr(nummix,64)
ozonek2a=fltarr(5,64)
openr, 1, "./output_couple_K2antistar.dat"
readf, 1, junk1
readf, 1, mixk2a  ;Z (km) H2O  H2 CH4  CO  N2O  CH3CL O3  HNO3  OH  O 
readf, 1, junk4
readf, 1, ozonek2a
readf, 1, junk127
readf, 1, k2a ;;press alt temp divf
close, 1

;; k5=fltarr(4,52)
;; mixk5=fltarr(nummix,64)
;; ozonek5=fltarr(5,64)
;; openr, 1, "./output_couple_K5star.dat"
;; readf, 1, junk1
;; readf, 1, mixk5  ;Z (km) H2O  H2 CH4  CO  N2O  CH3CL O3  HNO3  OH  O
;; readf, 1, junk4
;; readf, 1, ozonek5 
;; readf, 1, junk127
;; readf, 1, k5 ;;press alt temp divf
;; close, 1

readcol, "altPT_K5.txt", j,j,j,z,t,p, format="A,A,A,D,D,D",skipline=4


loadct,39




!p.multi=0
psa,filename="TP_NOSEFF_ly10.ps",/landscape,/color
plot, f0(2,*), f0(1,*),xrange=[155,360],yrange=[0,80],/ystyle,/xstyle,xtitle="Temp (K)", ytitle="Alt (km)", title="T/P Profile Ly 10(L to R: K5,K2,G8,Sun,G2,F9,F5,F2,F0)",charsize=1.0
oplot, f2(2,*),f2(1,*), color = 75;,thick=5 ;purple
oplot, f2a(2,*),f2a(1,*), color = 75,psym=1 ;purple cross
oplot, f5(2,*),f5(1,*), color = 100;,thick=5 ;blue

oplot, f9(2,*),f9(1,*), color = 150;,thick=5 ;light blue
oplot, sun(2,*),sun(1,*),linestyle=2;,thick=5
oplot, g2(2,*),g2(1,*), color=160,linestyle=2;,thick=5 ;light green
oplot, g2a(2,*),g2a(1,*), color=160, psym=1
oplot, g8(2,*),g8(1,*), color = 200;,thick=5 ;green
oplot, k2(2,*),k2(1,*), color = 230;,thick=5 ;orange
oplot, k2a(2,*),k2a(1,*), color = 230, psym=1 ;orange cross
;oplot, k5(2,*),k5(1,*), color = 0 ;red
;oplot, t,z,color=0
oplot, f0(2,*), f0(1,*), color=40;,thick=5

;oplot, m2(2,*),m2(1,*)
pse
spawn, "ps2pdf TP_NOSEFF_ly10.ps"

stop

;;Each Mixing ratio plotted all in one plot for each star type
!p.multi=[0,3,2]
psa,filename="mixing_ratios_NOSEFF_ly10.ps",/landscape,/color
plot,mixsun(2,*),mixsun(0,*), title="LY 10 Water Profile for F0-purple,F2-blue,F5-light blue,F9-green,Sun-black, G2-light green,G8-yellow,K2-red",xtitle="Mixing Ratio of Water", ytitle="Alt(km)",xrange=[1e-6,1e-2],/xstyle,/xlog,yrange=[0,60],/ystyle,charsize=0.6,linestyle=2;,thick=5
oplot, mixf0(2,*),mixf0(0,*),color=40;,thick=5
oplot, mixf2(2,*),mixf2(0,*),color=75;,thick=5
oplot, mixf5(2,*),mixf5(0,*),color=100;,thick=5
oplot, mixf9(2,*),mixf9(0,*),color=150;,thick=5
oplot, mixg2(2,*),mixg2(0,*),color=160,linestyle=2;,thick=5
oplot, mixg2a(2,*),mixg2a(0,*),color=160, psym=1;,thick=5
oplot, mixg8(2,*),mixg8(0,*),color=200;,thick=5
oplot, mixk2(2,*),mixk2(0,*),color=230;,thick=5
;oplot, mixk5(2,*),mixk5(0,*),color=0

plot,mixsun(4,*),mixsun(0,*), title="Methane Profile for F0-purple,F2-blue,F5-light blue,F9-green,Sun-black, G2-light green,G8-orange,K2-red",xtitle="Mixing Ratio of Methane", ytitle="Alt(km)",xrange=[1e-11,1e-3],/xstyle,/xlog,yrange=[0,60],/ystyle,charsize=0.6,linestyle=2
oplot, mixf0(4,*),mixf0(0,*),color=40;,thick=5
oplot, mixf2(4,*),mixf2(0,*),color=75;,thick=5
oplot, mixf5(4,*),mixf5(0,*),color=100;,thick=5
oplot, mixf9(4,*),mixf9(0,*),color=150;,thick=5
oplot, mixg2(4,*),mixg2(0,*),color=160,linestyle=2;,thick=5
oplot, mixg2a(4,*),mixg2a(0,*),color=160,psym=1;,thick=5
oplot, mixg8(4,*),mixg8(0,*),color=200;,thick=5
oplot, mixk2(4,*),mixk2(0,*),color=230;,thick=5
;oplot, mixk5(4,*),mixk5(0,*),color=0

plot,mixsun(6,*),mixsun(0,*), title="N2O Profile for F0-purple,F2-blue,F5-light blue,F9-green,Sun-black,G2-light green,G8-orange,K2-red",xtitle="Mixing Ratio of N2O", ytitle="Alt(km)",xrange=[1e-14,1e-4],/xstyle,/xlog,yrange=[0,60],/ystyle,charsize=0.6,linestyle=2
oplot, mixf0(6,*),mixf0(0,*),color=40;,thick=5
oplot, mixf2(6,*),mixf2(0,*),color=75;,thick=5
oplot, mixf5(6,*),mixf5(0,*),color=100;,thick=5
oplot, mixf9(6,*),mixf9(0,*),color=150;,thick=5
oplot, mixg2(6,*),mixg2(0,*),color=160,linestyle=2;,thick=5
oplot, mixg2a(6,*),mixg2a(0,*),color=160,psym=1;,thick=5
oplot, mixg8(6,*),mixg8(0,*),color=200;,thick=5
oplot, mixk2(6,*),mixk2(0,*),color=230;,thick=5
;oplot, mixk5(6,*),mixk5(0,*),color=0


plot,ozonesun(4,*)/ozonesun(2,*),ozonesun(0,*), title="Ozone Profile for F0-purple,F2-blue,F5-light blue,F9-green,Sun-black,G2-light green,G8-orange,K2-red",xtitle="Mixing Ratio of Ozone", ytitle="Alt(km)",xrange=[1e-8,1e-4],/xstyle,/xlog,yrange=[0,60],/ystyle,charsize=0.6,linestyle=2;,thick=5
oplot, ozonef0(4,*)/ozonef0(2,*),ozonef0(0,*),color=40;,thick=5
oplot, ozonef2(4,*)/ozonef2(2,*),ozonef2(0,*),color=75;,thick=5
oplot, ozonef5(4,*)/ozonef5(2,*),ozonef5(0,*),color=100;,thick=5
oplot, ozonef9(4,*)/ozonef9(2,*),ozonef9(0,*),color=150;,thick=5
oplot, ozoneg2(4,*)/ozoneg2(2,*),ozoneg2(0,*),linestyle=2,color=160;,thick=5
oplot, ozoneg2a(4,*)/ozoneg2a(2,*),ozoneg2a(0,*),color=160,psym=1;,thick=5
oplot, ozoneg8(4,*)/ozoneg8(2,*),ozoneg8(0,*),color=200;,thick=5
oplot, ozonek2(4,*)/ozonek2(2,*),ozonek2(0,*),color=230;,thick=5
;oplot, ozonek5(4,*)/ozonek5(2,*),ozonek5(0,*),color=0

plot,mixsun(7,*),mixsun(0,*), title="CH3Cl Profile for F0-purple,F2-blue,F5-light blue,F9-green,Sun-black,G2-light green,G8-orange,K2-red",xtitle="Mixing Ratio of Water", ytitle="Alt(km)",xrange=[1e-20,1e-6],/xstyle,/xlog,yrange=[0,60],/ystyle,charsize=0.6,linestyle=2
oplot, mixf0(7,*),mixf0(0,*),color=40;,thick=5
oplot, mixf2(7,*),mixf2(0,*),color=75;,thick=5
oplot, mixf5(7,*),mixf5(0,*),color=100;,thick=5
oplot, mixf9(7,*),mixf9(0,*),color=150;,thick=5
oplot, mixg2(7,*),mixg2(0,*),color=160,linestyle=2;,thick=5
oplot, mixg2a(7,*),mixg2a(0,*),color=160,psym=1;,thick=5
oplot, mixg8(7,*),mixg8(0,*),color=200;,thick=5
oplot, mixk2(7,*),mixk2(0,*),color=230;,thick=5
;oplot, mixk5(7,*),mixk5(0,*),color=240


;; plot,mixsun(3,*),mixsun(0,*), title="H2 Profile for F0-purple,F2-blue,F5-light blue,F9-green,G2-light green,G8-yellow,K2-orange,K5-red",xtitle="Mixing Ratio of H2", ytitle="Alt(km)",xrange=[1e-8,1e-5],/xstyle,/xlog,yrange=[0,60],/ystyle,charsize=0.6
;; oplot, mixf0(3,*),mixf0(0,*),color=40,thick=5
;; oplot, mixf2(3,*),mixf2(0,*),color=75,thick=5
;; oplot, mixf5(3,*),mixf5(0,*),color=100,thick=5
;; oplot, mixf9(3,*),mixf9(0,*),color=150,thick=5
;; oplot, mixg2(3,*),mixg2(0,*),color=160,thick=5
;; oplot, mixg8(3,*),mixg8(0,*),color=200,thick=5
;; oplot, mixk2(3,*),mixk2(0,*),color=230,thick=5
;; ;oplot, mixk5(3,*),mixk5(0,*),color=240


plot,ozonesun(3,*)/ozonesun(2,*),ozonesun(0,*), title="OH- Profile for F0-purple,F2-blue,F5-light blue,F9-green,Sun-black,G2-light green,G8-orange,K2-red",xtitle="Mixing Ratio of OH-", ytitle="Alt(km)",xrange=[1e-15,1e-7],/xstyle,/xlog,yrange=[0,60],/ystyle,charsize=0.6,linestyle=2;,thick=5
oplot, ozonef0(3,*)/ozonef0(2,*),ozonef0(0,*),color=40;,thick=5
oplot, ozonef2(3,*)/ozonef2(2,*),ozonef2(0,*),color=75;,thick=5
oplot, ozonef5(3,*)/ozonef5(2,*),ozonef5(0,*),color=100;,thick=5
oplot, ozonef9(3,*)/ozonef9(2,*),ozonef9(0,*),color=150;,thick=5
oplot, ozoneg2(3,*)/ozoneg2(2,*),ozoneg2(0,*),color=160,linestyle=2;,thick=5
oplot, ozoneg2a(3,*)/ozoneg2a(2,*),ozoneg2a(0,*),color=160,psym=1;,thick=5
oplot, ozoneg8(3,*)/ozoneg8(2,*),ozoneg8(0,*),color=200;,thick=5
oplot, ozonek2(3,*)/ozonek2(2,*),ozonek2(0,*),color=230;,thick=5
;oplot, ozonek5(3,*)/ozonek5(2,*),ozonek5(0,*),color=0


;; plot,mixsun(5,*),mixsun(0,*), title="CO Profile for F0-purple,F2-blue,F5-light blue,F9-green,G2-light green,G8-yellow,K2-orange,K5-red",xtitle="Mixing Ratio of CO", ytitle="Alt(km)",xrange=[1e-9,1e-5],/xstyle,/xlog,yrange=[0,60],/ystyle,charsize=0.6
;; oplot, mixf0(5,*),mixf0(0,*),color=40,thick=5
;; oplot, mixf2(5,*),mixf2(0,*),color=75,thick=5
;; oplot, mixf5(5,*),mixf5(0,*),color=100,thick=5
;; oplot, mixf9(5,*),mixf9(0,*),color=150,thick=5
;; oplot, mixg2(5,*),mixg2(0,*),color=160,thick=5
;; oplot, mixg8(5,*),mixg8(0,*),color=200,thick=5
;; oplot, mixk2(5,*),mixk2(0,*),color=230,thick=5
;; ;oplot, mixk5(5,*),mixk5(0,*),color=240
pse
spawn, "ps2pdf mixing_ratios_NOSEFF_ly10.ps"
!p.multi=0


end
