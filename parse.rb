# 
# parse.rb
# Tuesday, January 10th, 2017
# Ian Hoffman
# ijh6@cornell.edu
# 

# Structure for variable, coefficient pairs
VarPair = Struct.new(:varname, :coefficient)

# Sign multipliers
SIGNMULT = {'+' => 1, '-' => -1}

# Converts string to decimal, rational, or 
# floating point number if possible, otherwise nil
def str_to_num(string)
	return string.to_r rescue nil
end

def parse_equation(string)
	# split equation in two and parse the right hand side
	sides = string.split("=").map {|slice| slice.strip}
	return nil, nil if sides.length != 2
	rhs = str_to_num(sides[1])
	return nil, nil if rhs.nil?

	# parse the left hand side into variable, coefficient pairs
	lhs_tokens = sides[0].scan(/[a-z]+|\d+.\d+|\d+\/\d+|\d+|[+-]|\S/)
	lhs_varpairs = []

	unmatched_sign = nil
	unmatched_coef = nil
	lhs_tokens.each_with_index do |token, idx|
		if token == '+' or token == '-'
			if unmatched_sign.nil?
				unmatched_sign = SIGNMULT[token]
			else
				unmatched_sign *= SIGNMULT[token]
			end
		elsif token =~ /^[a-z]+$/
			if unmatched_sign.nil? and unmatched_coef.nil? and idx > 0
				puts "Unexpected variable name encountered: #{token}"
				return nil, nil
			end

			newpair = VarPair.new
			newpair.varname = token
			if unmatched_sign.nil?
				newpair.coefficient = unmatched_coef.nil? ? 1 : unmatched_coef
			elsif unmatched_coef.nil?
				newpair.coefficient = unmatched_sign
			else
				newpair.coefficient = unmatched_sign * unmatched_coef
			end
			lhs_varpairs << newpair

			unmatched_sign, unmatched_coef = [nil, nil]
		elsif not str_to_num(token).nil?
			if unmatched_coef.nil?
				unmatched_coef = str_to_num(token)
			else
				puts "Duplicate coefficient encountered: #{token}"
				return nil, nil
			end
		else
			puts "Invalid symbol: #{token}"
			return nil, nil
		end
	end

	return nil, nil if lhs_varpairs.length == 0
	[lhs_varpairs, rhs]
end
