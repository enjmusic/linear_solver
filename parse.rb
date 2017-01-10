# 
# parse.rb
# Tuesday, January 10th, 2017
# Ian Hoffman
# ijh6@cornell.edu
# 

def parse_equation(string)
	sides = string.split("=").map {|slice| slice.strip}
	return nil, nil if sides.length != 2
	return 1, 1
end