.macro print_int (%x)  #macro to print any integer or register
	li a7, 1
	add a5, zero, %x
	#zero here refers to register #0
	#the zero register always has constant value of 0
	ecall
	.end_macro
	
.macro print_str(%string1) #macro to print any string
	li a7,4 
	la a5, %string1
	ecall
	.end_macro
	
income_from_record:
#function to return numerical income from a specific record
#e.g. for record "Microsoft,34\r\n", income to return is 34(for which name is Microsoft)

#arguments:	a0 contains pointer to start of numerical income in record 

#function RETURNS income numerical value of the asci income in a0 (34 in our example)

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

	
	#need to preserve s0 and ra
	addi sp, sp, -8
	sw s0, 0(sp)
	sw ra, 4(sp)

	li t1, 0 # counter for decimal place
	li t2, 13 #'\r' character ==> ascii value 13
	
	#addi a0, a0, 4 # 0x1004 0004 or 0x10004 0000?
	lwu a0, 0(a0) 
	addi s0, a0, 0
	
counter:
	lbu t0, 0(a0) #t0 = ascii value of character string
	beq t0, t2, setup #check if t0 = '\r'
	addi t1, t1, 1 #increase t1 digit counter
	addi a0, a0, 1 #move to next character byte 
	j counter
setup:
	li a0, 0 #to be used as decimal value	
	li t2, 10 #used to multiply powers of ten
	addi t1, t1, -1 #used to determine power of ten of each digit
getInt:
	lbu t0, 0(s0) #t0 = ascii string value
	addi t0, t0, -48 #t0 = integer value
	#beqz t1, 
	addi t3, t1, 0 #set power of ten counter to digit counter value
multInt:
	beqz t3, addSum #if power of ten counter is zero, jump to add sum
	mul t0, t0, t2 #else, mult digit by ten
	addi t3, t3, -1 #decrease power of ten counter by one
	bnez t3, multInt #loop again if power of ten counter is not zero
addSum: 
	add a0, a0, t0 #add digit of the final power of ten to sum
	addi t1, t1, -1 #decrease digit counter (and power of ten counter) by one
	bltz t1, endInt #if digit counter < zero, jump to endInt
	addi s0, s0, 1 #move to next character byte
	bgez t1, getInt #if digit counter >= zero, loop to get next digit
endInt:	
	lwu s0, 0(sp)
	lwu ra, 4(sp)
	addi sp, sp, 8
	
	#print_str('\n')
	#print_int(a0)
	#print_str(newline)
	
	jr ra
	
	# End your coding  here!
	ret
	
#######################end of income_from_record###############################################	



