pro tpchem

loadct, 39

Nlayers=100
nlay=string(Nlayers,format='(I3)')

outputdir='./';_'+string(Nlayers,format='(I3)')+'Layers/'

couple_files=file_search(outputdir+"output_couple_*")


for m=0,n_elements(couple_files)-1 do begin
star=STRSPLIT(STRJOIN(STRSPLIT(couple_files(m),outputdir+'output_couple_',/EXTRACT,/REGEX)),string(Nlayers,format='(I3)')+'.dat',/EXTRACT,/REGEX)
print,star
end


;; GJ 1214
readcol, outputdir+'output_couple_121_'+nlay+'_ff1.0.dat',GJ1214_z,p,GJ1214_H2O,H2,GJ1214_CH4,CO,GJ1214_N2O,GJ1214_CH3CL,skipline=78,numline=Nlayers
readcol, outputdir+'output_couple_121_'+nlay+'_ff1.0.dat',z,p,GJ1214_total,GJ1214_OH,GJ1214_O3,skipline=82+Nlayers,numline=Nlayers
readcol, outputdir+'output_couple_121_'+nlay+'_ff1.0.dat',p,GJ1214_alt,GJ1214_t,divF,skipline=209+2*Nlayers,numline=Nlayers
;; GJ 436
readcol,outputdir+'output_couple_436_'+nlay+'_ff1.0.dat' ,GJ436_z,p,GJ436_H2O,H2,GJ436_CH4,CO,GJ436_N2O,GJ436_CH3CL,skipline=78,numline=Nlayers
readcol,outputdir+'output_couple_436_'+nlay+'_ff1.0.dat' ,z,p,GJ436_total,GJ436_OH,GJ436_O3,skipline=82+Nlayers,numline=Nlayers
readcol,outputdir+'output_couple_436_'+nlay+'_ff1.0.dat' ,p,GJ436_alt,GJ436_t,divF,skipline=209+2*Nlayers,numline=Nlayers
;; GL581
readcol, outputdir+'output_couple_581_'+nlay+'_ff1.0.dat',GL581_z,p,GL581_H2O,H2,GL581_CH4,CO,GL581_N2O,GL581_CH3CL,skipline=78,numline=Nlayers
readcol, outputdir+'output_couple_581_'+nlay+'_ff1.0.dat',z,p,GL581_total,GL581_OH,GL581_O3,skipline=82+Nlayers,numline=Nlayers
readcol, outputdir+'output_couple_581_'+nlay+'_ff1.0.dat',p,GL581_alt,GL581_t,divF,skipline=209+2*Nlayers,numline=Nlayers
;; GJ 667c
readcol, outputdir+'output_couple_667_'+nlay+'_ff1.0.dat',GJ667_z,p,GJ667_H2O,H2,GJ667_CH4,CO,GJ667_N2O,GJ667_CH3CL,skipline=78,numline=Nlayers
readcol, outputdir+'output_couple_667_'+nlay+'_ff1.0.dat',z,p,GJ667_total,GJ667_OH,GJ667_O3,skipline=82+Nlayers,numline=Nlayers
readcol, outputdir+'output_couple_667_'+nlay+'_ff1.0.dat',p,GJ667_alt,GJ667_t,divF,skipline=209+2*Nlayers,numline=Nlayers
;; GJ 832
readcol, outputdir+'output_couple_832_'+nlay+'_ff1.0.dat',GJ832_z,p,GJ832_H2O,H2,GJ832_CH4,CO,GJ832_N2O,GJ832_CH3CL,skipline=78,numline=Nlayers
readcol, outputdir+'output_couple_832_'+nlay+'_ff1.0.dat',z,p,GJ832_total,GJ832_OH,GJ832_O3,skipline=82+Nlayers,numline=Nlayers
readcol, outputdir+'output_couple_832_'+nlay+'_ff1.0.dat',p,GJ832_alt,GJ832_t,divF,skipline=209+2*Nlayers,numline=Nlayers

readcol, outputdir+'output_couple_Sun_'+nlay+'.dat',Sun_z,p,Sun_H2O,H2,Sun_CH4,CO,Sun_N2O,Sun_CH3CL,skipline=78,numline=Nlayers
readcol, outputdir+'output_couple_Sun_'+nlay+'.dat',z,p,Sun_total,Sun_OH,Sun_O3,skipline=82+Nlayers,numline=Nlayers
readcol, outputdir+'output_couple_Sun_'+nlay+'.dat',p,Sun_alt,Sun_t,divF,skipline=209+2*Nlayers,numline=Nlayers

!p.color=0
!p.multi=0
psa,filename=outputdir+"TP_Mstars.ps",/color,/landscape
;window,0,retain=2
!p.background=!d.table_size-1 & !p.color = 0
!p.thick=0
   plot, GJ1214_t, GJ1214_alt ,xrange=[200,300],yrange=[0,60],/ystyle,/xstyle,xtitle="Temp (K)", ytitle="Alt (km)",charsize=1.5, thick=4;, title="T/P Profile Layers 100 (L to R: K7,K5,K4,K2,K0,G8,Sun,G2,GJ832,GJ667,GL581,GJ436,GJ1214)"

   oplot,GJ436_t,GJ436_alt,color=230, thick=4 
   oplot,GL581_t,GL581_alt,color=150, thick=4
   oplot,GJ667_t,GJ667_alt,color=200, thick=4
   oplot,GJ832_t,GJ832_alt,color=90, thick=4
   oplot,Sun_t, Sun_alt,color=0,linestyle=2,thick=4
 pos=[0.8,0.2,0.95,0.65]  
 labels='GJ 1214\GJ 436\GL 581\GJ667C\GJ 832\Sun'
 cl=[0,230,150,200,90,0]
 li=[0, 0, 0, 0, 0,2]
tk=[4,4,4,4,4,4]
 esrg_legend,labels,pos=pos,bg=255,color=cl,li=li,thick=tk
pse
spawn, "ps2pdf "+outputdir+"TP_Mstars.ps"
stop

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
psa,filename=outputdir+"Chemplots_Mstars.ps",/color,/landscape
;window,1
!p.thick=0

   plot,GJ1214_H2O,GJ1214_z,xtitle="Mixing Ratio (mol H!I2!NO / mol Dry Air)", ytitle="ALT(km)",xrange=[1e-6,1e-2],/xstyle,/xlog,yrange=[0,60],/ystyle,charsize=1.8, thick=4,pos=pos1
   oplot,GJ436_H2O,GJ436_z,color=230, thick=4
   oplot,GL581_H2O,GL581_z,color=150, thick=4
   oplot,GJ667_H2O,GJ667_z,color=200, thick=4
   oplot,GJ832_H2O,GJ832_z,color=90, thick=4
    oplot,Sun_H2O,Sun_z,color=0,linestyle=2, thick=4

xyouts, .25,.67, tex2idl('$H_2O$'),/NORMAL

;;   pos=[0.75,0.65,0.95,0.95]  
;;  labels='.cLegend\7000K\6750K\6500K\6250K\6000K\SUN\5750K\5500K\5250K\5000K\4750K\4500K\4250K'
;;  cl=[0,30,50,70,90,0,110,130,150,170,190,210,230]
;;  li=[0, 0, 0, 0, 0,2, 0,  0,  0,  0,  0,  0,  0]
;;  esrg_legend,labels,pos=pos,bg=255,color=cl,li=li,/box
;; !p.background=!d.table_size-1 & !p.color = 0
   plot,GJ1214_O3/GJ1214_total,GJ1214_z,xtitle="Mixing Ratio (mol O!I3!N / mol Dry Air)", ytitle="ALT(km)",xrange=[1e-8,1e-4],/xstyle,/xlog,yrange=[0,60],/ystyle,charsize=1.8, thick=4,pos=pos2
   oplot,GJ436_O3/GJ436_total,GJ436_z,color=230, thick=4
   oplot,GL581_O3/GL581_total,GL581_z,color=150, thick=4
   oplot,GJ667_O3/GJ667_total,GJ667_z,color=200, thick=4
   oplot,GJ832_O3/GJ832_total,GJ832_z,color=90, thick=4
    oplot,Sun_O3/Sun_total,Sun_z,color=0, thick=4,linestyle=2

xyouts, .57,.67, tex2idl('$O_3$'),/NORMAL

;;  pos=[0.05,0.65,0.25,0.95]  
;;  labels='.cLegend\7000K\6750K\6500K\6250K\6000K\SUN\5750K\5500K\5250K\5000K\4750K\4500K\4250K'
;;  cl=[0,30,50,70,90,0,110,130,150,170,190,210,230]
;;  li=[0, 0, 0, 0, 0,2, 0,  0,  0,  0,  0,  0,  0]
;;  esrg_legend,labels,pos=pos,bg=255,color=cl,li=li,/box
;; !p.background=!d.table_size-1 & !p.color = 0
   plot,GJ1214_CH4,GJ1214_z,xtitle="Mixing Ratio (mol CH!I4!N / mol Dry Air)", ytitle="ALT(km)",xrange=[1e-8,1e-3],/xstyle,/xlog,yrange=[0,60],/ystyle,charsize=1.8, thick=4,pos=pos3
   oplot,GJ436_CH4,GJ436_z,color=230, thick=4
   oplot,GL581_CH4,GL581_z,color=150, thick=4
   oplot,GJ667_CH4,GJ667_z,color=200, thick=4
   oplot,GJ832_CH4,GJ832_z,color=90, thick=4
     oplot,Sun_CH4,Sun_z,color=0, thick=4,linestyle=2

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

   plot,GJ1214_N2O,GJ1214_z,xtitle="Mixing Ratio (mol N!I2!NO / mol Dry Air)", ytitle="ALT(km)",xrange=[1e-11,1e-4],/xstyle,/xlog,yrange=[0,60],/ystyle,charsize=1.8, thick=4,pos=pos4
   oplot,GJ436_N2O,GJ436_z,color=230, thick=4
   oplot,GL581_N2O,GL581_z,color=150, thick=4
   oplot,GJ667_N2O,GJ667_z,color=200, thick=4
   oplot,GJ832_N2O,GJ832_z,color=90, thick=4
    oplot,Sun_N2O,Sun_z,color=0,linestyle=2, thick=4

   xyouts, .18,.2, tex2idl('$N_2O$'),/NORMAL

   pos=[0.02,0.02,0.4,0.65]  

 labels='GJ 1214\GJ 436\GL 581\GJ667C\GJ 832\Sun'
 cl=[0,230,150,200,90,0]
 li=[0, 0, 0, 0, 0,2]
tk=[4,4,4,4,4,4]

 esrg_legend,labels,pos=pos,bg=255,color=cl,li=li,thick=tk
!p.background=!d.table_size-1 & !p.color = 0 & !p.thick=0


   ;; plot,GJ1214_O3/GJ1214_total,GJ1214_z, title="Ozone Profile for GJ1214-purple,GJ436-blue,GL581-light blue,GJ832-green,Sun-black,G2-light green,G8-orange,K2-red",xtitle="Mixing Ratio of Ozone", ytitle="ALT(km)",xrange=[1e-8,1e-4],/xstyle,/xlog,yrange=[0,60],/ystyle,charsize=0.6
   ;; oplot,GJ436_O3/GJ436_total,GJ436_z,color=30
   ;; oplot,GL581_O3/GL581_total,GL581_z,color=50
   ;; oplot,GJ667_O3/GJ667_total,GJ667_z,color=70
   ;; oplot,GJ832_O3/GJ832_total,GJ832_z,color=90
   ;; oplot,G2_O3/G2_total,G2_z,color=110
   ;; oplot,G8_O3/G8_total,G8_z,color=130
   ;; oplot,K0_O3/K0_total,K0_z,color=150
   ;; oplot,K2_O3/K2_total,K2_z,color=170
   ;; oplot,K4_O3/K4_total,K4_z,color=190
   ;; oplot,K5_O3/K5_total,K5_z,color=210
   ;; oplot,K7_O3/K7_total,K7_z,color=230
   ;; oplot,Sun_O3/Sun_total,Sun_z,linestyle=2

   plot,GJ1214_CH3CL,GJ1214_z,xtitle="Mixing Ratio (mol CH!I3!NCl / mol Dry Air)", ytitle="ALT(km)",xrange=[1e-14,1e-6],/xstyle,/xlog,yrange=[0,60],charsize=1.8,/ystyle, thick=4,pos=pos5
   oplot,GJ436_CH3CL,GJ436_z,color=230, thick=4
   oplot,GL581_CH3CL,GL581_z,color=150, thick=4
   oplot,GJ667_CH3CL,GJ667_z,color=200, thick=4
   oplot,GJ832_CH3CL,GJ832_z,color=90, thick=4
    oplot,Sun_CH3CL,Sun_z,color=0,linestyle=2, thick=4

   xyouts, .45,.2, tex2idl('$CH_3Cl$'),/NORMAL

;;  pos=[0.05,0.05,0.25,0.35]  
;;  labels='.cLegend\7000K\6750K\6500K\6250K\6000K\SUN\5750K\5500K\5250K\5000K\4750K\4500K\4250K'
;;  cl=[0,30,50,70,90,0,110,130,150,170,190,210,230]
;;  li=[0, 0, 0, 0, 0,2, 0,  0,  0,  0,  0,  0,  0]
;;  esrg_legend,labels,pos=pos,bg=255,color=cl,li=li,/box
;; !p.background=!d.table_size-1 & !p.color = 0

   plot,GJ1214_OH/GJ1214_total,GJ1214_z,xtitle="Mixing Ratio (mol OH / mol Dry Air)", ytitle="ALT(km)",xrange=[1.e-18,1e-7],/xstyle,/xlog,yrange=[0,60],charsize=1.8,/ystyle, thick=4,pos=pos6

   oplot,GJ436_OH/GJ436_total,GJ436_z,color=230, thick=4
   oplot,GL581_OH/GL581_total,GL581_z,color=150, thick=4
   oplot,GJ667_OH/GJ667_total,GJ667_z,color=200, thick=4
   oplot,GJ832_OH/GJ832_total,GJ832_z,color=90, thick=4
     oplot,Sun_OH/Sun_total,Sun_z,color=0,linestyle=2, thick=4

   xyouts, .9,.2, tex2idl('$OH$'),/NORMAL
;;  pos=[0.05,0.65,0.25,0.95]  
;;  labels='.cLegend\7000K\6750K\6500K\6250K\6000K\SUN\5750K\5500K\5250K\5000K\4750K\4500K\4250K'
;;  cl=[0,30,50,70,90,0,110,130,150,170,190,210,230]
;;  li=[0, 0, 0, 0, 0,2, 0,  0,  0,  0,  0,  0,  0]
;;  esrg_legend,labels,pos=pos,bg=255,color=cl,li=li,/box
;; !p.background=!d.table_size-1 & !p.color = 0

pse
spawn,"ps2pdf "+outputdir+"Chemplots_Mstars.ps"




end
