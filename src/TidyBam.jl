module TidyBAM
import XAM, Transducers, BGZFStreams

export readbam, @filterread, writebam

function readbam(filepath)
    	reader = open(XAM.BAM.Reader, filepath)
      global file_header = XAM.BAM.header(reader)
      return reader
end

macro filterread(filter_criteria)
  #this function takes in a filtering criteria quote
  #then it turns it into an actual filtering step
  #that uses transducers to put into a real transducer pipeline
  return quote
     Transducers.Filter(read->begin
       refname= XAM.BAM.refname(read)
       position = XAM.BAM.position(read)
       sequence_length = XAM.BAM.seqlength(read)
       quality = XAM.BAM.quality(read)
       is_primary = XAM.isprimaryalignment(read)
       is_mapped = XAM.ismapped(read)
       is_paired_end = XAM.flags(read) & 1 == 1
       is_proper_pair = XAM.flags(read) & 2 == 2
       is_read_1= XAM.flags(read) & 64 == 64
       is_read_2= XAM.flags(read) & 128 == 128

       criteria = $(filter_criteria)
       return criteria 
       end)
    end
end

function writebam(filename,record_list;bam_header=file_header)
  writer = XAM.BAM.Writer(BGZFStreams.BGZFStream(open(filename, "w"),"w"),bam_header)
  for read in record_list
    write(writer, read)
  end
end

end # module TidyBAM
