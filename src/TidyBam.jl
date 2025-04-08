module TidyBam
import XAM, Transducers

export @readbam, @bamfilter
#position
#length
#unmapped
#paired
macro readbam(filepath)
    return quote
	open(XAM.BAM.Reader, $filepath) |>
        Transducers.Map(record -> (refname=XAM.BAM.refname(record),
		       position=XAM.BAM.position(record)))

    end
end

macro filterreads(filters...)
    expression_list = []

    for arg in filters
	expression= quote
		Transducers.Filter(read-> $filter)
        end
    end

end

#@bamfilter(filters...)
#    expression_list = []
#    for arg in filters
#	    if key=="position"
#            Filter(record -> BAM.refname(record) 
#    Filter(pair -> pair[1] == "chr1") |>
#
#	elseif key == "refname"
#
#	else
#	    throw(ArgumentError("invalid bam record type, available options are position and refname"))
#	end
#    end
#expression = :(Filter
#    for argument in filters 
#     
#    end
#
#    return quote
#    end
#
#end


end # module TidyBam
