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
		@eq_res = result

		# consolidate any duplicate occurences 
		# of variable names in equation
		@eq_terms = {}
		terms.each do |varpair|
			if @eq_terms.key?(varpair.varname)
				@eq_terms[varpair.varname] += varpair.coefficient
			else
				@eq_terms[varpair.varname] = varpair.coefficient
			end
		end
	end

	def disp
		puts "VARIABLES:#{@eq_terms.length == 0 ? " none" : ""}"
		@eq_terms.each do |varname, coefficient|
			puts "  NAME: #{varname}, COEFFICIENT: #{coefficient}"
		end
		puts "RESULT: #{@eq_res}"
	end

	def varnames
		@eq_terms.keys
	end
end