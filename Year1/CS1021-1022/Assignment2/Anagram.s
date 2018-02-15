	AREA	Anagram, CODE, READONLY
	IMPORT	main
	EXPORT	start

start
	LDR	R1, =stringA
	LDR	R2, =stringB

stop	B	stop



	AREA	TestData, DATA, READWRITE

stringA	DCB	"bests",0
stringB	DCB	"beets",0

	END
