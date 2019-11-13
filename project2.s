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
	