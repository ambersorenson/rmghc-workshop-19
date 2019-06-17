#!/usr/bin/env nextflow
params.name             = "RNA-seq"
params.reads            = "$HOME/workshop/fastq/*{*_R1,*_R2}.fastq.gz"
params.email		= "amber.scott@colorado.edu"

log.info "RNA-seq Pipeline"
log.info "====================================="
log.info "name         : ${params.name}"
log.info "reads        : ${params.reads}"
log.info "email        : ${params.email}"
log.info "\n"


reads = Channel.fromFilePairs(params.reads, size: -1) 

// Make commends in nextflow like this 

process view_reads {

   publishDir "results"

   input:
   set val(sample_id), file(read_files) from reads

   output:
   file "*.txt"

   script:
   """
   # This is a bash script in here
   zcat ${read_files[[1]]} | wc -l - > ${sample_id}_counts.txt
   """


}
