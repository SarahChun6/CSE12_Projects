maxIncome:
#finds the total income from the file
#arguments:	a0 contains the file record pointer array location (0x10040000 in our example) But your code MUST handle any address value
#		a1:the number of records in the file
#return value a0: heap memory pointer to actual  location of the record stock name in the file buffer

	#if empty file, return 0 for both a0, a1
	bnez a1, maxIncome_fileNotEmpty
	li a0, 0
	ret

 maxIncome_fileNotEmpty:

##########################################################################
# Created by: Chun, Sarah
#		schun38
#		21 November 2022
#
# Assignment: Lab 4: RARS Stock Income Analysis
#		CSE 12, Computer Systems and Assembly Language
#		UC Santa Cruz, Fall 2022
#
# Description: This program takes in a csv spreadsheet of stock data (names and incomes)
#		then prints out the total file size in bytes, the total income in stocks,
#		and the stock with the maximum income.
#
# Notes: This program is intended to be run using RARS.
##########################################################################

	# Start your coding from here!
	
	#need to preserve a0,t0,t1,t2,t3,t4,ra for income_from_record
	addi sp, sp, -36
	sw s0, 32(sp)
	sw t4, 28(sp)	
	sw t3, 24(sp)
	sw t2, 20(sp)
	sw t1, 16(sp)
	sw t0, 12(sp)
	sw ra, 8(sp)
	sw a2, 4(sp)
	sw a0, 0(sp)
	
	li s0, 0 # start at zero 
	addi a0, a0, 4 # start after first name
	addi a2, a0, 0 # a2 temp hold address
maxLoop:
	sw a0, 0(sp) # store new address location
	jal income_from_record
	blt a0, s0, skipSwap # branch if a0 is less than s0
	addi s0, a0, 0 # update new max
	lw a0, 0(sp) # restore address location
	addi a2, a0, 0 # a2 temp hold new max address
skipSwap:
	lw a0, 0(sp) # restore address location
	addi a0, a0, 8 # moves to next income location (skip name)
	addi a1, a1, -1 # decreases number of records in file by one
	bgtz a1, maxLoop # if number of records in file > 0, loop again
	
endMax:
	addi a0, a2, 0	# transfer a2 (max income address) into a0 when done looping thru all records in file
	addi a0, a0, -4 # go back to name address from income address

	# restore register values from main memory
	lw s0, 32(sp)
	lw t4, 28(sp)
	lw t3, 24(sp)
	lw t2, 20(sp)		
	lw t1, 16(sp)
	lw t0, 12(sp)
	lw ra, 8(sp)
	lw a2, 4(sp)
	#lw a3, 0(sp)
	
	addi sp, sp, 36

	#li a0, 0x10040010 # if no student code entered, a0 just returns 0x10040010 always :(
	
	# End your  coding  here!
	
	ret
#######################end of maxIncome###############################################
