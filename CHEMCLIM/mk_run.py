import os
import sys

test_dir = '~/ecwrk/runs/'
run_label = 'run00/'

####
# Make isolated directory for run:
####
os.makedirs(test_dir + run_label + 'CHEMCLIM/', exist_ok = True)
os.system("cp * " + test_dir + run_label + 'CHEMCLIM/')
####
# Autorun script
####
import  test_dir + run_label + 'CHEMCLIM/run_tes.py'
