.data

	str1: .asciiz "Lager"
	str2: .asciiz "Regal"
	str3: .space  10
	.byte  0xff
	.byte  0xff
	
.text
######################################################################################################################
# heir fängt die main an
main:	
	la  $t2, str1		#string zum aufrufen wird geladen
	#jal strtolower		#die Subroutine zum umwandeln in kleinbuchstaben wird gestartet
	#jal strturnaround	# turn around wird aufgerufen
	#jal strispalindrom 	# check ob palindrom
	la $t0, str1		# die Adresse des ersten Strings wird in $t0 geladen
	la $t1, str2		# die Adresse des zweiten Strings wird in $t1 geladen
	jal strcat
	j progende		# sprung zum programmende
	
	
#########################################################################################################	
#	diese Methode "klebt" zwei String aneinander
	# $t0 str1 erster String 
	# $t1 str2 zweiter String 
	# $t2 Zählervariable
	# $t3 Arbeitsverzeichnis 
	# $s0 speicher der am ende beide strings enthält
strcat:
	li $t2, 0 	#die Zählervariable wird initialisiert
	la $s0, str3	# der Speicher wird in $s2 geladen
	
	
	#jetzt wird der erste Buchstabe geladen
nextChar:	
	lb $t3, ($t0)		# ein Buchstabe wird ins Arbeitsregister geladen
	
	# jetzt wird erstaml geprüft, ob das Wort zuende ist
	beqz $t3, naechsterString  # falls 0 gefunden wird ist der string fertig und es muss mit dem
				   # nächsten String begonnen werde
	sb $t3, ($s0)		# Buchstabe wird abgespeichert
	
	addi $t0, $t0, 1	#Zählervariable um 1 erhöht
	addi $s0, $s0, 1	#speicher um 1 erhöht
	j nextChar
	
				   
naechsterString:
	li $t2, 0 		# die Zählervariable wird erneut auf 0 gesetzt
nextChar2:	
	lb $t3, ($t1)	# ein Buchstabe wird in das Arbeitsverzeichnis geladen
	beqz $t3, subroutineFertig	#wenn das Arbeitsverzeichnis 0 ist, dann ist die subroutine fertig 				   	
	
	sb $t3, ($s0)	# Buchstabe wird in der Speicher geladen
	
	addi $t1, $t1, 1 	# string wird um 1 erhöht
	addi $s0, $s0, 1	#Speicher wird um 1 erhöht
	j nextChar2
	
subroutineFertig:
	jr $ra	# Programm fertig	
#########################################################################################################
strispalindrom:
		la $s2, ($t2) 	# adresse wird geladen
		li $t1, 0	# zähler wird initialisiert
		la $t3, str3 ($t1)   # cpace wird in $t3 geladen
speichern:	lb $t4, ($s2)	# erster Buchstabe wird in $t4 geladen
		#überpüfung ob $t4 = 0 ist bedeutet wort ist zuende
		beqz $t4, startcheck
		# buchstabe in speicher schreiben
		sb $t4, str3($t1)	# buchstabe wird in speicher geladen
		addi $s2, $s2, 1	#speicher wird um 1 erhöht
		addi $t1 $t1, 1		# zähler wird um 1 erhöht
		j speichern
		
startcheck:
		la $s2, ($t2) 	# adresse wird geladen
check:		subi $t1, $t1, 1 #zähler wird um 1 verringert
		
		lb $t4, ($s2)	# erster Buchstabe wird in $t4 geladen
		beqz $t4 checkright
		lb $t5, str3($t1) # erster Buchstabe vom speicher wird in $t5 geladen
		addi $s2, $s2, 1 # stringspeicher wird um 1 erhöht
		#jetzt müssen $t4 und $t5 auf gleichheit geprüft werde
		beq $t5, $t4, check
		bne $t5, $t4, checkfalse
		
checkfalse:	li $3, 0
		jr $ra 
		
checkright:	li $3,1
		jr $ra 	
		
				
#########################################################################################################		
strturnaround:
		#erstmal muss die die adresse vom string geladen werden
		la $s2, ($t2) 	# adresse wird geladen
		#space muss geladen werden
		li $t1, 0	# zähler wird initialisiert
		la $t3, str3 ($t1)   # cpace wird in $t3 geladen
		
		
		
turnanfang:	
		lb $t4, ($s2)	# erster Buchstabe wird in $t4 geladen
		#überpüfung ob $t4 = 0 ist bedeutet wort ist zuende
		beqz $t4, umdrehen
		# buchstabe in speicher schreiben
		sb $t4, ($t3)	# buchstabe wird in speicher geladen
		# jetzt muss de String adresse um 1 erhöht werden
		addi $s2, $s2, 1 # srtingspeicher wurde um 1 erhöht
		addi $t3, $t3, 1 # space wird um 1 erhöht
		addi $t1, $t1, 1 # zähler wird um 1 erhöht
		j turnanfang
			
umdrehen:
			# das umdrehen muss nafangen
			subi $t1, $t1, 1 #zähler wird um 1 verringert
			la $s2, ($t2) #adresse wird neu geladen
weiterumdrehen:		lb $t4, str3($t1) 	# letzer Buchstabe wird in $t1 geladen
			beqz $t4, zuruck
			#jetzt muss der Buchstabe abgespeichert werde
			sb $t4, ($s2) #hinterer Buchstabe wird in vorderen string gespeichert
			subi $t1, $t1, 1 # zähler wird um 1 verringert
			addi $s2, $s2, 1 # srtingspeicher wurde um 1 erhöht
			j weiterumdrehen
		
zuruck:			jr $ra	#routine beenden		
		
#########################################################################################################
strtolower:
		li $s1, 97		# der kleinste dezimalwert wird zum vergleichen gespeichert
		li $t1, 0		# initielisierung einer Zählvarianlen
		la $s2, ($t2)		# holt sich aus dem übergabe verzeichnis den string
		
		
		
	
start:		
		lb $t3, ($s2)	# lädt den buchstabe von string mit der zählvariable
		beqz $t3, end		# wenn leer bzw 0 dann programm beenden ende
		blt $t3, $s1, makelower	# wenn kleiner als 97 dann muss großbuchstabe sein
		addi $s2, $s2, 1	# Speicheradresse wird um 1 erhöht
		bge $t3, $s1, start	# wurde kleinbuchstabe gefunden weiter mit start

makelower:	
		sub $t3, $t3, -32	#buchstabe wird verkleinert
		sb  $t3, ($s2)		#buchstabe wird abgespeichert
		addi $s2, $s2, 1	# speicheradresse wird ums 1 erhöht
		j	start			
end:		jr $ra			# ende von strtolower es geht weiter in der main nach dem aufruf von strtolower


progende:
		li $2, 10 	#Servicenummer zum programm beenden
		syscall



