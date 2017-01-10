# 
# parse.rb
# Tuesday, January 10th, 2017
# Ian Hoffman
# ijh6@cornell.edu
# 

# Structure for variable, coefficient pairs
VarPair = Struct.new(:varname, :coefficient)

# Converts string to decimal, rational, or 
# floating point number if possible, otherwise nil
def str_to_num(string)
	return string.to_r if string =~ /^\d+\/\d+$/ rescue nil
	return string.to_i if string =~ /^\d+$/
	return Float(string) rescue nil
end

def parse_equation(string)
	# split equation in two and parse the right hand side
	sides = string.split("=").map {|slice| slice.strip}
	return nil, nil if sides.length != 2
	rhs = str_to_num(sides[1])
	return nil, nil if rhs.nil?

	# parse the left hand side into variable, coefficient pairs
	lhs_tokens = sides[0].scan(/[a-z]+|\d+\/\d+|\d+|[+-=]/)
	lhs_varpairs = []

	# ...

	return nil, nil if lhs_varpairs.length == 0
	[lhs_varpairs, rhs]
end