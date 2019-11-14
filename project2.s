# Chadille Jones 
# ID: @02856918
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
	
	loop: 
		bgt $t5, $t1, print_invalid_output	#if number of valid characters is greater than 4 then print invalid output	
		lb $t4, 0($t0)  #gets a character of the string
		
	print_invalid_output:
	li $v0, 4
	la $a0, invalid_input #prints "Invalid Output"
	syscall
	
	li $v0, 10
	syscall  #tell the system this is the end of file 
	
	
	
	