pro tpchem

loadct, 39

Nlayers=100
nlay=string(Nlayers,format='(I3)')

outputdir='NOSEFF_sanitycheck/';_'+string(Nlayers,format='(I3)')+'Layers/'

couple_files=file_search(outputdir+"output_couple_*")


for m=0,n_elements(couple_files)-1 do begin
star=STRSPLIT(STRJOIN(STRSPLIT(couple_files(m),outputdir+'output_couple_',/EXTRACT,/REGEX)),string(Nlayers,format='(I3)')+'.dat',/EXTRACT,/REGEX)
print,star
end


;; F0
readcol, outputdir+'output_couple_F0V_'+nlay+'_ff1.0.dat',F0_z,p,F0_H2O,H2,F0_CH4,CO,F0_N2O,F0_CH3CL,skipline=78,numline=Nlayers
readcol, outputdir+'output_couple_F0V_'+nlay+'_ff1.0.dat',z,p,F0_total,F0_OH,F0_O3,skipline=82+Nlayers,numline=Nlayers
readcol, outputdir+'output_couple_F0V_'+nlay+'_ff1.0.dat',p,F0_alt,F0_t,divF,skipline=209+2*Nlayers,numline=Nlayers
;; F2
readcol,outputdir+'output_couple_F2V_'+nlay+'_ff1.0.dat' ,F2_z,p,F2_H2O,H2,F2_CH4,CO,F2_N2O,F2_CH3CL,skipline=78,numline=Nlayers
readcol,outputdir+'output_couple_F2V_'+nlay+'_ff1.0.dat' ,z,p,F2_total,F2_OH,F2_O3,skipline=82+Nlayers,numline=Nlayers
readcol,outputdir+'output_couple_F2V_'+nlay+'_ff1.0.dat' ,p,F2_alt,F2_t,divF,skipline=209+2*Nlayers,numline=Nlayers
;; F5
readcol, outputdir+'output_couple_F5V_'+nlay+'_ff1.0.dat',F5_z,p,F5_H2O,H2,F5_CH4,CO,F5_N2O,F5_CH3CL,skipline=78,numline=Nlayers
readcol, outputdir+'output_couple_F5V_'+nlay+'_ff1.0.dat',z,p,F5_total,F5_OH,F5_O3,skipline=82+Nlayers,numline=Nlayers
readcol, outputdir+'output_couple_F5V_'+nlay+'_ff1.0.dat',p,F5_alt,F5_t,divF,skipline=209+2*Nlayers,numline=Nlayers
;; F7
readcol, outputdir+'output_couple_F7V_'+nlay+'_ff1.0.dat',F7_z,p,F7_H2O,H2,F7_CH4,CO,F7_N2O,F7_CH3CL,skipline=78,numline=Nlayers
readcol, outputdir+'output_couple_F7V_'+nlay+'_ff1.0.dat',z,p,F7_total,F7_OH,F7_O3,skipline=82+Nlayers,numline=Nlayers
readcol, outputdir+'output_couple_F7V_'+nlay+'_ff1.0.dat',p,F7_alt,F7_t,divF,skipline=209+2*Nlayers,numline=Nlayers
;; F9
readcol, outputdir+'output_couple_F9V_'+nlay+'_ff1.0.dat',F9_z,p,F9_H2O,H2,F9_CH4,CO,F9_N2O,F9_CH3CL,skipline=78,numline=Nlayers
readcol, outputdir+'output_couple_F9V_'+nlay+'_ff1.0.dat',z,p,F9_total,F9_OH,F9_O3,skipline=82+Nlayers,numline=Nlayers
readcol, outputdir+'output_couple_F9V_'+nlay+'_ff1.0.dat',p,F9_alt,F9_t,divF,skipline=209+2*Nlayers,numline=Nlayers
;; G2
readcol, outputdir+'output_couple_G2V_'+nlay+'_ff1.0.dat',G2_z,p,G2_H2O,H2,G2_CH4,CO,G2_N2O,G2_CH3CL,skipline=78,numline=Nlayers
readcol, outputdir+'output_couple_G2V_'+nlay+'_ff1.0.dat',z,p,G2_total,G2_OH,G2_O3,skipline=82+Nlayers,numline=Nlayers
readcol, outputdir+'output_couple_G2V_'+nlay+'_ff1.0.dat',p,G2_alt,G2_t,divF,skipline=209+2*Nlayers,numline=Nlayers
;; G8
readcol, outputdir+'output_couple_G8V_'+nlay+'_ff1.0.dat',G8_z,p,G8_H2O,H2,G8_CH4,CO,G8_N2O,G8_CH3CL,skipline=78,numline=Nlayers
readcol, outputdir+'output_couple_G8V_'+nlay+'_ff1.0.dat',z,p,G8_total,G8_OH,G8_O3,skipline=82+Nlayers,numline=Nlayers
readcol, outputdir+'output_couple_G8V_'+nlay+'_ff1.0.dat',p,G8_alt,G8_t,divF,skipline=209+2*Nlayers,numline=Nlayers
;; K0
readcol, outputdir+'output_couple_K0V_'+nlay+'_ff1.0.dat',K0_z,p,K0_H2O,H2,K0_CH4,CO,K0_N2O,K0_CH3CL,skipline=78,numline=Nlayers
readcol, outputdir+'output_couple_K0V_'+nlay+'_ff1.0.dat',z,p,K0_total,K0_OH,K0_O3,skipline=82+Nlayers,numline=Nlayers
readcol, outputdir+'output_couple_K0V_'+nlay+'_ff1.0.dat',p,K0_alt,K0_t,divF,skipline=209+2*Nlayers,numline=Nlayers
;; K2
readcol, outputdir+'output_couple_K2V_'+nlay+'_ff1.0.dat',K2_z,p,K2_H2O,H2,K2_CH4,CO,K2_N2O,K2_CH3CL,skipline=78,numline=Nlayers
readcol, outputdir+'output_couple_K2V_'+nlay+'_ff1.0.dat',z,p,K2_total,K2_OH,K2_O3,skipline=82+Nlayers,numline=Nlayers
readcol, outputdir+'output_couple_K2V_'+nlay+'_ff1.0.dat',p,K2_alt,K2_t,divF,skipline=209+2*Nlayers,numline=Nlayers
;; K4
readcol, outputdir+'output_couple_K4V_'+nlay+'_ff1.0.dat',K4_z,p,K4_H2O,H2,K4_CH4,CO,K4_N2O,K4_CH3CL,skipline=78,numline=Nlayers
readcol, outputdir+'output_couple_K4V_'+nlay+'_ff1.0.dat',z,p,K4_total,K4_OH,K4_O3,skipline=82+Nlayers,numline=Nlayers
readcol, outputdir+'output_couple_K4V_'+nlay+'_ff1.0.dat',p,K4_alt,K4_t,divF,skipline=209+2*Nlayers,numline=Nlayers
;; K5
readcol, outputdir+'output_couple_K5V_'+nlay+'_ff1.0.dat',K5_z,p,K5_H2O,H2,K5_CH4,CO,K5_N2O,K5_CH3CL,skipline=78,numline=Nlayers
readcol, outputdir+'output_couple_K5V_'+nlay+'_ff1.0.dat',z,p,K5_total,K5_OH,K5_O3,skipline=82+Nlayers,numline=Nlayers
readcol, outputdir+'output_couple_K5V_'+nlay+'_ff1.0.dat',p,K5_alt,K5_t,divF,skipline=209+2*Nlayers,numline=Nlayers
;; K7
readcol, outputdir+'output_couple_K7V_100_ff1.0.dat',K7_z,p,K7_H2O,H2,K7_CH4,CO,K7_N2O,K7_CH3CL,skipline=78,numline=100
readcol, outputdir+'output_couple_K7V_100_ff1.0.dat',z,p,K7_total,K7_OH,K7_O3,skipline=82+100,numline=100
readcol, outputdir+'output_couple_K7V_100_ff1.0.dat',p,K7_alt,K7_t,divF,skipline=209+2*100,numline=100;; Sun
readcol, outputdir+'output_couple_Sun_'+nlay+'_ff1.0.dat',Sun_z,p,Sun_H2O,H2,Sun_CH4,CO,Sun_N2O,Sun_CH3CL,skipline=78,numline=Nlayers
readcol, outputdir+'output_couple_Sun_'+nlay+'_ff1.0.dat',z,p,Sun_total,Sun_OH,Sun_O3,skipline=82+Nlayers,numline=Nlayers
readcol, outputdir+'output_couple_Sun_'+nlay+'_ff1.0.dat',p,Sun_alt,Sun_t,divF,skipline=209+2*Nlayers,numline=Nlayers
;readcol, outputdir+'output_couple_Sun_'+nlay+'.dat_1',Sun_z,p,Sun_H2O,H2,Sun_CH4,CO,Sun_N2O,Sun_CH3CL,skipline=78,numline=Nlayers
;readcol, outputdir+'output_couple_Sun_'+nlay+'.dat_1',z,p,Sun_total,Sun_OH,Sun_O3,skipline=82+Nlayers,numline=Nlayers
;readcol, outputdir+'output_couple_Sun_'+nlay+'.dat_1',p,Sun_alt1,Sun_t1,divF,skipline=209+2*Nlayers,numline=Nlayers
!p.color=0
!p.multi=0
psa,filename=outputdir+"TP_NOSEFF_paper.ps",/color,/landscape
;window,0,retain=2
!p.background=!d.table_size-1 & !p.color = 0
!p.thick=0
   plot, F0_t, F0_alt ,xrange=[155,370],yrange=[0,60],/ystyle,/xstyle,xtitle="Temp (K)", ytitle="Alt (km)",charsize=1.5, thick=4;, title="T/P Profile Layers 100 (L to R: K7,K5,K4,K2,K0,G8,Sun,G2,F9,F7,F5,F2,F0)"

   oplot,F2_t,F2_alt,color=30, thick=4 
   oplot,F5_t,F5_alt,color=50, thick=4
   oplot,F7_t,F7_alt,color=70, thick=4
   oplot,F9_t,F9_alt,color=90, thick=4
   oplot,G2_t,G2_alt,color=110, thick=4
   oplot,G8_t,G8_alt,color=130, thick=4
   oplot,K0_t,K0_alt,color=150, thick=4
   oplot,K2_t,K2_alt,color=170, thick=4
   oplot,K4_t,K4_alt,color=190, thick=4
   oplot,K5_t,K5_alt,color=210, thick=4
   oplot,K7_t,K7_alt,color=230, thick=4
   oplot,Sun_t,Sun_alt,linestyle=2, thick=4
 pos=[0.8,0.05,0.95,0.5]  
 labels='7000K\6750K\6500K\6250K\6000K\SUN\5750K\5500K\5250K\5000K\4750K\4500K\4250K'
 cl=[0,30,50,70,90,0,110,130,150,170,190,210,230]
 li=[0, 0, 0, 0, 0,2, 0,  0,  0,  0,  0,  0,  0]
tk=[4,4,4,4,4,4,4,4,4,4,4,4,4]
 esrg_legend,labels,pos=pos,bg=255,color=cl,li=li,thick=tk
pse
spawn, "ps2pdf "+outputdir+"TP_NOSEFF_paper.ps"
;stop

!p.background=!d.table_size-1 & !p.color = 0
!p.multi=[0,3,2]
;!p.multi=[0,3,1]


width=0.28
height=0.46
space=0.0

pos1=[0.05,0.55,0.32,0.99]
pos2=[0.38,0.55,0.65 ,0.99]
pos3=[0.71,0.55,0.98,0.99]
pos4=[0.05,0.05,0.32,0.49]
pos5=[0.38,0.05,0.65 ,0.49]
pos6=[0.71,0.05,0.98,0.49]
psa,filename=outputdir+"Chemplots_NOSEFF_Paper.ps",/color,/landscape
;window,1
!p.thick=0

   plot,F0_H2O,F0_z,xtitle="Mixing Ratio (mol H!I2!NO / mol Dry Air)", ytitle="ALT(km)",xrange=[5e-7,1e-2],/xstyle,/xlog,yrange=[0,60],/ystyle,charsize=1.8, thick=4,pos=pos1
   oplot,F2_H2O,F2_z,color=30, thick=4
   oplot,F5_H2O,F5_z,color=50, thick=4
   oplot,F7_H2O,F7_z,color=70, thick=4
   oplot,F9_H2O,F9_z,color=90, thick=4
   oplot,G2_H2O,G2_z,color=110, thick=4
   oplot,G8_H2O,G8_z,color=130, thick=4
   oplot,K0_H2O,K0_z,color=150, thick=4
   oplot,K2_H2O,K2_z,color=170, thick=4
   oplot,K4_H2O,K4_z,color=190, thick=4
   oplot,K5_H2O,K5_z,color=210, thick=4
   oplot,K7_H2O,K7_z,color=230, thick=4
   oplot,Sun_H2O,Sun_z,linestyle=2, thick=4
xyouts, .2,.67, tex2idl('$H_2O$'),/NORMAL

;;   pos=[0.75,0.65,0.95,0.95]  
;;  labels='.cLegend\7000K\6750K\6500K\6250K\6000K\SUN\5750K\5500K\5250K\5000K\4750K\4500K\4250K'
;;  cl=[0,30,50,70,90,0,110,130,150,170,190,210,230]
;;  li=[0, 0, 0, 0, 0,2, 0,  0,  0,  0,  0,  0,  0]
;;  esrg_legend,labels,pos=pos,bg=255,color=cl,li=li,/box
;; !p.background=!d.table_size-1 & !p.color = 0
   plot,F0_O3/F0_total,F0_z,xtitle="Mixing Ratio (mol O!I3!N / mol Dry Air)", ytitle="ALT(km)",xrange=[1e-8,1e-4],/xstyle,/xlog,yrange=[0,60],/ystyle,charsize=1.8, thick=4,pos=pos2
   oplot,F2_O3/F2_total,F2_z,color=30, thick=4
   oplot,F5_O3/F5_total,F5_z,color=50, thick=4
   oplot,F7_O3/F7_total,F7_z,color=70, thick=4
   oplot,F9_O3/F9_total,F9_z,color=90, thick=4
   oplot,G2_O3/G2_total,G2_z,color=110, thick=4
   oplot,G8_O3/G8_total,G8_z,color=130, thick=4
   oplot,K0_O3/K0_total,K0_z,color=150, thick=4
   oplot,K2_O3/K2_total,K2_z,color=170, thick=4
   oplot,K4_O3/K4_total,K4_z,color=190, thick=4
   oplot,K5_O3/K5_total,K5_z,color=210, thick=4
   oplot,K7_O3/K7_total,K7_z,color=230, thick=4
   oplot,Sun_O3/Sun_total,Sun_z,linestyle=2, thick=4
xyouts, .57,.67, tex2idl('$O_3$'),/NORMAL

;;  pos=[0.05,0.65,0.25,0.95]  
;;  labels='.cLegend\7000K\6750K\6500K\6250K\6000K\SUN\5750K\5500K\5250K\5000K\4750K\4500K\4250K'
;;  cl=[0,30,50,70,90,0,110,130,150,170,190,210,230]
;;  li=[0, 0, 0, 0, 0,2, 0,  0,  0,  0,  0,  0,  0]
;;  esrg_legend,labels,pos=pos,bg=255,color=cl,li=li,/box
;; !p.background=!d.table_size-1 & !p.color = 0
   plot,F0_CH4,F0_z,xtitle="Mixing Ratio (mol CH!I4!N / mol Dry Air)", ytitle="ALT(km)",xrange=[1e-11,1e-3],/xstyle,/xlog,yrange=[0,60],/ystyle,charsize=1.8, thick=4,pos=pos3
   oplot,F2_CH4,F2_z,color=30, thick=4
   oplot,F5_CH4,F5_z,color=50, thick=4
   oplot,F7_CH4,F7_z,color=70, thick=4
   oplot,F9_CH4,F9_z,color=90, thick=4
   oplot,G2_CH4,G2_z,color=110, thick=4
   oplot,G8_CH4,G8_z,color=130, thick=4
   oplot,K0_CH4,K0_z,color=150, thick=4
   oplot,K2_CH4,K2_z,color=170, thick=4
   oplot,K4_CH4,K4_z,color=190, thick=4
   oplot,K5_CH4,K5_z,color=210, thick=4
   oplot,K7_CH4,K7_z,color=230, thick=4
   oplot,Sun_CH4,Sun_z,linestyle=2, thick=4
xyouts, .8,.67, tex2idl('$CH_4$'),/NORMAL

;;  pos=[0.05,0.05,0.25,0.35]  
;;  labels='.cLegend\7000K\6750K\6500K\6250K\6000K\SUN\5750K\5500K\5250K\5000K\4750K\4500K\4250K'
;;  cl=[0,30,50,70,90,0,110,130,150,170,190,210,230]
;;  li=[0, 0, 0, 0, 0,2, 0,  0,  0,  0,  0,  0,  0]
;;  esrg_legend,labels,pos=pos,bg=255,color=cl,li=li,/box
;; !p.background=!d.table_size-1 & !p.color = 0
;;;;;;;;;;;;********************************
;pse
;stop
;spawn, "ps2pdf "+outputdir+"CPH2O_CPCH4_CPO3_NOSEFF_Paper_ls.ps"

;psa,filename=outputdir+"CPN2O_CPCH3Cl_CPOH_NOSEFF_Paper_ls.ps",/color,/landscape

   plot,F0_N2O,F0_z,xtitle="Mixing Ratio (mol N!I2!NO / mol Dry Air)", ytitle="ALT(km)",xrange=[1e-14,1e-4],/xstyle,/xlog,yrange=[0,60],/ystyle,charsize=1.8, thick=4,pos=pos4
   oplot,F2_N2O,F2_z,color=30, thick=4
   oplot,F5_N2O,F5_z,color=50, thick=4
   oplot,F7_N2O,F7_z,color=70, thick=4
   oplot,F9_N2O,F9_z,color=90, thick=4
   oplot,G2_N2O,G2_z,color=110, thick=4
   oplot,G8_N2O,G8_z,color=130, thick=4
   oplot,K0_N2O,K0_z,color=150, thick=4
   oplot,K2_N2O,K2_z,color=170, thick=4
   oplot,K4_N2O,K4_z,color=190, thick=4
   oplot,K5_N2O,K5_z,color=210, thick=4
   oplot,K7_N2O,K7_z,color=230, thick=4
   oplot,Sun_N2O,Sun_z,linestyle=2, thick=4
   xyouts, .18,.2, tex2idl('$N_2O$'),/NORMAL

   pos=[0.02,0.02,0.4,0.65]  
 labels='7000K\6750K\6500K\6250K\6000K\SUN\5750K\5500K\5250K\5000K\4750K\4500K\4250K'
 cl=[0,30,50,70,90,0,110,130,150,170,190,210,230]
 li=[0, 0, 0, 0, 0,2, 0,  0,  0,  0,  0,  0,  0]
 esrg_legend,labels,pos=pos,bg=255,color=cl,li=li,thick=tk
!p.background=!d.table_size-1 & !p.color = 0 & !p.thick=0


   ;; plot,F0_O3/F0_total,F0_z, title="Ozone Profile for F0-purple,F2-blue,F5-light blue,F9-green,Sun-black,G2-light green,G8-orange,K2-red",xtitle="Mixing Ratio of Ozone", ytitle="ALT(km)",xrange=[1e-8,1e-4],/xstyle,/xlog,yrange=[0,60],/ystyle,charsize=0.6
   ;; oplot,F2_O3/F2_total,F2_z,color=30
   ;; oplot,F5_O3/F5_total,F5_z,color=50
   ;; oplot,F7_O3/F7_total,F7_z,color=70
   ;; oplot,F9_O3/F9_total,F9_z,color=90
   ;; oplot,G2_O3/G2_total,G2_z,color=110
   ;; oplot,G8_O3/G8_total,G8_z,color=130
   ;; oplot,K0_O3/K0_total,K0_z,color=150
   ;; oplot,K2_O3/K2_total,K2_z,color=170
   ;; oplot,K4_O3/K4_total,K4_z,color=190
   ;; oplot,K5_O3/K5_total,K5_z,color=210
   ;; oplot,K7_O3/K7_total,K7_z,color=230
   ;; oplot,Sun_O3/Sun_total,Sun_z,linestyle=2

   plot,F0_CH3CL,F0_z,xtitle="Mixing Ratio (mol CH!I3!NCl / mol Dry Air)", ytitle="ALT(km)",xrange=[1e-20,1e-6],/xstyle,/xlog,yrange=[0,60],charsize=1.8,/ystyle, thick=4,pos=pos5
   oplot,F2_CH3CL,F2_z,color=30, thick=4
   oplot,F5_CH3CL,F5_z,color=50, thick=4
   oplot,F7_CH3CL,F7_z,color=70, thick=4
   oplot,F9_CH3CL,F9_z,color=90, thick=4
   oplot,G2_CH3CL,G2_z,color=110, thick=4
   oplot,G8_CH3CL,G8_z,color=130, thick=4
   oplot,K0_CH3CL,K0_z,color=150, thick=4
   oplot,K2_CH3CL,K2_z,color=170, thick=4
   oplot,K4_CH3CL,K4_z,color=190, thick=4
   oplot,K5_CH3CL,K5_z,color=210, thick=4
   oplot,K7_CH3CL,K7_z,color=230, thick=4
   oplot,Sun_CH3CL,Sun_z,linestyle=2, thick=4
   xyouts, .45,.2, tex2idl('$CH_3Cl$'),/NORMAL

;;  pos=[0.05,0.05,0.25,0.35]  
;;  labels='.cLegend\7000K\6750K\6500K\6250K\6000K\SUN\5750K\5500K\5250K\5000K\4750K\4500K\4250K'
;;  cl=[0,30,50,70,90,0,110,130,150,170,190,210,230]
;;  li=[0, 0, 0, 0, 0,2, 0,  0,  0,  0,  0,  0,  0]
;;  esrg_legend,labels,pos=pos,bg=255,color=cl,li=li,/box
;; !p.background=!d.table_size-1 & !p.color = 0

   plot,F0_OH/F0_total,F0_z,xtitle="Mixing Ratio (mol OH / mol Dry Air)", ytitle="ALT(km)",xrange=[1.e-16,1e-7],/xstyle,/xlog,yrange=[0,60],charsize=1.8,/ystyle, thick=4,pos=pos6

   oplot,F2_OH/F2_total,F2_z,color=30, thick=4
   oplot,F5_OH/F5_total,F5_z,color=50, thick=4
   oplot,F7_OH/F7_total,F7_z,color=70, thick=4
   oplot,F9_OH/F9_total,F9_z,color=90, thick=4
   oplot,G2_OH/G2_total,G2_z,color=110, thick=4
   oplot,G8_OH/G8_total,G8_z,color=130, thick=4
   oplot,K0_OH/K0_total,K0_z,color=150, thick=4
   oplot,K2_OH/K2_total,K2_z,color=170, thick=4
   oplot,K4_OH/K4_total,K4_z,color=190, thick=4
   oplot,K5_OH/K5_total,K5_z,color=210, thick=4
   oplot,K7_OH/K7_total,K7_z,color=230, thick=4
   oplot,Sun_OH/Sun_total,Sun_z,linestyle=2, thick=4
   xyouts, .9,.2, tex2idl('$OH$'),/NORMAL
;;  pos=[0.05,0.65,0.25,0.95]  
;;  labels='.cLegend\7000K\6750K\6500K\6250K\6000K\SUN\5750K\5500K\5250K\5000K\4750K\4500K\4250K'
;;  cl=[0,30,50,70,90,0,110,130,150,170,190,210,230]
;;  li=[0, 0, 0, 0, 0,2, 0,  0,  0,  0,  0,  0,  0]
;;  esrg_legend,labels,pos=pos,bg=255,color=cl,li=li,/box
;; !p.background=!d.table_size-1 & !p.color = 0

pse
spawn,"ps2pdf "+outputdir+"Chemplots_NOSEFF_Paper.ps"






xran=[1e-20,1e-2]
pos1=[0.05,0.55,0.32,0.99]
pos2=[0.38,0.55,0.65 ,0.99]
pos3=[0.71,0.55,0.98,0.99]
pos4=[0.05,0.05,0.32,0.49]
pos5=[0.38,0.05,0.65 ,0.49]
pos6=[0.71,0.05,0.98,0.49]
psa,filename=outputdir+"Chemplots_NOSEFF_Paper_V2.ps",/color,/landscape
;window,1
!p.thick=0

   plot,F0_H2O,F0_z,xtitle="Mixing Ratio (mol H!I2!NO / mol Dry Air)", ytitle="ALT(km)",xrange=xran,/xstyle,/xlog,yrange=[0,60],/ystyle,charsize=1.8, thick=4,pos=pos1
   oplot,F2_H2O,F2_z,color=30, thick=4
   oplot,F5_H2O,F5_z,color=50, thick=4
   oplot,F7_H2O,F7_z,color=70, thick=4
   oplot,F9_H2O,F9_z,color=90, thick=4
   oplot,G2_H2O,G2_z,color=110, thick=4
   oplot,G8_H2O,G8_z,color=130, thick=4
   oplot,K0_H2O,K0_z,color=150, thick=4
   oplot,K2_H2O,K2_z,color=170, thick=4
   oplot,K4_H2O,K4_z,color=190, thick=4
   oplot,K5_H2O,K5_z,color=210, thick=4
   oplot,K7_H2O,K7_z,color=230, thick=4
   oplot,Sun_H2O,Sun_z,linestyle=2, thick=4
xyouts, .2,.67, tex2idl('$H_2O$'),/NORMAL

;;   pos=[0.75,0.65,0.95,0.95]  
;;  labels='.cLegend\7000K\6750K\6500K\6250K\6000K\SUN\5750K\5500K\5250K\5000K\4750K\4500K\4250K'
;;  cl=[0,30,50,70,90,0,110,130,150,170,190,210,230]
;;  li=[0, 0, 0, 0, 0,2, 0,  0,  0,  0,  0,  0,  0]
;;  esrg_legend,labels,pos=pos,bg=255,color=cl,li=li,/box
;; !p.background=!d.table_size-1 & !p.color = 0
   plot,F0_O3/F0_total,F0_z,xtitle="Mixing Ratio (mol O!I3!N / mol Dry Air)", ytitle="ALT(km)",xrange=xran,/xstyle,/xlog,yrange=[0,60],/ystyle,charsize=1.8, thick=4,pos=pos2
   oplot,F2_O3/F2_total,F2_z,color=30, thick=4
   oplot,F5_O3/F5_total,F5_z,color=50, thick=4
   oplot,F7_O3/F7_total,F7_z,color=70, thick=4
   oplot,F9_O3/F9_total,F9_z,color=90, thick=4
   oplot,G2_O3/G2_total,G2_z,color=110, thick=4
   oplot,G8_O3/G8_total,G8_z,color=130, thick=4
   oplot,K0_O3/K0_total,K0_z,color=150, thick=4
   oplot,K2_O3/K2_total,K2_z,color=170, thick=4
   oplot,K4_O3/K4_total,K4_z,color=190, thick=4
   oplot,K5_O3/K5_total,K5_z,color=210, thick=4
   oplot,K7_O3/K7_total,K7_z,color=230, thick=4
   oplot,Sun_O3/Sun_total,Sun_z,linestyle=2, thick=4
xyouts, .57,.67, tex2idl('$O_3$'),/NORMAL

;;  pos=[0.05,0.65,0.25,0.95]  
;;  labels='.cLegend\7000K\6750K\6500K\6250K\6000K\SUN\5750K\5500K\5250K\5000K\4750K\4500K\4250K'
;;  cl=[0,30,50,70,90,0,110,130,150,170,190,210,230]
;;  li=[0, 0, 0, 0, 0,2, 0,  0,  0,  0,  0,  0,  0]
;;  esrg_legend,labels,pos=pos,bg=255,color=cl,li=li,/box
;; !p.background=!d.table_size-1 & !p.color = 0
   plot,F0_CH4,F0_z,xtitle="Mixing Ratio (mol CH!I4!N / mol Dry Air)", ytitle="ALT(km)",xrange=xran,/xstyle,/xlog,yrange=[0,60],/ystyle,charsize=1.8, thick=4,pos=pos3
   oplot,F2_CH4,F2_z,color=30, thick=4
   oplot,F5_CH4,F5_z,color=50, thick=4
   oplot,F7_CH4,F7_z,color=70, thick=4
   oplot,F9_CH4,F9_z,color=90, thick=4
   oplot,G2_CH4,G2_z,color=110, thick=4
   oplot,G8_CH4,G8_z,color=130, thick=4
   oplot,K0_CH4,K0_z,color=150, thick=4
   oplot,K2_CH4,K2_z,color=170, thick=4
   oplot,K4_CH4,K4_z,color=190, thick=4
   oplot,K5_CH4,K5_z,color=210, thick=4
   oplot,K7_CH4,K7_z,color=230, thick=4
   oplot,Sun_CH4,Sun_z,linestyle=2, thick=4
xyouts, .8,.67, tex2idl('$CH_4$'),/NORMAL

;;  pos=[0.05,0.05,0.25,0.35]  
;;  labels='.cLegend\7000K\6750K\6500K\6250K\6000K\SUN\5750K\5500K\5250K\5000K\4750K\4500K\4250K'
;;  cl=[0,30,50,70,90,0,110,130,150,170,190,210,230]
;;  li=[0, 0, 0, 0, 0,2, 0,  0,  0,  0,  0,  0,  0]
;;  esrg_legend,labels,pos=pos,bg=255,color=cl,li=li,/box
;; !p.background=!d.table_size-1 & !p.color = 0
;;;;;;;;;;;;********************************
;pse
;stop
;spawn, "ps2pdf "+outputdir+"CPH2O_CPCH4_CPO3_NOSEFF_Paper_ls.ps"

;psa,filename=outputdir+"CPN2O_CPCH3Cl_CPOH_NOSEFF_Paper_ls.ps",/color,/landscape

   plot,F0_N2O,F0_z,xtitle="Mixing Ratio (mol N!I2!NO / mol Dry Air)", ytitle="ALT(km)",xrange=xran,/xstyle,/xlog,yrange=[0,60],/ystyle,charsize=1.8, thick=4,pos=pos4
   oplot,F2_N2O,F2_z,color=30, thick=4
   oplot,F5_N2O,F5_z,color=50, thick=4
   oplot,F7_N2O,F7_z,color=70, thick=4
   oplot,F9_N2O,F9_z,color=90, thick=4
   oplot,G2_N2O,G2_z,color=110, thick=4
   oplot,G8_N2O,G8_z,color=130, thick=4
   oplot,K0_N2O,K0_z,color=150, thick=4
   oplot,K2_N2O,K2_z,color=170, thick=4
   oplot,K4_N2O,K4_z,color=190, thick=4
   oplot,K5_N2O,K5_z,color=210, thick=4
   oplot,K7_N2O,K7_z,color=230, thick=4
   oplot,Sun_N2O,Sun_z,linestyle=2, thick=4
   xyouts, .15,.2, tex2idl('$N_2O$'),/NORMAL

   pos=[0.05,0.05,0.2,0.45]  
 labels='.cLegend\7000K\6750K\6500K\6250K\6000K\SUN\5750K\5500K\5250K\5000K\4750K\4500K\4250K'
 cl=[0,30,50,70,90,0,110,130,150,170,190,210,230]
 li=[0, 0, 0, 0, 0,2, 0,  0,  0,  0,  0,  0,  0]
 esrg_legend,labels,pos=pos,bg=255,color=cl,li=li,/box
!p.background=!d.table_size-1 & !p.color = 0 & !p.thick=0


   ;; plot,F0_O3/F0_total,F0_z, title="Ozone Profile for F0-purple,F2-blue,F5-light blue,F9-green,Sun-black,G2-light green,G8-orange,K2-red",xtitle="Mixing Ratio of Ozone", ytitle="ALT(km)",xrange=[1e-8,1e-4],/xstyle,/xlog,yrange=[0,60],/ystyle,charsize=0.6
   ;; oplot,F2_O3/F2_total,F2_z,color=30
   ;; oplot,F5_O3/F5_total,F5_z,color=50
   ;; oplot,F7_O3/F7_total,F7_z,color=70
   ;; oplot,F9_O3/F9_total,F9_z,color=90
   ;; oplot,G2_O3/G2_total,G2_z,color=110
   ;; oplot,G8_O3/G8_total,G8_z,color=130
   ;; oplot,K0_O3/K0_total,K0_z,color=150
   ;; oplot,K2_O3/K2_total,K2_z,color=170
   ;; oplot,K4_O3/K4_total,K4_z,color=190
   ;; oplot,K5_O3/K5_total,K5_z,color=210
   ;; oplot,K7_O3/K7_total,K7_z,color=230
   ;; oplot,Sun_O3/Sun_total,Sun_z,linestyle=2

   plot,F0_CH3CL,F0_z,xtitle="Mixing Ratio (mol CH!I3!NCl / mol Dry Air)", ytitle="ALT(km)",xrange=xran,/xstyle,/xlog,yrange=[0,60],charsize=1.8,/ystyle, thick=4,pos=pos5
   oplot,F2_CH3CL,F2_z,color=30, thick=4
   oplot,F5_CH3CL,F5_z,color=50, thick=4
   oplot,F7_CH3CL,F7_z,color=70, thick=4
   oplot,F9_CH3CL,F9_z,color=90, thick=4
   oplot,G2_CH3CL,G2_z,color=110, thick=4
   oplot,G8_CH3CL,G8_z,color=130, thick=4
   oplot,K0_CH3CL,K0_z,color=150, thick=4
   oplot,K2_CH3CL,K2_z,color=170, thick=4
   oplot,K4_CH3CL,K4_z,color=190, thick=4
   oplot,K5_CH3CL,K5_z,color=210, thick=4
   oplot,K7_CH3CL,K7_z,color=230, thick=4
   oplot,Sun_CH3CL,Sun_z,linestyle=2, thick=4
   xyouts, .45,.2, tex2idl('$CH_3Cl$'),/NORMAL

;;  pos=[0.05,0.05,0.25,0.35]  
;;  labels='.cLegend\7000K\6750K\6500K\6250K\6000K\SUN\5750K\5500K\5250K\5000K\4750K\4500K\4250K'
;;  cl=[0,30,50,70,90,0,110,130,150,170,190,210,230]
;;  li=[0, 0, 0, 0, 0,2, 0,  0,  0,  0,  0,  0,  0]
;;  esrg_legend,labels,pos=pos,bg=255,color=cl,li=li,/box
;; !p.background=!d.table_size-1 & !p.color = 0

   plot,F0_OH/F0_total,F0_z,xtitle="Mixing Ratio (mol OH / mol Dry Air)", ytitle="ALT(km)",xrange=xran,/xstyle,/xlog,yrange=[0,60],charsize=1.8,/ystyle, thick=4,pos=pos6

   oplot,F2_OH/F2_total,F2_z,color=30, thick=4
   oplot,F5_OH/F5_total,F5_z,color=50, thick=4
   oplot,F7_OH/F7_total,F7_z,color=70, thick=4
   oplot,F9_OH/F9_total,F9_z,color=90, thick=4
   oplot,G2_OH/G2_total,G2_z,color=110, thick=4
   oplot,G8_OH/G8_total,G8_z,color=130, thick=4
   oplot,K0_OH/K0_total,K0_z,color=150, thick=4
   oplot,K2_OH/K2_total,K2_z,color=170, thick=4
   oplot,K4_OH/K4_total,K4_z,color=190, thick=4
   oplot,K5_OH/K5_total,K5_z,color=210, thick=4
   oplot,K7_OH/K7_total,K7_z,color=230, thick=4
   oplot,Sun_OH/Sun_total,Sun_z,linestyle=2, thick=4
   xyouts, .9,.2, tex2idl('$OH$'),/NORMAL
;;  pos=[0.05,0.65,0.25,0.95]  
;;  labels='.cLegend\7000K\6750K\6500K\6250K\6000K\SUN\5750K\5500K\5250K\5000K\4750K\4500K\4250K'
;;  cl=[0,30,50,70,90,0,110,130,150,170,190,210,230]
;;  li=[0, 0, 0, 0, 0,2, 0,  0,  0,  0,  0,  0,  0]
;;  esrg_legend,labels,pos=pos,bg=255,color=cl,li=li,/box
;; !p.background=!d.table_size-1 & !p.color = 0

pse
spawn,"ps2pdf "+outputdir+"Chemplots_NOSEFF_Paper_V2.ps"






;pse
;spawn, "ps2pdf "+outputdir+"mixing_ratios_NOSEFF.ps"
!p.multi=0



end
