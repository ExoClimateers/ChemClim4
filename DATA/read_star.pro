openr,1,'F2V_surf.pdat'

n=38

fluxf2v=dblarr(n)
lambda1=dblarr(n)
lambda2=dblarr(n)

a=''
for i=0, 17 do begin
	readf,1,a
endfor

for i=0,n-1 do begin
	readf,1,a1,a2,a3,a4
	fluxf2v[i]=a2
	lambda1[i]=a3
	lambda2[i]=a4
endfor

close,1


openr,1,'K2V_surf.pdat'
fluxk2v=dblarr(n)
lambda1=dblarr(n)
lambda2=dblarr(n)
for i=0, 17 do begin
	readf,1,a
endfor

for i=0,n-1 do begin
	readf,1,a1,a2,a3,a4
	fluxk2v[i]=a2
	lambda1[i]=a3
	lambda2[i]=a4
endfor
close,1


openr,1,'ADLeo_surf.pdat'
fluxADLeo=dblarr(n)
lambda1=dblarr(n)
lambda2=dblarr(n)
for i=0, 17 do begin
	readf,1,a
endfor

for i=0,n-1 do begin
	readf,1,a1,a2,a3,a4
	fluxADLeo[i]=a2
	lambda1[i]=a3
	lambda2[i]=a4
endfor
close,1


close,1



window,2,retain=2
plot,lambda1/1d4,fluxf2v,xtitle='wavelength [micron]',ytitle='flux [?]',charsize=1.3,/yl,psym=10,/xl
oplot,lambda1/1d4,fluxk2v,linestyle=1,psym=10
oplot,lambda1/1d4,fluxADLeo,linestyle=2,psym=10

xyouts,0.83,0.8,'F star',/normal,charsize=1.2
xyouts,0.83,0.75,'K star',/normal,charsize=1.2
xyouts,0.83,0.7,'M star',/normal,charsize=1.2

plots,[0.75,0.82],[0.81,0.81],/normal
plots,[0.75,0.82],[0.76,0.76],/normal,linestyle=1
plots,[0.75,0.82],[0.71,0.71],/normal,linestyle=2




set_plot,'PS' 
device,file='star_fluxes.ps', /encapsulated, bits=8
plot,lambda1/1d4,fluxf2v,xtitle='wavelength [micron]',ytitle='flux [?]',charsize=1.3,/yl,psym=10,/xl,thick=3,charthick=3
oplot,lambda1/1d4,fluxk2v,linestyle=1,psym=10,thick=3
oplot,lambda1/1d4,fluxADLeo,linestyle=2,psym=10,thick=3

xyouts,0.83,0.8,'F star',/normal,charsize=1.2,charthick=3
xyouts,0.83,0.75,'K star',/normal,charsize=1.2,charthick=3
xyouts,0.83,0.7,'M star',/normal,charsize=1.2,charthick=3

plots,[0.75,0.82],[0.81,0.81],/normal,thick=3
plots,[0.75,0.82],[0.76,0.76],/normal,linestyle=1,thick=3
plots,[0.75,0.82],[0.71,0.71],/normal,linestyle=2,thick=3

device,/close
set_plot,'X'


end
