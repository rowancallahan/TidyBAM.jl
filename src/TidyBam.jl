module TidyBAM
import XAM, Transducers

export @readbam, @filterread

macro readbam(filepath)
    return quote
    	open(XAM.BAM.Reader, $filepath)
    end
end

macro filterread(filter_criteria)
  #this function takes in a filtering criteria quote
  #then it turns it into an actual filtering step
  #that uses transducers to put into a real transducer pipeline
  function_out = quote
     Transducers.Filter(read->begin
       refname= XAM.BAM.refname(read)
       position = XAM.BAM.position(read)
       criteria = $(filter_criteria)
       return criteria 
       end)
    end
end

end # module TidyBam
