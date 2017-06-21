#######################################################################################################################
#														      #
#				Rechnerarchitektur Übungsblatt 5						      #
#				Autor: Vu Hung, Nguyen								      #
#				Datum: 07.06.2017								      #
#														      #
#######################################################################################################################


###########################################################################################
#
# Einsicht in der Data Segment der .date
#	
###########################################################################################

.data
str1: 	.asciiz "lager"
str2: 	.asciiz "regal"
str3: 	.space  10
	.byte  0xff
	.byte  0xff
###########################################################################################
#
# MAIN Programm Start
#	
###########################################################################################

.text
main:	
	la $a0,str1		# lädt str1 in Register 4 -> $a0
	jal strtolower		# springe in strtolower labbel hinein
	
	la $a0,str2		# lädt str1 in Register 4 -> $a0
	jal strtolower		# springe in strtolower labbel hinein
	
	la $a0,str1		# lädt str1 in Register 4 -> $a0
	jal strturnaround	# springe in strtolower labbel hinein
	
	la $a0,str2		# lädt str1 in Register 4 -> $a0
	jal strturnaround	# springe in strtolower labbel hinein
	

	la $a0,str1		# lädt str1 in Register 4 -> $a0
	la $a1,str2		# lädt str2 in Register 4 -> $a1
	jal strispalindrom	# springe ins strispalindrom labbel hinein
	
	la $a0,str1			# lädt str1 in Register 4 -> $a0
	la $a1,str2			# lädt str1 in Register 5 -> $a1
	jal strcat			# springe ins strcat labbel hinein
	j end				# jump to end


############################################################################################################
#  				Aufgabe A)
#  void strtolower(char*str)
#  Die Routine soll in einem C-String an der Adresse str alle Großbuchstaben in Kleinbuchstaben verwandeln.
############################################################################################################
############################################################################################################
# Prüfe String nach Großbuchstaben und Kleinbuchstaben
#
# Register legende
# $a0 Sting wird gespeichert
# $t0 lädt Register $a0 in $t0
# $t1 lädt die Zahl 97
# $t2 String wird kopiert
############################################################################################################
strtolower:
		move	$t2, $a0		# String wird kopiert von $a0 in $t2
str_check:	lb	$t0,($t2)		# lädt  String von $a0 in $t0 
		beqz 	$t0,return0		# if ($t0 == 0) goto return0
		bge 	$t0,'A',mayUpper	# Prüfen ist der Buchstabe Groß? | if ($t0 < A)
		addi 	$t2,$t2,1		# String Adresse ++
		j str_check			# jump to labbel str_check
	
#############################################################################################################
# Großbuchstabe wird keinbuchstabe umgewandelt
#############################################################################################################
mayUpper:
	ble	$t0, 'Z', isUpper	# # Prüfen ist der Buchstabe Groß? if ($t0 < Z)
	addi 	$t2,$t2,1		# String Adresse ++
	j str_check			# jump to labbel str_check

isUpper:
	addi 	$t0,$t0,32		# Register t0 wird Plaus 32 gemacht Großbuchstabe wird keinbuchstabe
	sb 	$t0,($t2)		# Buchstabe wird abgeseichert in Register $t0 -> $t2
	addi 	$t2,$t2,1		# String Adresse ++
	j str_check			# jump to labbel str_check
	



############################################################################################################
#				Aufgabe B)
#void strturnaround(char*str)
#Die Routine soll in einem C-String an der Adresse str die Reihenfolge der Zeichen umkehren.
############################################################################################################
############################################################################################################
# Die Adressestr soll die Reihenfolge der Zeichen umkehren
#
# Register legende
# $a0 Sting wird gespeichert
# $t0 lädt Register $a0 in $t0
# $t1 Zähler für die Speicherung
# $t2 Die Kopie von $a0
############################################################################################################
############################################################################################################
# Laden und Abspeichern der String Adresse
############################################################################################################

strturnaround:
		addi	$t1,$zero,0		# Zähler wird inizialisiert started von 0 in der .space ($t1)
		move	$t2,$a0			# Kopiere den Sting von $a0 in Register $t2
laden:		lb	$t0,($t2)		# lädt String von $a0 in $t0 
		sb	$t0,str3($t1)		# Speichert den gelandenen String von $t0 in $t1 str3
		beqz 	$t0, ausgabe		# if (register 8 == 0) goto ausgabe
		addi 	$t2,$t2,1		# $t2 String Adresse ++
		addi	$t1,$t1,1		# Zähler um 1 hoch
		j laden				# jump to labbel laden

############################################################################################################
# Die Reihenfolge der Zeichen wird umgekehrt
############################################################################################################

ausgabe:		
		subi 	$t1,$t1,1		# Zäher wird um 1 reduziert vom str3 und gibt wider den letzten Buchstabe .space ($t1) an
		la	$t0,($a0)		# läde $a0 Sting in $t0 rein
umkehr:		lb 	$t0,str3($t1)		# läde den letzten buchstaben $t1 von $t0 (.space) rein
		sb	$t0,($a0)		# Speichert Register $a0
		beqz 	$t0,return0		# if ($t0 == 0) goto return0
		subi	$t1,$t1,1		# Der Zäher wird um 1 reduziert vom Str3
		addi	$a0,$a0,1		# Die Speicheradresse wird um 1 erhöht
		j umkehr			# jump to labbel umkehr


############################################################################################################
#			Aufgabe C)
# int strispalindrom(char*str)
# Die Routine soll prüfen, ob der C-String an der Adresse str ein Palindrom ist. Wenn ja soll der Wert 1,
# sonst der Wert 0 zurückgegeben werden.
############################################################################################################
############################################################################################################
# Register legende
# 
# $a0 Sting1 wird gespeichert
# $a1 Sting2 wird gespeichert
# $t0 lade String1 rein
# $t1 Zähler für die Speicherung
# $t2 Die Kopie von $a0
# $t3 lade String2 rein
# $t5 Counter: Zählt alle gleichen Sting Zeichen
# $t6 Counter: Zählt wie lang der Sting ist
############################################################################################################
############################################################################################################
# Laden und Abspeichern der Strings Adressen
############################################################################################################

strispalindrom:
		addi	$t1,$zero,0		# Zähler wird inizialisiert started von 0 an
		la	$t2,($a0)		# Kopiere den Sting1 von $a0 in Register $t2
		la	$t3,($a1)		# Kopiere den Sting2 von $a0 in Register $t3
speichern:	lb	$t0,($t2)		# lädt String von $a0 in $t0 
		sb	$t0,str3($t1)		# Speichert den gelandenen String von $t0 in $t1 str3
		beqz 	$t0, next		# if (register 8 == 0) goto labbel next
		addi 	$t2,$t2,1		# $t2 String Adresse ++
		addi	$t1,$t1,1		# Zähler um 1 hoch
		j speichern			# jump to labbel speichern

############################################################################################################
# Prüfe ob das ein palindrom ist
############################################################################################################

next:		
		subi 	$t1,$t1,1		# Zäher wird um 1 reduziert vom str3 und gibt wider den letzten Buchstabe .space ($t1) an
control:	lb	$t0,str3($t1)		# läde den letzten buchstaben $t1 von $t0 (.space) rein
		lb	$t4,($t3)		# lade buchstaben $t3 von $t4 str2 rein
		beqz 	$t0,return1		# if ($t0 == $t0) goto labbel return0
		subi	$t1,$t1,1		# Der Zäher wird um 1 reduziert vom Str3 für nächsten buchstabe hintenrum
		addi	$t3,$t3,1		# Die Speicheradresse wird um 1 erhöht in str2 für nächsten buchstabe
		addi	$t6,$t6,1		# Counter fürs verleichen
		beq	$t4,$t0,gleich		# if ($t3 == $t0) goto labbel gleich
		j control			# jump to labbel control

############################################################################################################
# Labbel von gleich 
############################################################################################################

gleich:		
		addi $t5,$t5,1			# $t5 kriegt Wert 1++
		j control			# jump to labbel control

############################################################################################################
#			Aufgabe D)
# void strcat(char*result, char*str1, char*str2)
# Die Routine soll die beiden C-Strings an den Adressen str1 und str2 an die Adresse str3 
# als C-String hintereinander schreiben.
############################################################################################################
############################################################################################################
# Die Adressestr soll hintereinander abgespeichert werden
#
# Register legende
# $a0 Sting wird gespeichert
# $t0 lädt Register $a0 in $t0
# $t1 Zähler für die Speicherung
# $t2 Die Kopie von $a0
############################################################################################################
############################################################################################################
# Laden und Abspeichern vom ersten String in die .space 
############################################################################################################

strcat:		
		addi	$t1,$zero,0		# Zähler wird inizialisiert started von 0 an
		la	$t2,($a0)		# Kopiere den Sting von $a0 in Register $t2
laden1:		lb	$t0,($t2)		# lädt String von $a0 in $t0 
		sb	$t0,str3($t1)		# Speichert den gelandenen String von $t0 in $t1 str3
		beqz 	$t0,neuerstr		# if ($t0 == 0) goto labbel neuerstr
		addi 	$t2,$t2,1		# $t2 String Adresse ++
		addi	$t1,$t1,1		# Zähler um 1 hoch
		j laden1			# jump to labbel laden1
		
############################################################################################################
# Nächster String wird in die .space hinten dran und ohne /0 abgespeichert 
############################################################################################################

neuerstr:	
		la	$t2,($a1)		# Kopiere den Sting von $a1 in Register $t2
laden2:		lb	$t0,($t2)		# lädt String von $a0 in $t0 
		sb	$t0,str3($t1)		# Speichert den gelandenen String von $t0 in $t1 str3
		beqz 	$t0,return0		# if ($t0 == 0) goto labbel return0
		addi 	$t2,$t2,1		# $t2 String Adresse ++
		addi	$t1,$t1,1		# Zähler um 1 hoch
		j laden2			# jump to labbel laden2

############################################################################################################
# Ende der Routine return0
############################################################################################################
return0:
		jr $ra			# Return zur Adresse
############################################################################################################
# Ende der Routine return1
############################################################################################################
return1:	
		beq $t5,$t6,wahr	# if ($t5 == $t6) goto labbel wahr
		li $v0,0		# Register $v0 kriegt den Wert 0 = kein palindrom
		jr $ra			# Return zur Adresse
wahr:		
		li $v0,1		# Register $v0 kriegt den Wert 1 = ist ein palindrom
		jr $ra			# Return zur Adresse

################################################################################################
# Ende vom ganzem Programm
################################################################################################
end: 
		li $v0,10 		# Zahl 10 wird in $v0 immediated
		syscall			# syscall aktiviert in $v0 Service: exit (terminate execution) wird ausgefürt
