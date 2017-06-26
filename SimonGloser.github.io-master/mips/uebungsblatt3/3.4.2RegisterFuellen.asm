
	add	$8, $0, $0		#$8 = 0 + 0
	addi	$9, $0, 11		#$9 = 0 + 11
	addi 	$10, $0, 0x1000		#$10 = 0 + 0x1000
	addi 	$11, $0, -1		#$11 = 0 + -1
	addi	$12, $0, -0x8000	#$12 = 0 # -0x8000
	ori 	$13, $0, 0x8000		#$13 = 0 + 0x8000
	ori	$14, $0, 0x0000		#$14 = 0 + 0x0000 hinterer Teil von ffff0000
	lui	$14, 0xffff		#$14 =  vorderer Teil von ffff0000
	ori	$15, $0, 0xffff		#$15 = hinterer Teil von 7fffffff
	lui	$15, 0x7fff		#$15 = vorderer Teil von 7fff
	addi	$24, $0, 5322		#$24 = 0 + 5322
	addi	$25, $0, 75		#$25 = 0 + 75
	
	
################################	ab hier Aufgabe 3.4.3 	######################################
	
	add $2, $10, $9			#$2 = $10 + $9
	sub $2, $10, $9			#$2 = $10 - $9
	
	# $10 + not($9) + 1
	addi $18 , $0, 15			# dmit im register 1111 steht
	xor $16, $9, $18			#$16 = not($9)
	addi $17, $16, 1			#$17 = $16 + 1 
	add $2, $17, $10 			#$2 = $16 + $10
	
	
	# $13 << 5
	sll $2, $13, 5			# 5 Stellen nach links schiften
	
	# $13 >> 5 arthimetisch
	sra $2, $13, 5                  # 5 stellen nach rechts arithmetisch
	# f $12 >> 5 arithmetisch
	sra $2, $12, 5
	
	#g $12 >> 5 logical
	srl $2, $12, 5
	#h $13 >> $9 logical
	srlv $2, $13, $9 
	
	#i $24 / $25
	div  $24, $25		# ertmal in hi und lo
	mfhi $2
	mflo $3
	
	#j $15 +1 unsigned
	addiu  $2, $15, 1
	
	#k $15 + 1 signed
	addi $2, $15, 1		
	
	#l count leading 1s von $11
	clo $2, $11
	#m count leading 1s von $14
	clo $2, $14
	
.data
 .byte 0xa0 #a)
 .half 0xb1b0 #b)
 .word 0xc3c2c1c0 #c)
 .ascii "Das Ende"	
	
	
	
	
####################################	Programm Ende 	###############################################	
	


 


