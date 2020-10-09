.data
	message1: .asciiz "Type the numbers for matrix1\n"
	message2: .asciiz "Type the numbers for matrix2\n"
	message3: .asciiz "The root mean square is\n"
	.align 2
	matrix1: .space 36
	matrix2: .space 36
	rootmeansquare: .double 0.0
	size: .double 9.0
.text
	 main:
		li $t0,0                    # index for matrix
		
		matrixNumbers1:             # Loop for input of numbers for first matrix
			
			li $v0,4
			la $a0,message1
			syscall
			li $v0,5
			syscall
			move $t1,$v0
			sw $t1,matrix1($t0)
			add $t0,$t0,4
			blt $t0,36,matrixNumbers1
		
		li $t0,0
		
		matrixNumbers2:	             # Loop for input of numbers for second matrix
			
			li $v0,4
			la $a0,message2
			syscall
			li $v0,5
			syscall
			move $t1,$v0
			sw $t1,matrix2($t0)
			addi $t0,$t0,4
			blt $t0,36,matrixNumbers2
		
		jal RootMeanSquare
        li $v0,3
		syscall
		li $v0,10
		syscall
			
			
	RootMeanSquare:                        # function to claculate root mean square
		li $t0,0
		li $t4,0
		ldc1 $f12,rootmeansquare
		ldc1 $f2,size
		
		while:
			beq $t0,36,exit
			lw $t1,matrix1($t0)
			lw $t2,matrix2($t0)
			sub $t3,$t1,$t2
			mul $t5,$t3,$t3
			add $t4,$t5,$t4
			addi $t0,$t0,4
			j while
		exit:
			mtc1.d $t4,$f12
           		cvt.d.w $f12,$f12
                        div.d $f12,$f12,$f2
                        sdc1 $f12,rootmeansquare
                        li $v0,4
                        la $a0,message3
                        syscall
                jr $ra	
			
			
		
