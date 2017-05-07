export REF=$MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/
export WORK_DIR="${HOME}/bfx_genomic_medecine/module3"

module load mugqic/java/openjdk-jdk1.8.0_72 mugqic/samtools/1.4 
module load mugqic/GenomeAnalysisTK/3.7 mugqic/picard/1.123 
module load mugqic/snpEff/4.2 mugqic/R_Bioconductor/3.3.2_3.4


cd $WORK_DIR

####################
## NA12891
####################

#NA12891.sort
java -Xmx8g -jar $GATK_JAR -T HaplotypeCaller -l INFO -R ${REF}/genome/Homo_sapiens.GRCh37.fa \
-I bam/NA12891/NA12891.bwa.sort.bam  --variant_index_type LINEAR --variant_index_parameter 128000 -dt none \
-o variants/NA12891.hc.vcf -L 1:17704860-18004860

#NA12891.sort.rmdup.realign
java -Xmx8g -jar $GATK_JAR -T HaplotypeCaller -l INFO -R ${REF}/genome/Homo_sapiens.GRCh37.fa \
-I bam/NA12891/NA12891.bwa.sort.rmdup.realign.bam  --variant_index_type LINEAR --variant_index_parameter 128000 -dt none \
-o variants/NA12891.rmdup.realign.hc.vcf -L 1:17704860-18004860


java -Xmx8g -jar $GATK_JAR -T VariantFiltration \
-R ${REF}/genome/Homo_sapiens.GRCh37.fa --variant variants/NA12891.rmdup.realign.hc.vcf -o variants/NA12891.rmdup.realign.hc.filter.vcf --filterExpression "QD < 2.0" \
--filterExpression "FS > 200.0" \
--filterExpression "MQ < 40.0" \
--filterName QDFilter \
--filterName FSFilter \
--filterName MQFilter

java -Xmx8G -jar ${SNPEFF_HOME}/snpEff.jar eff  -v -no-intergenic \
-i vcf -o vcf GRCh37.75 variants/NA12891.rmdup.realign.hc.filter.vcf >  variants/NA12891.rmdup.realign.hc.filter.snpeff.vcf


java -Xmx8g -jar $GATK_JAR -T VariantAnnotator -R ${REF}/genome/Homo_sapiens.GRCh37.fa \
--dbsnp $REF/annotations/Homo_sapiens.GRCh37.dbSNP142.vcf.gz --variant variants/NA12891.rmdup.realign.hc.filter.snpeff.vcf \
-o variants/NA12891.rmdup.realign.hc.filter.snpeff.dbsnp.vcf -L 1:17704860-18004860

####################
## NA12892
####################


#NA12892.sort.rmdup.realign
java -Xmx8g -jar $GATK_JAR -T HaplotypeCaller -l INFO -R ${REF}/genome/Homo_sapiens.GRCh37.fa \
-I bam/NA12892/NA12892.bwa.sort.bam  --variant_index_type LINEAR --variant_index_parameter 128000 -dt none \
-o variants/NA12892.hc.vcf -L 1:17704860-18004860

#NA12892.sort.rmdup.realign
java -Xmx8g -jar $GATK_JAR -T HaplotypeCaller -l INFO -R ${REF}/genome/Homo_sapiens.GRCh37.fa \
-I bam/NA12892/NA12892.bwa.sort.rmdup.realign.bam  --variant_index_type LINEAR --variant_index_parameter 128000 -dt none \
-o variants/NA12892.rmdup.realign.hc.vcf -L 1:17704860-18004860


java -Xmx8g -jar $GATK_JAR -T VariantFiltration \
-R ${REF}/genome/Homo_sapiens.GRCh37.fa --variant variants/NA12892.rmdup.realign.hc.vcf -o variants/NA12892.rmdup.realign.hc.filter.vcf --filterExpression "QD < 2.0" \
--filterExpression "FS > 200.0" \
--filterExpression "MQ < 40.0" \
--filterName QDFilter \
--filterName FSFilter \
--filterName MQFilter


java -Xmx8G -jar ${SNPEFF_HOME}/snpEff.jar eff  -v -no-intergenic \
-i vcf -o vcf GRCh37.75 variants/NA12892.rmdup.realign.hc.filter.vcf >  variants/NA12892.rmdup.realign.hc.filter.snpeff.vcf



java -Xmx8g -jar $GATK_JAR -T VariantAnnotator -R ${REF}/genome/Homo_sapiens.GRCh37.fa \
--dbsnp $REF/annotations/Homo_sapiens.GRCh37.dbSNP142.vcf.gz --variant variants/NA12892.rmdup.realign.hc.filter.snpeff.vcf \
-o variants/NA12892.rmdup.realign.hc.filter.snpeff.dbsnp.vcf -L 1:17704860-18004860
