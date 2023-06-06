; function used to produce tick strings for the axes in the form of a*10^b
FUNCTION power10, value
 str=''
 value_ii = fix( alog10(value) )
 num=fix((value/10d0^(value_ii))*100d0)/100d0
 
 str = '10!U' + string(value_ii, format='(I0)') + '!N'
 return, str
END

;*****************
; start of program
;*****************

close,/all

; string used in the plots and images produced
; use a different string name for a different run to avoid overwriting
; previous files!
fname='Sun_100'
skip=20
;making a directory for the frames
;the frames show the T, H2O and O3 profiles as a of function height
;these frames can be used to produce a movie that shows how these profiles change 
;	during the iteration of the code.
spawn,'mkdir animation_'+fname+''


; open the clima_calls.tab file and find out the value of niter
openr,1,'IO/clima_calls_'+fname+'.tab'
while ~EOF(1) do begin
	readf,1,a1,a2
endwhile
close,1

niter=a1

clima_calls=dblarr(niter)

; find out how many times the climate code was called
openr,1,'IO/clima_calls_'+fname+'.tab'
for i=0L,niter-1L do begin
	readf,1,a1,a2
	clima_calls[i]=a2
endfor
close,1

print,total(clima_calls)
print,total(clima_calls)/skip
;open clima_allout and read the file
openr,1,'IO/clima_allout_'+fname+'.tab'

a=''

readf,1,a
readf,1,a
readf,1,a
readf,1,a
res=strsplit(a,'= ',/extract)
print,res[0],res[1],' = ',res[2]
print,res[3],' = ',res[4]
print,res[5],' = ',res[6]
print,res[7],' = ',res[8]
print,res[9],' = ',res[10]
print,res[11],' = ',res[12]
print,res[13],' = ',res[14]

;the number of vertical layers in the climate code
readf,1,nverti

;arrays to store the different variables in the output file:
J=dblarr(total(clima_calls)/skip,nverti)     
P=dblarr(total(clima_calls)/skip,nverti)        
ALT=dblarr(total(clima_calls)/skip,nverti)
T=dblarr(total(clima_calls)/skip,nverti)       
CONVEC=dblarr(total(clima_calls)/skip,nverti)       
DT=dblarr(total(clima_calls)/skip,nverti)           
TOLD=dblarr(total(clima_calls)/skip,nverti)        
FH2O=dblarr(total(clima_calls)/skip,nverti)        
TCOOL=dblarr(total(clima_calls)/skip,nverti)        
THEAT=dblarr(total(clima_calls)/skip,nverti)        
FO3=dblarr(total(clima_calls)/skip,nverti)        


PF=dblarr(total(clima_calls)/skip,nverti)
FTOTAL=dblarr(total(clima_calls)/skip,nverti)
FTIR=dblarr(total(clima_calls)/skip,nverti)
FDNIR=dblarr(total(clima_calls)/skip,nverti)
FUPIR=dblarr(total(clima_calls)/skip,nverti)
FTSOL=dblarr(total(clima_calls)/skip,nverti)
FDNSOL=dblarr(total(clima_calls)/skip,nverti)
FUPSOL=dblarr(total(clima_calls)/skip,nverti)
DIVF=dblarr(total(clima_calls)/skip,nverti)

;reading the file and filling up the arrays:
for i=0L,total(clima_calls)/skip-1L do begin
	
		readf,1,a
		readf,1,a
		readf,1,a
		readf,1,a
		readf,1,a

		for k=0,nverti-1 do begin
			readf,1,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11
			J[i,k]=a1     
			P[i,k]=a2 
			ALT[i,k]=a3   
			T[i,k]=a4
			CONVEC[i,k]=a5      
			DT[i,k]=a6 
			TOLD[i,k]=a7    
			FH2O[i,k]=a8  
			TCOOL[i,k]=a9  
			THEAT[i,k]=a10 
			FO3[i,k]=a11  
		 
;		 	print,a8,FH2O[i,k]
		endfor
		readf,1,a
		readf,1,a
		for k=0,nverti-1 do begin
			readf,1,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11
			PF[i,k]=a2         
			FTOTAL[i,k]=a4       
			FTIR[i,k]=a5       
			FDNIR[i,k]=a6       
			FUPIR[i,k]=a7       
			FTSOL[i,k]=a8       
			FDNSOL[i,k]=a9       
			FUPSOL[i,k]=a10       
			DIVF[i,k]=a11
		endfor
		readf,1,a
		
;	endfor
endfor
print,'surface temperature: ',T[total(clima_calls)/skip-1L,nverti-1]


close,1

;reading in the standard temp and ozone profiles (1976)

nn=52
heightT=dblarr(nn)
temp=dblarr(nn)

nnn=32
heightO3=dblarr(nnn)
Ozone=dblarr(nnn)

openr,1,'ozone_temp_standard1976.txt'

for ii=0L,nn-1 do begin
	readf,1,a1,b1
	heightT[ii]=a1
	temp[ii]=b1
endfor

readf,1,a

for ii=0,nnn-1 do begin
	readf,1,a1,b1
	heightO3[ii]=a1
	Ozone[ii]=b1
endfor
close,1

;reading the water profile

nn=32
heighth2o=dblarr(nn)
h2o=dblarr(nn)

openr,1,'h2o_standard.txt'
for ii=0L,nn-1 do begin
	readf,1,a1,b1,c1
	heighth2o[ii]=a1
	h2o[ii]=c1
endfor
close,1

;********
;plotting
;********

;creating the positions of the figures (T, H2O, O3):
xmin=0.09
xmax=0.98
ymin=0.15
ymax=0.9
space=0.01

position1=[xmin,	ymin,	xmin+(xmax-xmin)/3.-0.01,	ymax]
position2=[xmin+(xmax-xmin)/3.+0.01,ymin,xmin+(xmax-xmin)/3.*2.-0.01,ymax]
position3=[xmin+(xmax-xmin)/3.*2.+0.01,ymin,xmax,ymax]

;making the plots

window,2,retain=2,xsize=600,ysize=400
!p.multi=[0,3,1]
for i=0L,total(clima_calls)/skip-1L do begin
;for i=1000L-1,4000-1 do begin

	if ((i+1) mod 10) eq 0 then begin
		
	plot,T[i,*],ALT[i,*],charsize=2.5,ytitle='height [km]',xrange=[min(T),min([max(T),500.])],$
		yrange=[min(ALT),max(ALT)],xtitle='Temperature [K]',xticks=3,position=position1,$
		xtickname=['','','',' ']
	oplot,temp,heightT,linestyle=1
	xyouts,xmin,ymax+0.03,'climate iteration number = '+strcompress(i+1,/remove_all)+'',/normal,charsize=1.5

	plot,FO3[i,*],ALT[i,*],charsize=2.5,/xl,xtitle='O3 mixing ratio',$
		yrange=[min(ALT),max(ALT)],xrange=[min(FO3),max(FO3)],xticks=3,position=position2,$
		ytickname=replicate(' ',10),xtickname=['','','',' ']
	oplot,Ozone,heightO3,linestyle=1
	
	plot,FH2O[i,*],ALT[i,*],charsize=2.5,/xl,xtitle='H2O mixing ratio',$
		yrange=[min(ALT),max(ALT)],xrange=[min(FH2O),max(FH2O)],xticks=2,position=position3,$
		ytickname=replicate(' ',10),xtickname=['','','']
	oplot,h2o,heighth2o,linestyle=1

	wait,0.15

; uncomment the above two lines to produce a gif file of all frames in the animation* directory!	
;	image=tvrd(true=1,/order)  
;	write_gif,'animation_'+fname+'/frame'+strcompress(i,/remove_all)+'.gif',tvrd()

	endif

endfor

!p.multi=0

;stop


i=i-1


;creating ps files of the final T, O3 and H2O profiles

!p.multi=[0,3,1]
set_plot,'PS'
;device,file='profiles_'+strcompress(fix(clima_calls[0]),/remove_all)+'_'+fname+'.ps',/color
device,file='profiles_'+strcompress(fix(nverti),/remove_all)+'_'+fname+'.ps',/color

;you might need to tweak the number of ticks on the x axis to produce nice-looking plots

	plot,T[i,*],ALT[i,*],charsize=2.8,ytitle='height [km]',xrange=[min(T[i,*]),min([max(T[i,*]),500.])],$
		yrange=[min(ALT[i,*]),max(ALT[i,*])],xtitle='Temperature [K]',xticks=3,position=position1,$
		xtickname=['','','',' ']
	oplot,temp,heightT,linestyle=1
	;xyouts,xmin,ymax+0.03,'climate iteration number = '+strcompress(i+1,/remove_all)+'',/normal,charsize=1.5

	plot,FO3[i,*],ALT[i,*],charsize=2.8,/xl,xtitle='O3 mixing ratio',$
		yrange=[min(ALT[i,*]),max(ALT[i,*])],xrange=[1d-8,1d-4],xticks=2,position=position2,$
		ytickname=replicate(' ',10),xtickname=['','',' ']
	oplot,Ozone,heightO3,linestyle=1
	
	plot,FH2O[i,*],ALT[i,*],charsize=2.8,/xl,xtitle='H2O mixing ratio',$
		yrange=[min(ALT[i,*]),max(ALT[i,*])],xrange=[1d-6,1],xticks=2,position=position3,$
		ytickname=replicate(' ',10),xstyle=1,xtickname=[power10(1d-6),power10(1d-3),power10(1)]
	oplot,h2o,heighth2o,linestyle=1

device,/close
set_plot,'X'

!p.multi=0


;set_plot,'PS'
;;device,file='T_profile_'+strcompress(fix(clima_calls[0]),/remove_all)+'_'+fname+'.ps',/color
;device,file='T_profile_'+strcompress(fix(nverti),/remove_all)+'_'+fname+'.ps',/color
;
;	plot,T[i,*],ALT[i,*],charsize=1.3,ytitle='height [km]',xrange=[min(T),max(T)],yrange=[min(ALT),max(ALT)],xtitle='Temperature [K]';,/xl
;	oplot,temp,heightT,linestyle=1
;
;	xyouts,0.45,0.85,'iteration number = '+strcompress(i+1,/remove_all)+'',/normal,charsize=1.5
;
;device,/close
;set_plot,'X'


;set_plot,'PS'
;;device,file='O3_profile_'+strcompress(fix(clima_calls[0]),/remove_all)+'_'+fname+'.ps',/color
;device,file='O3_profile_'+strcompress(fix(nverti),/remove_all)+'_'+fname+'.ps',/color
;
;	plot,FO3[i,*],ALT[i,*],charsize=1.3,ytitle='height [km]',yrange=[min(ALT),max(ALT)],xtitle='O3 mixing ratio',/xl,xrange=[min(FO3),max(FO3)]
;	oplot,Ozone,heightO3,linestyle=1
;
;	xyouts,0.45,0.85,'iteration number = '+strcompress(i+1,/remove_all)+'',/normal,charsize=1.5
;
;device,/close
;set_plot,'X'


;set_plot,'PS'
;;device,file='H2O_profile_'+strcompress(fix(clima_calls[0]),/remove_all)+'_'+fname+'.ps',/color
;device,file='H2O_profile_'+strcompress(fix(nverti),/remove_all)+'_'+fname+'.ps',/color
;
;	plot,FH2O[i,*],ALT[i,*],charsize=1.3,ytitle='height [km]',yrange=[min(ALT),max(ALT)],xtitle='H2O mixing ratio',/xl,xrange=[min(FH2O),max(FH2O)]
;	oplot,H2O,heighth2o,linestyle=1
;
;	xyouts,0.45,0.85,'iteration number = '+strcompress(i+1,/remove_all)+'',/normal,charsize=1.5
;
;device,/close
;set_plot,'X'


;plotting the convergence history
; we know T(z) for all clima iterations.
; the temperature difference between two successive runs is calculate here.
; this T difference is then plotted as a contour figure:
;	x axis is iteration number
;	y axis is the height
;	the contour levels show the temperature difference
;	blue color, if the difference is negative (T decreased at the given height compared to the previous iteration)
;	red color, if the difference is positive (T increased)

; if plot_cont is not 1, no convergence plot is produced.
plot_cont=1

if plot_cont eq 1 then begin

nstep=1

;the positive difference array
diff=dblarr(total(clima_calls)/skip,nverti)
;the negative difference array
diffi=dblarr(total(clima_calls)/skip,nverti)

j=0d0
for i=0L,total(clima_calls)/skip-2L do begin

	diff[j,*]=T[i+1,*]-T[i,*]
	j=j+1d0
endfor


; it is not possible to use negative contour levels, so i have to do a trick.
; in diffi, all negative values are converted to positive ones, and all positive values to 0. 
; this way i can plot only the negative difference values.
for i=0L,total(clima_calls)/skip-2L do begin
	for j=0L,nverti-1L do begin
		if diff[i,j] lt 0d0 then diffi[i,j]=abs(diff[i,j])
		if diff[i,j] gt 0d0 then diffi[i,j]=0d0
	endfor
endfor

;number of contour levels
n=20

; creating the positive difference levels
maxi=max(diff)
mini=min(diff(where(diff gt 0d0)))


lev=mini*10^(findgen(n)/(n-1)*alog10(maxi/mini))

levs=dblarr(n+1)
levs[0]=0d0
for i=1,n do begin
	levs[i]=lev[i-1]
endfor

tick=[levs[1],levs[n/4],levs[n/2],levs[n/4*3],levs[n]]


; creating the negative difference levels
maxii=min(diff)
minii=max(diff(where(diff lt 0d0)))

levi=minii*10^(findgen(n)/(n-1)*alog10(maxii/minii))

levsi=dblarr(n+1)
levsi[0]=0d0
for i=1,n do begin
	levsi[i]=levi[i-1]
endfor

ticki=[levsi[1],levsi[n/4],levsi[n/2],levsi[n/4*3],levsi[n]]

;the number of iterations to plot
; this number should be comparable to the number of pixels in the image...
; if the number of iterations are much larger than the number of pixel,
;	you will not see the convergence properly
xrange=400


;plotting on the screen
;
;device,retain=2,decomposed=0
;window,0,retain=2
;
;loadct,3
;contour,diff,findgen(total(clima_calls)/nstep) # replicate(1d0,nverti),$
;ALT[0:total(clima_calls)/nstep-1,*],lev=levs,/cell_fill,position=[0.1, 0.12, 0.68, 0.95],$
;xtitle='nr. of iteration',ytitle='height [km]',charsize=1.3,/irregular,xrange=[0,xrange]
;
;loadct,1
;contour,diffi,findgen(total(clima_calls)/nstep) # replicate(1d0,nverti),$
;ALT[0:total(clima_calls)/nstep-1,*],lev=abs(levi),/cell_fill,/noerase,position=[0.1, 0.12, 0.68, 0.95],$
;xtitle='nr. of iteration',ytitle='height [km]',charsize=1.3,/irregular,xrange=[0,xrange]
;
;loadct,3
;COLORBAR, position=[0.12, 0.70, 0.95, 0.72],$
;/vertical,/right,ticknames=strcompress(string(power10(tick)),/remove_all),$
;title='positive temp. difference [K]',divisions=4,charsize=1.2
;
;loadct,1
;COLORBAR, position=[0.12, 0.85, 0.95, 0.87],$
;/vertical,/right,ticknames=strcompress('-'+string(power10(abs(ticki)))+'',/remove_all),$
;title='negative temp. difference [K]',divisions=4,charsize=1.2
;
;
;image=tvrd(true=1)
;dummy0=image(0,*,*)
;dummy1=image(1,*,*)
;dummy2=image(2,*,*)
;
;image[0,*,*]=dummy2
;image[1,*,*]=dummy1
;image[2,*,*]=dummy0
;
;write_bmp,'T_conv_'+strcompress(fix(nverti),/remove_all)+'_'+fname+'.bmp',image


;generating ps
;
;set_plot,'PS'
;device,file='T_conv_'+strcompress(fix(clima_calls[0]),/remove_all)+'_'+fname+'.ps',/color
;
;loadct,3
;
;contour,abs(diff),indgen(total(clima_calls)/nstep) # replicate(1d0,nverti),$
;ALT[0:total(clima_calls)/nstep-1,*],lev=levs,/cell_fill,position=[0.1, 0.12, 0.66, 0.95],$
;xtitle='nr. of iteration (niter!)',ytitle='height [km]',charsize=1.3,/irregular,xrange=[0,400]
;
;loadct,1
;contour,diffi,indgen(total(clima_calls)/nstep) # replicate(1d0,nverti),$
;ALT[0:total(clima_calls)/nstep-1,*],lev=abs(levi),/cell_fill,/noerase,position=[0.1, 0.12, 0.66, 0.95],$
;xtitle='nr. of iteration (niter!)',ytitle='height [km]',charsize=1.3,/irregular,xrange=[0,400]
;
;
;loadct,3
;COLORBAR, position=[0.12, 0.67, 0.95, 0.69],$
;/vertical,/right,ticknames=strcompress(string(power10(tick)),/remove_all),$
;divisions=4,charsize=1.2
;
;loadct,1
;COLORBAR, position=[0.12, 0.81, 0.95, 0.83],$
;/vertical,/right,ticknames=strcompress('-'+string(power10(abs(ticki)))+'',/remove_all),$
;title='temp. difference [K]',divisions=4,charsize=1.2
;
;
;
;device,/close
;set_plot,'X'


endif

close,1

end
