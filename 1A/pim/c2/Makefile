all: test_file exemple_file
test_file: test_file.o file.o
	c99 test_file.o file.o -o test_file
exemple_file: exemple_file.o file.o
	c99 exemple_file.o file.o -o exemple_file