.data
	string :	.asciz "%[^\n]"
	//string2 : 	.asciz "%s"
	newline :	.asciz "\n"
	prompt :	.asciz "Input a string: "
	usr_str :	.space 256

.global main
.text

main:
	//prints prompt
	//ldr x0, = string2
	ldr x0, = prompt
	bl printf

	//scans in the inputs
	ldr x0, = string
	ldr x1, = usr_str
	bl scanf

	ldr x19, = usr_str
	mov x20, #0
	bl is_vowel_loop

	//prints result
	//mov x1, x21
	//ldr x0, = string
	//bl printf

	//flushes
	ldr x0, = newline
	bl printf

exit:
	mov x0, #0
	mov x8, #93
	svc #0

is_vowel_loop:

	//just a lot of if statements checking

	//the ASCII values of each vowel
	//A = 65, E = 69, I = 73, O = 79, U = 85
	//a = 97, e = 101, i = 105, o = 111, u = 117
	//x = 120

	ldrb w21, [x19, x20]
	cbz w21, print_new_str

	subs x22, x21, #65 //A
	cbz x22, replace_vowels

	subs x22, x21, #97 //a
	cbz x22, replace_vowels

	subs x22, x21, #69 //E
	cbz x22, replace_vowels
	
	subs x22, x21, #101 //e
	cbz x22, replace_vowels

	subs x22, x21, #73 //I
	cbz x22, replace_vowels

	subs x22, x21, #105 //i
	cbz x22, replace_vowels

	subs x22, x21, #79 //O
	cbz x22, replace_vowels
		
	subs x22, x21, #111 //o
	cbz x22, replace_vowels

	subs x22, x21, #85 //U
	cbz x22, replace_vowels

	subs x22, x21, #117 //u
	cbz x22, replace_vowels

	//if character isn't a vowel, move on to the next character
	//in the string
	add x20, x20, #1
	b is_vowel_loop
	
replace_vowels:
	
	mov x23, #120 //ascii for x
	strb w23, [x19, x20]
	
	add x20, x20, #1

	bl is_vowel_loop

print_new_str:

	mov x0, x19
	ldr x1, = string
	bl printf

	ldr x0, = newline
	bl printf

	b exit

