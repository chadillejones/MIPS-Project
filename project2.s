# Chadille Jones 
# ID: @02856918
# 2856918 % 11 = 9 Base 35
.data  #Section to declare data
user_input: .space 2000
invalid_input: .asciiz "Invalid Input"

.text  #Assembly langugae instruction

main:

	li $v0, 8  #accepts user input
	la $a0, user_input
	syscall
	
	la $t0, user_input   #loads the address of the string
	li $t1, 4  #initialized the variable to check if number of characters is > 4
	li $t2, 32 #loaded a space here 
	li $t3, 9 #loaded a tab here
	li $t5, 0 #initialized count of valid characters 
	li $t6, 0 #initialized zero
	li $t7, 48 #lowest possible valid character ascii
	li $t8, 57 #hightest possible non-letter digit ascii
	li $t9, 65 #lowest possible capital letter ascii
	li $s0, 89 #highest possible capital letter ascii # =Y since N = 35
	li $s1, 97 #lowest possible common letter ascii 
	li $s2, 121 #highest possible common letter ascii = y since N = 35
	 
	
	loop: 
		bgt $t5, $t1, print_invalid_input	#if number of valid characters is greater than 4 then print invalid output	
		lb $t4, 0($t0)  #gets a character of the string
		beq $t5, $t6, leading_characters  #branch if character could be considered leading
		
	check_if_invalid:
		blt $t4, $t7, print_invalid_input #breaks if ascii of character is < 48
		bgt $t4, $t8, not_a_digit #breaks if ascii of character is > 57
		addi $t4, $t4, -48 #makes the ascii for digit align with digits
	
	
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
	
	not_a_capital_letter:
	blt $t4, $s1, print_invalid_input #breaks if ascii of character is < 97
	bgt $t4, $s2, print_invalid_input #breaks if ascii of character is > 121
	
	
	
	
	
	
	
	