.data
cad1: 		.asciiz "\n  Fin de las 3 iteraciones!"
newline: 	.asciiz "\n"
esp: 		.asciiz " "
	.globl __start
			.text
	
__start:
	li $a0,0			# cargamos 0 en a0
	li $a1,3			# cargamos 3 en a1 para utilizarlo para comparar
	
reiniciar:        
	seq $t0,$a0,$a1		# si a0 es 3 (a1), establece 1 en t0
	bgtz $t0,end		# si t0 es mayor que 0, salta a end

	jal rutina			# JAL, salta a rutina
	add $a0,$a0,1		# suma 1 a a0
	j reiniciar			# saltamos a reiniciar

rutina:	                       
	subu $sp,$sp, 8		# hacemos hueco en la pila para 8 bytes
	sw  $a0,4($sp)		# cargamos a0 en pila
	sw  $31,0($sp)		# cargamos return adress en pila
	li $a0,30			# cargamos 30 en a0, empezando rutina_a

repetirrutina:              
	seq $t0,$a0,41		# set if equal, establecemos t0 si a0=41
	bgtz $t0,return		# si t0 es mayor que 0, salta a return
	jal put_int			# JAL, salta a put_int
	add $a0,$a0,1		# suma a0=a0+1
	j repetirrutina		# salta a repetir rutina
	
put_int:		
	li $v0,1			# escribe entero
	syscall				# llamada al sistema
	jr $31				# vuelve a la rutina anterior

return:		           
	lw $a0,4($sp)		# cargamos de pila a0
	lw $31,0($sp)		# cargamos de pila la return adress
	add $sp,$sp,8		# Deshacemos el hueco que hemos utiizado en la pila moviendo el puntero 8 posiciones arriba
	jr $31				# volvemos a la rutina anterior
	
end:	
	la $a0,cad1			# cargamos cad_1 para mostrarla por pantalla
	li $v0,4			# escribe cadena de texto
	syscall				# llamada al sistema
	li $v0,10			# cargamos 10 en v0 para terminar el programa
	syscall 			# llamada al sistema