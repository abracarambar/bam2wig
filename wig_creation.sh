#!/bin/bash
#PBS -V
#PBS -N wig
#PBS -j oe
#PBS -m ae
#PBS -M m.gauthier@garvan.org.au
#PBS -q express
#PBS -l ncpus=4
#PBS -l mem=8gb
#PBS -l walltime=2:00:00

module load python

cd $PBS_O_WORKDIR 

#java -jar /g/data2/gd7/software/maegau/jvarkit/dist/bam2wig.jar  -s 3 -w 1 /g/data3/ba08/cSCC/alignments/321773_T.dedup.realigned.bam -o /g/data3/ba08/wigs/321773_T.wig
#first covert bam to wig

#paste the bam and the tumour wig
SAMPLE='34366'
paste ${SAMPLE}B.wig  ${SAMPLE}T.wig > ${SAMPLE}_BT.wig  

#create the wig file format matching MuTect1 using the script mutect_wiggle_file_generate.py
python mutect_wiggle_file_generate.py --sample ${SAMPLE}

#make a local copy of reference, as additional files will be created in its directory
#make sure your reference is using the 'chr1' nomenclature and nothing is written after the chromosome number
python /g/data2/gd7/software/maegau/InVEx-1.0.1/invex/create_nt_power_file_from_wig.py human_g1k_v37_decoy.ed.fasta /g/data3/ba08/wigs/${SAMPLE}_BT_mutsig.wig ${SAMPLE}
