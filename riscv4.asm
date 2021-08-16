
.data

	vector: 	.word   0x10040000		# endereco do vetor
    
.text
	jal     loadAddr                    # jump to loadAddr
	la      a1, vector                  # load address of "vector" in a1       
	li      t1, 10                      # t1 = value for iterations   
	sw      t1, 0(a1)                   # First position in vector is t1 ( 10 )
	addi    a1, a1, 4                   # a1 = a1 + 4
    
	mv      t0, t1                      # load the first value for iterations
	
	li      a7, 5                       # service 5 is read an int from input console
	ecall                               # syscall
	sw	    a0, (a1)			        # load input value to vector
	addi    a1, a1, 4                   # a1 = a1 + 4
	addi    t0, t0, -1                 	# (--t0) -> t0 = t0 + (-1)imm
	addi	t2, t2, 4			        # [index]

 readInput:       
 	ble     t0,zero, printV			    # jump if t0 (iterador) <= 0
	li      a7, 5                       # service 5 is read an int from input console
	ecall                               # syscall
	addi    t0, t0, -1                 	# (--t0) -> t0 = t0 + (-1)imm
	lw	    t1, -4(a1)			        # load the value of a1[index-1] in t1 to compare

	ble 	a0, t1, sort			    # if t2(a1[i]) <= a0 ? sort : continue
	sw	    a0, (a1)			        # load input value to vector
	addi    a1, a1, 4                   # a1 = a1 + 4
	addi	t2, t2, 4			        # [index]
	j	    readInput			        # return to readInput

sort:
	addi	t2, t2, -4			        # [index-4]
	sw	    a0, -4(a1)			        # [index-4]
	sw	    t1, (a1)			
	bge  	t2, zero, sort			    # if t2 >= 0 ? sort : continue
	j	    readInput
	
    
printV:
	jal     loadAddr                    # jump to loadAddr
	lw	    t0, (a1)			        # load vector size
	addi    a1, a1, 4                   # a1 = a1 + 4
pV:
	lw	    a0, (a1)			        # int to print
	li      a7, 1                       # service 1 is print integer in a0
	ecall                               # syscall
	
	addi    t0, t0, -1                 	# (--t0) -> t0 = t0 + (-1)imm
	ble 	t0, zero, exit			    # if t2(a1[i]) <= 0 ? sort : continue
	addi    a1, a1, 4                   # a1 = a1 + 4
	j	    pV                          # jump to pV

	
exit:           
	li      a7, 10                      # Exits the program with code 0
	ecall                               # syscall
	
loadAddr:
	la      a1, vector                  # load address of "vector" in a1
	jr      ra                          # jump to ra