# David Bacon 
# Homework 2
# Section 203, Mon: 3:30-6:30


.data

inBuf:		.space	80		# input line
outBuf: 	.space 	80		# char types for the input line

newline: .asciiz "\n"
prompt:	.asciiz	"Enter a new input line: \n"
endprompt: .asciiz "Would you like to end(y/n)?: \n"



Tabchar:.word  0x0a, 6		# LF
        .word 	' ', 5
        .word  '	',5 # I included tab so it could read the example input from the Homework file when copy and pasted.
 	.word 	'#', 6
	.word 	'$', 4
	.word 	'(', 4 
	.word 	')', 4 
	.word 	'*', 3 
	.word 	'+', 3 
	.word 	',', 4 
	.word 	'-', 3 
	.word 	'.', 4 
	.word 	'/', 3 

	.word 	'0', 1
	.word 	'1', 1 
	.word 	'2', 1 
	.word 	'3', 1 =
	.word 	'4', 1 
	.word 	'5', 1 
	.word 	'6', 1 
	.word 	'7', 1 
	.word 	'8', 1 
	.word 	'9', 1 

	.word 	':', 4 

	.word 	'A', 2
	.word 	'B', 2 
	.word 	'C', 2 
	.word 	'D', 2 
	.word 	'E', 2 
	.word 	'F', 2 
	.word 	'G', 2 
	.word 	'H', 2 
	.word 	'I', 2 
	.word 	'J', 2 
	.word 	'K', 2
	.word 	'L', 2 
	.word 	'M', 2 
	.word 	'N', 2 
	.word 	'O', 2 
	.word 	'P', 2 
	.word 	'Q', 2 
	.word 	'R', 2 
	.word 	'S', 2 
	.word 	'T', 2 
	.word 	'U', 2
	.word 	'V', 2 
	.word 	'W', 2 
	.word 	'X', 2 
	.word 	'Y', 2
	.word 	'Z', 2

	.word 	'a', 2 
	.word 	'b', 2 
	.word 	'c', 2 
	.word 	'd', 2 
	.word 	'e', 2 
	.word 	'f', 2 
	.word 	'g', 2 
	.word 	'h', 2 
	.word 	'i', 2 
	.word 	'j', 2 
	.word 	'k', 2
	.word 	'l', 2 
	.word 	'm', 2 
	.word 	'n', 2 
	.word 	'o', 2 
	.word 	'p', 2 
	.word 	'q', 2 
	.word 	'r', 2 
	.word 	's', 2 
	.word 	't', 2 
	.word 	'u', 2
	.word 	'v', 2 
	.word 	'w', 2 
	.word 	'x', 2 
	.word 	'y', 2
	.word 	'z', 2

	.word	0x5c, -1	# if you ‘\’ as the end-of-table symbol

.text

Main:
        
        #Call our two functions.
	jal getline
	jal lin_search
	
	


getline: 
	la	$a0, prompt		# Prompt to enter a new line
	li	$v0, 4
	syscall

	la	$a0, inBuf		# read a new line
	li	$a1, 80	
	li	$v0, 8
	syscall

	jr	$ra
	
lin_search:
        
     #Add the terminating value of 6 ie '#' to register $s2 so we know when to stop.
  
      addi $s2,$zero,6
     

       
        
loop:


       
       
       #Load a byte from the inBuf array into register $s0, using $t1 as a pointer to the address of the current character
       
       lb $t1,inBuf($s0)
       
       #Load a word from the Tabchar array into register $s1, using $t2 as a pointer to the address of the current integer.
       
       lw $t2,Tabchar($s1)
       
       #Check to see if the contents of $s0 and $s1 are equal, ie we have a character match. If so go to get_type.
       
       beq $t1,$t2,get_type
       
       #if not, jump back to loop and try again.After incrementing the tabChar pointer by 4 bytes to point to the next integer.
       
       addi $s1, $s1,4
       
       j loop
       
 
get_type:

    #increment the pointer for Tabchar by 4 bytes so we can store its type in the outBuf array after storing it in $t6.
    
    addi $s1,$s1,4
    lw $t6,Tabchar($s1)
    sw $t6, outBuf($s3)
    
  
    
 #Check to see whether the value is equal to 6 which we stored in $s2, in which case we are done and can move to print_array.
    
    beq $t6,$s2,print_array
    
    #otherwise we jump back to loop after incrementing the pointer for outBuf by 4 bytes for the next integer 
    #and reset tabChar's counter to zero. While also incrementing the pointer for the inBuf as well by 1 byte.
    
    addi $s0,$s0,1
    addi $s1,$zero,0
    addi $s3,$s3,4
    

    
    j loop
    
   
print_array:
    
    #add 4 bytes to $t4 so we print the final value of the array located at the last address.
    
    addi $s3,$s3,4
    
    
    while:
    
    #Use $t5 as a counter starting at zero and $t4, the size of the outbuf array, stored at register $t4 as a terminating condition.
    
    beq $s3,$t5,clearbuff
    
    #Load word from outBuf into $t7.
    
    lw $t7, outBuf($t5)
    
    #increment the counter for outBuf.
    
    addi $t5,$t5,4
    
    #Print the current integer.
    
    li $v0,1
    move $a0, $t7
    syscall 
     
     #Jump back to the while loop to see if we are done.
     j while 
       
clearbuff:
    
    
  #Reset all the counters we used for outbuf,inbuf,tabchar, and the while loop in print_array.
  
  addi $s0,$zero,0
  addi $s1,$zero,0
  addi $s3,$zero,0
  addi $t5,$zero,0
  
  #Reset all the memory addresses, as well as the other registers we used for tasks.
  
  addi $t1,$zero,0
  addi $t2,$zero,0
  addi $t6,$zero,0
  addi $t7,$zero,0
  
  
    
  #Print new line.
  
  li $v0, 4
  la $a0, newline
  syscall
  
  #Prompt the user if they wish to be done or go again.
  
    li $v0, 4
    la $a0, endprompt
    syscall
    
    #take in a y or an n.
    
    li $v0, 12
    syscall
	
    move $t0, $v0
    
    
  #Print new line.
  
  li $v0, 4
  la $a0, newline
  syscall
  
  li $t8,'y'
  
  #if y go to exit, if n go back to main.
  
  beq $t0,$t8,Exit
  
  
  j Main
  
  
 
  
 Exit: 
  
  #End program
  
  li $v0,10
  syscall
  
  

	
