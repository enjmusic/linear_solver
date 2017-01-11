# 
# row_reduce.rb
# Tuesday, January 10th, 2017
# Ian Hoffman
# ijh6@cornell.edu
# 

# Pretty prints gaussian row reduction matrices
def print_row_reduce_mats(eq_matrix, res_matrix)
	puts
	eq_matrix.each_with_index do |row, idx|
		row.each {|cell| print "#{cell}".ljust(10)}
		print "  |  #{res_matrix[idx]}"
		puts
	end
	puts
end

# Performs gaussian row reduction
def row_reduce(eq_matrix, res_matrix)
	return eq_matrix, res_matrix # TODO
end