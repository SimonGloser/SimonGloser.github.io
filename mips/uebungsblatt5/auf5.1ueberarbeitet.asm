.data

	str1: .asciiz "LAGER"
	str2: .asciiz "Regal"
	str3: .space  10
	.byte  0xff
	.byte  0xff
	
.text
######################################################################################################################
# heir fängt die main an
main:	
	la  $a0, str1		#string zum aufrufen wird geladen
	jal strtolower		#die Subroutine zum umwandeln in kleinbuchstaben wird gestartet
	#jal strturnaround	# turn around wird aufgerufen
	#jal strispalindrom 	# check ob palindrom
	#la $a0, str1		# die Adresse des ersten Strings wird in $t0 geladen
	#la $a1, str2		# die Adresse des zweiten Strings wird in $t1 geladen
	#jal strcat
	j progende		# sprung zum programmende
	
	
#########################################################################################################	
#	diese Methode "klebt" zwei String aneinander
	# $t0 str1 erster String 
	# $t1 str2 zweiter String 
	# $t2 Zählervariable
	# $t3 Arbeitsverzeichnis 
	# $t4 speicher der am ende beide strings enthält
########################################################################################################
strcat:
	li $t2, 0 	#die Zählervariable wird initialisiert
	la $t4, str3	# der Speicher wird in $s2 geladen
	la $t0, ($a0)	# der erste string wird in $t0 geladen
	la $t1, ($a1) 	# der zweite string wird in $t1 geladen
	
	#jetzt wird der erste Buchstabe geladen
nextChar:	
	lb $t3, ($t0)		# ein Buchstabe wird ins Arbeitsregister geladen
	
	# jetzt wird erstaml geprüft, ob das Wort zuende ist
	beqz $t3, naechsterString  # falls 0 gefunden wird ist der string fertig und es muss mit dem
				   # nächsten String begonnen werde
	sb $t3, ($s0)		# Buchstabe wird abgespeichert
	
	addi $t0, $t0, 1	# der erste string um 1 erhöht
	addi $t4, $t4, 1	#speicher um 1 erhöht
	j nextChar
	
				   
naechsterString:
	li $t2, 0 		# die Zählervariable wird erneut auf 0 gesetzt
nextChar2:	
	lb $t3, ($t1)	# ein Buchstabe wird in das Arbeitsverzeichnis geladen
	beqz $t3, subroutineFertig	#wenn das Arbeitsverzeichnis 0 ist, dann ist die subroutine fertig 				   	
	
	sb $t3, ($t4)	# Buchstabe wird in der Speicher geladen
	
	addi $t1, $t1, 1 	# string wird um 1 erhöht
	addi $t4, $t4, 1	#Speicher wird um 1 erhöht
	j nextChar2
	
subroutineFertig:
	jr $ra	# Programm fertig	
########################################################################################################
# 	Ende von strcat 	( Das war dei Subroutine, die zwei string aneinander "klebt" )
#########################################################################################################



#########################################################################################################
# 	strispalindrom 		( Anfang )
# 	diese Funktion bekommt einen string und prüft, ob es sich um einen string handelt
#	Registerverzeichnis
# 	$a0 		darin kommt der string an
#	$v0 		darin steht dann der return wert
# 	$t1		darin wird der space geladen	
#########################################################################################################

strispalindrom:
		#la $s2, ($t2) 	# adresse wird geladen
		#li $t1, 0	# zähler wird initialisiert			der zähler wird nicht gebraucht
		la $t1, str3    	# space wird in $t1 geladen
speichern:	lb $t4, ($a0)	# erster Buchstabe wird in $t4 geladen
		#überpüfung ob $t4 = 0 ist bedeutet wort ist zuende
		beqz $t4, startcheck
		# buchstabe in speicher schreiben
		sb $t4,  ($t1)	# buchstabe wird in speicher geladen
		#addi $s2, $s2, 1	#speicher wird um 1 erhöht
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
# 	Ende von strispalindrom ( hier wurde gechekt, ob es sich um ein palindrom handelt )
#########################################################################################################	

	
#########################################################################################################
# Anfang von strturnaraund 	(hier wird ein string umgedreht )
#	Registerlegende:
#	$a0 		enthält die Adresse des strings
#	$t0 		in $t0 wird die adresse vom string gespeichert weil wir das $a0 noch brauchen
#	$t1		zählervariable
#	$t2
#	$t3		enthält die Adresse vom space
# 	$t4 		enthält den aktuellen Buchstaben
#########################################################################################################	
strturnaround:
		#erstmal muss die die adresse vom string geladen werden
		la $t0, ($a0) 	# adresse wird geladen
		#space muss geladen werden
		li $t1, 0	# zähler wird initialisiert
		la $t3, str3 	   # cpace wird in $t3 geladen
		
		
		
turnanfang:	
		lb $t4, ($a0)	# erster Buchstabe wird in $t4 geladen
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
			la $t0, ($a0) #adresse wird neu geladen
weiterumdrehen:
			lb $t4, str3($t1) 	# letzer Buchstabe wird in $t1 geladen
			beqz $t4, zuruck
			#jetzt muss der Buchstabe abgespeichert werde
			sb $t4, ($t0) #hinterer Buchstabe wird in vorderen string gespeichert
			subi $t1, $t1, 1 # zähler wird um 1 verringert
			addi $t0, $t0, 1 # srtingspeicher wurde um 1 erhöht
			j weiterumdrehen
		
zuruck:			jr $ra	#routine beenden		
	
#########################################################################################################
# Ende von strturnaround
#########################################################################################################

			
				
					
							
#########################################################################################################
# 	Anfang von strtolower 	( diese funktion soll Großbuchstaben in kleinbuchstaben umwandeln )

# 	Resgister legende:
# 	$a0 hat die adresse des dtrings
# 	$t0 hat den kleinsten wert zum vergleichen
#	$t1 hat den aktuellen Buchstaben
#########################################################################################################  
strtolower:
		li $t0, 97		# der kleinste dezimalwert wird zum vergleichen gespeichert

start:		
		lb $t1, ($a0)	# lädt den buchstabe von string mit der zählvariable
		beqz $t1, end		# wenn leer bzw 0 dann programm beenden ende
		blt $t1, $t0, makelower	# wenn kleiner als 97 dann muss großbuchstabe sein
		addi $a0, $a0, 1	# Speicheradresse wird um 1 erhöht
		bge $t1, $t0, start	# wurde kleinbuchstabe gefunden weiter mit start

makelower:	
		sub $t1,  $t1,  -32	#buchstabe wird verkleinert
		sb  $t1, ($a0)		#buchstabe wird abgespeichert
		addi $a0,  $a0, 1	# speicheradresse wird ums 1 erhöht
		j	start			
end:		jr $ra			# ende von strtolower es geht weiter in der main nach dem aufruf von strtolower

##################################################################################################################
# Ende von strtolower
##################################################################################################################
progende:
		li $2, 10 	#Servicenummer zum programm beenden
		syscall



