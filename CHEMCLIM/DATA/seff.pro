pro seffphoto, ff, seff3,seff4,seff5,seff6,seff7,seff8,seff9,seff10,seff11,seff12,seff13,seff14,sefff2a,seffk2a

print, "Seff Photo"
print, "Fudge Factor ", ff


;;; RAN NUMERICALLY TO DETERMINE SEFF TO GET 288 K Surface Temp


print, "Seff Factors"
print, "F0", seff3
print, "F2", seff4
print, "Anti's F2",sefff2a
print, "F5", seff5
print, "F7", seff6
print, "F9", seff7
print, "G2", seff8
print, "G8", seff9
print, "K0", seff10
print, "K2", seff11
print, "Anti's K2",seffk2a
print, "K4", seff12
print, "K5", seff13
print, "K7", seff14
print, " "



;ff=2.5
;fudgefactor=ff


f0=fltarr(4,108)
header_f0=strarr(1)
openr, 1, "Teff7000K_photo.pdat_original"
readf, 1, header_f0
readf, 1, f0
close, 1

f2=fltarr(4,108)
header_f2=strarr(1)
openr, 1, "Teff6750K_photo.pdat_original"
readf, 1, header_f2
readf, 1, f2
close, 1

f2a=fltarr(4,108)
header_f2a=strarr(1)
openr, 1, "F2V_photo.pdat_original"
readf, 1, header_f2a
readf, 1, f2a
close, 1

f5=fltarr(4,108)
header_f5=strarr(1)
openr, 1, "Teff6500K_photo.pdat_original"
readf, 1, header_f5
readf, 1, f5
close, 1

f7=fltarr(4,108)
header_f7=strarr(1)
openr, 1, "Teff6250K_photo.pdat_original"
readf, 1, header_f7
readf, 1, f7
close, 1

f9=fltarr(4,108)
header_f9=strarr(1)
openr, 1, "Teff6000K_photo.pdat_original"
readf, 1, header_f9
readf, 1, f9
close, 1

g2=fltarr(4,108)
header_g2=strarr(1)
openr, 1, "Teff5750K_photo.pdat_original"
readf, 1, header_g2
readf, 1, g2
close, 1

g8=fltarr(4,108)
header_g8=strarr(1)
openr, 1, "Teff5500K_photo.pdat_original"
readf, 1, header_g8
readf, 1, g8
close, 1

k0=fltarr(4,108)
header_k0=strarr(1)
openr, 1, "Teff5250K_photo.pdat_original"
readf, 1, header_k0
readf, 1, k0
close, 1

k2=fltarr(4,108)
header_k2=strarr(1)
openr, 1, "Teff5000K_photo.pdat_original"
readf, 1, header_k2
readf, 1, k2
close, 1

k4=fltarr(4,108)
header_k4=strarr(1)
openr, 1, "Teff4750K_photo.pdat_original"
readf, 1, header_k4
readf, 1, k4
close, 1

k2a=fltarr(4,108)
header_k2a=strarr(1)
openr, 1, "K2V_photo.pdat_original"
readf, 1, header_k2a
readf, 1, k2a
close, 1

k5=fltarr(4,108)
header_k5=strarr(1)
openr, 1, "Teff4500K_photo.pdat_original"
readf, 1, header_k5
readf, 1, k5
close, 1

k7=fltarr(4,108)
header_k7=strarr(1)
openr, 1, "Teff4250K_photo.pdat_original"
readf, 1, header_k7
readf, 1, k7
close, 1


;; m2=fltarr(4,108)
;; header_m2=strarr(1)
;; openr, 1, "M2V_photo.pdat_original"
;; readf, 1, header_m2
;; readf, 1, m2
;; close, 1



print,f0(1,0)
print,f2(1,0)
print,f5(1,0)
print,f9(1,0)
print,g2(1,0)
print,g8(1,0)
print,k2(1,0)
print,k5(1,0)
;print,m2(1,0)

;; print," "


;a0(1,*)=a0(1,*)*seff0
;a5(1,*)=a5(1,*)*seff1
;a7(1,*)=a7(1,*)*seff2
f0(1,*)=f0(1,*)*seff3
f2(1,*)=f2(1,*)*seff4
f2a(1,*)=f2a(1,*)*sefff2a
f5(1,*)=f5(1,*)*seff5
f7(1,*)=f7(1,*)*seff6
f9(1,*)=f9(1,*)*seff7
g2(1,*)=g2(1,*)*seff8
g8(1,*)=g8(1,*)*seff9
k0(1,*)=k0(1,*)*seff10
k2(1,*)=k2(1,*)*seff11
k2a(1,*)=k2(1,*)*seffk2a
k4(1,*)=k4(1,*)*seff12
k5(1,*)=k5(1,*)*seff13
k7(1,*)=k7(1,*)*seff14
;m1(1,*)=m1(1,*)*seff11
;m2(1,*)=m2(1,*)*seff12

print,f0(1,0)
print,f2(1,0)
print,f5(1,0)
print,f9(1,0)
print,g2(1,0)
print,g8(1,0)
print,k2(1,0)
print,k5(1,0)
;print,m2(1,0)

openw, lun, "Teff7000K_photo.pdat",/get_lun
printf,lun,header_f0
for i=0,108-1 do begin
printf, lun, f0(0,i),f0(1,i),f0(2,i),f0(3,i),format='(1x,i3,2x,1E11.4,2x,f6.0,1x,f6.0)'
endfor
free_lun, lun

openw, lun, "Teff6750K_photo.pdat",/get_lun
printf,lun,header_f2
for i=0,108-1 do begin
printf, lun, f2(0,i),f2(1,i),f2(2,i),f2(3,i),format='(1x,i3,2x,1E11.4,2x,f6.0,1x,f6.0)'
endfor
free_lun, lun

openw, lun, "F2V_photo.pdat",/get_lun
printf,lun,header_f2a
for i=0,108-1 do begin
printf, lun, f2a(0,i),f2a(1,i),f2a(2,i),f2a(3,i),format='(1x,i3,2x,1E11.4,2x,f6.0,1x,f6.0)'
endfor
free_lun, lun

openw, lun, "Teff6500K_photo.pdat",/get_lun
printf,lun,header_f5
for i=0,108-1 do begin
printf, lun, f5(0,i),f5(1,i),f5(2,i),f5(3,i),format='(1x,i3,2x,1E11.4,2x,f6.0,1x,f6.0)'
endfor
free_lun, lun

openw, lun, "Teff6250K_photo.pdat",/get_lun
printf,lun,header_f7
for i=0,108-1 do begin
printf, lun, f7(0,i),f7(1,i),f7(2,i),f7(3,i),format='(1x,i3,2x,1E11.4,2x,f6.0,1x,f6.0)'
endfor
free_lun, lun

openw, lun, "Teff6000K_photo.pdat",/get_lun
printf,lun,header_f9
for i=0,108-1 do begin
printf, lun, f9(0,i),f9(1,i),f9(2,i),f9(3,i),format='(1x,i3,2x,1E11.4,2x,f6.0,1x,f6.0)'
endfor
free_lun, lun

openw, lun, "Teff5750K_photo.pdat",/get_lun
printf,lun,header_g2
for i=0,108-1 do begin
printf, lun, g2(0,i),g2(1,i),g2(2,i),g2(3,i),format='(1x,i3,2x,1E11.4,2x,f6.0,1x,f6.0)'
endfor
free_lun, lun

openw, lun, "Teff5500K_photo.pdat",/get_lun
printf,lun,header_g8
for i=0,108-1 do begin
printf, lun, g8(0,i),g8(1,i),g8(2,i),g8(3,i),format='(1x,i3,2x,1E11.4,2x,f6.0,1x,f6.0)'
endfor
free_lun, lun

openw, lun, "Teff5250K_photo.pdat",/get_lun
printf,lun,header_k0
for i=0,108-1 do begin
printf, lun, k0(0,i),k0(1,i),k0(2,i),k0(3,i),format='(1x,i3,2x,1E11.4,2x,f6.0,1x,f6.0)'
endfor
free_lun, lun

openw, lun, "Teff5000K_photo.pdat",/get_lun
printf,lun,header_k2
for i=0,108-1 do begin
printf, lun, k2(0,i),k2(1,i),k2(2,i),k2(3,i),format='(1x,i3,2x,1E11.4,2x,f6.0,1x,f6.0)'
endfor
free_lun, lun

openw, lun, "K2V_photo.pdat",/get_lun
printf,lun,header_k2a
for i=0,108-1 do begin
printf, lun, k2a(0,i),k2a(1,i),k2a(2,i),k2a(3,i),format='(1x,i3,2x,1E11.4,2x,f6.0,1x,f6.0)'
endfor
free_lun, lun

openw, lun, "Teff4750K_photo.pdat",/get_lun
printf,lun,header_k4
for i=0,108-1 do begin
printf, lun, k4(0,i),k4(1,i),k4(2,i),k4(3,i),format='(1x,i3,2x,1E11.4,2x,f6.0,1x,f6.0)'
endfor
free_lun, lun

openw, lun, "Teff4500K_photo.pdat",/get_lun
printf,lun,header_k5
for i=0,108-1 do begin
printf, lun, k5(0,i),k5(1,i),k5(2,i),k5(3,i),format='(1x,i3,2x,1E11.4,2x,f6.0,1x,f6.0)'
endfor
free_lun, lun

openw, lun, "Teff4250K_photo.pdat",/get_lun
printf,lun,header_k7
for i=0,108-1 do begin
printf, lun, k7(0,i),k7(1,i),k7(2,i),k7(3,i),format='(1x,i3,2x,1E11.4,2x,f6.0,1x,f6.0)'
endfor
free_lun, lun

;; openw, lun, "M2V_photo.pdat",/get_lun
;; printf,lun,header_m2
;; for i=0,108-1 do begin
;; printf, lun, m2(0,i),m2(1,i),m2(2,i),m2(3,i),format='(1x,i3,2x,1E11.4,2x,f6.0,1x,f6.0)'
;; endfor
;; free_lun, lun

end


pro seffsurf, ff, seff3,seff4,seff5,seff6,seff7,seff8,seff9,seff10,seff11,seff12,seff13,seff14,sefff2a,seffk2a

print, "Seff Surf"
print, "Fudge Factor ", ff





N=54
N1=16
N2=38
header="                           "

f0=fltarr(4,N)
header_f0=strarr(1)
openr, 1, "Teff7000K_surf.pdat_original"
readf, 1, header_f0
readf, 1, f0
close, 1

;print, f0


f2=fltarr(4,N)
header_f2=strarr(1)
openr, 1, "Teff6750K_surf.pdat_original"
readf, 1, header_f2
readf, 1, f2
close, 1

f2a=fltarr(4,N)
header_f2a=strarr(1)
openr, 1, "F2V_surf.pdat_original"
readf, 1, header_f2a
readf, 1, f2a
close, 1


f5=fltarr(4,N)
header_f5=strarr(1)
openr, 1, "Teff6500K_surf.pdat_original"
readf, 1, header_f5
readf, 1, f5
close, 1

f7=fltarr(4,N)
header_f7=strarr(1)
openr, 1, "Teff6250K_surf.pdat_original"
readf, 1, header_f7
readf, 1, f7
close, 1

f9=fltarr(4,N)
header_f9=strarr(1)
openr, 1, "Teff6000K_surf.pdat_original"
readf, 1, header_f9
readf, 1, f9
close, 1

g2=fltarr(4,N)
header_g2=strarr(1)
openr, 1, "Teff5750K_surf.pdat_original"
readf, 1, header_g2
readf, 1, g2
close, 1

g8=fltarr(4,N)
header_g8=strarr(1)
openr, 1, "Teff5500K_surf.pdat_original"
readf, 1, header_g8
readf, 1, g8
close, 1

k0=fltarr(4,N)
header_k0=strarr(1)
openr, 1, "Teff5250K_surf.pdat_original"
readf, 1, header_k0
readf, 1, k0
close, 1

k2=fltarr(4,N)
header_k2=strarr(1)
openr, 1, "Teff5000K_surf.pdat_original"
readf, 1, header_k2
readf, 1, k2
close, 1

k2a=fltarr(4,N)
header_k2a=strarr(1)
openr, 1, "K2V_surf.pdat_original"
readf, 1, header_k2a
readf, 1, k2a
close, 1

k4=fltarr(4,N)
header_k4=strarr(1)
openr, 1, "Teff4750K_surf.pdat_original"
readf, 1, header_k4
readf, 1, k4
close, 1

k5=fltarr(4,N)
header_k5=strarr(1)
openr, 1, "Teff4500K_surf.pdat_original"
readf, 1, header_k5
readf, 1, k5
close, 1

k7=fltarr(4,N)
header_k7=strarr(1)
openr, 1, "Teff4250K_surf.pdat_original"
readf, 1, header_k7
readf, 1, k7
close, 1



;; m2=fltarr(4,N)
;; header_m2=strarr(1)
;; openr, 1, "M2V_surf.pdat_original"
;; readf, 1, header_m2
;; readf, 1, m2
;; close, 1

;ff=2.5
;fudgefactor=ff

print,f0(1,0)
print,f2(1,0)
print,f5(1,0)
print,f9(1,0)
print,g2(1,0)
print,g8(1,0)
print,k2(1,0)
print,k5(1,0)
;; print,m2(1,0)

;; print," "




;a0(1,*)=a0(1,*)*seff0
;a5(1,*)=a5(1,*)*seff1
;a7(1,*)=a7(1,*)*seff2
f0(1,*)=f0(1,*)*seff3
f2(1,*)=f2(1,*)*seff4
f2a(1,*)=f2a(1,*)*sefff2a
f5(1,*)=f5(1,*)*seff5
f7(1,*)=f7(1,*)*seff6
f9(1,*)=f9(1,*)*seff7
g2(1,*)=g2(1,*)*seff8
g8(1,*)=g8(1,*)*seff9
k0(1,*)=k0(1,*)*seff10
k2(1,*)=k2(1,*)*seff11
k2a(1,*)=k2(1,*)*seffk2a
k4(1,*)=k4(1,*)*seff12
k5(1,*)=k5(1,*)*seff13
k7(1,*)=k7(1,*)*seff14
;m1(1,*)=m1(1,*)*seff11
;m2(1,*)=m2(1,*)*seff12


print,f0(1,0)
print,f2(1,0)
print,f5(1,0)
print,f9(1,0)
print,g2(1,0)
print,g8(1,0)
print,k2(1,0)
print,k5(1,0)
;; print,m2(1,0)



openw, lun, "Teff7000K_surf.pdat",/get_lun
printf,lun,header_f0
for i=0,N1-1 do begin
printf, lun, f0(0,i),f0(1,i),f0(2,i),f0(3,i),format='(1x,i3,2x,1E11.4,2x,f6.0,1x,f6.0)'
endfor
printf,lun,header
for i=N1,N-1 do begin
printf, lun, f0(0,i),f0(1,i),f0(2,i),f0(3,i),format='(1x,i3,2x,1E11.4,2x,f6.0,1x,f6.0)'
endfor
free_lun, lun



openw, lun, "Teff6750K_surf.pdat",/get_lun
printf,lun,header_f2
for i=0,N1-1 do begin
printf, lun, f2(0,i),f2(1,i),f2(2,i),f2(3,i),format='(1x,i3,2x,1E11.4,2x,f6.0,1x,f6.0)'
endfor
printf,lun,header
for i=N1,N-1 do begin
printf, lun, f2(0,i),f2(1,i),f2(2,i),f2(3,i),format='(1x,i3,2x,1E11.4,2x,f6.0,1x,f6.0)'
endfor
free_lun, lun

openw, lun, "F2V_surf.pdat",/get_lun
printf,lun,header_f2a
for i=0,N1-1 do begin
printf, lun, f2a(0,i),f2a(1,i),f2a(2,i),f2a(3,i),format='(1x,i3,2x,1E11.4,2x,f6.0,1x,f6.0)'
endfor
printf,lun,header
for i=N1,N-1 do begin
printf, lun, f2a(0,i),f2a(1,i),f2a(2,i),f2a(3,i),format='(1x,i3,2x,1E11.4,2x,f6.0,1x,f6.0)'
endfor
free_lun, lun


openw, lun, "Teff6500K_surf.pdat",/get_lun
printf,lun,header_f5
for i=0,N1-1 do begin
printf, lun, f5(0,i),f5(1,i),f5(2,i),f5(3,i),format='(1x,i3,2x,1E11.4,2x,f6.0,1x,f6.0)'
endfor
printf,lun,header
for i=N1,N-1 do begin
printf, lun, f5(0,i),f5(1,i),f5(2,i),f5(3,i),format='(1x,i3,2x,1E11.4,2x,f6.0,1x,f6.0)'
endfor
free_lun, lun

openw, lun, "Teff6250K_surf.pdat",/get_lun
printf,lun,header_f7
for i=0,N1-1 do begin
printf, lun, f7(0,i),f7(1,i),f7(2,i),f7(3,i),format='(1x,i3,2x,1E11.4,2x,f6.0,1x,f6.0)'
endfor
printf,lun,header
for i=N1,N-1 do begin
printf, lun, f7(0,i),f7(1,i),f7(2,i),f7(3,i),format='(1x,i3,2x,1E11.4,2x,f6.0,1x,f6.0)'
endfor
free_lun, lun

openw, lun, "Teff6000K_surf.pdat",/get_lun
printf,lun,header_f9
for i=0,N1-1 do begin
printf, lun, f9(0,i),f9(1,i),f9(2,i),f9(3,i),format='(1x,i3,2x,1E11.4,2x,f6.0,1x,f6.0)'
endfor
printf,lun,header
for i=N1,N-1 do begin
printf, lun, f9(0,i),f9(1,i),f9(2,i),f9(3,i),format='(1x,i3,2x,1E11.4,2x,f6.0,1x,f6.0)'
endfor
free_lun, lun

openw, lun, "Teff5750K_surf.pdat",/get_lun
printf,lun,header_g2
for i=0,N1-1 do begin
printf, lun, g2(0,i),g2(1,i),g2(2,i),g2(3,i),format='(1x,i3,2x,1E11.4,2x,f6.0,1x,f6.0)'
endfor
printf,lun,header
for i=N1,N-1 do begin
printf, lun, g2(0,i),g2(1,i),g2(2,i),g2(3,i),format='(1x,i3,2x,1E11.4,2x,f6.0,1x,f6.0)'
endfor
free_lun, lun

openw, lun, "Teff5500K_surf.pdat",/get_lun
printf,lun,header_g8
for i=0,N1-1 do begin
printf, lun, g8(0,i),g8(1,i),g8(2,i),g8(3,i),format='(1x,i3,2x,1E11.4,2x,f6.0,1x,f6.0)'
endfor
printf,lun,header
for i=N1,N-1 do begin
printf, lun, g8(0,i),g8(1,i),g8(2,i),g8(3,i),format='(1x,i3,2x,1E11.4,2x,f6.0,1x,f6.0)'
endfor
free_lun, lun

openw, lun, "Teff5250K_surf.pdat",/get_lun
printf,lun,header_k0
for i=0,N1-1 do begin
printf, lun, k0(0,i),k0(1,i),k0(2,i),k0(3,i),format='(1x,i3,2x,1E11.4,2x,f6.0,1x,f6.0)'
endfor
printf,lun,header
for i=N1,N-1 do begin
printf, lun, k0(0,i),k0(1,i),k0(2,i),k0(3,i),format='(1x,i3,2x,1E11.4,2x,f6.0,1x,f6.0)'
endfor
free_lun, lun


openw, lun, "Teff5000K_surf.pdat",/get_lun
printf,lun,header_k2
for i=0,N1-1 do begin
printf, lun, k2(0,i),k2(1,i),k2(2,i),k2(3,i),format='(1x,i3,2x,1E11.4,2x,f6.0,1x,f6.0)'
endfor
printf,lun,header
for i=N1,N-1 do begin
printf, lun, k2(0,i),k2(1,i),k2(2,i),k2(3,i),format='(1x,i3,2x,1E11.4,2x,f6.0,1x,f6.0)'
endfor
free_lun, lun


openw, lun, "K2V_surf.pdat",/get_lun
printf,lun,header_k2a
for i=0,N1-1 do begin
printf, lun, k2a(0,i),k2a(1,i),k2a(2,i),k2a(3,i),format='(1x,i3,2x,1E11.4,2x,f6.0,1x,f6.0)'
endfor
printf,lun,header
for i=N1,N-1 do begin
printf, lun, k2a(0,i),k2a(1,i),k2a(2,i),k2a(3,i),format='(1x,i3,2x,1E11.4,2x,f6.0,1x,f6.0)'
endfor
free_lun, lun

openw, lun, "Teff4750K_surf.pdat",/get_lun
printf,lun,header_k4
for i=0,N1-1 do begin
printf, lun, k4(0,i),k4(1,i),k4(2,i),k4(3,i),format='(1x,i3,2x,1E11.4,2x,f6.0,1x,f6.0)'
endfor
printf,lun,header
for i=N1,N-1 do begin
printf, lun, k4(0,i),k4(1,i),k4(2,i),k4(3,i),format='(1x,i3,2x,1E11.4,2x,f6.0,1x,f6.0)'
endfor
free_lun, lun

openw, lun, "Teff4500K_surf.pdat",/get_lun
printf,lun,header_k5
for i=0,N1-1 do begin
printf, lun, k5(0,i),k5(1,i),k5(2,i),k5(3,i),format='(1x,i3,2x,1E11.4,2x,f6.0,1x,f6.0)'
endfor
printf,lun,header
for i=N1,N-1 do begin
printf, lun, k5(0,i),k5(1,i),k5(2,i),k5(3,i),format='(1x,i3,2x,1E11.4,2x,f6.0,1x,f6.0)'
endfor
free_lun, lun

openw, lun, "Teff4250K_surf.pdat",/get_lun
printf,lun,header_k7
for i=0,N1-1 do begin
printf, lun, k7(0,i),k7(1,i),k7(2,i),k7(3,i),format='(1x,i3,2x,1E11.4,2x,f6.0,1x,f6.0)'
endfor
printf,lun,header
for i=N1,N-1 do begin
printf, lun, k7(0,i),k7(1,i),k7(2,i),k7(3,i),format='(1x,i3,2x,1E11.4,2x,f6.0,1x,f6.0)'
endfor
free_lun, lun

;; openw, lun, "M2V_surf.pdat",/get_lun
;; printf,lun,header_m2
;; for i=0,N1-1 do begin
;; printf, lun, m2(0,i),m2(1,i),m2(2,i),m2(3,i),format='(1x,i3,2x,1E11.4,2x,f6.0,1x,f6.0)'
;; endfor
;; printf,lun,header
;; for i=N1,N-1 do begin
;; printf, lun, m2(0,i),m2(1,i),m2(2,i),m2(3,i),format='(1x,i3,2x,1E11.4,2x,f6.0,1x,f6.0)'
;; endfor
;; free_lun, lun

end





pro seffuv,ff, seff3,seff4,seff5,seff6,seff7,seff8,seff9,seff10,seff11,seff12,seff13,seff14,sefff2a,seffk2a
print, "Seff UV"
print, "Fudge Factor ", ff

N=10

header="                  "

f0=fltarr(2,N)
header_f0=strarr(1)
header1=strarr(1)
header2=strarr(1)
openr, 1, "faruv_Teff7000K.pdat_original"
readf, 1, header_f0
readf, 1, f0
readf, 1, header1
readf, 1, header1
readf, 1, header2
close, 1


f2=fltarr(2,N)
header_f2=strarr(1)
openr, 1, "faruv_Teff6750K.pdat_original"
readf, 1, header_f2
readf, 1, f2
close, 1

f2a=fltarr(2,N)
header_f2a=strarr(1)
openr, 1, "faruv_F2V.pdat_original"
readf, 1, header_f2a
readf, 1, f2a
close, 1


f5=fltarr(2,N)
header_f5=strarr(1)
openr, 1, "faruv_Teff6500K.pdat_original"
readf, 1, header_f5
readf, 1, f5
close, 1

f7=fltarr(2,N)
header_f7=strarr(1)
openr, 1, "faruv_Teff6250K.pdat_original"
readf, 1, header_f7
readf, 1, f7
close, 1


f9=fltarr(2,N)
header_f9=strarr(1)
openr, 1, "faruv_Teff6000K.pdat_original"
readf, 1, header_f9
readf, 1, f9
close, 1

g2=fltarr(2,N)
header_g2=strarr(1)
openr, 1, "faruv_Teff5750K.pdat_original"
readf, 1, header_g2
readf, 1, g2
close, 1

g8=fltarr(2,N)
header_g8=strarr(1)
openr, 1, "faruv_Teff5500K.pdat_original"
readf, 1, header_g8
readf, 1, g8
close, 1

k0=fltarr(2,N)
header_k0=strarr(1)
openr, 1, "faruv_Teff5250K.pdat_original"
readf, 1, header_k0
readf, 1, k0
close, 1


k2=fltarr(2,N)
header_k2=strarr(1)
openr, 1, "faruv_Teff5000K.pdat_original"
readf, 1, header_k2
readf, 1, k2
close, 1

k2a=fltarr(2,N)
header_k2a=strarr(1)
openr, 1, "faruv_K2V.pdat_original"
readf, 1, header_k2a
readf, 1, k2a
close, 1

k4=fltarr(2,N)
header_k4=strarr(1)
openr, 1, "faruv_Teff4750K.pdat_original"
readf, 1, header_k4
readf, 1, k4
close, 1

k5=fltarr(2,N)
header_k5=strarr(1)
openr, 1, "faruv_Teff4500K.pdat_original"
readf, 1, header_k5
readf, 1, k5
close, 1

k7=fltarr(2,N)
header_k7=strarr(1)
openr, 1, "faruv_Teff4250K.pdat_original"
readf, 1, header_k7
readf, 1, k7
close, 1

;; m2=fltarr(2,N)
;; header_m2=strarr(1)
;; openr, 1, "faruv_M2V.pdat_original"
;; readf, 1, header_m2
;; readf, 1, m2
;; close, 1

;;ff=2.5
;fudgefactor=ff

print,f0(1,0)
print,f2(1,0)
print,f5(1,0)
print,f9(1,0)
print,g2(1,0)
print,g8(1,0)
print,k2(1,0)
print,k5(1,0)
;; print,m2(1,0)

;; print," "



;a0(1,*)=a0(1,*)*seff0
;a5(1,*)=a5(1,*)*seff1
;a7(1,*)=a7(1,*)*seff2
f0(1,*)=f0(1,*)*seff3
f2(1,*)=f2(1,*)*seff4
f2a(1,*)=f2a(1,*)*sefff2a
f5(1,*)=f5(1,*)*seff5
f7(1,*)=f7(1,*)*seff6
f9(1,*)=f9(1,*)*seff7
g2(1,*)=g2(1,*)*seff8
g8(1,*)=g8(1,*)*seff9
k0(1,*)=k0(1,*)*seff10
k2(1,*)=k2(1,*)*seff11
k2a(1,*)=k2(1,*)*seffk2a
k4(1,*)=k4(1,*)*seff12
k5(1,*)=k5(1,*)*seff13
k7(1,*)=k7(1,*)*seff14
;m1(1,*)=m1(1,*)*seff11
;m2(1,*)=m2(1,*)*seff12



print,f0(1,0)
print,f2(1,0)
print,f5(1,0)
print,f9(1,0)
print,g2(1,0)
print,g8(1,0)
print,k2(1,0)
print,k5(1,0)
;; print,m2(1,0)

openw, lun, "faruv_Teff7000K.pdat",/get_lun
printf,lun,header_f0
printf,lun,header
for i=0,N-1 do begin
printf, lun, f0(0,i),f0(1,i),format='(1x,i4,2x,1E8.1)'
endfor
printf, lun,header
printf, lun, header1
printf, lun, header2
free_lun, lun


openw, lun, "faruv_Teff6750K.pdat",/get_lun
printf,lun,header_f2
printf,lun,header
for i=0,N-1 do begin
printf, lun, f2(0,i),f2(1,i),format='(1x,i4,2x,1E8.1)'
endfor
printf, lun,header
printf, lun, header1
printf, lun, header2
free_lun, lun

openw, lun, "faruv_F2V.pdat",/get_lun
printf,lun,header_f2a
printf,lun,header
for i=0,N-1 do begin
printf, lun, f2a(0,i),f2a(1,i),format='(1x,i4,2x,1E8.1)'
endfor
printf, lun,header
printf, lun, header1
printf, lun, header2
free_lun, lun


openw, lun, "faruv_Teff6500K.pdat",/get_lun
printf,lun,header_f5
printf,lun,header
for i=0,N-1 do begin
printf, lun, f5(0,i),f5(1,i),format='(1x,i4,2x,1E8.1)'
endfor
printf, lun,header
printf, lun, header1
printf, lun, header2
free_lun, lun

openw, lun, "faruv_Teff6250K.pdat",/get_lun
printf,lun,header_f7
printf,lun,header
for i=0,N-1 do begin
printf, lun, f7(0,i),f7(1,i),format='(1x,i4,2x,1E8.1)'
endfor
printf, lun,header
printf, lun, header1
printf, lun, header2
free_lun, lun

openw, lun, "faruv_Teff6000K.pdat",/get_lun
printf,lun,header_f9
printf,lun,header
for i=0,N-1 do begin
printf, lun, f9(0,i),f9(1,i),format='(1x,i4,2x,1E8.1)'
endfor
printf, lun,header
printf, lun, header1
printf, lun, header2
free_lun, lun

openw, lun, "faruv_Teff5750K.pdat",/get_lun
printf,lun,header_g2
printf,lun,header
for i=0,N-1 do begin
printf, lun, g2(0,i),g2(1,i),format='(1x,i4,2x,1E8.1)'
endfor
printf, lun,header
printf, lun, header1
printf, lun, header2
free_lun, lun

openw, lun, "faruv_Teff5500K.pdat",/get_lun
printf,lun,header_g8
printf,lun,header
for i=0,N-1 do begin
printf, lun, g8(0,i),g8(1,i),format='(1x,i4,2x,1E8.1)'
endfor
printf, lun,header
printf, lun, header1
printf, lun, header2
free_lun, lun

openw, lun, "faruv_Teff5250K.pdat",/get_lun
printf,lun,header_k0
printf,lun,header
for i=0,N-1 do begin
printf, lun, k0(0,i),k0(1,i),format='(1x,i4,2x,1E8.1)'
endfor
printf, lun,header
printf, lun, header1
printf, lun, header2
free_lun, lun

openw, lun, "faruv_Teff5000K.pdat",/get_lun
printf,lun,header_k2
printf,lun,header
for i=0,N-1 do begin
printf, lun, k2(0,i),k2(1,i),format='(1x,i4,2x,1E8.1)'
endfor
printf, lun,header
printf, lun, header1
printf, lun, header2
free_lun, lun

openw, lun, "faruv_K2V.pdat",/get_lun
printf,lun,header_k2a
printf,lun,header
for i=0,N-1 do begin
printf, lun, k2a(0,i),k2a(1,i),format='(1x,i4,2x,1E8.1)'
endfor
printf, lun,header
printf, lun, header1
printf, lun, header2
free_lun, lun

openw, lun, "faruv_Teff4750K.pdat",/get_lun
printf,lun,header_k4
printf,lun,header
for i=0,N-1 do begin
printf, lun, k4(0,i),k4(1,i),format='(1x,i4,2x,1E8.1)'
endfor
printf, lun,header
printf, lun, header1
printf, lun, header2
free_lun, lun

openw, lun, "faruv_Teff4500K.pdat",/get_lun
printf,lun,header_k5
printf,lun,header
for i=0,N-1 do begin
printf, lun, k5(0,i),k5(1,i),format='(1x,i4,2x,1E8.1)'
endfor
printf, lun,header
printf, lun, header1
printf, lun, header2
free_lun, lun

openw, lun, "faruv_Teff4250K.pdat",/get_lun
printf,lun,header_k7
printf,lun,header
for i=0,N-1 do begin
printf, lun, k7(0,i),k7(1,i),format='(1x,i4,2x,1E8.1)'
endfor
printf, lun,header
printf, lun, header1
printf, lun, header2
free_lun, lun

;; openw, lun, "faruv_M2V.pdat",/get_lun
;; printf,lun,header_m2
;; printf,lun,header
;; for i=0,N-1 do begin
;; printf, lun, m2(0,i),m2(1,i),format='(1x,i4,2x,1E8.1)'
;; endfor
;; printf, lun,header
;; printf, lun, header1
;; printf, lun, header2
;; free_lun, lun


end

pro seffspectra,ff, seff3,seff4,seff5,seff6,seff7,seff8,seff9,seff10,seff11,seff12,seff13,seff14

headerK7=strarr(1)
star4250=fltarr(2,1815)
openr, 1, "../../../Plotting/SPECTRA/Teff4250K_plusUV.dat_original"
readf, 1, headerK7
readf, 1, star4250
close, 1

headerK5=strarr(1)
star4500=fltarr(2,1815)
openr, 1, "../../../Plotting/SPECTRA/Teff4500K_plusUV.dat_original"
readf, 1, headerK5
readf, 1, star4500
close, 1

headerK4=strarr(1)
star4750=fltarr(2,1815)
openr, 1, "../../../Plotting/SPECTRA/Teff4750K_plusUV.dat_original"
readf, 1, headerK4
readf, 1, star4750
close, 1

headerK2=strarr(1)
star5000=fltarr(2,1815)
openr, 1, "../../../Plotting/SPECTRA/Teff5000K_plusUV.dat_original"
readf, 1, headerK2
readf, 1, star5000
close, 1

headerK0=strarr(1)
star5250=fltarr(2,1815)
openr, 1, "../../../Plotting/SPECTRA/Teff5250K_plusUV.dat_original"
readf, 1, headerK0
readf, 1, star5250
close, 1

headerG8=strarr(1)
star5500=fltarr(2,1815)
openr, 1, "../../../Plotting/SPECTRA/Teff5500K_plusUV.dat_original"
readf, 1, headerG8
readf, 1, star5500
close, 1

headerG2=strarr(1)
star5750=fltarr(2,1814)
openr, 1, "../../../Plotting/SPECTRA/Teff5750K_plusUV.dat_original"
readf, 1, headerG2
readf, 1, star5750
close, 1

headerF9=strarr(1)
star6000=fltarr(2,1815)
openr, 1, "../../../Plotting/SPECTRA/Teff6000K_plusUV.dat_original"
readf, 1, headerF9
readf, 1, star6000
close, 1

headerF7=strarr(1)
star6250=fltarr(2,1815)
openr, 1, "../../../Plotting/SPECTRA/Teff6250K_plusUV.dat_original"
readf, 1, headerF7
readf, 1, star6250
close, 1

headerF5=strarr(1)
star6500=fltarr(2,1750)
openr, 1, "../../../Plotting/SPECTRA/Teff6500K_plusUV.dat_original"
readf, 1, headerF5
readf, 1, star6500
close, 1


headerF2=strarr(1)
star6750=fltarr(2,1750)
openr, 1, "../../../Plotting/SPECTRA/Teff6750K_plusUV.dat_original"
readf, 1, headerF2
readf, 1, star6750
close, 1


headerF0=strarr(1)
star7000=fltarr(2,1750)
openr, 1, "../../../Plotting/SPECTRA/Teff7000K_plusUV.dat_original"
readf, 1, headerF0
readf, 1, star7000
close, 1

star4250(1,*)=star4250(1,*)*seff14
star4500(1,*)=star4500(1,*)*seff13
star4750(1,*)=star4750(1,*)*seff12
star5000(1,*)=star5000(1,*)*seff11
star5250(1,*)=star5250(1,*)*seff10
star5500(1,*)=star5500(1,*)*seff9
star5750(1,*)=star5750(1,*)*seff8
star6000(1,*)=star6000(1,*)*seff7
star6250(1,*)=star6250(1,*)*seff6
star6500(1,*)=star6500(1,*)*seff5
star6750(1,*)=star6750(1,*)*seff4
star7000(1,*)=star7000(1,*)*seff3

N=n_elements(star7000(1,*))
openw, lun, "../../../Plotting/SPECTRA/Teff7000K_plusUV.dat",/get_lun
printf,lun,headerF0
for i=0,N-1 do begin
printf, lun, star7000(0,i),star7000(1,i),format='(1x,i8,2x,1E12.4)'
endfor

free_lun, lun

openw, lun, "../../../Plotting/SPECTRA/Teff6750K_plusUV.dat",/get_lun
printf,lun,headerF2
for i=0,N-1 do begin
printf, lun, star6750(0,i),star6750(1,i),format='(1x,i8,2x,1E12.4)'
endfor
free_lun, lun

openw, lun, "../../../Plotting/SPECTRA/Teff6500K_plusUV.dat",/get_lun
printf,lun,headerF5
for i=0,N-1 do begin
printf, lun, star6500(0,i),star6500(1,i),format='(1x,i8,2x,1E12.4)'
endfor
free_lun, lun

openw, lun, "../../../Plotting/SPECTRA/Teff6250K_plusUV.dat",/get_lun
printf,lun,headerF7
for i=0,N-1 do begin
printf, lun, star6250(0,i),star6250(1,i),format='(1x,i8,2x,1E12.4)'
endfor
free_lun, lun

openw, lun, "../../../Plotting/SPECTRA/Teff6000K_plusUV.dat",/get_lun
printf,lun,headerF9
for i=0,N-1 do begin
printf, lun, star6000(0,i),star6000(1,i),format='(1x,i8,2x,1E12.4)'
endfor
free_lun, lun

openw, lun, "../../../Plotting/SPECTRA/Teff5750K_plusUV.dat",/get_lun
printf,lun,headerG2
for i=0,N-1 do begin
printf, lun, star5750(0,i),star5750(1,i),format='(1x,i8,2x,1E12.4)'
endfor
free_lun, lun

openw, lun, "../../../Plotting/SPECTRA/Teff5500K_plusUV.dat",/get_lun
printf,lun,headerG8
for i=0,N-1 do begin
printf, lun, star5500(0,i),star5500(1,i),format='(1x,i8,2x,1E12.4)'
endfor
free_lun, lun

openw, lun, "../../../Plotting/SPECTRA/Teff5250K_plusUV.dat",/get_lun
printf,lun,headerK0
for i=0,N-1 do begin
printf, lun, star5250(0,i),star5250(1,i),format='(1x,i8,2x,1E12.4)'
endfor
free_lun, lun


openw, lun, "../../../Plotting/SPECTRA/Teff5000K_plusUV.dat",/get_lun
printf,lun,headerK2
for i=0,N-1 do begin
printf, lun, star5000(0,i),star5000(1,i),format='(1x,i8,2x,1E12.4)'
endfor
free_lun, lun

openw, lun, "../../../Plotting/SPECTRA/Teff4750K_plusUV.dat",/get_lun
printf,lun,headerK4
for i=0,N-1 do begin
printf, lun, star4750(0,i),star4750(1,i),format='(1x,i8,2x,1E12.4)'
endfor
free_lun, lun

openw, lun, "../../../Plotting/SPECTRA/Teff4500K_plusUV.dat",/get_lun
printf,lun,headerK5
for i=0,N-1 do begin
printf, lun, star4500(0,i),star4500(1,i),format='(1x,i8,2x,1E12.4)'
endfor
free_lun, lun

openw, lun, "../../../Plotting/SPECTRA/Teff4250K_plusUV.dat",/get_lun
printf,lun,headerK7
for i=0,N-1 do begin
printf, lun, star4250(0,i),star4250(1,i),format='(1x,i8,2x,1E12.4)'
endfor
free_lun, lun

end




pro seff;, ff

ff=1.0

;;;; ********** Old Seff factors from Iconserv=1 runs ********

;; seff3= 1.096;;F0
;; seff4= 1.08;;F2
;; sefff2a=1.0;.98
;; ;seff3= 1.08965 ;;F0
;; ;seff4= 1.05769 ;;F2
;; seff5= 1.04899  ;;F5
;; seff6= 1.01103 ;F9
;; seff7= 1.0 ;;G2
;; seff8= 0.9905 ;;G8
;; ;seff8= 0.98772 ;;G8
;; seff9=0.98 ;;K2
;; seffk2a= 1.0;1.027
;; seff10=.9415 ;;K5
;; ;seff9= 0.967919 ;;K2
;; ;seff10= 0.909853 ;;K5

;;;;; ******* New Seff factors ********


;;WHEN Zenith Angle = 42photo/60climate

;; seff3=1.05 ;FO
;; seff4=1.03 ;F2
;; seff5=1.026 ;F5

;; seff7=1.011 ;F9
;; seff8=1.008 ;G2 (antis)
;; seff9=0.988 ;G8

;; seff11=0.955 ;K2

;; seff13=0.94;0.915 ;K5

;;WHEN Zenith Angle = 60photo/60climate
seff3=1.05 ;FO
seff4=1.03 ;F2
seff5=1.026 ;F5
seff6=1.018 ;F7
seff7=1.011 ;F9
seff8=1.008 ;G2 (antis)
seff9=0.988 ;G8
seff10=0.97 ;K0
seff11=0.955 ;K2
seff12=0.945;K4
seff13=0.94;0.915 ;K5
seff14=0.93;K7

sefff2a=0.940 ;Anti's F2
seffk2a=1.015 ;Anti's K2


;;;SEFF factors for fixed Mixing ratios (not fixed flux)

;seff9=0.97
;seff10=0.95

;;WHEN Zenith Angle = 60photo/60climate NEEDS ADJUSTMENT OLD
;; seff3=1.094 ;FO
;; seff4=1.067 ;F2
;; seff5=1.04 ;F5
;; seff6=1.025 ;F9
;; seff7=1.008 ;G2 (antis)
;; seff8=0.99 ;G8
;; seff9=0.967 ;K2
;; seff10=0.95 ;K5

;; sefff2a=0.98 ;Anti's F2
;; seffk2a=1.027 ;Anti's K2




seffphoto,ff, seff3,seff4,seff5,seff6,seff7,seff8,seff9,seff10,seff11,seff12,seff13,seff14,sefff2a,seffk2a
seffsurf,ff, seff3,seff4,seff5,seff6,seff7,seff8,seff9,seff10,seff11,seff12,seff13,seff14,sefff2a,seffk2a
seffuv,ff, seff3,seff4,seff5,seff6,seff7,seff8,seff9,seff10,seff11,seff12,seff13,seff14,sefff2a,seffk2a
seffspectra,ff, seff3,seff4,seff5,seff6,seff7,seff8,seff9,seff10,seff11,seff12,seff13,seff14
print, "Spectra,Photo, Surf, and Faruv files have been corrected."

end