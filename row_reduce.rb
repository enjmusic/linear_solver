# 
# row_reduce.rb
# Tuesday, January 10th, 2017
# Ian Hoffman
# ijh6@cornell.edu
# 

# Extension of Rational to allow .reciprocal method
class Rational
	def reciprocal
		Rational(self.denominator, self.numerator)
	end
end

# Pretty prints gaussian row reduction matrices
def print_row_reduce_mat(eq_matrix)
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
	return eq_matrix if row1 == row2
	eq_matrix[row1], eq_matrix[row2] = eq_matrix[row2], eq_matrix[row1]
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


# Helper function to find scalar to multiply src by to get
# the additive inverse (negative) of to_cancel
def cancel_multiple(src, to_cancel)
	return (Rational(-1) * src.to_r.reciprocal * to_cancel.to_r)
end


# Performs gaussian elimination
def row_reduce(eq_matrix)
	num_rows = eq_matrix.length
	num_vars = eq_matrix[0].length - 1
	num_vars.times do |idx|
		# for each row index, find first row w/ that column 
		# nonzero and swap it into that row position if needed
		column_search = idx
		column_search += 1 while eq_matrix[column_search][idx] == 0 and column_search < num_rows
		next if column_search == num_rows
		eq_matrix = swap_rows(eq_matrix, idx, column_search)
		# normalize mat[idx][idx] to 1
		eq_matrix = mult_row(eq_matrix, idx, eq_matrix[idx][idx].reciprocal)

		# after possible swap, zero out entries in columns of lower rows
		((idx + 1)...num_rows).each do |lower_row|
			if eq_matrix[lower_row][idx] != 0
				eq_matrix = add_multiple_of_row(eq_matrix, lower_row, 
					idx, cancel_multiple(1, eq_matrix[lower_row][idx]))
			end
		end
	end
	return eq_matrix
end

# Checks consistency of row-reduced system matrix
def is_consistent(eq_matrix)
	num_vars = eq_matrix[0].length - 1
	eq_matrix.each do |row|
		return false if row[0...-1].inject(:+) == 0 and row[-1] != 0
	end
	return true
end

# Performs back elimination to achieve reduced 
# row echelon form, after having performed 
# Gaussian elimination as implemented above
def back_eliminate(eq_matrix)
	num_rows = eq_matrix.length
	num_vars = eq_matrix[0].length - 1
	(num_vars - 1).step(0, -1) do |idx|
		# for each row index, eliminate that column index's variable
		# in all above rows, starting from the last variable and
		# working towards the left side of the equation matrix
		idx.times do |upper_row|
			if eq_matrix[upper_row][idx] != 0
				eq_matrix = add_multiple_of_row(eq_matrix, upper_row, idx, 
					cancel_multiple(eq_matrix[idx][idx], eq_matrix[upper_row][idx]))
			end
		end
	end
	return eq_matrix
end

