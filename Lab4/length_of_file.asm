length_of_file:
#function to find length of data read from file
#arguments: a1=bufferAddress holding file data
#return file length in a0

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

	#Start your coding here
	
	#need to preserve s0 in main memory
	addi sp, sp, -4
	sw s0, 0(sp)
	
	addi s0, a1, 0
	lbu t1, 0(s0)
	li a0, 0
	bnez t1, fileNotDone
	ret
	
fileNotDone:
	addi a0, a0, 1
	addi s0, s0, 1
	lbu t1, 0(s0)
	bnez t1, fileNotDone

	lwu s0, 0(sp)

#End your coding here
	
	ret
#######################end of length_of_file###############################################	
