li  a7, 5           # service 5 is read an int from input console
ecall
li  t1, 2           # load 2 to get the double of the number in input
mul a0, a0, t1       # load desired value into argument register a0, using pseudo-op
li  a7, 1           # service 1 is print integer in a0
ecall
li  a7, 10           # Exits the program with code 0
ecall