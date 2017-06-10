#################################################################
#
# MIPS Progamm euklidischer Algorithmus Aufgabenblatt4
#
#################################################################
#################################################################
# Auflistung der Zahlenpaare Aufgabe b und der Unterprogramme jal
#################################################################
li $4,25
li $5,35
 jal programm

li $4,210
li $5,28
 jal programm

li $4,49
li $5,42
 jal programm

li $4,17
li $5,3
 jal programm

li $4,17
li $5,51
 jal programm
j end

############################################################
# MIPS Code soll so aussehen
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
programm:		
	la $2,($5)	# lädt Register 5 in Register 2 rein

	beqz $4,end10	# if (r4==0) go to labbel ten
five: 	beqz $5,nine	# if (r5==0) go to labbel nine
	bgt  $4,$5,goto	# if (r4>r5)
	subu $5,$5,$4 	# elese r5=r5-r4
	j five		# jump to labbel five

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
	la $2,($4)	# lädt Register 4 in Register 2 rein
	jr $ra		# jump to zurück
###############################################################
#Labbel end10
###############################################################
end10:
	jr $ra		# jump to zurück
###############################################################
#Ende des Programms 
###############################################################
end:

