# Programm zum ermitteln des ggT diesmal ohne die Pseudoinstuktions
.text
	# erstes Zahlenpaar in die Register $4 und $5 laden
	addi $4, $zero,  30		#Für die Zahlen 30 und 25 sollen der ggT ermittelt werden
	addi $5, $zero, 25
	j	 findggT			# Die soubroutine wird nun aufgerufen
	
findggT:
	add $2, $zero, $5		# im $2 steht später der ggT vorläufig wird aber das Register $5 dort hineingeladen
	
	beq $4, $zero, ten			#(4)	if $4 == 0 goto ten
five:	beq $5, $zero, nine 		#(5)	if $5 == 0 goto nine
	slt $t1, $5, $4			# hier wird verglichen, ob $5 < $4 if true $t1 = 1
	bne $t1, $zero, six
#bgt ersetzen
	#bgt $4, $5, six 			#(6)	if $4 > $5 goTo six

	sub $5, $5, $4 		#(7)	else $5 = $5 - $4
	j five


six:
	sub $4, $4, $5  		# $4 = $4 - $5
	j five

nine:	
	add $2, $zero, $4		#(9) $2 <-- $4

ten:		j	ten		#(10)zum Programmende springen
