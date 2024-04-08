# some codes have been hidden

.data

.text

	# load color codes to registers
	li $t0, Base_Address		# $t0 stores the base address of graph pointer
	li $t1, col_white		# $t1 stores the white color code
	li $t2, col_yellow		# $t2 stores the yellow color code
	li $t3, col_blue		# $t3 stores the blue color code
	li $t4, col_red			# $t4 stores the red color code
	li $t5, col_black		# $t5 stores the black color code

main:
	# load the start-up menu
	j start_menu
	
	main_level_1:
	
		
		
		level_1_key_detect:
		
			beq $a3, 0, good_bye_page				# check if HP is zero, then game is over
			beq $a1, 0, level_2_page				# check if player collects all the coins
			jal coin_collision_check_level_1_coin_1
			jal coin_collision_check_level_1_coin_2
			jal coin_collision_check_level_1_coin_3
			jal coin_collision_check_level_1_coin_4
			jal red_cross_collision_check_level_1
			jal grey_cross_collision_check_level_1
			
			gravity_check_level_1:
				add $s6, $zero, $s2				# $s6 temporarily stores the position of player
				addi $s6, $s6, 256				# following code checks if the pixel right blow the player is white a.k.a. is a platform
				lw $s5, ($s6)		
				beq $s5, 0xffffff, continuation_level_1
				addi $s6, $s6, -4
				lw $s5, ($s6)
				beq $s5, 0xffffff, continuation_level_1
				addi $s6, $s6, 8
				lw $s5, ($s6)
				beq $s5, 0xffffff, continuation_level_1
				
				add $s6, $zero, $s2
				addi $s6, $s6, 256				# following code checks if the pixel right blow the player is blue a.k.a. is an ocean
				lw $s5, ($s6)		
				beq $s5, 0x4d6df3, fallToOcean_1
				addi $s6, $s6, -4
				lw $s5, ($s6)
				beq $s5, 0x4d6df3, fallToOcean_1
				addi $s6, $s6, 8
				lw $s5, ($s6)
				beq $s5, 0x4d6df3, fallToOcean_1
				addi $s6, $s6, 256				
				lw $s5, ($s6)		
				beq $s5, 0x4d6df3, fallToOcean_1
				addi $s6, $s6, -4
				lw $s5, ($s6)
				beq $s5, 0x4d6df3, fallToOcean_1
				addi $s6, $s6, -4
				lw $s5, ($s6)
				beq $s5, 0x4d6df3, fallToOcean_1

				# player is in the air
				# player should be pulled down to the ground
				jal delete_player
				addi $s2, $s2, 256
				jal draw_player	
				
				li $v0, 32
				li $a0, 100 # Wait one second (1000 milliseconds)
				syscall
				

			continuation_level_1:
				li $t9, 0xffff0000		# check if a key is pressed by the user
				lw $t8, 0($t9)
				beq $t8, 1, keypress_level_1	# jump to key detection
				j level_1_key_detect		# no key is pressed, go back to the first line 
			
			r_key_press_level_1:
				addi $a3, $zero, 3		# reset player HP
				jal clear_all_HP
				jal draw_HP
				j level_1_page
			
			keypress_level_1: 

			lw $t7, 4($t9)					# $t7 stores the key value pressed by user
			beq $t7, 0x64, level_1_d_pressed		# check if key 'd' is pressed
			beq $t7, 0x61, level_1_a_pressed		# check if key 'a' is pressed
			beq $t7, 0x77, level_1_w_pressed		# check if key 'w' is pressed
			beq $t7, 0x71, good_bye_page			# check if key 'q' is pressed
			beq $t7, 0x72, r_key_press_level_1		# check if key 'r' is pressed
			j level_1_key_detect				# no key is pressed, go back to the first line 
			
		level_1_d_pressed:
			beq $s7, 62, level_1_key_detect			# if player already on the boundary, no action requires 

			addi $s0, $s2, 0				# check if there is a platform on the right
			addi $s0, $s0, 8
			lw $s6, ($s0)
			beq $s6, 0xffffff, level_1_key_detect
			addi $s0, $s0, -256
			lw $s6, ($s0)
			beq $s6, 0xffffff, level_1_key_detect
			addi $s0, $s0, -256
			lw $s6, ($s0)
			beq $s6, 0xffffff, level_1_key_detect
			addi $s0, $s0, -256
			lw $s6, ($s0)
			beq $s6, 0xffffff, level_1_key_detect
			

			level_1_p_pressed_rest:
			jal delete_player				# delete original player at the old position
			addi $s2, $s2, 4				# update the new location of the player
			addi $s7, $s7, 1
			jal draw_player					# draw the player at the new position
			j level_1_key_detect
		
		level_1_a_pressed:
			beq $s7, 1, level_1_key_detect			# if player already on the boundary, no action requires 


			addi $s0, $s2, 0				# check if there is a platform on the left
			addi $s0, $s0, -8
			lw $s6, ($s0)
			beq $s6, 0xffffff, level_1_key_detect
			addi $s0, $s0, -256
			lw $s6, ($s0)
			beq $s6, 0xffffff, level_1_key_detect
			addi $s0, $s0, -256
			lw $s6, ($s0)
			beq $s6, 0xffffff, level_1_key_detect
			addi $s0, $s0, -256
			lw $s6, ($s0)
			beq $s6, 0xffffff, level_1_key_detect
	

			jal delete_player				# delete original player at the old position
			addi $s2, $s2, -4				# update the new location of the player
			addi $s7, $s7, -1
			jal draw_player					# draw the player at the new position
			j level_1_key_detect

		level_1_w_pressed:
			add $s6, $zero, $s2				# $s6 temporarily stores the position of player
			addi $s6, $s6, 256				# following code checks if the pixel right blow the player is white a.k.a. is a platform
			lw $s5, ($s6)		
			beq $s5, 0xffffff, level_1_w_continue
			
			addi $s6, $s6, -4
			lw $s5, ($s6)
			beq $s5, 0xffffff, level_1_w_continue
			addi $s6, $s6, 8
			lw $s5, ($s6)
			beq $s5, 0xffffff, level_1_w_continue
			j level_1_key_detect
			level_1_w_continue:
				jal delete_player
				addi $s2, $s2, -4352
				jal draw_player
				j level_1_key_detect
		
			li $v0, 32
			li $a0, 3000 # Wait one second (1000 milliseconds)
			syscall
		
		j level_1_key_detect
		
		fallToOcean_1:
			jal delete_player
			addi $s2, $t0, 8968			# reset the player position
			addi $s7, $zero, 2
			addi $a3, $a3, -1			# HP is decreased by one
			jal clear_all_HP			# update the new HP
			jal draw_HP
			jal draw_player
			j level_1_key_detect
		
		
	main_level_2:
		
		
		
			level_2_key_detect:
			
			beq $a3, 0, good_bye_page				# check if HP is zero, then game is over
			beq $a1, 0, level_3_page				# check if player collects all the coins
			
			jal coin_collision_check_level_2_coin_1
			jal coin_collision_check_level_2_coin_2
			jal coin_collision_check_level_2_coin_3
			jal coin_collision_check_level_2_coin_4
			jal red_cross_collision_check_level_2
			jal grey_cross_collision_check_level_2
			
			
			
			
			gravity_check_level_2:
				add $s6, $zero, $s2				# $s6 temporarily stores the position of player
				addi $s6, $s6, 256				# following code checks if the pixel right blow the player is white a.k.a. is a platform
				lw $s5, ($s6)		
				beq $s5, 0xffffff, continuation_level_2
				addi $s6, $s6, -4
				lw $s5, ($s6)
				beq $s5, 0xffffff, continuation_level_2
				addi $s6, $s6, 8
				lw $s5, ($s6)
				beq $s5, 0xffffff, continuation_level_2
				
				
				
				add $s6, $zero, $s2
				addi $s6, $s6, 256				# following code checks if the pixel right blow the player is blue a.k.a. is an ocean
				lw $s5, ($s6)		
				beq $s5, 0x4d6df3, fallToOcean_2
				addi $s6, $s6, -4
				lw $s5, ($s6)
				beq $s5, 0x4d6df3, fallToOcean_2
				addi $s6, $s6, 8
				lw $s5, ($s6)
				beq $s5, 0x4d6df3, fallToOcean_2
				addi $s6, $s6, 256				
				lw $s5, ($s6)		
				beq $s5, 0x4d6df3, fallToOcean_2
				addi $s6, $s6, -4
				lw $s5, ($s6)
				beq $s5, 0x4d6df3, fallToOcean_2
				addi $s6, $s6, -4
				lw $s5, ($s6)
				beq $s5, 0x4d6df3, fallToOcean_2

				# player is in the air
				# player should be pulled down to the ground
				jal delete_player
				addi $s2, $s2, 256
				jal draw_player	
				
				li $v0, 32
				li $a0, 100 # Wait one second (1000 milliseconds)
				syscall





			continuation_level_2:
				li $t9, 0xffff0000		# check if a key is pressed by the user
				lw $t8, 0($t9)
				beq $t8, 1, keypress_level_2	# jump to key detection
				j level_2_key_detect		# no key is pressed, go back to the first line 
		
			r_key_press_level_2:
				addi $a3, $zero, 3		# reset player HP
				jal clear_all_HP
				jal draw_HP
				j level_2_page
		
			keypress_level_2: 

			lw $t7, 4($t9)					# $t7 stores the key value pressed by user
			beq $t7, 0x64, level_2_d_pressed		# check if key 'd' is pressed
			beq $t7, 0x61, level_2_a_pressed		# check if key 'a' is pressed
			beq $t7, 0x77, level_2_w_pressed		# check if key 'q' is pressed
			beq $t7, 0x71, good_bye_page			# check if key 'q' is pressed
			beq $t7, 0x72, r_key_press_level_2			# check if key 'r' is pressed
			j level_2_key_detect				# no key is pressed, go back to the first line 
			
		level_2_d_pressed:
			beq $s7, 62, level_2_key_detect			# if player already on the boundary, no action requires 

			addi $s0, $s2, 0				# check if there is a platform on the right
			addi $s0, $s0, 8
			lw $s6, ($s0)
			beq $s6, 0xffffff, level_2_key_detect
			addi $s0, $s0, -256
			lw $s6, ($s0)
			beq $s6, 0xffffff, level_2_key_detect
			addi $s0, $s0, -256
			lw $s6, ($s0)
			beq $s6, 0xffffff, level_2_key_detect
			addi $s0, $s0, -256
			lw $s6, ($s0)
			beq $s6, 0xffffff, level_2_key_detect
			
			jal delete_player				# delete original player at the old position
			addi $s2, $s2, 4				# update the new location of the player
			addi $s7, $s7, 1
			jal draw_player					# draw the player at the new position
			j level_2_key_detect
		
		level_2_a_pressed:
			beq $s7, 1, level_2_key_detect			# if player already on the boundary, no action requires 

			addi $s0, $s2, 0				# check if there is a platform on the left
			addi $s0, $s0, -8
			lw $s6, ($s0)
			beq $s6, 0xffffff, level_2_key_detect
			addi $s0, $s0, -256
			lw $s6, ($s0)
			beq $s6, 0xffffff, level_2_key_detect
			addi $s0, $s0, -256
			lw $s6, ($s0)
			beq $s6, 0xffffff, level_2_key_detect
			addi $s0, $s0, -256
			lw $s6, ($s0)
			beq $s6, 0xffffff, level_2_key_detect
	

			jal delete_player				# delete original player at the old position
			addi $s2, $s2, -4				# update the new location of the player
			addi $s7, $s7, -1
			jal draw_player					# draw the player at the new position
			j level_2_key_detect

		level_2_w_pressed:
			add $s6, $zero, $s2				# $s6 temporarily stores the position of player
			addi $s6, $s6, 256				# following code checks if the pixel right blow the player is white a.k.a. is a platform
			lw $s5, ($s6)		
			beq $s5, 0xffffff, level_2_w_continue
			addi $s6, $s6, -4
			lw $s5, ($s6)
			beq $s5, 0xffffff, level_2_w_continue
			addi $s6, $s6, 8
			lw $s5, ($s6)
			beq $s5, 0xffffff, level_2_w_continue
			j level_2_key_detect
			level_2_w_continue:
				jal delete_player
				addi $s2, $s2, -4352
				jal draw_player
				j level_2_key_detect
		
			li $v0, 32
			li $a0, 3000 # Wait one second (1000 milliseconds)
			syscall
		
		j level_2_key_detect
			
		
		
		fallToOcean_2:
			jal delete_player
			addi $s2, $t0, 9228			# update player position
			addi $s7, $zero, 3
			addi $a3, $a3, -1			# HP is decreased by one
			jal clear_all_HP			# update the new HP
			jal draw_HP
			jal draw_player
			j level_2_key_detect
		
		
	
	main_level_3:
			level_3_key_detect:
			
			beq $a3, 0, good_bye_page				# check if HP is zero, then game is over
			beq $a1, 0, winning_page
			
			jal coin_collision_check_level_3_coin_1
			jal coin_collision_check_level_3_coin_2
			jal coin_collision_check_level_3_coin_3
			jal red_cross_collision_check_level_3
			jal grey_cross_collision_check_level_3


			gravity_check_level_3:
				add $s6, $zero, $s2				# $s6 temporarily stores the position of player
				addi $s6, $s6, 256				# following code checks if the pixel right blow the player is white a.k.a. is a platform
				lw $s5, ($s6)		
				beq $s5, 0xffffff, continuation_level_3
				addi $s6, $s6, -4
				lw $s5, ($s6)
				beq $s5, 0xffffff, continuation_level_3
				addi $s6, $s6, 8
				lw $s5, ($s6)
				beq $s5, 0xffffff, continuation_level_3
				
				
				add $s6, $zero, $s2
				addi $s6, $s6, 256				# following code checks if the pixel right blow the player is blue a.k.a. is an ocean
				lw $s5, ($s6)		
				beq $s5, 0x4d6df3, fallToOcean_3
				addi $s6, $s6, -4
				lw $s5, ($s6)
				beq $s5, 0x4d6df3, fallToOcean_3
				addi $s6, $s6, 8
				lw $s5, ($s6)
				beq $s5, 0x4d6df3, fallToOcean_3
				addi $s6, $s6, 256				
				lw $s5, ($s6)		
				beq $s5, 0x4d6df3, fallToOcean_3
				addi $s6, $s6, -4
				lw $s5, ($s6)
				beq $s5, 0x4d6df3, fallToOcean_3
				addi $s6, $s6, -4
				lw $s5, ($s6)
				beq $s5, 0x4d6df3, fallToOcean_3
				
				
				# player is in the air
				# player should be pulled down to the ground
				jal delete_player
				addi $s2, $s2, 256
				jal draw_player	
				
				li $v0, 32
				li $a0, 100 # Wait one second (1000 milliseconds)
				syscall

			continuation_level_3:
				li $t9, 0xffff0000		# check if a key is pressed by the user
				lw $t8, 0($t9)
				beq $t8, 1, keypress_level_3	# jump to key detection
				j level_3_key_detect		# no key is pressed, go back to the first line 
		
			r_key_press_level_3:
				addi $a3, $zero, 3		# reset player HP
				jal clear_all_HP
				jal draw_HP
				j level_3_page
		
			keypress_level_3: 
			lw $t7, 4($t9)					# $t7 stores the key value pressed by user
			beq $t7, 0x64, level_3_d_pressed		# check if key 'd' is pressed
			beq $t7, 0x61, level_3_a_pressed		# check if key 'a' is pressed
			beq $t7, 0x77, level_3_w_pressed		# check if key 'q' is pressed
			beq $t7, 0x71, good_bye_page			# check if key 'q' is pressed
			beq $t7, 0x72, r_key_press_level_3		# check if key 'r' is pressed
			j level_3_key_detect				# no key is pressed, go back to the first line 
			
		level_3_d_pressed:
			beq $s7, 62, level_3_key_detect			# if player already on the boundary, no action requires 


			addi $s0, $s2, 0				# check if there is a platform on the right
			addi $s0, $s0, 8
			lw $s6, ($s0)
			beq $s6, 0xffffff, level_3_key_detect
			addi $s0, $s0, -256
			lw $s6, ($s0)
			beq $s6, 0xffffff, level_3_key_detect
			addi $s0, $s0, -256
			lw $s6, ($s0)
			beq $s6, 0xffffff, level_3_key_detect
			addi $s0, $s0, -256
			lw $s6, ($s0)
			beq $s6, 0xffffff, level_3_key_detect


			jal delete_player				# delete original player at the old position
			addi $s2, $s2, 4				# update the new location of the player
			addi $s7, $s7, 1
			jal draw_player					# draw the player at the new position
			j level_3_key_detect
		
		level_3_a_pressed:
			beq $s7, 1, level_3_key_detect			# if player already on the boundary, no action requires 

			addi $s0, $s2, 0				# check if there is a platform on the left
			addi $s0, $s0, -8
			lw $s6, ($s0)
			beq $s6, 0xffffff, level_3_key_detect
			addi $s0, $s0, -256
			lw $s6, ($s0)
			beq $s6, 0xffffff, level_3_key_detect
			addi $s0, $s0, -256
			lw $s6, ($s0)
			beq $s6, 0xffffff, level_3_key_detect
			addi $s0, $s0, -256
			lw $s6, ($s0)
			beq $s6, 0xffffff, level_3_key_detect
	

			jal delete_player				# delete original player at the old position
			addi $s2, $s2, -4				# update the new location of the player
			addi $s7, $s7, -1
			jal draw_player					# draw the player at the new position
			j level_3_key_detect

		level_3_w_pressed:
			add $s6, $zero, $s2				# $s6 temporarily stores the position of player
			addi $s6, $s6, 256				# following code checks if the pixel right blow the player is white a.k.a. is a platform
			lw $s5, ($s6)		
			beq $s5, 0xffffff, level_3_w_continue
			addi $s6, $s6, -4
			lw $s5, ($s6)
			beq $s5, 0xffffff, level_3_w_continue
			addi $s6, $s6, 8
			lw $s5, ($s6)
			beq $s5, 0xffffff, level_3_w_continue
			j level_3_key_detect
			level_3_w_continue:
				jal delete_player
				addi $s2, $s2, -4352
				jal draw_player
				j level_3_key_detect
		
			li $v0, 32
			li $a0, 3000 # Wait one second (1000 milliseconds)
			syscall
		
		j level_3_key_detect
		
		fallToOcean_3:
			jal delete_player
			addi $s2, $t0, 8208			# update player position
			addi $s7, $zero, 4
			addi $a3, $a3, -1			# HP is decreased by one
			jal clear_all_HP			# update the new HP
			jal draw_HP
			jal draw_player
			j level_3_key_detect
	j main

# this function checks if the player collides with the coin 1
coin_collision_check_level_1_coin_1:

	addi $sp, $sp, -4
	sw $ra, ($sp)				# push $ra to the stack

	addi $s3, $t0, 9048			# collide with coin one
	lw $s5, ($s3)
	beq $s5, $t2, go_on_11			# color is still yellow
	lw $ra, ($sp)
	addi $sp, $sp, 4			# pop $ra from the stack
	jr $ra
	
	go_on_11:
	addi $s3, $s3, -8			
	beq $s2, $s3, level_1_delete_coin_1
	addi $s3, $s3, -256
	beq $s2, $s3, level_1_delete_coin_1
	addi $s3, $s3, -256
	beq $s2, $s3, level_1_delete_coin_1
	addi $s3, $s3, -256
	beq $s2, $s3, level_1_delete_coin_1
	addi $s3, $s3, 4
	beq $s2, $s3, level_1_delete_coin_1
	addi $s3, $s3, 256
	beq $s2, $s3, level_1_delete_coin_1
	addi $s3, $s3, 256
	beq $s2, $s3, level_1_delete_coin_1
	addi $s3, $s3, 256
	beq $s2, $s3, level_1_delete_coin_1
	addi $s3, $s3, 4
	beq $s2, $s3, level_1_delete_coin_1
	addi $s3, $s3, -256
	beq $s2, $s3, level_1_delete_coin_1
	addi $s3, $s3, -256
	beq $s2, $s3, level_1_delete_coin_1
	addi $s3, $s3, -256
	beq $s2, $s3, level_1_delete_coin_1
	addi $s3, $s3, 4
	beq $s2, $s3, level_1_delete_coin_1
	addi $s3, $s3, 256
	beq $s2, $s3, level_1_delete_coin_1
	addi $s3, $s3, 256
	beq $s2, $s3, level_1_delete_coin_1
	addi $s3, $s3, 256
	beq $s2, $s3, level_1_delete_coin_1
	addi $s3, $s3, 4
	beq $s2, $s3, level_1_delete_coin_1
	addi $s3, $s3, -256
	beq $s2, $s3, level_1_delete_coin_1
	addi $s3, $s3, -256
	beq $s2, $s3, level_1_delete_coin_1
	addi $s3, $s3, -256
	beq $s2, $s3, level_1_delete_coin_1

	coin_collision_check_level_11_rest:
	jal draw_player
	lw $ra, ($sp)
	addi $sp, $sp, 4			# pop $ra from the stack
	jr $ra
	
	level_1_delete_coin_1:
		addi $s3, $t0, 9048
		sw $t5, ($s3)
		sw $t5, -256($s3)
		sw $t5, -512($s3)
		sw $t5, -768($s3)
		sw $t5, -516($s3)
		sw $t5, -508($s3)
		sw $t5, -260($s3)
		sw $t5, -252($s3)
		add $a1, $a1, -1
		jal delete_score
		jal draw_score
		j coin_collision_check_level_11_rest
	
	
# this function checks if the player collides with the coin 2
coin_collision_check_level_1_coin_2:

	addi $sp, $sp, -4
	sw $ra, ($sp)				# push $ra to the stack

	addi $s3, $t0, 6488			# collide with coin one
	lw $s5, ($s3)
	beq $s5, $t2, go_on_12			# color is still yellow
	lw $ra, ($sp)
	addi $sp, $sp, 4			# pop $ra from the stack
	jr $ra
	
	go_on_12:
	addi $s3, $s3, -8			
	beq $s2, $s3, level_1_delete_coin_2
	addi $s3, $s3, -256
	beq $s2, $s3, level_1_delete_coin_2
	addi $s3, $s3, -256
	beq $s2, $s3, level_1_delete_coin_2
	addi $s3, $s3, -256
	beq $s2, $s3, level_1_delete_coin_2
	addi $s3, $s3, 4
	beq $s2, $s3, level_1_delete_coin_2
	addi $s3, $s3, 256
	beq $s2, $s3, level_1_delete_coin_2
	addi $s3, $s3, 256
	beq $s2, $s3, level_1_delete_coin_2
	addi $s3, $s3, 256
	beq $s2, $s3, level_1_delete_coin_2
	addi $s3, $s3, 4
	beq $s2, $s3, level_1_delete_coin_2
	addi $s3, $s3, -256
	beq $s2, $s3, level_1_delete_coin_2
	addi $s3, $s3, -256
	beq $s2, $s3, level_1_delete_coin_2
	addi $s3, $s3, -256
	beq $s2, $s3, level_1_delete_coin_2
	addi $s3, $s3, 4
	beq $s2, $s3, level_1_delete_coin_2
	addi $s3, $s3, 256
	beq $s2, $s3, level_1_delete_coin_2
	addi $s3, $s3, 256
	beq $s2, $s3, level_1_delete_coin_2
	addi $s3, $s3, 256
	beq $s2, $s3, level_1_delete_coin_2
	addi $s3, $s3, 4
	beq $s2, $s3, level_1_delete_coin_2
	addi $s3, $s3, -256
	beq $s2, $s3, level_1_delete_coin_2
	addi $s3, $s3, -256
	beq $s2, $s3, level_1_delete_coin_2
	addi $s3, $s3, -256
	beq $s2, $s3, level_1_delete_coin_2

	coin_collision_check_level_12_rest:
	jal draw_player
	lw $ra, ($sp)
	addi $sp, $sp, 4			# pop $ra from the stack
	jr $ra
	
	level_1_delete_coin_2:
		addi $s3, $t0, 6488
		sw $t5, ($s3)
		sw $t5, -256($s3)
		sw $t5, -512($s3)
		sw $t5, -768($s3)
		sw $t5, -516($s3)
		sw $t5, -508($s3)
		sw $t5, -260($s3)
		sw $t5, -252($s3)
		add $a1, $a1, -1
		jal delete_score
		jal draw_score
		j coin_collision_check_level_12_rest
		
		
# this function checks if the player collides with the coin 3
coin_collision_check_level_1_coin_3:

	addi $sp, $sp, -4
	sw $ra, ($sp)				# push $ra to the stack

	addi $s3, $t0, 6584			# collide with coin one
	lw $s5, ($s3)
	beq $s5, $t2, go_on_13			# color is still yellow
	lw $ra, ($sp)
	addi $sp, $sp, 4			# pop $ra from the stack
	jr $ra
	
	go_on_13:
	addi $s3, $s3, -8			
	beq $s2, $s3, level_1_delete_coin_3
	addi $s3, $s3, -256
	beq $s2, $s3, level_1_delete_coin_3
	addi $s3, $s3, -256
	beq $s2, $s3, level_1_delete_coin_3
	addi $s3, $s3, -256
	beq $s2, $s3, level_1_delete_coin_3
	addi $s3, $s3, 4
	beq $s2, $s3, level_1_delete_coin_3
	addi $s3, $s3, 256
	beq $s2, $s3, level_1_delete_coin_3
	addi $s3, $s3, 256
	beq $s2, $s3, level_1_delete_coin_3
	addi $s3, $s3, 256
	beq $s2, $s3, level_1_delete_coin_3
	addi $s3, $s3, 4
	beq $s2, $s3, level_1_delete_coin_3
	addi $s3, $s3, -256
	beq $s2, $s3, level_1_delete_coin_3
	addi $s3, $s3, -256
	beq $s2, $s3, level_1_delete_coin_3
	addi $s3, $s3, -256
	beq $s2, $s3, level_1_delete_coin_3
	addi $s3, $s3, 4
	beq $s2, $s3, level_1_delete_coin_3
	addi $s3, $s3, 256
	beq $s2, $s3, level_1_delete_coin_3
	addi $s3, $s3, 256
	beq $s2, $s3, level_1_delete_coin_3
	addi $s3, $s3, 256
	beq $s2, $s3, level_1_delete_coin_3
	addi $s3, $s3, 4
	beq $s2, $s3, level_1_delete_coin_3
	addi $s3, $s3, -256
	beq $s2, $s3, level_1_delete_coin_3
	addi $s3, $s3, -256
	beq $s2, $s3, level_1_delete_coin_3
	addi $s3, $s3, -256
	beq $s2, $s3, level_1_delete_coin_3

	coin_collision_check_level_13_rest:
	jal draw_player
	lw $ra, ($sp)
	addi $sp, $sp, 4			# pop $ra from the stack
	jr $ra
	
	level_1_delete_coin_3:
		addi $s3, $t0, 6584
		sw $t5, ($s3)
		sw $t5, -256($s3)
		sw $t5, -512($s3)
		sw $t5, -768($s3)
		sw $t5, -516($s3)
		sw $t5, -508($s3)
		sw $t5, -260($s3)
		sw $t5, -252($s3)
		add $a1, $a1, -1
		jal delete_score
		jal draw_score
		j coin_collision_check_level_13_rest



# this function checks if the player collides with the coin 4
coin_collision_check_level_1_coin_4:

	addi $sp, $sp, -4
	sw $ra, ($sp)				# push $ra to the stack

	addi $s3, $t0, 4016			# collide with coin one
	lw $s5, ($s3)
	beq $s5, $t2, go_on_14			# color is still yellow
	lw $ra, ($sp)
	addi $sp, $sp, 4			# pop $ra from the stack
	jr $ra
	
	go_on_14:
	addi $s3, $s3, -8			
	beq $s2, $s3, level_1_delete_coin_4
	addi $s3, $s3, -256
	beq $s2, $s3, level_1_delete_coin_4
	addi $s3, $s3, -256
	beq $s2, $s3, level_1_delete_coin_4
	addi $s3, $s3, -256
	beq $s2, $s3, level_1_delete_coin_4
	addi $s3, $s3, 4
	beq $s2, $s3, level_1_delete_coin_4
	addi $s3, $s3, 256
	beq $s2, $s3, level_1_delete_coin_4
	addi $s3, $s3, 256
	beq $s2, $s3, level_1_delete_coin_4
	addi $s3, $s3, 256
	beq $s2, $s3, level_1_delete_coin_4
	addi $s3, $s3, 4
	beq $s2, $s3, level_1_delete_coin_4
	addi $s3, $s3, -256
	beq $s2, $s3, level_1_delete_coin_4
	addi $s3, $s3, -256
	beq $s2, $s3, level_1_delete_coin_4
	addi $s3, $s3, -256
	beq $s2, $s3, level_1_delete_coin_4
	addi $s3, $s3, 4
	beq $s2, $s3, level_1_delete_coin_4
	addi $s3, $s3, 256
	beq $s2, $s3, level_1_delete_coin_4
	addi $s3, $s3, 256
	beq $s2, $s3, level_1_delete_coin_4
	addi $s3, $s3, 256
	beq $s2, $s3, level_1_delete_coin_4
	addi $s3, $s3, 4
	beq $s2, $s3, level_1_delete_coin_4
	addi $s3, $s3, -256
	beq $s2, $s3, level_1_delete_coin_4
	addi $s3, $s3, -256
	beq $s2, $s3, level_1_delete_coin_4
	addi $s3, $s3, -256
	beq $s2, $s3, level_1_delete_coin_4

	coin_collision_check_level_14_rest:
	jal draw_player
	lw $ra, ($sp)
	addi $sp, $sp, 4			# pop $ra from the stack
	jr $ra
	
	level_1_delete_coin_4:
		addi $s3, $t0, 4016
		sw $t5, ($s3)
		sw $t5, -256($s3)
		sw $t5, -512($s3)
		sw $t5, -768($s3)
		sw $t5, -516($s3)
		sw $t5, -508($s3)
		sw $t5, -260($s3)
		sw $t5, -252($s3)
		add $a1, $a1, -1
		jal delete_score
		jal draw_score
		j coin_collision_check_level_14_rest


red_cross_collision_check_level_1:
	addi $sp, $sp, -4
	sw $ra, ($sp)				# push $ra to the stack

	addi $s3, $t0, 	9964			# collide with red cross
	lw $s5, ($s3)
	beq $s5, $t4, go_on_111			# color is still red
	lw $ra, ($sp)
	addi $sp, $sp, 4			# pop $ra from the stack
	jr $ra
	
	go_on_111:
	addi $s3, $s3, -8			
	beq $s2, $s3, level_1_delete_red_cross
	addi $s3, $s3, -256
	beq $s2, $s3, level_1_delete_red_cross
	addi $s3, $s3, -256
	beq $s2, $s3, level_1_delete_red_cross
	addi $s3, $s3, 4
	beq $s2, $s3, level_1_delete_red_cross
	addi $s3, $s3, 256
	beq $s2, $s3, level_1_delete_red_cross
	addi $s3, $s3, 256
	beq $s2, $s3, level_1_delete_red_cross
	addi $s3, $s3, 4
	beq $s2, $s3, level_1_delete_red_cross
	addi $s3, $s3, -256
	beq $s2, $s3, level_1_delete_red_cross
	addi $s3, $s3, -256
	beq $s2, $s3, level_1_delete_red_cross
	addi $s3, $s3, 4
	beq $s2, $s3, level_1_delete_red_cross
	addi $s3, $s3, 256
	beq $s2, $s3, level_1_delete_red_cross
	addi $s3, $s3, 256
	beq $s2, $s3, level_1_delete_red_cross
	addi $s3, $s3, 4
	beq $s2, $s3, level_1_delete_red_cross
	addi $s3, $s3, -256
	beq $s2, $s3, level_1_delete_red_cross
	addi $s3, $s3, -256
	beq $s2, $s3, level_1_delete_red_cross

	red_cross_collision_check_level_111_rest:
	jal draw_player
	lw $ra, ($sp)
	addi $sp, $sp, 4			# pop $ra from the stack
	jr $ra
	
	level_1_delete_red_cross:
		addi $s3, $t0, 9964
		sw $t5, ($s3)
		sw $t5, -256($s3)
		sw $t5, -512($s3)
		sw $t5, -260($s3)
		sw $t5, -252($s3)
		addi $a3, $a3, 1
		jal clear_all_HP
		jal draw_HP

		j red_cross_collision_check_level_111_rest



grey_cross_collision_check_level_1:
	addi $sp, $sp, -4
	sw $ra, ($sp)				# push $ra to the stack

	addi $s3, $t0, 	4080			# collide with grey cross
	addi $s3, $s3, -256
	lw $s5, ($s3)
	beq $s5, 0xb6b6b6, go_on_1111		# color is still grey
	lw $ra, ($sp)
	addi $sp, $sp, 4			# pop $ra from the stack
	jr $ra
	
	go_on_1111:
	addi $s3, $s3, 248			
	beq $s2, $s3, level_1_delete_grey_cross
	addi $s3, $s3, -256
	beq $s2, $s3, level_1_delete_grey_cross
	addi $s3, $s3, -256
	beq $s2, $s3, level_1_delete_grey_cross
	addi $s3, $s3, 4
	beq $s2, $s3, level_1_delete_grey_cross
	addi $s3, $s3, 256
	beq $s2, $s3, level_1_delete_grey_cross
	addi $s3, $s3, 256
	beq $s2, $s3, level_1_delete_grey_cross
	addi $s3, $s3, 4
	beq $s2, $s3, level_1_delete_grey_cross
	addi $s3, $s3, -256
	beq $s2, $s3, level_1_delete_grey_cross
	addi $s3, $s3, -256
	beq $s2, $s3, level_1_delete_grey_cross
	addi $s3, $s3, 4
	beq $s2, $s3, level_1_delete_grey_cross
	addi $s3, $s3, 256
	beq $s2, $s3, level_1_delete_grey_cross
	addi $s3, $s3, 256
	beq $s2, $s3, level_1_delete_grey_cross
	addi $s3, $s3, 4
	beq $s2, $s3, level_1_delete_grey_cross
	addi $s3, $s3, -256
	beq $s2, $s3, level_1_delete_grey_cross
	addi $s3, $s3, -256
	beq $s2, $s3, level_1_delete_grey_cross

	grey_cross_collision_check_level_1111_rest:
	jal draw_player
	lw $ra, ($sp)
	addi $sp, $sp, 4			# pop $ra from the stack
	jr $ra
	
	level_1_delete_grey_cross:
		addi $s3, $t0, 4084
		sw $t5, ($s3)
		sw $t5, -512($s3)
		sw $t5, -8($s3)
		sw $t5, -520($s3)
		sw $t5, -260($s3)
		
		addi $s7, $zero, 31		# player will render to a new position
		jal delete_player
		addi $s2, $t0, 892

		j grey_cross_collision_check_level_1111_rest
		
		
#########################level 2##################################3
# this function checks if the player collides with the coin 1
coin_collision_check_level_2_coin_1:

	addi $sp, $sp, -4
	sw $ra, ($sp)				# push $ra to the stack

	addi $s3, $t0, 2324			# collide with coin one
	lw $s5, ($s3)
	beq $s5, $t2, go_on_21			# color is still yellow
	lw $ra, ($sp)
	addi $sp, $sp, 4			# pop $ra from the stack
	jr $ra
	
	go_on_21:
	addi $s3, $s3, -8			
	beq $s2, $s3, level_2_delete_coin_1
	addi $s3, $s3, -256
	beq $s2, $s3, level_2_delete_coin_1
	addi $s3, $s3, -256
	beq $s2, $s3, level_2_delete_coin_1
	addi $s3, $s3, -256
	beq $s2, $s3, level_2_delete_coin_1
	addi $s3, $s3, 4
	beq $s2, $s3, level_2_delete_coin_1
	addi $s3, $s3, 256
	beq $s2, $s3, level_2_delete_coin_1
	addi $s3, $s3, 256
	beq $s2, $s3, level_2_delete_coin_1
	addi $s3, $s3, 256
	beq $s2, $s3, level_2_delete_coin_1
	addi $s3, $s3, 4
	beq $s2, $s3, level_2_delete_coin_1
	addi $s3, $s3, -256
	beq $s2, $s3, level_2_delete_coin_1
	addi $s3, $s3, -256
	beq $s2, $s3, level_2_delete_coin_1
	addi $s3, $s3, -256
	beq $s2, $s3, level_2_delete_coin_1
	addi $s3, $s3, 4
	beq $s2, $s3, level_2_delete_coin_1
	addi $s3, $s3, 256
	beq $s2, $s3, level_2_delete_coin_1
	addi $s3, $s3, 256
	beq $s2, $s3, level_2_delete_coin_1
	addi $s3, $s3, 256
	beq $s2, $s3, level_2_delete_coin_1
	addi $s3, $s3, 4
	beq $s2, $s3, level_2_delete_coin_1
	addi $s3, $s3, -256
	beq $s2, $s3, level_2_delete_coin_1
	addi $s3, $s3, -256
	beq $s2, $s3, level_2_delete_coin_1
	addi $s3, $s3, -256
	beq $s2, $s3, level_2_delete_coin_1

	coin_collision_check_level_21_rest:
	jal draw_player
	lw $ra, ($sp)
	addi $sp, $sp, 4			# pop $ra from the stack
	jr $ra
	
	level_2_delete_coin_1:
		addi $s3, $t0, 2324
		sw $t5, ($s3)
		sw $t5, -256($s3)
		sw $t5, -512($s3)
		sw $t5, -768($s3)
		sw $t5, -516($s3)
		sw $t5, -508($s3)
		sw $t5, -260($s3)
		sw $t5, -252($s3)
		add $a1, $a1, -1
		jal delete_score
		jal draw_score

		j coin_collision_check_level_21_rest
	
	
# this function checks if the player collides with the coin 2
coin_collision_check_level_2_coin_2:

	addi $sp, $sp, -4
	sw $ra, ($sp)				# push $ra to the stack

	addi $s3, $t0, 2372			# collide with coin one
	lw $s5, ($s3)
	beq $s5, $t2, go_on_22			# color is still yellow
	lw $ra, ($sp)
	addi $sp, $sp, 4			# pop $ra from the stack
	jr $ra
	
	go_on_22:
	addi $s3, $s3, -8			
	beq $s2, $s3, level_2_delete_coin_2
	addi $s3, $s3, -256
	beq $s2, $s3, level_2_delete_coin_2
	addi $s3, $s3, -256
	beq $s2, $s3, level_2_delete_coin_2
	addi $s3, $s3, -256
	beq $s2, $s3, level_2_delete_coin_2
	addi $s3, $s3, 4
	beq $s2, $s3, level_2_delete_coin_2
	addi $s3, $s3, 256
	beq $s2, $s3, level_2_delete_coin_2
	addi $s3, $s3, 256
	beq $s2, $s3, level_2_delete_coin_2
	addi $s3, $s3, 256
	beq $s2, $s3, level_2_delete_coin_2
	addi $s3, $s3, 4
	beq $s2, $s3, level_2_delete_coin_2
	addi $s3, $s3, -256
	beq $s2, $s3, level_2_delete_coin_2
	addi $s3, $s3, -256
	beq $s2, $s3, level_2_delete_coin_2
	addi $s3, $s3, -256
	beq $s2, $s3, level_2_delete_coin_2
	addi $s3, $s3, 4
	beq $s2, $s3, level_2_delete_coin_2
	addi $s3, $s3, 256
	beq $s2, $s3, level_2_delete_coin_2
	addi $s3, $s3, 256
	beq $s2, $s3, level_2_delete_coin_2
	addi $s3, $s3, 256
	beq $s2, $s3, level_2_delete_coin_2
	addi $s3, $s3, 4
	beq $s2, $s3, level_2_delete_coin_2
	addi $s3, $s3, -256
	beq $s2, $s3, level_2_delete_coin_2
	addi $s3, $s3, -256
	beq $s2, $s3, level_2_delete_coin_2
	addi $s3, $s3, -256
	beq $s2, $s3, level_2_delete_coin_2

	coin_collision_check_level_22_rest:
	jal draw_player
	lw $ra, ($sp)
	addi $sp, $sp, 4			# pop $ra from the stack
	jr $ra
	
	level_2_delete_coin_2:
		addi $s3, $t0, 2372
		sw $t5, ($s3)
		sw $t5, -256($s3)
		sw $t5, -512($s3)
		sw $t5, -768($s3)
		sw $t5, -516($s3)
		sw $t5, -508($s3)
		sw $t5, -260($s3)
		sw $t5, -252($s3)
		add $a1, $a1, -1
		jal delete_score
		jal draw_score

		j coin_collision_check_level_22_rest
		
		
# this function checks if the player collides with the coin 3
coin_collision_check_level_2_coin_3:

	addi $sp, $sp, -4
	sw $ra, ($sp)				# push $ra to the stack

	addi $s3, $t0, 5780			# collide with coin one
	lw $s5, ($s3)
	beq $s5, $t2, go_on_23			# color is still yellow
	lw $ra, ($sp)
	addi $sp, $sp, 4			# pop $ra from the stack
	jr $ra
	
	go_on_23:
	addi $s3, $s3, -8			
	beq $s2, $s3, level_2_delete_coin_3
	addi $s3, $s3, -256
	beq $s2, $s3, level_2_delete_coin_3
	addi $s3, $s3, -256
	beq $s2, $s3, level_2_delete_coin_3
	addi $s3, $s3, -256
	beq $s2, $s3, level_2_delete_coin_3
	addi $s3, $s3, 4
	beq $s2, $s3, level_2_delete_coin_3
	addi $s3, $s3, 256
	beq $s2, $s3, level_2_delete_coin_3
	addi $s3, $s3, 256
	beq $s2, $s3, level_2_delete_coin_3
	addi $s3, $s3, 256
	beq $s2, $s3, level_2_delete_coin_3
	addi $s3, $s3, 4
	beq $s2, $s3, level_2_delete_coin_3
	addi $s3, $s3, -256
	beq $s2, $s3, level_2_delete_coin_3
	addi $s3, $s3, -256
	beq $s2, $s3, level_2_delete_coin_3
	addi $s3, $s3, -256
	beq $s2, $s3, level_2_delete_coin_3
	addi $s3, $s3, 4
	beq $s2, $s3, level_2_delete_coin_3
	addi $s3, $s3, 256
	beq $s2, $s3, level_2_delete_coin_3
	addi $s3, $s3, 256
	beq $s2, $s3, level_2_delete_coin_3
	addi $s3, $s3, 256
	beq $s2, $s3, level_2_delete_coin_3
	addi $s3, $s3, 4
	beq $s2, $s3, level_2_delete_coin_3
	addi $s3, $s3, -256
	beq $s2, $s3, level_2_delete_coin_3
	addi $s3, $s3, -256
	beq $s2, $s3, level_2_delete_coin_3
	addi $s3, $s3, -256
	beq $s2, $s3, level_2_delete_coin_3

	coin_collision_check_level_23_rest:
	jal draw_player
	lw $ra, ($sp)
	addi $sp, $sp, 4			# pop $ra from the stack
	jr $ra
	
	level_2_delete_coin_3:
		addi $s3, $t0, 5780
		sw $t5, ($s3)
		sw $t5, -256($s3)
		sw $t5, -512($s3)
		sw $t5, -768($s3)
		sw $t5, -516($s3)
		sw $t5, -508($s3)
		sw $t5, -260($s3)
		sw $t5, -252($s3)
		add $a1, $a1, -1
		jal delete_score
		jal draw_score

		j coin_collision_check_level_23_rest



# this function checks if the player collides with the coin 4
coin_collision_check_level_2_coin_4:

	addi $sp, $sp, -4
	sw $ra, ($sp)				# push $ra to the stack

	addi $s3, $t0, 2544			# collide with coin one
	lw $s5, ($s3)
	beq $s5, $t2, go_on_24			# color is still yellow
	lw $ra, ($sp)
	addi $sp, $sp, 4			# pop $ra from the stack
	jr $ra
	
	go_on_24:
	addi $s3, $s3, -8			
	beq $s2, $s3, level_2_delete_coin_4
	addi $s3, $s3, -256
	beq $s2, $s3, level_2_delete_coin_4
	addi $s3, $s3, -256
	beq $s2, $s3, level_2_delete_coin_4
	addi $s3, $s3, -256
	beq $s2, $s3, level_2_delete_coin_4
	addi $s3, $s3, 4
	beq $s2, $s3, level_2_delete_coin_4
	addi $s3, $s3, 256
	beq $s2, $s3, level_2_delete_coin_4
	addi $s3, $s3, 256
	beq $s2, $s3, level_2_delete_coin_4
	addi $s3, $s3, 256
	beq $s2, $s3, level_2_delete_coin_4
	addi $s3, $s3, 4
	beq $s2, $s3, level_2_delete_coin_4
	addi $s3, $s3, -256
	beq $s2, $s3, level_2_delete_coin_4
	addi $s3, $s3, -256
	beq $s2, $s3, level_2_delete_coin_4
	addi $s3, $s3, -256
	beq $s2, $s3, level_2_delete_coin_4
	addi $s3, $s3, 4
	beq $s2, $s3, level_2_delete_coin_4
	addi $s3, $s3, 256
	beq $s2, $s3, level_2_delete_coin_4
	addi $s3, $s3, 256
	beq $s2, $s3, level_2_delete_coin_4
	addi $s3, $s3, 256
	beq $s2, $s3, level_2_delete_coin_4
	addi $s3, $s3, 4
	beq $s2, $s3, level_2_delete_coin_4
	addi $s3, $s3, -256
	beq $s2, $s3, level_2_delete_coin_4
	addi $s3, $s3, -256
	beq $s2, $s3, level_2_delete_coin_4
	addi $s3, $s3, -256
	beq $s2, $s3, level_2_delete_coin_4

	coin_collision_check_level_24_rest:
	jal draw_player
	lw $ra, ($sp)
	addi $sp, $sp, 4			# pop $ra from the stack
	jr $ra
	
	level_2_delete_coin_4:
		addi $s3, $t0, 2544
		sw $t5, ($s3)
		sw $t5, -256($s3)
		sw $t5, -512($s3)
		sw $t5, -768($s3)
		sw $t5, -516($s3)
		sw $t5, -508($s3)
		sw $t5, -260($s3)
		sw $t5, -252($s3)
		add $a1, $a1, -1
		jal delete_score
		jal draw_score

		j coin_collision_check_level_24_rest


red_cross_collision_check_level_2:
	addi $sp, $sp, -4
	sw $ra, ($sp)				# push $ra to the stack

	addi $s3, $t0, 	2488			# collide with red cross
	lw $s5, ($s3)
	beq $s5, $t4, go_on_222		# color is still red
	lw $ra, ($sp)
	addi $sp, $sp, 4			# pop $ra from the stack
	jr $ra
	
	go_on_222:
	addi $s3, $s3, -8			
	beq $s2, $s3, level_2_delete_red_cross
	addi $s3, $s3, -256
	beq $s2, $s3, level_2_delete_red_cross
	addi $s3, $s3, -256
	beq $s2, $s3, level_2_delete_red_cross
	addi $s3, $s3, 4
	beq $s2, $s3, level_2_delete_red_cross
	addi $s3, $s3, 256
	beq $s2, $s3, level_2_delete_red_cross
	addi $s3, $s3, 256
	beq $s2, $s3, level_2_delete_red_cross
	addi $s3, $s3, 4
	beq $s2, $s3, level_2_delete_red_cross
	addi $s3, $s3, -256
	beq $s2, $s3, level_2_delete_red_cross
	addi $s3, $s3, -256
	beq $s2, $s3, level_2_delete_red_cross
	addi $s3, $s3, 4
	beq $s2, $s3, level_2_delete_red_cross
	addi $s3, $s3, 256
	beq $s2, $s3, level_2_delete_red_cross
	addi $s3, $s3, 256
	beq $s2, $s3, level_2_delete_red_cross
	addi $s3, $s3, 4
	beq $s2, $s3, level_2_delete_red_cross
	addi $s3, $s3, -256
	beq $s2, $s3, level_2_delete_red_cross
	addi $s3, $s3, -256
	beq $s2, $s3, level_2_delete_red_cross

	red_cross_collision_check_level_222_rest:
	jal draw_player
	lw $ra, ($sp)
	addi $sp, $sp, 4			# pop $ra from the stack
	jr $ra
	
	level_2_delete_red_cross:
		addi $s3, $t0, 2488
		sw $t5, ($s3)
		sw $t5, -256($s3)
		sw $t5, -512($s3)
		sw $t5, -260($s3)
		sw $t5, -252($s3)
		addi $a3, $a3, 1
		jal clear_all_HP
		jal draw_HP
		j red_cross_collision_check_level_222_rest


grey_cross_collision_check_level_2:
	addi $sp, $sp, -4
	sw $ra, ($sp)				# push $ra to the stack

	addi $s3, $t0, 	5832			# collide with grey cross
	addi $s3, $s3, -256
	lw $s5, ($s3)
	beq $s5, 0xb6b6b6, go_on_2222		# color is still grey
	lw $ra, ($sp)
	addi $sp, $sp, 4			# pop $ra from the stack
	jr $ra
	
	go_on_2222:
	addi $s3, $s3, 248			
	beq $s2, $s3, level_2_delete_grey_cross
	addi $s3, $s3, -256
	beq $s2, $s3, level_2_delete_grey_cross
	addi $s3, $s3, -256
	beq $s2, $s3, level_2_delete_grey_cross
	addi $s3, $s3, 4
	beq $s2, $s3, level_2_delete_grey_cross
	addi $s3, $s3, 256
	beq $s2, $s3, level_2_delete_grey_cross
	addi $s3, $s3, 256
	beq $s2, $s3, level_2_delete_grey_cross
	addi $s3, $s3, 4
	beq $s2, $s3, level_2_delete_grey_cross
	addi $s3, $s3, -256
	beq $s2, $s3, level_2_delete_grey_cross
	addi $s3, $s3, -256
	beq $s2, $s3, level_2_delete_grey_cross
	addi $s3, $s3, 4
	beq $s2, $s3, level_2_delete_grey_cross
	addi $s3, $s3, 256
	beq $s2, $s3, level_2_delete_grey_cross
	addi $s3, $s3, 256
	beq $s2, $s3, level_2_delete_grey_cross
	addi $s3, $s3, 4
	beq $s2, $s3, level_2_delete_grey_cross
	addi $s3, $s3, -256
	beq $s2, $s3, level_2_delete_grey_cross
	addi $s3, $s3, -256
	beq $s2, $s3, level_2_delete_grey_cross

	grey_cross_collision_check_level_2222_rest:
	jal draw_player
	lw $ra, ($sp)
	addi $sp, $sp, 4			# pop $ra from the stack
	jr $ra
	
	level_2_delete_grey_cross:
		addi $s3, $t0, 5828
		sw $t5, ($s3)
		sw $t5, -512($s3)
		sw $t5, 8($s3)
		sw $t5, -252($s3)
		sw $t5, -504($s3)
		
		addi $s7, $zero, 31		# player will render to a new position
		jal delete_player
		addi $s2, $t0, 892

		j grey_cross_collision_check_level_2222_rest
		


###############################level 3####################################
coin_collision_check_level_3_coin_1:

	addi $sp, $sp, -4
	sw $ra, ($sp)				# push $ra to the stack

	addi $s3, $t0, 6212			# collide with coin one
	lw $s5, ($s3)
	beq $s5, $t2, go_on_31			# color is still yellow
	lw $ra, ($sp)
	addi $sp, $sp, 4			# pop $ra from the stack
	jr $ra
	
	go_on_31:
	addi $s3, $s3, -8			
	beq $s2, $s3, level_3_delete_coin_1
	addi $s3, $s3, -256
	beq $s2, $s3, level_3_delete_coin_1
	addi $s3, $s3, -256
	beq $s2, $s3, level_3_delete_coin_1
	addi $s3, $s3, -256
	beq $s2, $s3, level_3_delete_coin_1
	addi $s3, $s3, 4
	beq $s2, $s3, level_3_delete_coin_1
	addi $s3, $s3, 256
	beq $s2, $s3, level_3_delete_coin_1
	addi $s3, $s3, 256
	beq $s2, $s3, level_3_delete_coin_1
	addi $s3, $s3, 256
	beq $s2, $s3, level_3_delete_coin_1
	addi $s3, $s3, 4
	beq $s2, $s3, level_3_delete_coin_1
	addi $s3, $s3, -256
	beq $s2, $s3, level_3_delete_coin_1
	addi $s3, $s3, -256
	beq $s2, $s3, level_3_delete_coin_1
	addi $s3, $s3, -256
	beq $s2, $s3, level_3_delete_coin_1
	addi $s3, $s3, 4
	beq $s2, $s3, level_3_delete_coin_1
	addi $s3, $s3, 256
	beq $s2, $s3, level_3_delete_coin_1
	addi $s3, $s3, 256
	beq $s2, $s3, level_3_delete_coin_1
	addi $s3, $s3, 256
	beq $s2, $s3, level_3_delete_coin_1
	addi $s3, $s3, 4
	beq $s2, $s3, level_3_delete_coin_1
	addi $s3, $s3, -256
	beq $s2, $s3, level_3_delete_coin_1
	addi $s3, $s3, -256
	beq $s2, $s3, level_3_delete_coin_1
	addi $s3, $s3, -256
	beq $s2, $s3, level_3_delete_coin_1

	coin_collision_check_level_31_rest:
	jal draw_player
	lw $ra, ($sp)
	addi $sp, $sp, 4			# pop $ra from the stack
	jr $ra
	
	level_3_delete_coin_1:
		addi $s3, $t0, 6212
		sw $t5, ($s3)
		sw $t5, -256($s3)
		sw $t5, -512($s3)
		sw $t5, -768($s3)
		sw $t5, -516($s3)
		sw $t5, -508($s3)
		sw $t5, -260($s3)
		sw $t5, -252($s3)
		addi $a1, $a1, -1
		jal delete_score
		jal draw_score

		j coin_collision_check_level_31_rest
	
	
# this function checks if the player collides with the coin 2
coin_collision_check_level_3_coin_2:

	addi $sp, $sp, -4
	sw $ra, ($sp)				# push $ra to the stack

	addi $s3, $t0, 4476			# collide with coin one
	lw $s5, ($s3)
	beq $s5, $t2, go_on_32			# color is still yellow
	lw $ra, ($sp)
	addi $sp, $sp, 4			# pop $ra from the stack
	jr $ra
	
	go_on_32:
	addi $s3, $s3, -8			
	beq $s2, $s3, level_3_delete_coin_2
	addi $s3, $s3, -256
	beq $s2, $s3, level_3_delete_coin_2
	addi $s3, $s3, -256
	beq $s2, $s3, level_3_delete_coin_2
	addi $s3, $s3, -256
	beq $s2, $s3, level_3_delete_coin_2
	addi $s3, $s3, 4
	beq $s2, $s3, level_3_delete_coin_2
	addi $s3, $s3, 256
	beq $s2, $s3, level_3_delete_coin_2
	addi $s3, $s3, 256
	beq $s2, $s3, level_3_delete_coin_2
	addi $s3, $s3, 256
	beq $s2, $s3, level_3_delete_coin_2
	addi $s3, $s3, 4
	beq $s2, $s3, level_3_delete_coin_2
	addi $s3, $s3, -256
	beq $s2, $s3, level_3_delete_coin_2
	addi $s3, $s3, -256
	beq $s2, $s3, level_3_delete_coin_2
	addi $s3, $s3, -256
	beq $s2, $s3, level_3_delete_coin_2
	addi $s3, $s3, 4
	beq $s2, $s3, level_3_delete_coin_2
	addi $s3, $s3, 256
	beq $s2, $s3, level_3_delete_coin_2
	addi $s3, $s3, 256
	beq $s2, $s3, level_3_delete_coin_2
	addi $s3, $s3, 256
	beq $s2, $s3, level_3_delete_coin_2
	addi $s3, $s3, 4
	beq $s2, $s3, level_3_delete_coin_2
	addi $s3, $s3, -256
	beq $s2, $s3, level_3_delete_coin_2
	addi $s3, $s3, -256
	beq $s2, $s3, level_3_delete_coin_2
	addi $s3, $s3, -256
	beq $s2, $s3, level_3_delete_coin_2

	coin_collision_check_level_32_rest:
	jal draw_player
	lw $ra, ($sp)
	addi $sp, $sp, 4			# pop $ra from the stack
	jr $ra
	
	level_3_delete_coin_2:
		addi $s3, $t0, 4476
		sw $t5, ($s3)
		sw $t5, -256($s3)
		sw $t5, -512($s3)
		sw $t5, -768($s3)
		sw $t5, -516($s3)
		sw $t5, -508($s3)
		sw $t5, -260($s3)
		sw $t5, -252($s3)
		addi $a1, $a1, -1
		jal delete_score
		jal draw_score

		j coin_collision_check_level_32_rest
		
		
# this function checks if the player collides with the coin 3
coin_collision_check_level_3_coin_3:

	addi $sp, $sp, -4
	sw $ra, ($sp)				# push $ra to the stack

	addi $s3, $t0, 6332			# collide with coin one
	lw $s5, ($s3)
	beq $s5, $t2, go_on_33			# color is still yellow
	lw $ra, ($sp)
	addi $sp, $sp, 4			# pop $ra from the stack
	jr $ra
	
	go_on_33:
	addi $s3, $s3, -8			
	beq $s2, $s3, level_3_delete_coin_3
	addi $s3, $s3, -256
	beq $s2, $s3, level_3_delete_coin_3
	addi $s3, $s3, -256
	beq $s2, $s3, level_3_delete_coin_3
	addi $s3, $s3, -256
	beq $s2, $s3, level_3_delete_coin_3
	addi $s3, $s3, 4
	beq $s2, $s3, level_3_delete_coin_3
	addi $s3, $s3, 256
	beq $s2, $s3, level_3_delete_coin_3
	addi $s3, $s3, 256
	beq $s2, $s3, level_3_delete_coin_3
	addi $s3, $s3, 256
	beq $s2, $s3, level_3_delete_coin_3
	addi $s3, $s3, 4
	beq $s2, $s3, level_3_delete_coin_3
	addi $s3, $s3, -256
	beq $s2, $s3, level_3_delete_coin_3
	addi $s3, $s3, -256
	beq $s2, $s3, level_3_delete_coin_3
	addi $s3, $s3, -256
	beq $s2, $s3, level_3_delete_coin_3
	addi $s3, $s3, 4
	beq $s2, $s3, level_3_delete_coin_3
	addi $s3, $s3, 256
	beq $s2, $s3, level_3_delete_coin_3
	addi $s3, $s3, 256
	beq $s2, $s3, level_3_delete_coin_3
	addi $s3, $s3, 256
	beq $s2, $s3, level_3_delete_coin_3
	addi $s3, $s3, 4
	beq $s2, $s3, level_3_delete_coin_3
	addi $s3, $s3, -256
	beq $s2, $s3, level_3_delete_coin_3
	addi $s3, $s3, -256
	beq $s2, $s3, level_3_delete_coin_3
	addi $s3, $s3, -256
	beq $s2, $s3, level_3_delete_coin_3

	coin_collision_check_level_33_rest:
	jal draw_player
	lw $ra, ($sp)
	addi $sp, $sp, 4			# pop $ra from the stack
	jr $ra
	
	level_3_delete_coin_3:
		addi $s3, $t0, 6332
		sw $t5, ($s3)
		sw $t5, -256($s3)
		sw $t5, -512($s3)
		sw $t5, -768($s3)
		sw $t5, -516($s3)
		sw $t5, -508($s3)
		sw $t5, -260($s3)
		sw $t5, -252($s3)
		addi $a1, $a1, -1
		jal delete_score
		jal draw_score

		j coin_collision_check_level_33_rest

red_cross_collision_check_level_3:
	addi $sp, $sp, -4
	sw $ra, ($sp)				# push $ra to the stack

	addi $s3, $t0, 	3252			# collide with red cross
	lw $s5, ($s3)
	beq $s5, $t4, go_on_333			# color is still red
	lw $ra, ($sp)
	addi $sp, $sp, 4			# pop $ra from the stack
	jr $ra
	
	go_on_333:
	addi $s3, $s3, -8			
	beq $s2, $s3, level_3_delete_red_cross
	addi $s3, $s3, -256
	beq $s2, $s3, level_3_delete_red_cross
	addi $s3, $s3, -256
	beq $s2, $s3, level_3_delete_red_cross
	addi $s3, $s3, 4
	beq $s2, $s3, level_3_delete_red_cross
	addi $s3, $s3, 256
	beq $s2, $s3, level_3_delete_red_cross
	addi $s3, $s3, 256
	beq $s2, $s3, level_3_delete_red_cross
	addi $s3, $s3, 4
	beq $s2, $s3, level_3_delete_red_cross
	addi $s3, $s3, -256
	beq $s2, $s3, level_3_delete_red_cross
	addi $s3, $s3, -256
	beq $s2, $s3, level_3_delete_red_cross
	addi $s3, $s3, 4
	beq $s2, $s3, level_3_delete_red_cross
	addi $s3, $s3, 256
	beq $s2, $s3, level_3_delete_red_cross
	addi $s3, $s3, 256
	beq $s2, $s3, level_3_delete_red_cross
	addi $s3, $s3, 4
	beq $s2, $s3, level_3_delete_red_cross
	addi $s3, $s3, -256
	beq $s2, $s3, level_3_delete_red_cross
	addi $s3, $s3, -256
	beq $s2, $s3, level_3_delete_red_cross

	red_cross_collision_check_level_333_rest:
	jal draw_player
	lw $ra, ($sp)
	addi $sp, $sp, 4			# pop $ra from the stack
	jr $ra
	
	level_3_delete_red_cross:
		addi $s3, $t0, 3252
		sw $t5, ($s3)
		sw $t5, -256($s3)
		sw $t5, -512($s3)
		sw $t5, -260($s3)
		sw $t5, -252($s3)
		addi $a3, $a3, 1
		jal clear_all_HP
		jal draw_HP
		j red_cross_collision_check_level_333_rest
		
		
grey_cross_collision_check_level_3:
	addi $sp, $sp, -4
	sw $ra, ($sp)				# push $ra to the stack

	addi $s3, $t0, 	8948			# collide with grey cross
	addi $s3, $s3, -256
	lw $s5, ($s3)
	beq $s5, 0xb6b6b6, go_on_3333		# color is still grey
	lw $ra, ($sp)
	addi $sp, $sp, 4			# pop $ra from the stack
	jr $ra
	
	go_on_3333:
	addi $s3, $s3, 248			
	beq $s2, $s3, level_3_delete_grey_cross
	addi $s3, $s3, -256
	beq $s2, $s3, level_3_delete_grey_cross
	addi $s3, $s3, -256
	beq $s2, $s3, level_3_delete_grey_cross
	addi $s3, $s3, 4
	beq $s2, $s3, level_3_delete_grey_cross
	addi $s3, $s3, 256
	beq $s2, $s3, level_3_delete_grey_cross
	addi $s3, $s3, 256
	beq $s2, $s3, level_3_delete_grey_cross
	addi $s3, $s3, 4
	beq $s2, $s3, level_3_delete_grey_cross
	addi $s3, $s3, -256
	beq $s2, $s3, level_3_delete_grey_cross
	addi $s3, $s3, -256
	beq $s2, $s3, level_3_delete_grey_cross
	addi $s3, $s3, 4
	beq $s2, $s3, level_3_delete_grey_cross
	addi $s3, $s3, 256
	beq $s2, $s3, level_3_delete_grey_cross
	addi $s3, $s3, 256
	beq $s2, $s3, level_3_delete_grey_cross
	addi $s3, $s3, 4
	beq $s2, $s3, level_3_delete_grey_cross
	addi $s3, $s3, -256
	beq $s2, $s3, level_3_delete_grey_cross
	addi $s3, $s3, -256
	beq $s2, $s3, level_3_delete_grey_cross

	grey_cross_collision_check_level_3333_rest:
	jal draw_player
	lw $ra, ($sp)
	addi $sp, $sp, 4			# pop $ra from the stack
	jr $ra
	
	level_3_delete_grey_cross:
		addi $s3, $t0, 8944
		sw $t5, ($s3)
		sw $t5, -512($s3)
		sw $t5, 8($s3)
		sw $t5, -252($s3)
		sw $t5, -504($s3)
	
		addi $s7, $zero, 31		# player will render to a new position
		jal delete_player
		addi $s2, $t0, 892

	
		j grey_cross_collision_check_level_3333_rest
		
##################################drawing functions##############################################
# this function initialize the original position of all objects
initialize_position_level_1:
		addi $sp, $sp, -4
		sw $ra, ($sp)				# push $ra to the stack
		
		addi $s2, $t0, 8968			# $s2 stores the player address
		jal draw_player
		addi $s3, $t0, 9048			# $s3 stores the coin address
		jal draw_coin
		addi $s3, $t0, 6488			# $s3 stores the coin address
		jal draw_coin
		addi $s3, $t0, 6584			# $s3 stores the coin address
		jal draw_coin
		addi $s3, $t0, 4016			# $s3 stores the coin address
		jal draw_coin
		addi $s3, $t0, 4080			# $s3 stores the grey cross address
		jal draw_grey_cross
		addi $s3, $t0, 9964			# $s3 stores the red cross address
		jal draw_red_cross
		addi $s7, $zero, 2			# set the x-coordinate to 2 as original position
		
		lw $ra, ($sp)
		addi $sp, $sp, 4			# pop $ra from the stack
		jr $ra

# this function initialize the original position of all objects
initialize_position_level_2:
		addi $sp, $sp, -4
		sw $ra, ($sp)				# push $ra to the stack
		
		addi $s2, $t0, 9228			# $s2 stores the player address
		jal draw_player
		addi $s3, $t0, 	2324			# $s3 stores the coin address
		jal draw_coin
		addi $s3, $t0, 	2372			# $s3 stores the coin address
		jal draw_coin
		addi $s3, $t0, 5780			# $s3 stores the coin address
		jal draw_coin
		addi $s3, $t0, 2544			# $s3 stores the coin address
		jal draw_coin
		addi $s3, $t0, 2488			# $s3 stores the red cross address
		jal draw_red_cross
		addi $s3, $t0, 5832			# $s3 stores the grey cross address
		jal draw_grey_cross
		
		addi $s7, $zero, 3			# set the x-coordinate to 2 as original position
		lw $ra, ($sp)
		addi $sp, $sp, 4			# pop $ra from the stack
		jr $ra

# this function initialize the original position of all objects
initialize_position_level_3:
		addi $sp, $sp, -4
		sw $ra, ($sp)				# push $ra to the stack
		
		addi $s2, $t0, 8208			# $s2 stores the player address
		jal draw_player
		addi $s3, $t0, 6212			# $s3 stores the coin address
		jal draw_coin
		addi $s3, $t0, 4476			# $s3 stores the coin address
		jal draw_coin
		addi $s3, $t0, 6332			# $s3 stores the coin address
		jal draw_coin
		addi $s3, $t0, 8948			# $s3 stores the grey cross address
		jal draw_grey_cross
		addi $s3, $t0, 3252			# $s3 stores the red cross address
		jal draw_red_cross
	
		addi $s7, $zero, 4			# set the x-coordinate to 2 as original position
		lw $ra, ($sp)
		addi $sp, $sp, 4			# pop $ra from the stack
		jr $ra


# this function draws the player
draw_player:
	addi $t6, $zero, 0xed1c25			# $t6 stores the color red which is a bit different than the color red for red cross							
	sw $t6, ($s2)
	sw $t6, 4($s2)
	sw $t6, -4($s2)
	sw $t6, -260($s2)
	sw $t6, -516($s2)
	sw $t1, -772($s2)
	sw $t6, -252($s2)
	sw $t6, -508($s2)
	sw $t1, -764($s2)
	jr $ra

delete_player:
	sw $t5, ($s2)
	sw $t5, 4($s2)
	sw $t5, -4($s2)
	sw $t5, -260($s2)
	sw $t5, -516($s2)
	sw $t5, -772($s2)
	sw $t5, -252($s2)
	sw $t5, -508($s2)
	sw $t5, -764($s2)
	jr $ra

draw_coin:
	sw $t2, ($s3)
	sw $t2, -256($s3)
	sw $t2, -512($s3)
	sw $t2, -768($s3)
	sw $t2, -516($s3)
	sw $t2, -508($s3)
	sw $t2, -260($s3)
	sw $t2, -252($s3)
	jr $ra

draw_grey_cross:
	addi $t6, $zero, 0xb6b6b6
	sw $t6, -256($s3)
	sw $t6, -4($s3)
	sw $t6, 4($s3)
	sw $t6, -516($s3)
	sw $t6, -508($s3)
	jr $ra
	
draw_red_cross:
	sw $t4, ($s3)
	sw $t4, -256($s3)
	sw $t4, -252($s3)
	sw $t4, -260($s3)
	sw $t4, -512($s3)
	jr $ra

# this function initializes the start menu page
start_menu:
	
	addi $a3, $zero, 3			# initialize the orginal health to 3
	
	jal clear_screen	# clear the screen first before drawing
	
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
	beq $t7, 0x71, start_menu_q_pressed		# check if key 'q' is pressed
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
	beq $t6, 1, level_1_page		# level 1 is selected
	beq $t6, 2, level_2_page		# level 2 is seleted
	beq $t6, 3, level_3_page		# level 3 is seleted	
	j start_menu_key_detect	
	
# this function deals with the case when q is pressed in start menu
start_menu_q_pressed:
	jal clear_screen		# clears the screen
	j good_bye_page		# draw goodbye screen and terminate the program


# this function draw goodbye page and terminates the program
good_bye_page:
	jal clear_screen		# clear the screen
	# draw the goodbye page
	# draw 'B'
	sw $t1, 2864($t0)
	sw $t1, 2868($t0)
	sw $t1, 2872($t0)
	sw $t1, 2876($t0)
	sw $t1, 2880($t0)
	sw $t1, 2884($t0)
	sw $t1, 2888($t0)
	sw $t1, 3144($t0)
	sw $t1, 3148($t0)
	sw $t1, 3404($t0)
	sw $t1, 3660($t0)
	sw $t1, 3916($t0)
	sw $t1, 4172($t0)
	sw $t1, 4168($t0)
	sw $t1, 4424($t0)
	sw $t1, 4420($t0)
	sw $t1, 4416($t0)
	sw $t1, 4412($t0)
	sw $t1, 4408($t0)
	sw $t1, 4404($t0)
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
	sw $t1, 5940($t0)
	sw $t1, 5944($t0)
	sw $t1, 5948($t0)
	sw $t1, 5952($t0)
	sw $t1, 5956($t0)
	sw $t1, 5960($t0)
	sw $t1, 5704($t0)
	sw $t1, 5708($t0)
	sw $t1, 5452($t0)
	sw $t1, 5196($t0)
	sw $t1, 4940($t0)
	sw $t1, 4684($t0)
	sw $t1, 4680($t0)
	
	# draw 'Y'
	sw $t1, 2912($t0)
	sw $t1, 3168($t0)
	sw $t1, 3172($t0)
	sw $t1, 3428($t0)
	sw $t1, 3432($t0)
	sw $t1, 3688($t0)
	sw $t1, 3692($t0)
	sw $t1, 3948($t0)
	sw $t1, 3952($t0)
	sw $t1, 4208($t0)
	sw $t1, 4212($t0)
	sw $t1, 4216($t0)
	sw $t1, 3960($t0)
	sw $t1, 3964($t0)
	sw $t1, 3708($t0)
	sw $t1, 3712($t0)
	sw $t1, 3456($t0)
	sw $t1, 3460($t0)
	sw $t1, 3204($t0)
	sw $t1, 3208($t0)
	sw $t1, 2952($t0)
	sw $t1, 4468($t0)
	sw $t1, 4724($t0)
	sw $t1, 4980($t0)
	sw $t1, 5236($t0)
	sw $t1, 5492($t0)
	sw $t1, 5748($t0)
	sw $t1, 6004($t0)
	
	# draw 'E'
	sw $t1, 4508($t0)
	sw $t1, 4512($t0)
	sw $t1, 4516($t0)
	sw $t1, 4520($t0)
	sw $t1, 4524($t0)
	sw $t1, 4528($t0)
	sw $t1, 4532($t0)
	sw $t1, 4536($t0)
	sw $t1, 4252($t0)
	sw $t1, 3996($t0)
	sw $t1, 3740($t0)
	sw $t1, 3484($t0)
	sw $t1, 3228($t0)
	sw $t1, 2972($t0)
	sw $t1, 2976($t0)
	sw $t1, 2980($t0)
	sw $t1, 2984($t0)
	sw $t1, 2988($t0)
	sw $t1, 2992($t0)
	sw $t1, 2996($t0)
	sw $t1, 3000($t0)
	sw $t1, 4764($t0)
	sw $t1, 5020($t0)
	sw $t1, 5276($t0)
	sw $t1, 5532($t0)
	sw $t1, 5788($t0)
	sw $t1, 6044($t0)
	sw $t1, 6048($t0)
	sw $t1, 6052($t0)
	sw $t1, 6056($t0)
	sw $t1, 6060($t0)
	sw $t1, 6064($t0)
	sw $t1, 6068($t0)
	sw $t1, 6072($t0)
	
	# draw '!'
	sw $t1, 3024($t0)
	sw $t1, 3280($t0)
	sw $t1, 3536($t0)
	sw $t1, 3792($t0)
	sw $t1, 4048($t0)
	sw $t1, 4304($t0)
	sw $t1, 4560($t0)
	sw $t1, 4816($t0)
	sw $t1, 5072($t0)
	sw $t1, 5328($t0)
	sw $t1, 5584($t0)
	sw $t1, 6096($t0)

	
	
	# draw "GAME OVER!"
	# draw 'G'
	sw $t1, 10768($t0)
	sw $t1, 10772($t0)
	sw $t1, 10776($t0)
	sw $t1, 10780($t0)
	sw $t1, 10784($t0)
	sw $t1, 10788($t0)
	sw $t1, 10792($t0)
	sw $t1, 11024($t0)
	sw $t1, 11280($t0)
	sw $t1, 11536($t0)
	sw $t1, 11792($t0)
	sw $t1, 12048($t0)
	sw $t1, 12304($t0)
	sw $t1, 12308($t0)
	sw $t1, 12312($t0)
	sw $t1, 12316($t0)
	sw $t1, 12320($t0)
	sw $t1, 12324($t0)
	sw $t1, 12328($t0)
	sw $t1, 12072($t0)
	sw $t1, 11816($t0)
	sw $t1, 11812($t0)
	sw $t1, 11808($t0)
	
	# draw "A"
	sw $t1, 10800($t0)
	sw $t1, 11056($t0)
	sw $t1, 11312($t0)
	sw $t1, 11568($t0)
	sw $t1, 11824($t0)
	sw $t1, 12080($t0)
	sw $t1, 12336($t0)
	sw $t1, 10804($t0)
	sw $t1, 10808($t0)
	sw $t1, 10812($t0)
	sw $t1, 10816($t0)
	sw $t1, 10820($t0)
	sw $t1, 11076($t0)
	sw $t1, 11332($t0)
	sw $t1, 11588($t0)
	sw $t1, 11844($t0)
	sw $t1, 12100($t0)
	sw $t1, 12356($t0)
	sw $t1, 11840($t0)
	sw $t1, 11836($t0)
	sw $t1, 11832($t0)
	sw $t1, 11828($t0)
	
	# draw 'M'
	sw $t1, 10844($t0)
	sw $t1, 11100($t0)
	sw $t1, 11356($t0)
	sw $t1, 11612($t0)
	sw $t1, 11868($t0)
	sw $t1, 12124($t0)
	sw $t1, 12380($t0)
	sw $t1, 10840($t0)
	sw $t1, 10836($t0)
	sw $t1, 10832($t0)
	sw $t1, 10828($t0)
	sw $t1, 11084($t0)
	sw $t1, 11340($t0)
	sw $t1, 11596($t0)
	sw $t1, 11852($t0)
	sw $t1, 12108($t0)
	sw $t1, 12364($t0)
	sw $t1, 10848($t0)
	sw $t1, 10852($t0)
	sw $t1, 10856($t0)
	sw $t1, 10860($t0)
	sw $t1, 11116($t0)
	sw $t1, 11372($t0)
	sw $t1, 11628($t0)
	sw $t1, 11884($t0)
	sw $t1, 12140($t0)
	sw $t1, 12396($t0)
	
	# draw 'E'
	sw $t1, 10868($t0)
	sw $t1, 10872($t0)
	sw $t1, 10876($t0)
	sw $t1, 10880($t0)
	sw $t1, 10884($t0)
	sw $t1, 10888($t0)
	sw $t1, 11124($t0)
	sw $t1, 11380($t0)
	sw $t1, 11636($t0)
	sw $t1, 11892($t0)
	sw $t1, 11896($t0)
	sw $t1, 11900($t0)
	sw $t1, 11904($t0)
	sw $t1, 11908($t0)
	sw $t1, 11912($t0)
	sw $t1, 12148($t0)
	sw $t1, 12404($t0)
	sw $t1, 12408($t0)
	sw $t1, 12412($t0)
	sw $t1, 12416($t0)
	sw $t1, 12420($t0)
	sw $t1, 12424($t0)
	# draw 'O'
	sw $t1, 13692($t0)
	sw $t1, 13948($t0)
	sw $t1, 14204($t0)
	sw $t1, 14460($t0)
	sw $t1, 14716($t0)
	sw $t1, 14972($t0)
	sw $t1, 15228($t0)
	sw $t1, 15232($t0)
	sw $t1, 15236($t0)
	sw $t1, 15240($t0)
	sw $t1, 15244($t0)
	sw $t1, 15248($t0)
	sw $t1, 15252($t0)
	sw $t1, 14996($t0)
	sw $t1, 14740($t0)
	sw $t1, 14484($t0)
	sw $t1, 14228($t0)
	sw $t1, 13972($t0)
	sw $t1, 13716($t0)
	sw $t1, 13712($t0)
	sw $t1, 13708($t0)
	sw $t1, 13704($t0)
	sw $t1, 13700($t0)
	sw $t1, 13696($t0)
	
	# draw 'V'
	sw $t1, 13724($t0)
	sw $t1, 13980($t0)
	sw $t1, 14236($t0)
	sw $t1, 14492($t0)
	sw $t1, 14748($t0)
	sw $t1, 14752($t0)
	sw $t1, 15008($t0)
	sw $t1, 15012($t0)
	sw $t1, 15268($t0)
	sw $t1, 15016($t0)
	sw $t1, 14760($t0)
	sw $t1, 14764($t0)
	sw $t1, 14508($t0)
	sw $t1, 14252($t0)
	sw $t1, 13996($t0)
	sw $t1, 13740($t0)
	
	# draw 'E'
	sw $t1, 13748($t0)
	sw $t1, 13752($t0)
	sw $t1, 13756($t0)
	sw $t1, 13760($t0)
	sw $t1, 13764($t0)
	sw $t1, 13768($t0)
	sw $t1, 14004($t0)
	sw $t1, 14260($t0)
	sw $t1, 14516($t0)
	sw $t1, 14772($t0)
	sw $t1, 14776($t0)
	sw $t1, 14780($t0)
	sw $t1, 14784($t0)
	sw $t1, 14788($t0)
	sw $t1, 14792($t0)
	sw $t1, 15028($t0)
	sw $t1, 15284($t0)
	sw $t1, 15288($t0)
	sw $t1, 15292($t0)
	sw $t1, 15296($t0)
	sw $t1, 15300($t0)
	sw $t1, 15304($t0)
	
	# draw 'R'
	sw $t1, 13776($t0)
	sw $t1, 14032($t0)
	sw $t1, 14288($t0)
	sw $t1, 14544($t0)
	sw $t1, 14800($t0)
	sw $t1, 15056($t0)
	sw $t1, 15312($t0)
	sw $t1, 13780($t0)
	sw $t1, 13784($t0)
	sw $t1, 13788($t0)
	sw $t1, 13792($t0)
	sw $t1, 14052($t0)
	sw $t1, 14308($t0)
	sw $t1, 14564($t0)
	sw $t1, 14816($t0)
	sw $t1, 14812($t0)
	sw $t1, 14808($t0)
	sw $t1, 14804($t0)
	sw $t1, 15076($t0)
	sw $t1, 15332($t0)
	
	# draw '!'
	sw $t1, 13808($t0)
	sw $t1, 14064($t0)
	sw $t1, 14320($t0)
	sw $t1, 14576($t0)
	sw $t1, 14832($t0)
	sw $t1, 15344($t0)
	
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
		
# this function launch level 1 game
level_1_page:
	jal clear_screen			# clear screen content
	# draw background
	
	
	# draw HP
	jal draw_HP
	# set the number of coin to 4
	addi $a1, $zero, 4
	jal delete_score
	jal draw_score

	
	# draw the white line
	addi $s0, $zero, 0			# $s0 stores the index i = 0
	add $s1, $t0, 12544			# $s1 stores the address of graph pointer
	level_1_page_loop1:
		bge $s0, 64, level_1_page_remaining1	# exit condition: $s0 >= 64
		sw $t1, ($s1)				# draw white line
		addi $s0, $s0, 1			# increment index by 1
		addi $s1, $s1, 4			# increment graph pointer by 4
		j level_1_page_loop1
	level_1_page_remaining1:
	# draw ocean waves
	addi $s0, $zero, 0			# $s0 stores the index i = 0
	add $s1, $t0, 12032			# $s1 stores the address of graph pointer
	level_1_page_loop2:
		bge $s0, 64, level_1_page_remaining2	# exit condition: $s0 >= 64
		sw $t3, ($s1)				# draw blue line
		addi $s0, $s0, 1			# increment index by 1
		addi $s1, $s1, 4			# increment graph pointer by 4
		j level_1_page_loop2
	level_1_page_remaining2:
	# draw secondary waves
	addi $s0, $zero, 0			# $s0 stores the index i = 0
	add $s1, $t0, 11780			# $s1 stores the address of graph pointer
	level_1_page_loop3:
		bge $s0, 16, level_1_page_remaining3	# exit condition: $s0 >= 64
		sw $t3, ($s1)				# draw blue line
		sw $t3, 4($s1)
		sw $t3, 8($s1)
		addi $s0, $s0, 1			# increment index by 1
		addi $s1, $s1, 16			# increment graph pointer by 16
		j level_1_page_loop3
	level_1_page_remaining3:
	# draw final layer of waves
	addi $s0, $zero, 0			# $s0 stores the index i = 0
	add $s1, $t0, 11528			# $s1 stores the address of graph pointer
	level_1_page_loop4:
		bge $s0, 16, level_1_page_remaining4	# exit condition: $s0 >= 64
		sw $t3, ($s1)				# draw blue line
		addi $s0, $s0, 1			# increment index by 1
		addi $s1, $s1, 16			# increment graph pointer by 16
		j level_1_page_loop4
	level_1_page_remaining4:
	# draw platforms
	# draw platform one
	addi $s0, $zero, 0			# $s0 stores the index i = 0
	addi $s1, $t0, 9216			# $s1 stores the address of graph pointer
	level_1_page_loop5:
		bge $s0, 25, level_1_page_remaining5	# exit condition: $s0 >= 25
		sw $t1, ($s1)				# draw white line
		addi $s0, $s0, 1			# increment index by 1
		addi $s1, $s1, 4			# increment graph pointer by 16
		j level_1_page_loop5
	level_1_page_remaining5:
	# draw platform two
	addi $s0, $zero, 0			# $s0 stores the index i = 0
	addi $s1, $t0, 6732			# $s1 stores the address of graph pointer
	level_1_page_loop6:
		bge $s0, 31, level_1_page_remaining6	# exit condition: $s0 >= 25
		sw $t1, ($s1)				# draw white line
		addi $s0, $s0, 1			# increment index by 1
		addi $s1, $s1, 4			# increment graph pointer by 16
		j level_1_page_loop6
	level_1_page_remaining6:
	# draw platform three
	addi $s0, $zero, 0			# $s0 stores the index i = 0
	addi $s1, $t0, 4260			# $s1 stores the address of graph pointer
	level_1_page_loop7:
		bge $s0, 23, level_1_page_remaining7	# exit condition: $s0 >= 25
		sw $t1, ($s1)				# draw white line
		addi $s0, $s0, 1			# increment index by 1
		addi $s1, $s1, 4			# increment graph pointer by 16
		j level_1_page_loop7
	level_1_page_remaining7:
	# draw platform four
	addi $s0, $zero, 0			# $s0 stores the index i = 0
	addi $s1, $t0, 	10172		# $s1 stores the address of graph pointer
	level_1_page_loop8:
		bge $s0, 17, level_1_page_remaining8	# exit condition: $s0 >= 25
		sw $t1, ($s1)				# draw white line
		addi $s0, $s0, 1			# increment index by 1
		addi $s1, $s1, 4			# increment graph pointer by 16
		j level_1_page_loop8
	level_1_page_remaining8:
	jal initialize_position_level_1               # draw original position of all objects 
	j main_level_1
	
# this function launch level 2 game
level_2_page:
	jal clear_screen			# clear screen content
	# draw background
	
	# draw HP
	jal draw_HP
	# set the number of coin to 4
	addi $a1, $zero, 4
	jal delete_score
	jal draw_score
	
	# draw the white line
	addi $s0, $zero, 0			# $s0 stores the index i = 0
	add $s1, $t0, 12544			# $s1 stores the address of graph pointer
	level_2_page_loop1:
		bge $s0, 64, level_2_page_remaining1	# exit condition: $s0 >= 64
		sw $t1, ($s1)				# draw white line
		addi $s0, $s0, 1			# increment index by 1
		addi $s1, $s1, 4			# increment graph pointer by 4
		j level_2_page_loop1
	level_2_page_remaining1:
	# draw ocean waves
	addi $s0, $zero, 0			# $s0 stores the index i = 0
	add $s1, $t0, 12032			# $s1 stores the address of graph pointer
	level_2_page_loop2:
		bge $s0, 64, level_2_page_remaining2	# exit condition: $s0 >= 64
		sw $t3, ($s1)				# draw blue line
		addi $s0, $s0, 1			# increment index by 1
		addi $s1, $s1, 4			# increment graph pointer by 4
		j level_2_page_loop2
	level_2_page_remaining2:
	# draw secondary waves
	addi $s0, $zero, 0			# $s0 stores the index i = 0
	add $s1, $t0, 11780			# $s1 stores the address of graph pointer
	level_2_page_loop3:
		bge $s0, 16, level_2_page_remaining3	# exit condition: $s0 >= 64
		sw $t3, ($s1)				# draw blue line
		sw $t3, 4($s1)
		sw $t3, 8($s1)
		addi $s0, $s0, 1			# increment index by 1
		addi $s1, $s1, 16			# increment graph pointer by 16
		j level_2_page_loop3
	level_2_page_remaining3:
	# draw final layer of waves
	addi $s0, $zero, 0			# $s0 stores the index i = 0
	add $s1, $t0, 11528			# $s1 stores the address of graph pointer
	level_2_page_loop4:
		bge $s0, 16, level_2_page_remaining4	# exit condition: $s0 >= 64
		sw $t3, ($s1)				# draw blue line
		addi $s0, $s0, 1			# increment index by 1
		addi $s1, $s1, 16			# increment graph pointer by 16
		j level_2_page_loop4
	level_2_page_remaining4:
	# draw platforms
	# draw platform one
	addi $s0, $zero, 0			# $s0 stores the index i = 0
	addi $s1, $t0, 2560			# $s1 stores the address of graph pointer
	level_2_page_loop5:
		bge $s0, 20, level_2_page_remaining5	# exit condition: $s0 >= 25
		sw $t1, ($s1)				# draw white line
		addi $s0, $s0, 1			# increment index by 1
		addi $s1, $s1, 4			# increment graph pointer by 16
		j level_2_page_loop5
	level_2_page_remaining5:
	# draw platform two
	addi $s0, $zero, 0			# $s0 stores the index i = 0
	addi $s1, $t0, 2732		# $s1 stores the address of graph pointer
	level_2_page_loop6:
		bge $s0, 21, level_2_page_remaining6	# exit condition: $s0 >= 25
		sw $t1, ($s1)				# draw white line
		addi $s0, $s0, 1			# increment index by 1
		addi $s1, $s1, 4			# increment graph pointer by 16
		j level_2_page_loop6
	level_2_page_remaining6:
	# draw platform three
	addi $s0, $zero, 0			# $s0 stores the index i = 0
	addi $s1, $t0, 6016			# $s1 stores the address of graph pointer
	level_2_page_loop7:
		bge $s0, 23, level_2_page_remaining7	# exit condition: $s0 >= 25
		sw $t1, ($s1)				# draw white line
		addi $s0, $s0, 1			# increment index by 1
		addi $s1, $s1, 4			# increment graph pointer by 16
		j level_2_page_loop7
	level_2_page_remaining7:
	# draw platform four
	addi $s0, $zero, 0			# $s0 stores the index i = 0
	addi $s1, $t0, 9472			# $s1 stores the address of graph pointer
	level_2_page_loop8:
		bge $s0, 21, level_2_page_remaining8	# exit condition: $s0 >= 25
		sw $t1, ($s1)				# draw white line
		addi $s0, $s0, 1			# increment index by 1
		addi $s1, $s1, 4			# increment graph pointer by 16
		j level_2_page_loop8
	level_2_page_remaining8:
	# draw platform five
	addi $s0, $zero, 0			# $s0 stores the index i = 0
	addi $s1, $t0, 7768			# $s1 stores the address of graph pointer
	level_2_page_loop9:
		bge $s0, 15, level_2_page_remaining9	# exit condition: $s0 >= 25
		sw $t1, ($s1)				# draw white line
		addi $s0, $s0, 1			# increment index by 1
		addi $s1, $s1, 4			# increment graph pointer by 16
		j level_2_page_loop9
	level_2_page_remaining9:
	
	# draw platform six
	addi $s0, $zero, 0			# $s0 stores the index i = 0
	addi $s1, $t0, 2144			# $s1 stores the address of graph pointer
	level_2_page_loop10:
		bge $s0, 10, level_2_page_remaining10	# exit condition: $s0 >= 25
		sw $t1, ($s1)				# draw white line
		addi $s0, $s0, 1			# increment index by 1
		addi $s1, $s1, 4			# increment graph pointer by 16
		j level_2_page_loop10
	level_2_page_remaining10:
	
	
	jal initialize_position_level_2               # draw original position of all objects 
	j main_level_2
	
# this function launch level 3 game
level_3_page:
	jal clear_screen			# clear screen content
	# draw background
	
	# draw HP
	jal draw_HP
	# set the number of coin to 4
	addi $a1, $zero, 3
	jal delete_score
	jal draw_score
	
	# draw the white line
	addi $s0, $zero, 0			# $s0 stores the index i = 0
	add $s1, $t0, 12544			# $s1 stores the address of graph pointer
	level_3_page_loop1:
		bge $s0, 64, level_3_page_remaining1	# exit condition: $s0 >= 64
		sw $t1, ($s1)				# draw white line
		addi $s0, $s0, 1			# increment index by 1
		addi $s1, $s1, 4			# increment graph pointer by 4
		j level_3_page_loop1
	level_3_page_remaining1:
	# draw ocean waves
	addi $s0, $zero, 0			# $s0 stores the index i = 0
	add $s1, $t0, 12032			# $s1 stores the address of graph pointer
	level_3_page_loop2:
		bge $s0, 64, level_3_page_remaining2	# exit condition: $s0 >= 64
		sw $t3, ($s1)				# draw blue line
		addi $s0, $s0, 1			# increment index by 1
		addi $s1, $s1, 4			# increment graph pointer by 4
		j level_3_page_loop2
	level_3_page_remaining2:
	# draw secondary waves
	addi $s0, $zero, 0			# $s0 stores the index i = 0
	add $s1, $t0, 11780			# $s1 stores the address of graph pointer
	level_3_page_loop3:
		bge $s0, 16, level_3_page_remaining3	# exit condition: $s0 >= 64
		sw $t3, ($s1)				# draw blue line
		sw $t3, 4($s1)
		sw $t3, 8($s1)
		addi $s0, $s0, 1			# increment index by 1
		addi $s1, $s1, 16			# increment graph pointer by 16
		j level_3_page_loop3
	level_3_page_remaining3:
	# draw final layer of waves
	addi $s0, $zero, 0			# $s0 stores the index i = 0
	add $s1, $t0, 11528			# $s1 stores the address of graph pointer
	level_3_page_loop4:
		bge $s0, 16, level_3_page_remaining4	# exit condition: $s0 >= 64
		sw $t3, ($s1)				# draw blue line
		addi $s0, $s0, 1			# increment index by 1
		addi $s1, $s1, 16			# increment graph pointer by 16
		j level_3_page_loop4
	level_3_page_remaining4:
	# draw platforms
	# draw platform one
	addi $s0, $zero, 0			# $s0 stores the index i = 0
	addi $s1, $t0, 8448			# $s1 stores the address of graph pointer
	level_3_page_loop5:
		bge $s0, 10, level_3_page_remaining5	# exit condition: $s0 >= 25
		sw $t1, ($s1)				# draw white line
		addi $s0, $s0, 1			# increment index by 1
		addi $s1, $s1, 4			# increment graph pointer by 16
		j level_3_page_loop5
	level_3_page_remaining5:
	# draw platform two
	addi $s0, $zero, 0			# $s0 stores the index i = 0
	addi $s1, $t0, 6440			# $s1 stores the address of graph pointer
	level_3_page_loop6:
		bge $s0, 12, level_3_page_remaining6	# exit condition: $s0 >= 25
		sw $t1, ($s1)				# draw white line
		addi $s0, $s0, 1			# increment index by 1
		addi $s1, $s1, 4			# increment graph pointer by 16
		j level_3_page_loop6
	level_3_page_remaining6:
	# draw platform three
	addi $s0, $zero, 0			# $s0 stores the index i = 0
	addi $s1, $t0, 4716			# $s1 stores the address of graph pointer
	level_3_page_loop7:
		bge $s0, 7, level_3_page_remaining7	# exit condition: $s0 >= 25
		sw $t1, ($s1)				# draw white line
		addi $s0, $s0, 1			# increment index by 1
		addi $s1, $s1, 4			# increment graph pointer by 16
		j level_3_page_loop7
	level_3_page_remaining7:
	# draw platform four
	addi $s0, $zero, 0			# $s0 stores the index i = 0
	addi $s1, $t0, 6572			# $s1 stores the address of graph pointer
	level_3_page_loop8:
		bge $s0, 7, level_3_page_remaining8	# exit condition: $s0 >= 25
		sw $t1, ($s1)				# draw white line
		addi $s0, $s0, 1			# increment index by 1
		addi $s1, $s1, 4			# increment graph pointer by 16
		j level_3_page_loop8
	level_3_page_remaining8:
	# draw platform five
	addi $s0, $zero, 0			# $s0 stores the index i = 0
	addi $s1, $t0, 9188			# $s1 stores the address of graph pointer
	level_3_page_loop9:
		bge $s0, 7, level_3_page_remaining9	# exit condition: $s0 >= 25
		sw $t1, ($s1)				# draw white line
		addi $s0, $s0, 1			# increment index by 1
		addi $s1, $s1, 4			# increment graph pointer by 16
		j level_3_page_loop9
	level_3_page_remaining9:
	# draw platform six
	addi $s0, $zero, 0			# $s0 stores the index i = 0
	addi $s1, $t0, 9136			# $s1 stores the address of graph pointer
	level_3_page_loop10:
		bge $s0, 5, level_3_page_remaining10	# exit condition: $s0 >= 25
		sw $t1, ($s1)				# draw white line
		addi $s0, $s0, 1			# increment index by 1
		addi $s1, $s1, 4			# increment graph pointer by 16
		j level_3_page_loop10
	level_3_page_remaining10:
	# draw platform seven
	addi $s0, $zero, 0			# $s0 stores the index i = 0
	addi $s1, $t0, 	3496		# $s1 stores the address of graph pointer
	level_3_page_loop11:
		bge $s0, 5, level_3_page_remaining11	# exit condition: $s0 >= 25
		sw $t1, ($s1)				# draw white line
		addi $s0, $s0, 1			# increment index by 1
		addi $s1, $s1, 4			# increment graph pointer by 16
		j level_3_page_loop11
	level_3_page_remaining11:
	
	
	jal initialize_position_level_3               # draw original position of all objects 
	j main_level_3

# this function draws the player's HP
draw_HP:

	hp_case1:
		bge, $a3, 1, heartdrawing1
	hp_case2:
		bge, $a3, 2, heartdrawing2
	hp_case3:
		bge, $a3, 3, heartdrawing3
	hp_case4:
		bge, $a3, 4, heartdrawing4
	hp_case5:
		bge, $a3, 5, heartdrawing5
	hp_case6:
		bge, $a3, 6, heartdrawing6
	hp_case7:
		jr $ra
	
	heartdrawing1:
		add, $s3, $t0, 15124
		sw $t4, ($s3)
		sw $t4, -256($s3)
		sw $t4, -512($s3)
		sw $t4, -252($s3)
		sw $t4, -508($s3)
		sw $t4, -764($s3)
		sw $t4, -1020($s3)
		sw $t4, -260($s3)
		sw $t4, -516($s3)
		sw $t4, -772($s3)
		sw $t4, -1028($s3)
		sw $t4, -520($s3)
		sw $t4, -776($s3)
		sw $t4, -1032($s3)
		sw $t4, -504($s3)
		sw $t4, -760($s3)
		sw $t4, -1016($s3)
		sw $t4, -780($s3)
		sw $t4, -756($s3)
		sw $t4, -768($s3)
		j hp_case2

	heartdrawing2:
		add, $s3, $t0, 15160
		sw $t4, ($s3)
		sw $t4, -256($s3)
		sw $t4, -512($s3)
		sw $t4, -252($s3)
		sw $t4, -508($s3)
		sw $t4, -764($s3)
		sw $t4, -1020($s3)
		sw $t4, -260($s3)
		sw $t4, -516($s3)
		sw $t4, -772($s3)
		sw $t4, -1028($s3)
		sw $t4, -520($s3)
		sw $t4, -776($s3)
		sw $t4, -1032($s3)
		sw $t4, -504($s3)
		sw $t4, -760($s3)
		sw $t4, -1016($s3)
		sw $t4, -780($s3)
		sw $t4, -756($s3)
		sw $t4, -768($s3)
		j hp_case3

	heartdrawing3:
		add, $s3, $t0, 15196
		sw $t4, ($s3)
		sw $t4, -256($s3)
		sw $t4, -512($s3)
		sw $t4, -252($s3)
		sw $t4, -508($s3)
		sw $t4, -764($s3)
		sw $t4, -1020($s3)
		sw $t4, -260($s3)
		sw $t4, -516($s3)
		sw $t4, -772($s3)
		sw $t4, -1028($s3)
		sw $t4, -520($s3)
		sw $t4, -776($s3)
		sw $t4, -1032($s3)
		sw $t4, -504($s3)
		sw $t4, -760($s3)
		sw $t4, -1016($s3)
		sw $t4, -780($s3)
		sw $t4, -756($s3)
		sw $t4, -768($s3)
		j hp_case4
		
	heartdrawing4:
		add, $s3, $t0, 15232
		sw $t4, ($s3)
		sw $t4, -256($s3)
		sw $t4, -512($s3)
		sw $t4, -252($s3)
		sw $t4, -508($s3)
		sw $t4, -764($s3)
		sw $t4, -1020($s3)
		sw $t4, -260($s3)
		sw $t4, -516($s3)
		sw $t4, -772($s3)
		sw $t4, -1028($s3)
		sw $t4, -520($s3)
		sw $t4, -776($s3)
		sw $t4, -1032($s3)
		sw $t4, -504($s3)
		sw $t4, -760($s3)
		sw $t4, -1016($s3)
		sw $t4, -780($s3)
		sw $t4, -756($s3)
		sw $t4, -768($s3)
		j hp_case5
		
	heartdrawing5:
		add, $s3, $t0, 15268
		sw $t4, ($s3)
		sw $t4, -256($s3)
		sw $t4, -512($s3)
		sw $t4, -252($s3)
		sw $t4, -508($s3)
		sw $t4, -764($s3)
		sw $t4, -1020($s3)
		sw $t4, -260($s3)
		sw $t4, -516($s3)
		sw $t4, -772($s3)
		sw $t4, -1028($s3)
		sw $t4, -520($s3)
		sw $t4, -776($s3)
		sw $t4, -1032($s3)
		sw $t4, -504($s3)
		sw $t4, -760($s3)
		sw $t4, -1016($s3)
		sw $t4, -780($s3)
		sw $t4, -756($s3)
		sw $t4, -768($s3)
		j hp_case6
		
	heartdrawing6:
		add, $s3, $t0, 15304
		sw $t4, ($s3)
		sw $t4, -256($s3)
		sw $t4, -512($s3)
		sw $t4, -252($s3)
		sw $t4, -508($s3)
		sw $t4, -764($s3)
		sw $t4, -1020($s3)
		sw $t4, -260($s3)
		sw $t4, -516($s3)
		sw $t4, -772($s3)
		sw $t4, -1028($s3)
		sw $t4, -520($s3)
		sw $t4, -776($s3)
		sw $t4, -1032($s3)
		sw $t4, -504($s3)
		sw $t4, -760($s3)
		sw $t4, -1016($s3)
		sw $t4, -780($s3)
		sw $t4, -756($s3)
		sw $t4, -768($s3)
		j hp_case7
	
# this function deletes all the HPs	
clear_all_HP:
		add, $s3, $t0, 15124
		sw $t5, ($s3)
		sw $t5, -256($s3)
		sw $t5, -512($s3)
		sw $t5, -252($s3)
		sw $t5, -508($s3)
		sw $t5, -764($s3)
		sw $t5, -1020($s3)
		sw $t5, -260($s3)
		sw $t5, -516($s3)
		sw $t5, -772($s3)
		sw $t5, -1028($s3)
		sw $t5, -520($s3)
		sw $t5, -776($s3)
		sw $t5, -1032($s3)
		sw $t5, -504($s3)
		sw $t5, -760($s3)
		sw $t5, -1016($s3)
		sw $t5, -780($s3)
		sw $t5, -756($s3)
		sw $t5, -768($s3)

		add, $s3, $t0, 15160
		sw $t5, ($s3)
		sw $t5, -256($s3)
		sw $t5, -512($s3)
		sw $t5, -252($s3)
		sw $t5, -508($s3)
		sw $t5, -764($s3)
		sw $t5, -1020($s3)
		sw $t5, -260($s3)
		sw $t5, -516($s3)
		sw $t5, -772($s3)
		sw $t5, -1028($s3)
		sw $t5, -520($s3)
		sw $t5, -776($s3)
		sw $t5, -1032($s3)
		sw $t5, -504($s3)
		sw $t5, -760($s3)
		sw $t5, -1016($s3)
		sw $t5, -780($s3)
		sw $t5, -756($s3)
		sw $t5, -768($s3)

		add, $s3, $t0, 15196
		sw $t5, ($s3)
		sw $t5, -256($s3)
		sw $t5, -512($s3)
		sw $t5, -252($s3)
		sw $t5, -508($s3)
		sw $t5, -764($s3)
		sw $t5, -1020($s3)
		sw $t5, -260($s3)
		sw $t5, -516($s3)
		sw $t5, -772($s3)
		sw $t5, -1028($s3)
		sw $t5, -520($s3)
		sw $t5, -776($s3)
		sw $t5, -1032($s3)
		sw $t5, -504($s3)
		sw $t5, -760($s3)
		sw $t5, -1016($s3)
		sw $t5, -780($s3)
		sw $t5, -756($s3)
		sw $t5, -768($s3)

		add, $s3, $t0, 15232
		sw $t5, ($s3)
		sw $t5, -256($s3)
		sw $t5, -512($s3)
		sw $t5, -252($s3)
		sw $t5, -508($s3)
		sw $t5, -764($s3)
		sw $t5, -1020($s3)
		sw $t5, -260($s3)
		sw $t5, -516($s3)
		sw $t5, -772($s3)
		sw $t5, -1028($s3)
		sw $t5, -520($s3)
		sw $t5, -776($s3)
		sw $t5, -1032($s3)
		sw $t5, -504($s3)
		sw $t5, -760($s3)
		sw $t5, -1016($s3)
		sw $t5, -780($s3)
		sw $t5, -756($s3)
		sw $t5, -768($s3)

		add, $s3, $t0, 15268
		sw $t5, ($s3)
		sw $t5, -256($s3)
		sw $t5, -512($s3)
		sw $t5, -252($s3)
		sw $t5, -508($s3)
		sw $t5, -764($s3)
		sw $t5, -1020($s3)
		sw $t5, -260($s3)
		sw $t5, -516($s3)
		sw $t5, -772($s3)
		sw $t5, -1028($s3)
		sw $t5, -520($s3)
		sw $t5, -776($s3)
		sw $t5, -1032($s3)
		sw $t5, -504($s3)
		sw $t5, -760($s3)
		sw $t5, -1016($s3)
		sw $t5, -780($s3)
		sw $t5, -756($s3)
		sw $t5, -768($s3)


		add, $s3, $t0, 15304
		sw $t5, ($s3)
		sw $t5, -256($s3)
		sw $t5, -512($s3)
		sw $t5, -252($s3)
		sw $t5, -508($s3)
		sw $t5, -764($s3)
		sw $t5, -1020($s3)
		sw $t5, -260($s3)
		sw $t5, -516($s3)
		sw $t5, -772($s3)
		sw $t5, -1028($s3)
		sw $t5, -520($s3)
		sw $t5, -776($s3)
		sw $t5, -1032($s3)
		sw $t5, -504($s3)
		sw $t5, -760($s3)
		sw $t5, -1016($s3)
		sw $t5, -780($s3)
		sw $t5, -756($s3)
		sw $t5, -768($s3)
		
		jr $ra
		
# this function draws the winning page
winning_page:

	# draw U
	jal clear_screen
	sw $t1, 4144($t0)
	sw $t1, 4400($t0)
	sw $t1, 4656($t0)
	sw $t1, 4912($t0)
	sw $t1, 5168($t0)
	sw $t1, 5424($t0)
	sw $t1, 5680($t0)
	sw $t1, 5936($t0)
	sw $t1, 6192($t0)
	sw $t1, 6448($t0)
	sw $t1, 6704($t0)
	sw $t1, 6960($t0)
	sw $t1, 7216($t0)
	sw $t1, 7220($t0)
	sw $t1, 7224($t0)
	sw $t1, 7228($t0)
	sw $t1, 7232($t0)
	sw $t1, 7236($t0)
	sw $t1, 7240($t0)
	sw $t1, 7244($t0)
	sw $t1, 7248($t0)
	sw $t1, 7252($t0)
	sw $t1, 7256($t0)
	sw $t1, 7000($t0)
	sw $t1, 6744($t0)
	sw $t1, 6488($t0)
	sw $t1, 6232($t0)
	sw $t1, 5976($t0)
	sw $t1, 5720($t0)
	sw $t1, 5464($t0)
	sw $t1, 5208($t0)
	sw $t1, 4952($t0)
	sw $t1, 4696($t0)
	sw $t1, 4440($t0)
	sw $t1, 4184($t0)
	
	# draw W
	sw $t1, 9316($t0)
	sw $t1, 9572($t0)
	sw $t1, 9828($t0)
	sw $t1, 10084($t0)
	sw $t1, 10340($t0)
	sw $t1, 10596($t0)
	sw $t1, 10852($t0)
	sw $t1, 11108($t0)
	sw $t1, 11364($t0)
	sw $t1, 11620($t0)
	sw $t1, 11876($t0)
	sw $t1, 11880($t0)
	sw $t1, 11884($t0)
	sw $t1, 11888($t0)
	sw $t1, 11892($t0)
	sw $t1, 11896($t0)
	sw $t1, 11900($t0)
	sw $t1, 11644($t0)
	sw $t1, 11388($t0)
	sw $t1, 11132($t0)
	sw $t1, 10876($t0)
	sw $t1, 10620($t0)
	sw $t1, 10364($t0)
	sw $t1, 10108($t0)
	sw $t1, 9852($t0)
	sw $t1, 9596($t0)
	sw $t1, 9340($t0)
	sw $t1, 11904($t0)
	sw $t1, 11908($t0)
	sw $t1, 11912($t0)
	sw $t1, 11916($t0)
	sw $t1, 11920($t0)
	sw $t1, 11924($t0)
	sw $t1, 11668($t0)
	sw $t1, 11412($t0)
	sw $t1, 11156($t0)
	sw $t1, 10900($t0)
	sw $t1, 10644($t0)
	sw $t1, 10388($t0)
	sw $t1, 10132($t0)
	sw $t1, 9876($t0)
	sw $t1, 9620($t0)
	sw $t1, 9364($t0)
	
	# draw I
	sw $t1, 9380($t0)
	sw $t1, 9636($t0)
	sw $t1, 9892($t0)
	sw $t1, 10148($t0)
	sw $t1, 10404($t0)
	sw $t1, 10660($t0)
	sw $t1, 10916($t0)
	sw $t1, 11172($t0)
	sw $t1, 11428($t0)
	sw $t1, 11684($t0)
	sw $t1, 11940($t0)
	
	# draw N
	sw $t1, 11956($t0)
	sw $t1, 11700($t0)
	sw $t1, 11444($t0)
	sw $t1, 11188($t0)
	sw $t1, 10932($t0)
	sw $t1, 10676($t0)
	sw $t1, 10420($t0)
	sw $t1, 10164($t0)
	sw $t1, 9908($t0)
	sw $t1, 9652($t0)
	sw $t1, 9396($t0)
	sw $t1, 9400($t0)
	sw $t1, 9404($t0)
	sw $t1, 9408($t0)
	sw $t1, 9412($t0)
	sw $t1, 9416($t0)
	sw $t1, 9420($t0)
	sw $t1, 9424($t0)
	sw $t1, 9680($t0)
	sw $t1, 9936($t0)
	sw $t1, 10192($t0)
	sw $t1, 10448($t0)
	sw $t1, 10704($t0)
	sw $t1, 10960($t0)
	sw $t1, 11216($t0)
	sw $t1, 11472($t0)
	sw $t1, 11728($t0)
	sw $t1, 11984($t0)
	
	# draw !
	sw $t1, 9448($t0)
	sw $t1, 9704($t0)
	sw $t1, 9960($t0)
	sw $t1, 10216($t0)
	sw $t1, 10472($t0)
	sw $t1, 10728($t0)
	sw $t1, 10984($t0)
	sw $t1, 11240($t0)
	sw $t1, 11496($t0)
	
	sw $t1, 12008($t0)
	
	li $v0, 10
	syscall					# properly terminates the program

draw_score:
	score_case1:
		bge, $a1, 1, scoredrawing1
	score_case2:
		bge, $a1, 2, scoredrawing2
	score_case3:
		bge, $a1, 3, scoredrawing3
	score_case4:
		bge, $a1, 4, scoredrawing4
	score_case5:
		jr $ra
	
	scoredrawing1:
		sw $t2, 13816($t0)
		sw $t2, 14072($t0)
		sw $t2, 14328($t0)
		sw $t2, 14584($t0)
		sw $t2, 14840($t0)
		sw $t2, 15096($t0)
		sw $t2, 15352($t0)
		j score_case2
		
	scoredrawing2:
		sw $t2, 13808($t0)
		sw $t2, 14064($t0)
		sw $t2, 14320($t0)
		sw $t2, 14576($t0)
		sw $t2, 14832($t0)
		sw $t2, 15088($t0)
		sw $t2, 15344($t0)
		j score_case3
		
	scoredrawing3:
		sw $t2, 13800($t0)
		sw $t2, 14056($t0)
		sw $t2, 14312($t0)
		sw $t2, 14568($t0)
		sw $t2, 14824($t0)
		sw $t2, 15080($t0)
		sw $t2, 15336($t0)
		j score_case4
		
	scoredrawing4:
		sw $t2, 13792($t0)
		sw $t2, 14048($t0)
		sw $t2, 14304($t0)
		sw $t2, 14560($t0)
		sw $t2, 14816($t0)
		sw $t2, 15072($t0)
		sw $t2, 15328($t0)
		j score_case5
		

delete_score:
		sw $t5, 13816($t0)
		sw $t5, 14072($t0)
		sw $t5, 14328($t0)
		sw $t5, 14584($t0)
		sw $t5, 14840($t0)
		sw $t5, 15096($t0)
		sw $t5, 15352($t0)
		sw $t5, 13808($t0)
		sw $t5, 14064($t0)
		sw $t5, 14320($t0)
		sw $t5, 14576($t0)
		sw $t5, 14832($t0)
		sw $t5, 15088($t0)
		sw $t5, 15344($t0)
		sw $t5, 13800($t0)
		sw $t5, 14056($t0)
		sw $t5, 14312($t0)
		sw $t5, 14568($t0)
		sw $t5, 14824($t0)
		sw $t5, 15080($t0)
		sw $t5, 15336($t0)
		sw $t5, 13792($t0)
		sw $t5, 14048($t0)
		sw $t5, 14304($t0)
		sw $t5, 14560($t0)
		sw $t5, 14816($t0)
		sw $t5, 15072($t0)
		sw $t5, 15328($t0)
		jr $ra
