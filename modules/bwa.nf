nextflow.enable.dsl=2

def currDir = System.getProperty("user.dir")

def res_dir = new File("${currDir}/${params.output_dir}/alignment")
if (!res_dir.exists()) {
        res_dir.mkdirs()
}

process BWA {

  conda	'envs/bwa.yml'

  publishDir "${currDir}/${params.output_dir}/alignment", mode: 'copy'

  input:
  val rawfile_dir
	tuple val(sampleId)

  output:
  val "${sampleId}.sam", emit: sam

  script:
  """
	bwa mem ${currDir}/reference/${params.reference_genome} ${currDir}/${rawfile_dir}/${sampleId}.${params.rawfile_type} > ${currDir}/${params.output_dir}/alignment/${sampleId}.sam 
  """
}

