# David Bacon
# Homework 1
# Section 203, Mon: 3:30-6:30

.data
        #Reserve space for three null terminated strings for prompt messages.
        
	promptx: .asciiz "Please enter an x integer:\n"
	prompty: .asciiz "Please enter an y integer:\n"
        summessage: .asciiz "Your sum is: "
        
        #Reserve space for two integers, x and y where we will store user input.
	
	x: .word 0
	y: .word 0

.text

	Main:
	
	#Print prompt x.
	
	li $v0, 4
	la $a0,promptx
	syscall
	
	#Take in the x integer.
	
	li $v0, 5
	syscall
	
	move $t0, $v0
	sw $t0, x
	
	
	
	#Print prompt y.
	
	li $v0, 4
	la $a0,prompty
	syscall
	
	#Take in the y integer.
	
	li $v0, 5
	syscall
	
	move $t0, $v0
	sw $t0, y 
	
	
	
	#Load X and Y in temporary registers $t8 and $t9
	
	lw $t8, x
	lw $t9, y
	
	
	# Go to sum function return from it and print sum with an output message.
	
	li $v0, 4
	la $a0,summessage
	syscall
	
	jal Sum
	
	
	#Take the value from $a0 and print it.
	
	li $v0, 1
	syscall
	
	#Main function finish.
	
	li $v0, 10
	syscall
	
	
	#A function which adds the values found in $t8 and $t9 puts then in $a0 and returns to main
	
	Sum:	
	
	
	
	add, $a0, $t8, $t9
	
	
	
	jr $ra
	
	
	
	
	
	
	
	
	

	
	 
