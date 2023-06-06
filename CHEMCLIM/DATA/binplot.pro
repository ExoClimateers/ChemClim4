pro binplot

loadct,39
;window,0

g8=fltarr(4,108)
header_g8=strarr(1)
openr, 1, "Teff5500K_photo.pdat"
readf, 1, header_g8
readf, 1, g8
close, 1

k2=fltarr(4,108)
header_k2=strarr(1)
openr, 1, "Teff5000K_photo.pdat"
readf, 1, header_k2
readf, 1, k2
close, 1

k2a=fltarr(4,108)
header_k2a=strarr(1)
openr, 1, "K2V_photo.pdat"
readf, 1, header_k2a
readf, 1, k2a
close, 1

;p.multi=[0,1,3]

;psa, filename="binphoto.ps",/landscape,/color
plot, (g8(2,*)+g8(3,*))*.5,g8(1,*),title="binned g8(black),k2(blue),k2a(orange) photo files"
oplot, (k2(2,*)+k2(3,*))*.5,k2(1,*),color=75
oplot, (k2a(2,*)+k2a(3,*))*.5,k2a(1,*),color=220
;pse


N=54
N1=16
N2=38


g8=fltarr(4,N)
header_g8=strarr(1)
openr, 1, "Teff5500K_surf.pdat"
readf, 1, header_g8
readf, 1, g8
close, 1

k2=fltarr(4,N)
header_k2=strarr(1)
openr, 1, "Teff5000K_surf.pdat"
readf, 1, header_k2
readf, 1, k2
close, 1

k2a=fltarr(4,N)
header_k2a=strarr(1)
openr, 1, "K2V_surf.pdat"
readf, 1, header_k2a
readf, 1, k2a
close, 1

;window,2
;psa, filename="binsurf.ps",/landscape,/color
plot, (g8(2,*)+g8(3,*))*.5,g8(1,*),title="binned g8(black),k2(blue),k2a(orange) surf files",xrange=[9620,45450],/xstyle,/ylog
oplot, (k2(2,*)+k2(3,*))*.5,k2(1,*),color=50;,title="binned k2(black),k2a(orange) surf files",xrange=[9620,10360],/xstyle;, color=50
oplot, (k2a(2,*)+k2a(3,*))*.5,k2a(1,*),color=220,psym=1
;pse
stop
N=10
g8=fltarr(2,N)
header_g8=strarr(1)
openr, 1, "faruv_Teff5500K.pdat"
readf, 1, header_g8
readf, 1, g8
close, 1

k2=fltarr(2,N)
header_k2=strarr(1)
openr, 1, "faruv_Teff5000K.pdat"
readf, 1, header_k2
readf, 1, k2
close, 1

k2a=fltarr(2,N)
header_k2a=strarr(1)
openr, 1, "faruv_K2V.pdat"
readf, 1, header_k2a
readf, 1, k2a
close, 1

;window,1
psa, filename="binuv.ps",/landscape,/color
plot, g8(0,*),g8(1,*),title="binned g8(black),k2(blue),k2a(orange) uv files"
oplot, k2(0,*),k2(1,*),color=50
oplot, k2a(0,*),k2a(1,*),color=220
pse

;p.multi=0



end
