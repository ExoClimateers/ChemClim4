pro rdNextGen,name,w,f,b,teff,logg,mh
;on MIC==> 12/05/01 mods to really work on MIC!
;rdNextGen,'34-4.5-0.0',w,f,b,teff,logg,mh
;8-31-01 modified by MC "rm-->rmno" and to deposits entire spectrum now
;9-4-01 move to MIC
;------------------------------------
;rdNextGen,'k:\ngen\lte34-4.5-0.0.NextGen.spec',w,f,b,teff,logg,mh **INVOCATION
; this routine reads a gzipped NextGen
; spectrum into the variables given.
;
;-inputs:
; name: input filename
;-outputs:
; teff,logg,mh: output Teff, log(g) and metallicity
; w: wavelength array, Angstroem
; f: flux array, erg/s/cm^2/cm
; b: Planck function array, erg/s/cm^2/cm
;
; version 1.2
; written by Peter H. Hauschildt, August 1997

;spawn,string("gzip -d "+name+' >k:\ngen\rdyng_tmp || rm rdyng_tmp'),ierr
;openr,myunit,'k:\ngen\rdyng_tmp',/get_lun
path='k:' & name='' & fn='' & newname=''
read,name,PROMPT='Enter NGen name <52-4.5-0.0>: '
fn='lte'+name+'.NextGen.spec' & openr,myunit,fn,/get_lun
readf,myunit,teff,logg,mh
readf,myunit,npoint

w = fltarr(npoint)
f = fltarr(npoint)
b = fltarr(npoint)

readf,myunit,w
readf,myunit,f
readf,myunit,b
close,myunit
free_lun,myunit
;spawn,string("rmno rdyng_tmp"),ierr

;convert to microns and W/cm2/um units
;w=w*1.e-4 & ww=w(0:21190) & w1=w(21191:21311)
;f=f*1.e-11 & ff=f(0:21190) & f1=f(21191:21311)
;loadct,39 & plot,ww,ww^4*smooth(ff,75),col=200,xr=[0,20] & wshow
;oplot,ww(21151:21190),ww(21151:21190)^4*smooth(ff(21151:21190),15),col=160
;oplot,w1,w1^4*f1,col=65 & newname=''
;f2=smooth(ff(0:21190),75) & f3=smooth(ff(21151:21190),15)
;newf=[f2(0:21150),f3] & conf=congrid(newf,2115) & fff=[conf,f1]
;www=[congrid(ww,2115),w1] & q=fltarr(141) & for i=0,140 do q(i)=21+i*0.1
;plot,www,www^4*fff,xs=1,ys=1,col=255,xr=[0.3,11] & wshow
;f4=interpol(fff(2214:2217)*www(2214:2217)^4,www(2214:2217),q) & f4=f4/q^4
;wav=[www(0:2215),q] & flux=[fff(0:2215),f4]
;n=n_elements(wav) & read,newname,PROMPT='Save as <new name>: '
w=w*1.e-4 & f=f*1.e-11 & plot,w,w^4*f,/xlog & wshow & n=n_elements(w)
want='' & read,want,PROMPT='Want to write new file? <y/n>: '
if want eq 'y' then begin
  read,newname,PROMPT='Save as <new name>: '
  openw,1,'k:\ngen\'+newname & pad=' '
  for i=0,n-1 do printf,1,format='(f7.3,a1,e10.3)',w(i),pad,f(i) & close,1
  print,'closing k:\ngen\: ',newname
endif
help,w,f
end