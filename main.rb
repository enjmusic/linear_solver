# 
# main.rb
# Tuesday, January 10th, 2017
# Ian Hoffman
# ijh6@cornell.edu
# 

require_relative 'parse'
require_relative 'equation'

puts "Welcome to the linear equation system solver! Please enter your equations below."
puts "If you are finished entering equations, press ENTER"

equations = []

loop do
	input = gets.chomp.strip
	break if input == ""
	terms, result = parse_equation(input)

	if terms.nil? or result.nil?
		puts "Unable to parse equation, please try again"
		next
	end
	equations << Equation.new(terms, result)
end

puts "Solving system of equations..."

# check solvability 
# is num total vars <= num equations?
# do any vars have conflicting definitions?
# etc.