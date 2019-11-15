# Chadille Jones 
# ID: @02856918
# 2856918 % 11 = 9 Base 35
.data  #Section to declare data
user_input: .space 2000
list: .word 0,0,0,0 #initialize a word list
invalid_input: .asciiz "Invalid Input"

.text  #Assembly langugae instruction
.globl main

main:
	
	li $v0, 8  #accepts user input
	la $a0, user_input
	li $a1, 1001 #specify the length of the input #changed so the person can enter 10 characters and then enter button
	syscall
	
	la $s4, list #load the address of the list #reverted change
	la $t0, user_input   #loads the address of the string
	li $t1, 4  #initialized the variable to check if number of characters is > 4
	li $t2, 32 #loaded a space here 
	li $t3, 9 #loaded a tab here
	li $t5, 0 #initialized count of valid characters #reverted
	li $t6, 0 #initialized zero
	li $t7, 48 #lowest possible valid character ascii
	li $t8, 57 #hightest possible non-letter digit ascii
	li $t9, 65 #lowest possible capital letter ascii
	li $s0, 89 #highest possible capital letter ascii # =Y since N = 35
	li $s1, 97 #lowest possible common letter ascii 
	li $s2, 121 #highest possible common letter ascii = y since N = 35
	li $a3, 0 #to sum all the digits  #changed to a3 so that I can pass this to function
	li $s5, 0x0A #initialized a new line
	
	loop: 
		bgt $t5, $t1, print_invalid_input	#if number of valid characters is greater than 4 then print invalid output	
		lb $t4, 0($t0)  #gets a character of the string
		beq $t5, $t6, leading_characters  #branch if character could be considered leading
		beq $t4, $t2, skip_trailing_tab_or_space #branches if leading character is equal to a space
		beq $t4, $t3, skip_trailing_tab_or_space #branches if leading character is equal to a tab
		beq $t4, $s5, valid_input #branches if a newline comes before a invalid character is entered
		
	check_if_invalid:
		blt $t4, $t7, print_invalid_input #breaks if ascii of character is < 48
		bgt $t4, $t8, not_a_digit #breaks if ascii of character is > 57
		addi $t4, $t4, -48 #makes the ascii for digit align with digits
		sb $t4, 0($s4) #stores the character in a new string 
		addi $s4, $s4, 1 #increments the address of the new array
		addi $t0, $t0, 1 #increments the address of the input string
		addi $t5, $t5, 1 #increments the amount of valid characters
		j loop
	
	
	print_invalid_input:
	li $v0, 4
	la $a0, invalid_input #prints "Invalid Input"
	syscall
	
	li $v0, 10
	syscall  #tell the system this is the end of file 
	
	leading_characters:
	beq $t4, $t2, skip_leading_tab_or_space #branches if leading character is equal to a space
	beq $t4, $t3, skip_leading_tab_or_space #branches if leading character is equal to a tab
	j check_if_invalid #if they are not tab or spaces then return to loop
	
	
	
	skip_leading_tab_or_space: #skips character and goes to the next one
	addi $t0, $t0, 1 
	j loop
	
	not_a_digit:
	blt $t4, $t9, print_invalid_input #breaks if ascii of character is < 65
	bgt $t4, $s0, not_a_capital_letter #breaks if ascii of character is > 89
	addi $t4, $t4, -55 #makes the ascii for digit align with capital letters
	sb $t4, 0($s4) #stores the character in a new string
	addi $s4, $s4, 1 #increments the address of the new array
	addi $t0, $t0, 1 #increments the address of the input string
	addi $t5, $t5, 1 #increments the amount of valid characters
	j loop
	
	not_a_capital_letter:
	blt $t4, $s1, print_invalid_input #breaks if ascii of character is < 97
	bgt $t4, $s2, print_invalid_input #breaks if ascii of character is > 121
	addi $t4, $t4, -87 #makes the ascii for digit align with common letters
	sb $t4, 0($s4) #stores the character in a new string
	addi $s4, $s4, 1 #increments the address of the new array
	addi $t0, $t0, 1 #increments the address of the input string
	addi $t5, $t5, 1 #increments the amount of valid characters
	j loop
	
	skip_trailing_tab_or_space:  #fucntion for checking if the rest of the code is all trailing tabs or spaces
	addi $t0, $t0, 1 #move to the next byte
	lb $t4, 0($t0)  #gets a character of the string
	beq $t4, $s5, valid_input #branches if only trailing tabs are spaces are found before newline
	bne $t4, $t2, not_a_space #branches if character is not a space
	j skip_trailing_tab_or_space #returns to check next character for trailing tab or space
	
	not_a_space:
	bne $t4, $t3, print_invalid_input #if character after space for trailing is not a tab or space then print invalid
	j skip_trailing_tab_or_space #returns to check the next character for trailing tab or space
	
	valid_input:
	li $a0, 35 #initialized the base number
	jal calculateBaseTen #subprogram to calculate the decimal number
	add $a1, $zero, $s4
	sub $a1, $a1, $t5
	li $v0, 10
	syscall  #tell the system this is the end of file
	
	calculateBaseTen:
	li $t6, 1
	li $t7, 2
	li $t8, 3
	li $t9, 4
	beq $a1, $t9,four_valid_chars #branch if there are 4 characters
	beq $a1, $t8,three_valid_chars #branch if there are 3 characters
	beq $a1, $t7,two_valid_chars #branch if there are 2 valid characters
	beq $a1, $t6,one_valid_char #branch if there is one valid character
	jr $ra
	
	four_valid_chars:
	li $t9, 42875
	lb $t2, 0($a1) #load the first character of the valid numbers
	multu $t9, $t2 #multiplying the character by the base number to a specific power
	mflo $t9 #moves the answer to a register
	add $a3, $a3, $t9 #adds it to the total sum
	addi $a1, $a1, 1 #increment the character
	j three_valid_chars
	
	three_valid_chars:
	li $t8, 1225
	lb $t2, 0($a1) #load the first character of the valid numbers
	multu $t8, $t2 #multiplying the character by the base number to a specific power
	mflo $t8 #moves the answer to a register
	add $a3, $a3, $t8 #adds it to the total sum
	addi $a1, $a1, 1 #increment the character
	j two_valid_chars
	
	
	
	
	
