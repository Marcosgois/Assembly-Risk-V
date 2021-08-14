
.data

	vector: 	.word   0x10040000		# endereco do vetor
    
.text
    jal     loadAddr                    # jump to loadAddr
    la      a1, vector                  # load address of "vector" in a1       
    li      t1, 11                      # t1 = value for iterations   
    sw      t1, 0(a1)                   # First position in vector is t1 ( 10 )
    addi    a1, a1, 4                   # t0 = t1 + imm
    
    mv      t0, t1                      # load the first value for iterations

 readInput:       
    li      a7, 5                       # service 5 is read an int from input console
    ecall                               # syscall
    addi    t0, t0, -1                  # (--t0) -> t0 = t0 + (-1)imm
    
    
printV:
    jal     loadAddr                    # jump to loadAddr
    la      a1, vector                  # load address of "vector" in a1    
    li      t1, 2                       # load 2 to get the double of the number in input
    mul     a0, a0, t1                  # load desired value into argument register a0, using pseudo-op
    li      a7, 1                       # service 1 is print integer in a0
    ecall                               # syscall
exit:                                   
    beq     t0, zero, readInput         # if t0 == 0 then jump to sortList
    li      a7, 10                      # Exits the program with code 0
    ecall
loadAddr:
    la      a1, vector                  # load address of "vector" in a1
    jr      ra                          # jump to ra