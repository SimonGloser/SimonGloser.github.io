#Uebungsblatt 7 
# Autor: Simon Gloser
# Datum: 09.07.2017
# Das Programm soll realisiert eine C-Funktion, die
# zwei int Zahlen einliest den Bruch in reduzierter Darstellung ausgibt ( Also einfach gekuezt )
# und dann noch den ggT der beiden zahlen ausgibt.


.data 
	newLine: .asciiz "\n"		# macht einen Zeilenumbruch (kann durchaus mal nuetzlich sein
	zaehler: .asciiz "Zaehler>"
	nenner:  .asciiz "Nenner>"
	redPrompt: .asciiz "Reduzierte Darstellung "
	testausgabe: .asciiz "hat geklappt"
	bruch:	.asciiz	" / "
	ggt: .asciiz " ggt "
	nochmal: .asciiz "weitere Berechnung ?"
	z1:   .word 0
	n1:   .word 0
	

###################################################################################################
#
# main
#
###################################################################################################
.text

main:	


	la $a0, zaehler		# print("zahler>");
	li $v0, 4
	syscall
	
	li $v0, 5		# read int
	syscall
	
	move $s0, $v0 	# erster int wird in $s0 gespeichert
	
	la $a0, nenner		# print("nenner>");
	li $v0, 4
	syscall
	
	li $v0, 5		# read int
	syscall
	
	move $s1, $v0 	# zweiter int wird in $s1 gespeichert
	
	la $a2, z1
	la $a3, n1
	
	
	# Sequenz zum aufrufen der reduce_fraction
	move $a0, $s0
	move $a1, $s1	# werte werden übergeben
	jal reduce_fraction
	
	
	la $a0, newLine		# print("\n");
	li $v0, 4
	syscall
	
	la $a0, nochmal	# print("witer berechnung ?");
	li $v0, 4
	syscall
	
	li $v0, 50
	syscall
	
	beqz $a0, main
	
	j end
	
	
###############################################################
#
# Anfang reduce_fraction
#
# Registerlegende:
#	$t1  Speichert das Argument von $a0
#	$t2  Speichert das Argument von $a1
#	$t3  speichert ggT der beiden eingegebenen Int
#	$t4  ergebins $a0 / ggT
#	$t5  ergebnis $a1 / ggT
###############################################################	
reduce_fraction:
	# sichern der argumente
	move $t0, $a0	# Sichern der eingegebenen werte
	move $t1, $a1
	
	
	addi $sp, $sp, -4	# ein Platz auf dem stack wird resaviert
	sw    $ra, 0($sp)
	jal euklid
	
	
	move $t3, $v0	# speichert den ggt aus der Euklid subroutine
	
	#anfang des ausgabedialogs
	la $a0, redPrompt	# print("Reduzierte Darstellung ");
	li $v0, 4
	syscall
	
	div $t0, $t3	# teilte erste zahl/ ggT
	mflo $t4
	
	div $t1, $t3	# zweite Zahl / ggT
	mflo $t5
	
	# print erste Zahl reduziert
	move $a0, $t4
	li $v0, 1
	syscall
	
	la $a0, bruch	# print(" / ");
	li $v0, 4
	syscall
	
	# print zweite  Zahl reduziert
	move $a0, $t5
	li $v0, 1
	syscall
	
	la $a0, ggt	# print(" ggT ");
	li $v0, 4
	syscall
	
	# Print ggT
	move $a0, $t3
	li $v0, 1
	syscall
	
	
	lw $ra, 0($sp)

	jr 	$ra
###############################################################
#
# Ende reduce_fraction
#
###############################################################	
	
	
############################################################
# Euklid zum ggT ermitteln
#(1)  Zahl wird in r4 hinein geladen
#(2)  Zahl wird in r5 hinein geladen
#(3)  Werte von r5 wird in r2 geladen
#(4)  if(r4 == 0) goto (10)
#(5)  if(r5 == 0) goto (9)
#(6)  if(r4 > r5) r4 <-- r4 - r5
#(7)  else        r5 <-- r5 - r4
#(8)  goto (5)
#(9)  r2 <-- r4
#(10) goto (10)
###############################################################
euklid:		
	#la $2,($5)	# lädt Register 5 in Register 2 rein
	move $v0, $a1	
	beqz $a0,end10		# if (r4==0) go to labbel ten
five: 	beqz $a1,nine		# if (r5==0) go to labbel nine
	bgt  $a0, $a1, goto	# if (r4>r5)
	sub $a1, $a1, $a0 		# elese r5=r5-r4
	j five		#	 jump to labbel five

###############################################################
#Labbel goto
###############################################################
goto:
	subu $4,$4,$5	# Resister 4 = Resister 4 - Resister 5
	j five
###############################################################
#Labbel Nine
###############################################################
nine:
	move $v0, $a0	
	jr $ra		# jump to zurück
###############################################################
#Labbel end10
###############################################################
end10:
	jr $ra		# jump to zurück
	
###############################################################
# ende von euklid
###############################################################	

end:
