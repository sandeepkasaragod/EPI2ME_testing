nextflow.enable.dsl=2

def currDir = System.getProperty("user.dir")

def res_dir = new File("${currDir}/${params.output_dir}/SAM2BAM")
if (!res_dir.exists()) {
        res_dir.mkdirs()
}

process SAMTOOLS {

  conda 'envs/samtools.yml'

  publishDir "${currDir}/${params.output_dir}/SAM2BAM", mode: 'copy'

  input:
  val input_bam
	tuple val(sampleId)

  output:
  val "${sampleId}.bam", emit: bam

  script:
  """
	samtools view -bS ${currDir}/${params.output_dir}/alignment/${sampleId}.sam > ${currDir}/${params.output_dir}/SAM2BAM/${sampleId}.bam 
  """
}

