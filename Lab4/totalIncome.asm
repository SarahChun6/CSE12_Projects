totalIncome:
#finds the total income from the file
#arguments:	a0 contains the file record pointer array location (0x10040000 in our example) But your code MUST handle any address value
#		a1:the number of records in the file
#return value a0:the total income (add up all the record incomes)

	#if empty file, return 0 for a0
	bnez a1, totalIncome_fileNotEmpty
	li a0, 0
	ret

totalIncome_fileNotEmpty:
	
	# Start your coding from here!
	
	#need to preserve a0,t0,t1,t2,t3,t4,ra for income_from_record
	addi sp, sp, -32
	sw t4, 28(sp)	
	sw t3, 24(sp)
	sw t2, 20(sp)
	sw t1, 16(sp)
	sw t0, 12(sp)
	sw ra, 8(sp)
	sw a2, 4(sp)
	sw a0, 0(sp)
	
	li a2, 0 # start sum at zero 
	addi a0, a0, 4 # start after first name
loop:
	sw a0, 0(sp) # store new address location
	jal income_from_record
	add a2, a2, a0 # add income of first stock to sum
	lw a0, 0(sp) # restore address location
	addi a0, a0, 8 # moves to next income location (skip name)
	addi a1, a1, -1 # decreases number of records in file by one
	bnez a1, loop # if number of records in file != 0, loop again
	
endLoop:
	addi a0, a2, 0 # transfer the income sum from a2 to a0
	
	# restore register values from main memory
	lw t4, 28(sp)
	lw t3, 24(sp)
	lw t2, 20(sp)		
	lw t1, 16(sp)
	lw t0, 12(sp)
	lw ra, 8(sp)
	lw a2, 4(sp)
	lw a3, 0(sp)
	
	addi sp, sp, 32
	#jr ra
	
	# End your  coding  here!
	
	ret
#######################end of nameOfMaxIncome_totalIncome###############################################
