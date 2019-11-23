.data
	# For Print
	stringLogUser: .asciiz "Please Enter Staff Username: "
	stringLogPass: .asciiz "Please Enter Staff Password: "
	stringUserMatch:	.asciiz "User Match"
	stringUserUnmatch:.asciiz "User Not Match"
	stringPassMatch:	.asciiz "Password Match"
	stringPassUnmatch:.asciiz "Password Not Match"
	stringNewLine: .asciiz "\n"
	stringDoubleNewLine: .asciiz "\n\n"
	stringOptionList: .asciiz "\n\nCar Rental System \n--------------------------------- \nPress a button to continue: \n\n1)Reserved Cars \n2)Collected Cars \n3)Returned Cars \n4) Display All Car \n5)Exit"
	                   
	
		
	# For Validation
	logUserAuth:	.asciiz "staff\n"
	logPassAuth:	.asciiz "abc123\n"
	
	# For Input
	user1: .space 20
	pass1: .space 20
	
.text

.globl main

main:

	# test

	while:
	bge $s0, 1, passCont
		
		# Print logUser
	li $v0,4
	la $a0,stringLogUser
	syscall

	li $v0,8
	la $a0,user1
	li $a1 ,20
	syscall

	# Validate Username
	la $a0,logUserAuth
	la $a1,user1
	jal userEqual

	# Print LogPass
	li $v0,4
	la $a0,stringLogPass
	syscall
	
	li $v0,8
	la $a0,pass1
	li $a1 ,20
	syscall
	
	# Validate Password 
	la $a0,logPassAuth 
	la $a1,pass1
	jal passEqual

	jal printNewLine
		
	#Print Validation Result
	bne $s0, 1, userNotMatch

	li $v0,4
	la $a0,stringUserMatch
	syscall
	
	afterUserNotMatch:
	
	jal printNewLine
			
	j while
		
	# test
	
	afterUserAuth:
			
	# Print LogPass
	li $v0,4
	la $a0,stringOptionList
	syscall

	
	j exit
	
passCont:

	bne $s1, 1, passNotMatch

	li $v0,4
	la $a0,stringPassMatch
	syscall
	
	j afterUserAuth


# Prints a new Line
printNewLine:
	li $v0, 4
	la $a0, stringNewLine
	syscall
	j endfunction

# Prints a double Line
printDoubleNewLine:
	li $v0, 4
	la $a0, stringDoubleNewLine
	syscall
	j endfunction

# Print User not match
userNotMatch:
	li $v0,4
	la $a0,stringUserUnmatch
	syscall
	j afterUserNotMatch
	

	
	
# Print Pass not match
passNotMatch:
	li $v0,4
	la $a0,stringPassUnmatch
	syscall
	
	la $s0, 0 
	la $s1, 0
	
	jal printDoubleNewLine
	
	j while

# Exit Program
exit:
	li $v0,10
	syscall


	

# Function Validate Username
userEqual:
validateUser:
	lb $t0($a0)  #load a byte from each string
	lb $t1($a1)
	beqz $t0,checkUser #str1 end
	beqz $t1,userMissmatch
	slt $t5,$t0,$t1 #compare two bytes
	bnez $t5,userMissmatch
	addi $a0,$a0,1  #t1 points to the next byte of str1
	addi $a1,$a1,1
	j validateUser


userMissmatch: 
	la $s0, 0
	j endfunction


checkUser:
	bnez $t1,userMissmatch
	la $s0, 1




passEqual:
validatePass:
	lb $t0($a0)  #load a byte from each string
	lb $t1($a1)
	beqz $t0,checkPass #str1 end
	beqz $t1,passMissmatch
	slt $t5,$t0,$t1 #compare two bytes
	bnez $t5,passMissmatch
	addi $a0,$a0,1  #t1 points to the next byte of str1
	addi $a1,$a1,1
	j validatePass

passMissmatch: 
	la $s1, 0
	j endfunction


checkPass:
	bnez $t1,passMissmatch
	la $s1, 1

# Function Validate Password


	



endfunction:
	jr $ra
