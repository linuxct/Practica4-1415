.data

entero:		.asciiz "Introduzca un Entero: "
resultado:	.asciiz "El resultado de la ecuacion recursiva f(x) = [(x+1) + f(x-1)] es: "
	.text
	.globl __start

__start: 	
	la $a0,entero 		# carga entero para mostrarlo por pantalla
	li $v0,4 		# escribe cadena de texto
	syscall 		# impresión de cadena

	li $v0,5 		# lee entero de consola
	syscall 		# llamada al sistema

	add $a0,$v0,0 		# "movemos" de v0 a a0 
	add $a1,$a0,1		# b = a+1
	jal buc			# JAL, salta a Bucle

	add $t0,$v0,0		# "movemos" el resultado de v0 a t0
	la $a0,resultado	# carga resultado para mostrarlo por pantalla
	li $v0,4 		# escribe cadena de texto
	syscall 		# llamada al sistema

	add $a0,$t0,$0  	# "movemos" de t0 a a0
	li $v0,1 		# escribe entero
	syscall 		# llamada al sistema
	li $v0,10  		# Carga 10 en V0 para acabar el programa
	syscall 		# Fin del programa.

buc: 	subu $29, $29,8 	# hacemos hueco en la pila moviendo el puntero dos bytes
	sw $a0,4($29)		# guardamos a0 en pila
	sw $31,0($sp)		# guardamos la return adress en pila
	lw $v0,4($29) 		# lectura de v0 
	bgtz $v0,continue 	# si v0 es mayor que 0 salta a sigue
	addi $v0, $0, 0 	# cargamos 0 en v0
	j return 		# empezamos a volver hacia a tras en las recursiones

continue: 	
	lw $v1,4($29) 		# Cargamos n en v1 desde la pila
	addi $a0, $v1,-1 	# Guardamos n=n-1
	jal buc 		# JAL, salta a bucle
	lw $v1,4($29) 		# Cargamos n en v1 desde la pila
	add $v1,$v1,1		# Sumamos +1
	add $v0,$v0,$v1 	# Sumamos v0+v1 y lo guardamos en v0 

return: 	
	lw $31,0($29) 		# Cargamos la return adress desde la pila a $31
	addi $29,$29,8 		# Deshacemos el hueco que hemos utiizado en la pila moviendo el puntero 8 posiciones arriba
	j $31 			# volvemos a la rutina anterior
