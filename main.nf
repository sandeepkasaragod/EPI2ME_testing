//main.nf

include { BWA     			} from './modules/bwa.nf'
include { SAMTOOLS			} from './modules/samtools.nf'

meta_file = "${params.meta_file}"

fq_channel = channel
        .fromPath(meta_file)
        .splitCsv(header: true, sep: ",")
  .map { row -> tuple(row.sampleId) }

rw = "${params.rawfile_dir}"

workflow {
	BWA(rawfile_dir=rw, fq_channel)
	SAMTOOLS(input_bam=BWA.out.sam, fq_channel)
}

