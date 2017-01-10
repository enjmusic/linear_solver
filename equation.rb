# 
# equation.rb
# Tuesday, January 10th, 2017
# Ian Hoffman
# ijh6@cornell.edu
# 

class Equation
	attr_reader :eq_terms
	attr_reader :eq_res

	def initialize(terms, result)
		@eq_terms = terms
		@eq_res = result
	end

	def disp
		puts "VARIABLES:#{@eq_terms.length == 0 ? " none" : ""}"
		@eq_terms.each do |term|
			puts "  NAME: #{term.varname}, COEFFICIENT: #{term.coefficient}"
		end
		puts "RESULT: #{@eq_res}"
	end
end