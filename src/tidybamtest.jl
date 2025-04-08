using Transducers, TidyBAM, XAM
#set up the reader
#reader = open(BAM.Reader, "/Users/rowancallahan/projects/TidyBam/src/testbam.bam")
#reader = open(BAM.Reader, "/Users/callahro//TidyBAM.jl/src/testbam.bam")

# Iterate through records
result = @readbam("/Users/callahro/TidyBAM.jl/src/testbam.bam")|> 
    @filterread(refname=="chr1") |>
    collect
    #need to hace filter(refname =="chr1) and filter( position<10000) as options super simple
    #need to have writebam
    #need to have writesam
    #need to have writefasta
    #need to have get sequences
    #need to have reverse complement

    # Don't forget to close the reader
print(result)

