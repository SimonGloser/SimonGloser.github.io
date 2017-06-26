# Rauch Übungsblatt4 Aufgabe1 Euglidischer algorthmus
#dieser Teil ist für den Aufgabenteil c

li $4, 30	
li $5, 25
 jal programm
 
li $4, 210	
li $5, 28
 jal programm
 
li $4, 49	
li $5, 42
 jal programm
 
li $4, 17	
li $5, 3
 jal programm
 
li $4, 17	
li $5, 51
 jal programm
 
 j end

programm:
	
la $2, ($5)	#(3)	# lädt Register $5 in Register $2

	beq $4, 0, ten	#(4)	if $4 == 0 goto ten
five:	beq $5, 0, nine #(5)	if $5 == 0 goto nine
	bgt $4, $5, six #(6)	if $4 > $5 goTo six

subu $5, $5, $4 #(7)	else $5 = $5 - $4
j five


six:
	subu $4, $4, $5  # $4 = $4 - $5
	j five

nine:	
	la $2, ($4)	#(9) $2 <-- $4
	jr $ra	#jump back

ten:		jr $ra #(10) #jump back


end: