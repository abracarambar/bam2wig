#!/bin/env python
import subprocess
import argparse

def main():
    parser = argparse.ArgumentParser()
    sample = myargparse(parser)

    fout = open('/g/data3/ba08/wigs/' + str(sample) + '_BT_mutsig.wig', 'w')
    with open('/g/data3/ba08/wigs/' + str(sample) + '_BT.wig', 'r') as fin:
        for line in fin:
            glob_cov=0
            if line.startswith('fixedStep'):
                fout.write(line)
            else:
                cov_germ, cov_tum = line.strip().split('\t')
                if cov_germ >= '8' and cov_tum >= '14':
                    glob_cov='1'
                else:
                    glob_cov='0'
            fout.write(str(glob_cov) + "\n")

def myargparse(parser):
    parser.add_argument('-s','--sample', help= 'Enter sample')
    args = parser.parse_args()
    return args.sample

if __name__ == "__main__":
    main()

fout.close()
