#####################################################################
#
# CSCB58 Winter 2024 Assembly Final Project
# University of Toronto, Scarborough
#
# Student: Name: Hengyi Li
# Student Number: 1009086926
# UTorID: lihengyi
# official email: hengyi.li@mail.utoronto.ca
#
# Bitmap Display Configuration:
# - Unit width in pixels: 4
# - Unit height in pixels: 4
# - Display width in pixels: 256
# - Display height in pixels: 256
# - Base Address for Display: 0x10008000 ($gp)
#
# Which milestoneshave been reached in this submission?
# (See the assignment handout for descriptions of the milestones)
# - Milestone 1
# - Milestone 2
# - Milestone 3
# - Milestone 4 features that I picked
#	D. Different levels
#	G. Pick up effects
#	J. Start Menu
# Which approved features have been implemented for milestone 3?
# All of Them
#
# Link to video demonstration for final submission:
# - (insert YouTube / MyMedia / other URL here). Make sure we can view it!
#
# Are you OK with us sharing the video with people outside course staff?
# - yes
# - To be updated......
#
# Any additional information that the TA needs to know:
# Nothing specific and hope you enjoy the game
#
#####################################################################

.eqv Base_Address 	0x10008000
.eqv col_white		0xffffff
.eqv col_yellow		0xfff200
.eqv col_blue		0x4d6df3
.eqv col_red		0xed1c24
.eqv col_black		0x000000

.data

.text

.globl main

main:
	# load the start-up menu
	j start_menu
	
	j main
	

# this function initializes the start menu page
start_menu:
# draw the start menu page
	li $t0, Base_Address		# $t0 stores the base address of graph pointer
	li $t1, col_white		# $t1 stores the white color code
	li $t2, col_yellow		# $t2 stores the yellow color code
	li $t3, col_blue		# $t3 stores the blue color code
	li $t4, col_red			# $t4 stores the red color code
	li $t5, col_black		# $t5 stores the black color code

	
	# draw the first line "COIN"
	# draw 'C'
	sw $t1, 1320($t0)
	sw $t1, 1576($t0)
	sw $t1, 1832($t0)
	sw $t1, 2088($t0)
	sw $t1, 2344($t0)
	sw $t1, 2600($t0)
	sw $t1, 2856($t0)
	sw $t1, 3112($t0)
	sw $t1, 3368($t0)
	sw $t1, 1324($t0)
	sw $t1, 1068($t0)
	sw $t1, 1072($t0)
	sw $t1, 816($t0)
	sw $t1, 820($t0)
	sw $t1, 824($t0)
	sw $t1, 828($t0)
	sw $t1, 832($t0)
	sw $t1, 836($t0)
	sw $t1, 1092($t0)
	sw $t1, 1096($t0)
	sw $t1, 1352($t0)
	sw $t1, 3372($t0)
	sw $t1, 3628($t0)
	sw $t1, 3632($t0)
	sw $t1, 3888($t0)
	sw $t1, 3892($t0)
	sw $t1, 3896($t0)
	sw $t1, 3900($t0)
	sw $t1, 3904($t0)
	sw $t1, 3908($t0)
	sw $t1, 3652($t0)
	sw $t1, 3656($t0)
	sw $t1, 3400($t0)
	
	# draw the big yellow coin
	sw $t2, 1880($t0)
	sw $t2, 2136($t0)
	sw $t2, 2392($t0)
	sw $t2, 2648($t0)
	sw $t2, 2904($t0)
	sw $t2, 3164($t0)
	sw $t2, 2908($t0)
	sw $t2, 2652($t0)
	sw $t2, 2396($t0)
	sw $t2, 2140($t0)
	sw $t2, 1884($t0)
	sw $t2, 1628($t0)
	sw $t2, 1376($t0)
	sw $t2, 1632($t0)
	sw $t2, 1888($t0)
	sw $t2, 2144($t0)
	sw $t2, 2400($t0)
	sw $t2, 2656($t0)
	sw $t2, 2912($t0)
	sw $t2, 3168($t0)
	sw $t2, 3424($t0)
	sw $t2, 3684($t0)
	sw $t2, 3428($t0)
	sw $t2, 3172($t0)
	sw $t2, 2916($t0)
	sw $t2, 2660($t0)
	sw $t2, 2404($t0)
	sw $t2, 2148($t0)
	sw $t2, 1892($t0)
	sw $t2, 1636($t0)
	sw $t2, 1380($t0)
	sw $t2, 1124($t0)
	sw $t2, 872($t0)
	sw $t2, 876($t0)
	sw $t2, 880($t0)
	sw $t2, 884($t0)
	sw $t2, 1140($t0)
	sw $t2, 1136($t0)
	sw $t2, 1132($t0)
	sw $t2, 1128($t0)
	sw $t2, 1384($t0)
	sw $t2, 1388($t0)
	sw $t2, 1392($t0)
	sw $t1, 1396($t0)
	sw $t2, 1652($t0)
	sw $t2, 1648($t0)
	sw $t2, 1644($t0)
	sw $t2, 1640($t0)
	sw $t2, 1896($t0)
	sw $t2, 1900($t0)
	sw $t2, 1904($t0)
	sw $t2, 1908($t0)
	sw $t2, 2164($t0)
	sw $t2, 2160($t0)
	sw $t2, 2156($t0)
	sw $t2, 2152($t0)
	sw $t2, 2408($t0)
	sw $t2, 2412($t0)
	sw $t2, 2416($t0)
	sw $t2, 2420($t0)
	sw $t2, 2676($t0)
	sw $t2, 2672($t0)
	sw $t2, 2668($t0)
	sw $t2, 2664($t0)
	sw $t2, 2920($t0)
	sw $t2, 2924($t0)
	sw $t2, 2928($t0)
	sw $t2, 2932($t0)
	sw $t2, 3188($t0)
	sw $t2, 3184($t0)
	sw $t2, 3180($t0)
	sw $t2, 3176($t0)
	sw $t2, 3432($t0)
	sw $t2, 3432($t0)
	sw $t2, 3436($t0)
	sw $t2, 3440($t0)
	sw $t2, 3444($t0)
	sw $t2, 3700($t0)
	sw $t2, 3696($t0)
	sw $t2, 3692($t0)
	sw $t2, 3688($t0)
	sw $t2, 3944($t0)
	sw $t2, 3948($t0)
	sw $t2, 3952($t0)
	sw $t2, 3956($t0)
	sw $t2, 3704($t0)
	sw $t2, 3448($t0)
	sw $t2, 3192($t0)
	sw $t2, 2936($t0)
	sw $t2, 2680($t0)
	sw $t2, 2424($t0)
	sw $t2, 2168($t0)
	sw $t2, 1912($t0)
	sw $t1, 1656($t0)
	sw $t1, 1400($t0)
	sw $t2, 1144($t0)
	sw $t2, 1404($t0)
	sw $t1, 1660($t0)
	sw $t1, 1916($t0)
	sw $t2, 2172($t0)
	sw $t2, 2428($t0)
	sw $t2, 2684($t0)
	sw $t2, 2940($t0)
	sw $t2, 3196($t0)
	sw $t2, 3452($t0)
	sw $t2, 3200($t0)
	sw $t2, 2944($t0)
	sw $t2, 2688($t0)
	sw $t2, 2432($t0)
	sw $t2, 2176($t0)
	sw $t1, 1920($t0)
	sw $t2, 1664($t0)
	sw $t2, 1924($t0)
	sw $t2, 2180($t0)
	sw $t2, 2436($t0)
	sw $t2, 2692($t0)
	sw $t2, 2948($t0)
	
	# draw 'I'
	sw $t1, 916($t0)
	sw $t1, 1172($t0)
	sw $t1, 1428($t0)
	sw $t1, 1684($t0)
	sw $t1, 1940($t0)
	sw $t1, 2196($t0)
	sw $t1, 2452($t0)
	sw $t1, 2708($t0)
	sw $t1, 2964($t0)
	sw $t1, 3220($t0)
	sw $t1, 3476($t0)
	sw $t1, 3732($t0)
	sw $t1, 3988($t0)
	
	# draw 'N'
	sw $t1, 928($t0)
	sw $t1, 1184($t0)
	sw $t1, 1440($t0)
	sw $t1, 1696($t0)
	sw $t1, 1952($t0)
	sw $t1, 2208($t0)
	sw $t1, 2464($t0)
	sw $t1, 2720($t0)
	sw $t1, 2976($t0)
	sw $t1, 3232($t0)
	sw $t1, 3488($t0)
	sw $t1, 3744($t0)
	sw $t1, 4000($t0)
	sw $t1, 932($t0)
	sw $t1, 1188($t0)
	sw $t1, 1448($t0)
	sw $t1, 1704($t0)
	sw $t1, 1964($t0)
	sw $t1, 2220($t0)
	sw $t1, 2476($t0)
	sw $t1, 2480($t0)
	sw $t1, 2736($t0)
	sw $t1, 2992($t0)
	sw $t1, 3252($t0)
	sw $t1, 3508($t0)
	sw $t1, 3768($t0)
	sw $t1, 4024($t0)
	sw $t1, 4028($t0)
	sw $t1, 3772($t0)
	sw $t1, 3516($t0)
	sw $t1, 3260($t0)
	sw $t1, 3004($t0)
	sw $t1, 2748($t0)
	sw $t1, 2492($t0)
	sw $t1, 2236($t0)
	sw $t1, 1980($t0)
	sw $t1, 1724($t0)
	sw $t1, 1468($t0)
	sw $t1, 1212($t0)
	sw $t1, 956($t0)
	
	# draw second line
	# draw 'C'
	sw $t1, 5160($t0)
	sw $t1, 5416($t0)
	sw $t1, 5672($t0)
	sw $t1, 5928($t0)
	sw $t1, 6184($t0)
	sw $t1, 6440($t0)
	sw $t1, 6696($t0)
	sw $t1, 6700($t0)
	sw $t1, 6704($t0)
	sw $t1, 6708($t0)
	sw $t1, 6712($t0)
	sw $t1, 6456($t0)
	sw $t1, 5164($t0)
	sw $t1, 5168($t0)
	sw $t1, 5172($t0)
	sw $t1, 5176($t0)
	sw $t1, 5432($t0)
	
	# draw 'A'
	sw $t1, 5184($t0)
	sw $t1, 5188($t0)
	sw $t1, 5192($t0)
	sw $t1, 5196($t0)
	sw $t1, 5200($t0)
	sw $t1, 5440($t0)
	sw $t1, 5696($t0)
	sw $t1, 5952($t0)
	sw $t1, 6208($t0)
	sw $t1, 6464($t0)
	sw $t1, 6720($t0)
	sw $t1, 5188($t0)
	sw $t1, 5192($t0)
	sw $t1, 5196($t0)
	sw $t1, 5200($t0)
	sw $t1, 5456($t0)
	sw $t1, 5712($t0)
	sw $t1, 5968($t0)
	sw $t1, 6224($t0)
	sw $t1, 6480($t0)
	sw $t1, 6736($t0)
	sw $t1, 5956($t0)
	sw $t1, 5960($t0)
	sw $t1, 5964($t0)
	
	# draw 'T'
	sw $t1, 5208($t0)
	sw $t1, 5212($t0)
	sw $t1, 5216($t0)
	sw $t1, 5220($t0)
	sw $t1, 5224($t0)
	sw $t1, 5228($t0)
	sw $t1, 5232($t0)
	sw $t1, 5476($t0)
	sw $t1, 5732($t0)
	sw $t1, 5988($t0)
	sw $t1, 6244($t0)
	sw $t1, 6500($t0)
	sw $t1, 6756($t0)
	
	# draw 'C'
	sw $t1, 5240($t0)
	sw $t1, 5244($t0)
	sw $t1, 5248($t0)
	sw $t1, 5252($t0)
	sw $t1, 5256($t0)
	sw $t1, 5512($t0)
	sw $t1, 5496($t0)
	sw $t1, 5752($t0)
	sw $t1, 6008($t0)
	sw $t1, 6264($t0)
	sw $t1, 6520($t0)
	sw $t1, 6776($t0)
	sw $t1, 6780($t0)
	sw $t1, 6784($t0)
	sw $t1, 6788($t0)
	sw $t1, 6792($t0)
	sw $t1, 6536($t0)
	
	# draw 'H'
	sw $t1, 5264($t0)
	sw $t1, 5520($t0)
	sw $t1, 5776($t0)
	sw $t1, 6032($t0)
	sw $t1, 6036($t0)
	sw $t1, 6040($t0)
	sw $t1, 6044($t0)
	sw $t1, 6048($t0)
	sw $t1, 5792($t0)
	sw $t1, 5536($t0)
	sw $t1, 5280($t0)
	sw $t1, 6304($t0)
	sw $t1, 6560($t0)
	sw $t1, 6816($t0)
	sw $t1, 6288($t0)
	sw $t1, 6544($t0)
	sw $t1, 6800($t0)
	
	# draw 'E'
	sw $t1, 5288($t0)
	sw $t1, 5292($t0)
	sw $t1, 5296($t0)
	sw $t1, 5300($t0)
	sw $t1, 5304($t0)
	sw $t1, 5544($t0)
	sw $t1, 5800($t0)
	sw $t1, 6056($t0)
	sw $t1, 6060($t0)
	sw $t1, 6064($t0)
	sw $t1, 6068($t0)
	sw $t1, 6072($t0)
	sw $t1, 6312($t0)
	sw $t1, 6568($t0)
	sw $t1, 6824($t0)
	sw $t1, 6828($t0)
	sw $t1, 6832($t0)
	sw $t1, 6836($t0)
	sw $t1, 6840($t0)
	
	# draw 'R'
	sw $t1, 5312($t0)
	sw $t1, 5316($t0)
	sw $t1, 5320($t0)
	sw $t1, 5324($t0)
	sw $t1, 5328($t0)
	sw $t1, 5584($t0)
	sw $t1, 5840($t0)
	sw $t1, 6096($t0)
	sw $t1, 6092($t0)
	sw $t1, 6088($t0)
	sw $t1, 6084($t0)
	sw $t1, 5568($t0)
	sw $t1, 5824($t0)
	sw $t1, 6080($t0)
	sw $t1, 6336($t0)
	sw $t1, 6592($t0)
	sw $t1, 6848($t0)
	sw $t1, 6344($t0)
	sw $t1, 6348($t0)
	sw $t1, 6604($t0)
	sw $t1, 6608($t0)
	sw $t1, 6864($t0)
	
	# draw line 3 "LEVEL 1"
	# draw 'L'
	sw $t1, 8292($t0)
	sw $t1, 8548($t0)
	sw $t1, 8804($t0)
	sw $t1, 9060($t0)
	sw $t1, 9316($t0)
	sw $t1, 9320($t0)
	sw $t1, 9324($t0)
	
	# draw 'E'
	sw $t1, 8308($t0)
	sw $t1, 8312($t0)
	sw $t1, 8316($t0)
	sw $t1, 8564($t0)
	sw $t1, 8820($t0)
	sw $t1, 8824($t0)
	sw $t1, 8828($t0)
	sw $t1, 9076($t0)
	sw $t1, 9332($t0)
	sw $t1, 9336($t0)
	sw $t1, 9340($t0)
	
	# draw 'V'
	sw $t1, 8324($t0)
	sw $t1, 8580($t0)
	sw $t1, 8836($t0)
	sw $t1, 9092($t0)
	sw $t1, 9352($t0)
	sw $t1, 9100($t0)
	sw $t1, 8844($t0)
	sw $t1, 8588($t0)
	sw $t1, 8332($t0)
	
	# draw 'E'
	sw $t1, 8852($t0)
	sw $t1, 8596($t0)
	sw $t1, 8340($t0)
	sw $t1, 8344($t0)
	sw $t1, 8348($t0)
	sw $t1, 8856($t0)
	sw $t1, 8860($t0)
	sw $t1, 9108($t0)
	sw $t1, 9364($t0)
	sw $t1, 9368($t0)
	sw $t1, 9372($t0)
	
	# draw 'L'
	sw $t1, 8356($t0)
	sw $t1, 8612($t0)
	sw $t1, 8868($t0)
	sw $t1, 9124($t0)
	sw $t1, 9380($t0)
	sw $t1, 9384($t0)
	sw $t1, 9388($t0)
	
	# draw 1
	sw $t1, 8396($t0)
	sw $t1, 8652($t0)
	sw $t1, 8908($t0)
	sw $t1, 9164($t0)
	sw $t1, 9420($t0)
	
	# draw fourth line "LEVEL 2"
	# draw 'L'
	sw $t1, 10084($t0)
	sw $t1, 10340($t0)
	sw $t1, 10596($t0)
	sw $t1, 10852($t0)
	sw $t1, 11108($t0)
	sw $t1, 11112($t0)
	sw $t1, 11116($t0)
	
	# draw 'L'
	sw $t1, 10100($t0)
	sw $t1, 10104($t0)
	sw $t1, 10108($t0)
	sw $t1, 10356($t0)
	sw $t1, 10612($t0)
	sw $t1, 10616($t0)
	sw $t1, 10620($t0)
	sw $t1, 10868($t0)
	sw $t1, 11124($t0)
	sw $t1, 11128($t0)
	sw $t1, 11132($t0)

	# draw 'V'
	sw $t1, 10116($t0)
	sw $t1, 10372($t0)
	sw $t1, 10628($t0)
	sw $t1, 10884($t0)
	sw $t1, 11144($t0)
	sw $t1, 10892($t0)
	sw $t1, 10636($t0)
	sw $t1, 10380($t0)
	sw $t1, 10124($t0)
	
	# draw 'E'
	sw $t1, 10644($t0)
	sw $t1, 10388($t0)
	sw $t1, 10132($t0)
	sw $t1, 10136($t0)
	sw $t1, 10140($t0)
	sw $t1, 10648($t0)
	sw $t1, 10652($t0)
	sw $t1, 10900($t0)
	sw $t1, 11156($t0)
	sw $t1, 11160($t0)
	sw $t1, 11164($t0)
	
	# draw 'L'
	sw $t1, 10148($t0)
	sw $t1, 10404($t0)
	sw $t1, 10660($t0)
	sw $t1, 10916($t0)
	sw $t1, 11172($t0)
	sw $t1, 11176($t0)
	sw $t1, 11180($t0)

	#  draw 2
	sw $t1, 10184($t0)
	sw $t1, 10188($t0)
	sw $t1, 10192($t0)
	sw $t1, 10448($t0)
	sw $t1, 10704($t0)
	sw $t1, 10700($t0)
	sw $t1, 10696($t0)
	sw $t1, 10952($t0)
	sw $t1, 11208($t0)
	sw $t1, 11212($t0)
	sw $t1, 11216($t0)
	
	# draw fifth line "LEVEL 3"
	# draw 'L'
	sw $t1, 11876($t0)
	sw $t1, 12132($t0)
	sw $t1, 12388($t0)
	sw $t1, 12644($t0)
	sw $t1, 12900($t0)
	sw $t1, 12904($t0)
	sw $t1, 12908($t0)
	
	# draw 'E'
	sw $t1, 12404($t0)
	sw $t1, 12148($t0)
	sw $t1, 11892($t0)
	sw $t1, 11896($t0)
	sw $t1, 11900($t0)
	sw $t1, 12408($t0)
	sw $t1, 12412($t0)
	sw $t1, 12660($t0)
	sw $t1, 12916($t0)
	sw $t1, 12920($t0)
	sw $t1, 12924($t0)

	# draw 'V'
	sw $t1, 11908($t0)
	sw $t1, 12164($t0)
	sw $t1, 12420($t0)
	sw $t1, 12676($t0)
	sw $t1, 12936($t0)
	sw $t1, 12684($t0)
	sw $t1, 12428($t0)
	sw $t1, 12172($t0)
	sw $t1, 11916($t0)
	
	# draw 'E'
	sw $t1, 12436($t0)
	sw $t1, 12692($t0)
	sw $t1, 12948($t0)
	sw $t1, 12952($t0)
	sw $t1, 12956($t0)
	sw $t1, 12180($t0)
	sw $t1, 11924($t0)
	sw $t1, 11928($t0)
	sw $t1, 11932($t0)
	sw $t1, 12440($t0)
	sw $t1, 12444($t0)
	
	# draw 'L'
	sw $t1, 11940($t0)
	sw $t1, 12196($t0)
	sw $t1, 12452($t0)
	sw $t1, 12708($t0)
	sw $t1, 12964($t0)
	sw $t1, 12968($t0)
	sw $t1, 12972($t0)
	
	# draw 3
	sw $t1, 11976($t0)
	sw $t1, 11980($t0)
	sw $t1, 11984($t0)
	sw $t1, 12240($t0)
	sw $t1, 12496($t0)
	sw $t1, 12492($t0)
	sw $t1, 12488($t0)
	sw $t1, 12752($t0)
	sw $t1, 13008($t0)
	sw $t1, 13004($t0)
	sw $t1, 13000($t0)
	
	# draw sixth line "EXIT"
	sw $t1, 14180($t0)
	sw $t1, 13924($t0)
	sw $t1, 13668($t0)
	sw $t1, 13672($t0)
	sw $t1, 13676($t0)
	sw $t1, 14184($t0)
	sw $t1, 14188($t0)
	sw $t1, 14436($t0)
	sw $t1, 14692($t0)
	sw $t1, 14696($t0)
	sw $t1, 14700($t0)
	
	# draw 'X'
	sw $t1, 14200($t0)
	sw $t1, 13940($t0)
	sw $t1, 13684($t0)
	sw $t1, 13948($t0)
	sw $t1, 13692($t0)
	sw $t1, 14452($t0)
	sw $t1, 14708($t0)
	sw $t1, 14460($t0)
	sw $t1, 14716($t0)
	
	# draw 'I'
	sw $t1, 13700($t0)
	sw $t1, 13956($t0)
	sw $t1, 14212($t0)
	sw $t1, 14468($t0)
	sw $t1, 14724($t0)
	
	# draw 'T'
	sw $t1, 13708($t0)
	sw $t1, 13712($t0)
	sw $t1, 13716($t0)
	sw $t1, 13968($t0)
	sw $t1, 14224($t0)
	sw $t1, 14480($t0)
	sw $t1, 14736($t0)
	
	# optional cursor position 1
	cursor_position_1:
		sw $t1, 8244($t0)
		sw $t4, 8500($t0)
		sw $t4, 8756($t0)
		sw $t4, 9012($t0)
		sw $t4, 9272($t0)
		sw $t4, 9276($t0)
		sw $t4, 9280($t0)
		sw $t4, 9028($t0)
		sw $t4, 8772($t0)
		sw $t4, 8516($t0)
		sw $t1, 8260($t0)
		addi $t6, $zero, 1		# $t6 stores the cursor position and set to 1
		j start_menu_key_detect
	
	# optional cursor position 2
	cursor_position_2:
		sw $t1, 10036($t0)
		sw $t4, 10292($t0)
		sw $t4, 10548($t0)
		sw $t4, 10804($t0)
		sw $t4, 11064($t0)
		sw $t4, 11068($t0)
		sw $t4, 11072($t0)
		sw $t4, 10820($t0)
		sw $t4, 10564($t0)
		sw $t4, 10308($t0)
		sw $t1, 10052($t0)
		addi $t6, $zero, 2		# update cursor position to 2
		j start_menu_key_detect
	
	# optional cursor position 3
	cursor_position_3:

		sw $t1, 11828($t0)
		sw $t4, 12084($t0)
		sw $t4, 12340($t0)
		sw $t4, 12596($t0)
		sw $t4, 12856($t0)
		sw $t4, 12860($t0)
		sw $t4, 12864($t0)
		sw $t4, 12612($t0)
		sw $t4, 12356($t0)
		sw $t4, 12100($t0)
		sw $t1, 11844($t0)
		addi $t6, $zero, 3		# update cursor position to 3
		j start_menu_key_detect

	# optional cursor position 4
	cursor_position_4:
		sw $t1, 13620($t0)
		sw $t4, 13876($t0)
		sw $t4, 14132($t0)
		sw $t4, 14388($t0)
		sw $t4, 14648($t0)
		sw $t4, 14652($t0)
		sw $t4, 14656($t0)
		sw $t4, 14404($t0)
		sw $t4, 14148($t0)
		sw $t4, 13892($t0)
		sw $t1, 13636($t0)
		addi $t6, $zero, 4		# update cursor position to 4
		j start_menu_key_detect

	
	# drawing is complete, now read user input
	start_menu_key_detect:
		li $t9, 0xffff0000		# check if a key is pressed by the user
		lw $t8, 0($t9)
		beq $t8, 1, keypress_happen	# jump to key detection
		j start_menu_key_detect		# no key is pressed, go back to the first line 


	keypress_happen:
		lw $t7, 4($t9)					# $t7 stores the key value pressed by user
		beq $t7, 0x73, start_menu_s_pressed		# check if key 's' is pressed
		beq $t7, 0x77, start_menu_w_pressed		# check if key 'w' is pressed
		beq $t7, 0x0a, start_menu_enter_pressed	# check if key 'Enter' is pressed
		j start_menu_key_detect		# no key is pressed, go back to the first line 
	
	
# this function deals with the case when s is pressed in start menu
start_menu_s_pressed:
	beq $t6, 1, clear_position_1
	beq $t6, 2, clear_position_2
	beq $t6, 3, clear_position_3
	beq $t6, 4, clear_position_4
	j start_menu_key_detect	
	
	clear_position_1:
		sw $t5, 8244($t0)
		sw $t5, 8500($t0)
		sw $t5, 8756($t0)
		sw $t5, 9012($t0)
		sw $t5, 9272($t0)
		sw $t5, 9276($t0)
		sw $t5, 9280($t0)
		sw $t5, 9028($t0)
		sw $t5, 8772($t0)
		sw $t5, 8516($t0)
		sw $t5, 8260($t0)
		j cursor_position_2
	
	clear_position_2:
		sw $t5, 10036($t0)
		sw $t5, 10292($t0)
		sw $t5, 10548($t0)
		sw $t5, 10804($t0)
		sw $t5, 11064($t0)
		sw $t5, 11068($t0)
		sw $t5, 11072($t0)
		sw $t5, 10820($t0)
		sw $t5, 10564($t0)
		sw $t5, 10308($t0)
		sw $t5, 10052($t0)
		j cursor_position_3
	
	clear_position_3:
		sw $t5, 11828($t0)
		sw $t5, 12084($t0)
		sw $t5, 12340($t0)
		sw $t5, 12596($t0)
		sw $t5, 12856($t0)
		sw $t5, 12860($t0)
		sw $t5, 12864($t0)
		sw $t5, 12612($t0)
		sw $t5, 12356($t0)
		sw $t5, 12100($t0)
		sw $t5, 11844($t0)
		j cursor_position_4
	
	clear_position_4:
		sw $t5, 13620($t0)
		sw $t5, 13876($t0)
		sw $t5, 14132($t0)
		sw $t5, 14388($t0)
		sw $t5, 14648($t0)
		sw $t5, 14652($t0)
		sw $t5, 14656($t0)
		sw $t5, 14404($t0)
		sw $t5, 14148($t0)
		sw $t5, 13892($t0)
		sw $t5, 13636($t0)
		j cursor_position_1
		
# this function deals with the case when w is pressed in start menu
start_menu_w_pressed:
	beq $t6, 1, clear_position_11
	beq $t6, 2, clear_position_22
	beq $t6, 3, clear_position_33
	beq $t6, 4, clear_position_44
	
	clear_position_11:
		sw $t5, 8244($t0)
		sw $t5, 8500($t0)
		sw $t5, 8756($t0)
		sw $t5, 9012($t0)
		sw $t5, 9272($t0)
		sw $t5, 9276($t0)
		sw $t5, 9280($t0)
		sw $t5, 9028($t0)
		sw $t5, 8772($t0)
		sw $t5, 8516($t0)
		sw $t5, 8260($t0)
		j cursor_position_4
	
	clear_position_22:
		sw $t5, 10036($t0)
		sw $t5, 10292($t0)
		sw $t5, 10548($t0)
		sw $t5, 10804($t0)
		sw $t5, 11064($t0)
		sw $t5, 11068($t0)
		sw $t5, 11072($t0)
		sw $t5, 10820($t0)
		sw $t5, 10564($t0)
		sw $t5, 10308($t0)
		sw $t5, 10052($t0)
		j cursor_position_1
	
	clear_position_33:
		sw $t5, 11828($t0)
		sw $t5, 12084($t0)
		sw $t5, 12340($t0)
		sw $t5, 12596($t0)
		sw $t5, 12856($t0)
		sw $t5, 12860($t0)
		sw $t5, 12864($t0)
		sw $t5, 12612($t0)
		sw $t5, 12356($t0)
		sw $t5, 12100($t0)
		sw $t5, 11844($t0)
		j cursor_position_2
	
	clear_position_44:
		sw $t5, 13620($t0)
		sw $t5, 13876($t0)
		sw $t5, 14132($t0)
		sw $t5, 14388($t0)
		sw $t5, 14648($t0)
		sw $t5, 14652($t0)
		sw $t5, 14656($t0)
		sw $t5, 14404($t0)
		sw $t5, 14148($t0)
		sw $t5, 13892($t0)
		sw $t5, 13636($t0)
		j cursor_position_3

# this function deals with the case when Enter is pressed in start menu
start_menu_enter_pressed:
	beq $t6, 4, good_bye_page		# exit option is selected
	j start_menu_key_detect	
	
	
# this function draw goodbye page and terminates the program
good_bye_page:
	jal clear_screen		# clear the screen
	# draw the goodbye page
	sw $t1, 2864($t0)
	sw $t1, 3120($t0)
	sw $t1, 3376($t0)
	sw $t1, 3632($t0)
	sw $t1, 3888($t0)
	sw $t1, 4144($t0)
	sw $t1, 4400($t0)
	
	sw $t1, 4656($t0)
	sw $t1, 4912($t0)
	sw $t1, 5168($t0)
	sw $t1, 5424($t0)
	sw $t1, 5680($t0)
	sw $t1, 5936($t0)
	li $v0, 10
	syscall				# the game is terminated by clicking on quit


# this function clears the screen
clear_screen:
	addi $s0, $zero, 0				# $s0 stores the index i = 0
	addi $s1, $t0, 0				# $s1 stores the base address of graph pointer
	clear_screen_for_loop:
		bgt $s0, 16380, clear_screen_remaining		# exit condition index i > 16380
		sw $t5, ($s1)					# clear one pixel to black color
		addi $s1, $s1, 4				# increment address of graph pointer by 4
		addi $s0, $s0, 4				# increment index i by 4
		j clear_screen_for_loop
	clear_screen_remaining:
		jr $ra

