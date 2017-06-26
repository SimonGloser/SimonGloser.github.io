# Übungsblatt 6 Das Programm soll einen String einlesen und dann ein bestimmtes Zeichen zählen


.data

	str1: 	.asciiz "Bitte String eingeben:"
	str2:   .asciiz "Bitte Buchstaben eingeben: "
	space:	.space	10
	strResult: .asciiz "Ergebnis:"
	str3: .asciiz "Noch einen String?"
	
.text
################################################################################################# 
main:
	jal ncstr
	
	j end
##################	Sequnez zum einlesen eines Strings	#################################

# funktion zum Zählen von Zeichen
ncstr:
	la $a0, str1	# aufforderungsstring in $a0
	li $v0, 4
	syscall
	
	la $a0, space
	li $a1, 10
	
	li $v0, 8
	syscall
#################	Sequenz zum einlesen des char	############################################
	
	la $a0, str2	# aufforderungsstring in $a0
	li $v0, 4
	syscall
	
	
	
	
	li $v0, 12
	syscall
	move $t1, $v0
	
	#zählen
	li $t3, 0		#zähler wird initialisiert
	la $t0, space		# string wird geladen in $t0
	
	
charZaehlen:
	
	lb $t2, ($t0)			#check ob die Buchstaben gleich sind
	beqz $t2, fertig
	beq $t2, $t1, gleich		#wenn gleich ist weiter bei gleich
	addi $t0, $t0, 1		# Speicher wird um 1 erhöht
	j charZaehlen
	
################################################	
gleich:
	addi $t3, $t3, 1	#zähler wird um 1 erhöht
	addi $t0, $t0, 1	# Speicher wird um 1 erhöht
	j charZaehlen
################################################
fertig:
	move $s0, $t3		# ergebnis wird in $s0 gespeichert
	la $a0, strResult	# print "Ergebnis:"
	li $v0, 4
	syscall
	
	move $a0, $s0
	li $v0,1
	syscall
	
	la $a0, str3	# print "Noch ein string?"
	li $v0, 4
	syscall
	
	li $v0, 50
	syscall
	
	
	beqz $a0, ncstr
	
	jr $ra
####################################################################################################





end:
	li	$v0, 10		# system call code for exit = 10
	syscall				# call operating sys