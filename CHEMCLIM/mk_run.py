import os
import sys

test_dir   = '/home/mucephie/ecwrk/runs/' # location for your runs
run_label  = 'run00/'                     # label for run
python     = 'vpython -m '                # your python command for desired python environment
run_script = 'run_me.py'                  # the python script to initiate run
####
# Make isolated directory for run:
####
os.makedirs(test_dir + run_label + 'CHEMCLIM/', exist_ok = True)
os.system("cp * " + test_dir + run_label + 'CHEMCLIM/ -r')

####
# Autorun script
####
os.chdir(test_dir + run_label + 'CHEMCLIM/')
os.system(python + run_script)
os.system('ls ')
