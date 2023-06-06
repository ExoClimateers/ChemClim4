# Unix commands to save the output of a flare simulation 

#set SDIR = SAVEOUT/Gl581-CO279-O21e-2-Solcon11

#cp inputGl581-1AUeq.dat  $SDIR

cp fromClima2Photo.dat  ../../IO/
cp fromPhoto2Clima.dat ../../IO/
cp input_clima.dat ../../IO/
cp mixing_ratios.dat ../../IO/

cp TempIn.dat ../../CLIMA/IO

cp atm_composition.dat ../../ATMCHEM/IO
cp atm_chem.f ../../ATMCHEM

