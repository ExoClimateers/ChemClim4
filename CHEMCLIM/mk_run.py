import os
import sys

test_dir = '~/ecwrk/runs/'
run_label = 'run00/'


####
os.makedirs(test_dir + run_label + 'CHEMCLIM/', exist_ok = True)
os.system("cp * " + test_dir + run_label + 'CHEMCLIM/')