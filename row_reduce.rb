# 
# row_reduce.rb
# Tuesday, January 10th, 2017
# Ian Hoffman
# ijh6@cornell.edu
# 

# Pretty prints gaussian row reduction matrices
def print_row_reduce_mats(eq_matrix)
	puts
	eq_matrix.each do |row|
		row.each_with_index do |cell, col_idx| 
			if col_idx < (eq_matrix[0].length - 1)
				print "#{cell}".ljust(10)
			else
				print "  |  #{cell}"
			end
		end
		puts
	end
	puts
end


# 3 helper functions for the 3 elementary row operations
def swap_rows(eq_matrix, row1, row2)
	eq_matrix[row1], eq_matrix[row2] = [
		eq_matrix[row2], eq_matrix[row1]
	]
	return eq_matrix
end

def mult_row(eq_matrix, row, scalar)
	eq_matrix[row].map! {|cell| cell *= scalar}
	return eq_matrix
end

def add_multiple_of_row(eq_matrix, dest, src, scalar)
	eq_matrix[dest].map!.with_index {|cell, idx| cell + (scalar * eq_matrix[src][idx])}
	return eq_matrix
end


# Performs gaussian row reduction
def row_reduce(eq_matrix)
	eq_matrix = swap_rows(eq_matrix, 0, 1)
	eq_matrix = mult_row(eq_matrix, 1, Rational(1, 2))
	eq_matrix = add_multiple_of_row(eq_matrix, 1, 0, Rational(-1, 3))
	return eq_matrix # TODO
end