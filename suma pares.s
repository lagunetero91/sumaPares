			.data
fraseini:	.asciiz "Introduzca los 15 elementos del vector uno a uno\n"	
frasefin:	.asciiz "La suma de los elementos pares o en posicion par es: "
#vector:		.word 9, 2, 4, 3, 1, 5, 8, 3, 5, 7, 8, 5, 6, 6, 8
vector:	.space 60
sumapar:	.space 4
sumaotros:	.space 4
			.text
main:		add $t0,$0,$0	#Suma pares
			add $t1,$0,$0	#Suma otros
			add $t2,$0,$0	#Comtador para recorrer el vector
			add $t6,$0,$0	# contador de 4 en 4 para palabra
			add $t3,$0,$0	#donde cargamos elementos de vector
			addi $s0,$0,15  #Limite buclela $a0,fraseini
			la $a0,fraseini	#Mostramos primer mensaje
			li $v0,4
			syscall
seguir:		addi $t2,$t2,1	
			li $v0,5		#Recibimos un dato por pontalla
			syscall
			sw $v0,vector($t6)	#Lo guardamos en memoria
			addi $t6,$t6,4
			bne $t2,$s0,seguir
			
			add $t2,$0,$0	#reinicializamos los contadores
			add $t6,$0,$0	
			
para:		beq $t2,$s0,fin
			lw $t3,vector($t6)	#Carga elemento del vector
			addi $t6,$t6,4
			andi $t5, $t2, 1
			beq $t5,$0,par		#Comprobamos posicion par
			andi $t4, $t3, 1
			beq $t4,$0,par		#Comprobamos elemento par
			add $t1,$t1, $t3	#Suma impares
			addi $t2,$t2,1		
			j para
par:		add $t0,$t0,$t3		#Suma de pares
			addi $t2,$t2,1
			j para
fin:		sw $t0,sumapar($0)	#Guardamos los resultados en memoria
			sw $t1,sumaotros($0)
			la $a0,frasefin		# Mostramos mensaje mas valor suma de pares
			li $v0,4
			syscall
			add $a0,$t0,$0
			li $v0,1
			syscall
			jr $ra