ls *_R1_001.fastq  | awk -F "_R1_001.fastq" '{print $1}' >samples.txt

while read line
do
#echo "gunzip ${line}_R1_001.fastq.gz">run.${line}.sh
#echo "gunzip ${line}_R2_001.fastq.gz">>run.${line}.sh

#echo "/u/home/s/serghei/collab/code/recycle.RNA.seq/benchmark_RNASeq_aligners/code/run.hisat2.tuned.sh ${line}_R1_001.fastq ${line}_R2_001.fastq ${line}">run.${line}.sh

echo ". /u/local/Modules/default/init/modules.sh">>run.${line}.sh
echo "module load samtools">>run.${line}.sh
echo "samtools sort -n $line.bam ${line}_sort_byname.bam">>run.${line}.sh
htseq-count --mode=intersection-strict --stranded=no  -f bam /u/home/s/serghei/scratch/AS07022018/bam//hisat2.tuned_01-012-D0_S1_R1_001_sort_byname.bam /u/home/s/serghei/project/Homo_sapiens/Ensembl/Homo_sapiens.GRCh38.79.gtf >hisat2.tuned_01-012-D0_S1_R1_001.counts
rm -rf hisat2.tuned_01-012-D0_S1_R1_001_sort_byname.bam



#qsub -cwd -V -N X$line -l h_data=8G,time=10:00:00  run.${line}.sh




done<samples.txt
