; function used to produce tick strings for the axes in the form of a*10^b
FUNCTION power10, value
 str=''
 value_ii = fix( alog10(value) )
 num=fix((value/10d0^(value_ii))*100d0)/100d0
 
 str = ''+string(num,format='(F0.1)')+'*10!U' + string(value_ii, format='(I0)') + '!N'
 return, str
END

;*****************
; start of program
;*****************

close,/all

; string used in the plots and images produced
; use a different string name for a different run to avoid overwriting previous files!
fname='conv_testIR2_0'


;making a directory for the frames
;the frames show the T, H2O and O3 profiles as a function of height
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

;open clima_allout and read the file
openr,1,'IO/clima_allout_'+fname+'.ta'

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
J=dblarr(total(clima_calls),nverti)     
P=dblarr(total(clima_calls),nverti)        
ALT=dblarr(total(clima_calls),nverti)
T=dblarr(total(clima_calls),nverti)       
CONVEC=dblarr(total(clima_calls),nverti)       
DT=dblarr(total(clima_calls),nverti)           
TOLD=dblarr(total(clima_calls),nverti)        
FH2O=dblarr(total(clima_calls),nverti)        
TCOOL=dblarr(total(clima_calls),nverti)        
THEAT=dblarr(total(clima_calls),nverti)        
FO3=dblarr(total(clima_calls),nverti)        


PF=dblarr(total(clima_calls),nverti)
FTOTAL=dblarr(total(clima_calls),nverti)
FTIR=dblarr(total(clima_calls),nverti)
FDNIR=dblarr(total(clima_calls),nverti)
FUPIR=dblarr(total(clima_calls),nverti)
FTSOL=dblarr(total(clima_calls),nverti)
FDNSOL=dblarr(total(clima_calls),nverti)
FUPSOL=dblarr(total(clima_calls),nverti)
DIVF=dblarr(total(clima_calls),nverti)

;reading the file and filling up the arrays:
for i=0L,total(clima_calls)-1L do begin
	
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

close,1

n=total(clima_calls)

;********
;plotting
;********

window,2,retain=2
plot,FDNSOL[n-1,*],ALT[n-1,*],/xl,xrange=[min([min(FUPSOL),min(FDNSOL)]),max([max(FUPSOL),max(FDNSOL)])],/yl,$
	yrange=[ALT[n-1,nverti-2],ALT[n-1,0]],xtitle='solar flux [erg/cm^2/s]',ytitle='height [km]',charsize=1.3
oplot,FUPSOL[n-1,*],ALT[n-1,*],linestyle=1
xyouts,0.3,0.78,'F!DDOWN!N',charsize=1.6,/normal
xyouts,0.3,0.7,'F!DUP!N',charsize=1.6,/normal
plots,[0.2,0.28],[0.795,0.795],/normal
plots,[0.2,0.28],[0.715,0.715],/normal,linestyle=1
xyouts,0.2,0.85,'Albedo: '+strcompress(string(FUPSOL[n-1,0]/FDNSOL[n-1,0],format='(F0.2)'),/remove_all)+'',$
	charsize=1.2,/normal


print,'the albedo is ',FUPSOL[n-1,0]/FDNSOL[n-1,0]
print,FUPSOL[n-1,nverti-1]/FDNSOL[n-1,nverti-1]

set_plot,'PS'
device,file='FSOL_profile_'+strcompress(fix(nverti),/remove_all)+'_'+fname+'.ps',/color

	plot,FDNSOL[n-1,*],ALT[n-1,*],/xl,xrange=[min([min(FUPSOL),min(FDNSOL)]),max([max(FUPSOL),max(FDNSOL)])],/yl,$
		yrange=[ALT[n-1,nverti-2],ALT[n-1,0]],xtitle='solar flux [erg/cm^2/s]',ytitle='height [km]',charsize=1.3,thick=3,charthick=3	
	oplot,FUPSOL[n-1,*],ALT[n-1,*],linestyle=1,thick=3
	xyouts,0.3,0.78,'F!DDOWN!N',charsize=1.3,charthick=3,/normal
	xyouts,0.3,0.7,'F!DUP!N',charsize=1.3,charthick=3,/normal
	plots,[0.2,0.28],[0.795,0.795],thick=3,/normal
	plots,[0.2,0.28],[0.715,0.715],thick=3,/normal,linestyle=1
	xyouts,0.2,0.85,'Albedo: '+strcompress(string(FUPSOL[n-1,0]/FDNSOL[n-1,0],format='(F0.2)'),/remove_all)+'',$
		charsize=1.2,charthick=3,/normal

device,/close
set_plot,'X'


set_plot,'PS'
device,file='FIR_profile_'+strcompress(fix(nverti),/remove_all)+'_'+fname+'.ps',/color

	plot,FDNIR[n-1,*],ALT[n-1,*],/xl,xrange=[1d0,max([max(FUPIR),max(FDNIR)])],/yl,$
		yrange=[ALT[n-1,nverti-2],ALT[n-1,0]],xtitle='infrared flux [erg/cm^2/s]',ytitle='height [km]',charsize=1.3,thick=3,charthick=3	
	oplot,FUPIR[n-1,*],ALT[n-1,*],linestyle=1,thick=3
	xyouts,0.3,0.78,'F!DDOWN!N',charsize=1.3,charthick=3,/normal
	xyouts,0.3,0.7,'F!DUP!N',charsize=1.3,charthick=3,/normal
	plots,[0.2,0.28],[0.795,0.795],thick=3,/normal
	plots,[0.2,0.28],[0.715,0.715],thick=3,/normal,linestyle=1

device,/close
set_plot,'X'


;window,2,retain=2
;plot,FDNIR[n-1,*],ALT[n-1,*],/xl,xrange=[1d0,max([max(FUPIR),max(FDNIR)])],/yl,$
;	yrange=[ALT[n-1,nverti-2],ALT[n-1,0]],xtitle='infrared flux [erg/cm^2/s]',ytitle='height [km]',charsize=1.3
;oplot,FUPIR[n-1,*],ALT[n-1,*],linestyle=1
;xyouts,0.3,0.78,'F!DDOWN!N',charsize=1.6,/normal
;xyouts,0.3,0.7,'F!DUP!N',charsize=1.6,/normal
;plots,[0.2,0.28],[0.795,0.795],/normal
;plots,[0.2,0.28],[0.715,0.715],/normal,linestyle=1

set_plot,'PS'
device,file='FTOTAL_profile_'+strcompress(fix(nverti),/remove_all)+'_'+fname+'.ps',/color

	plot,abs(FTIR[n-1,*]),ALT[n-1,*],/xl,xrange=[min([min(FTSOL),min(abs(FTIR))]),max([max(abs(FTIR)),max(FTSOL)])],$
		yrange=[ALT[n-1,nverti-2],ALT[n-1,0]],/yl,xtitle='total flux [erg/cm^2/s]',ytitle='height [km]',charsize=1.3,$
		thick=3,charthick=3,LINESTYLE=1
	oplot,FTSOL[n-1,*],ALT[n-1,*],thick=3
	xyouts,0.3,0.78,'F!DSOL!N',charsize=1.3,charthick=3,/normal
	xyouts,0.3,0.7,'F!DIR!N',charsize=1.3,charthick=3,/normal
	plots,[0.2,0.28],[0.795,0.795],thick=3,/normal
	plots,[0.2,0.28],[0.715,0.715],thick=3,/normal,linestyle=1

device,/close
set_plot,'X'


;plot,-FDNSOL[n-1,*]+FUPSOL[n-1,*]-FDNIR[n-1,*]+FUPIR[n-1,*],P[n-1,*],/yl,yrange=[min(P(n-1,*)),1.]
;plot,FTOTAL[n-1,*],P[n-1,*],/yl,yrange=[min(P(n-1,*)),1.]
;plot,FTIR[n-1,*]+FTSOL[n-1,*],ALT[n-1,*];,/yl,yrange=[min(P(n-1,*)),1.]

end
