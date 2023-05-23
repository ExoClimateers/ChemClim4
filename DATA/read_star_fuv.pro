openr,1,'faruv_F2V.pdat'

n=10

fluxf2v=dblarr(n)
lambda1=dblarr(n)

a=''
for i=0, 1 do begin
	readf,1,a
endfor

for i=0,n-1 do begin
	readf,1,a1,a2
	fluxf2v[i]=a2
	lambda1[i]=a1
endfor

close,1


openr,1,'faruv_K2V.pdat'
fluxk2v=dblarr(n)
lambda1=dblarr(n)
lambda2=dblarr(n)
for i=0, 1 do begin
	readf,1,a
endfor

for i=0,n-1 do begin
	readf,1,a1,a2
	fluxk2v[i]=a2
	lambda1[i]=a1
endfor
close,1


openr,1,'faruv_ADLeo.pdat'
fluxADLeo=dblarr(n)
lambda1=dblarr(n)
lambda2=dblarr(n)
for i=0, 1 do begin
	readf,1,a
endfor

for i=0,n-1 do begin
	readf,1,a1,a2
	fluxADLeo[i]=a2
	lambda1[i]=a1
endfor
close,1

openr,1,'faruv_sun.pdat'
fluxsun=dblarr(n)
lambda1=dblarr(n)
lambda2=dblarr(n)
for i=0, 1 do begin
	readf,1,a
endfor

for i=0,n-1 do begin
	readf,1,a1,a2
	fluxsun[i]=a2
	lambda1[i]=a1
endfor
close,1


close,1



window,2,retain=2
plot,lambda1,fluxf2v,xtitle='wavelength [Angstroms]',ytitle='flux [photons/s/cm^2/A]',charsize=1.3,psym=10,/yl,yrange=[min(fluxsun),max(fluxf2v)]
oplot,lambda1,fluxsun,linestyle=3,psym=10
oplot,lambda1,fluxk2v,linestyle=1,psym=10
oplot,lambda1,fluxADLeo,linestyle=2,psym=10

xyouts,0.83,0.8,'F star',/normal,charsize=1.2
xyouts,0.83,0.75,'Sun',/normal,charsize=1.2
xyouts,0.83,0.7,'K star',/normal,charsize=1.2
xyouts,0.83,0.65,'M star',/normal,charsize=1.2

plots,[0.75,0.82],[0.81,0.81],/normal
plots,[0.75,0.82],[0.76,0.76],/normal,linestyle=3
plots,[0.75,0.82],[0.71,0.71],/normal,linestyle=1
plots,[0.75,0.82],[0.66,0.66],/normal,linestyle=2




set_plot,'PS' 
device,file='star_fluxes.ps', /encapsulated, bits=8
plot,lambda1,fluxf2v,xtitle='wavelength [Angstoms]',ytitle='flux [photons/s/cm^2/A]',charsize=1.3,psym=10,thick=3,charthick=3,/yl,yrange=[min(fluxsun),max(fluxf2v)]
oplot,lambda1,fluxsun,linestyle=3,psym=10,thick=3
oplot,lambda1,fluxk2v,linestyle=1,psym=10,thick=3
oplot,lambda1,fluxADLeo,linestyle=2,psym=10,thick=3

xyouts,0.38,0.85,'F star',/normal,charsize=1.2,charthick=3
xyouts,0.38,0.8,'Sun',/normal,charsize=1.2,charthick=3
xyouts,0.38,0.75,'K star',/normal,charsize=1.2,charthick=3
xyouts,0.38,0.7,'M star (ADLeo)',/normal,charsize=1.2,charthick=3

plots,[0.30,0.37],[0.86,0.86],/normal,thick=3
plots,[0.30,0.37],[0.81,0.81],/normal,linestyle=3,thick=3
plots,[0.30,0.37],[0.76,0.76],/normal,linestyle=1,thick=3
plots,[0.30,0.37],[0.71,0.71],/normal,linestyle=2,thick=3


device,/close
set_plot,'X'


end
