CC = gcc
CFLAGS = -lm -g

Mandelbrot: ComplexNumber.o Mandelbrot.o MandelFrame.o
	$(CC) -o MandelFrame ComplexNumber.o Mandelbrot.o MandelFrame.o -lm -g 

MandelMovie: ComplexNumber.o Mandelbrot.o MandelMovie.o
	$(CC) -o $@ ComplexNumber.o Mandelbrot.o MandelMovie.o -g 

testA:	Mandelbrot
	./MandelFrame 2 1536 -0.7746806106269039 -0.1374168856037867 1e-5 100 student_output/student_output.txt
	python verify.py testing/partA.txt student_output/student_output.txt

testASimple:	Mandelbrot
	./MandelFrame 2 1536 5 3 5 2 student_output/student_output.txt
	python verify.py testing/partASimple.txt student_output/student_output.txt

memcheckA:	Mandelbrot
	valgrind --tool=memcheck --leak-check=full --dsymutil=yes --track-origins=yes ./MandelFrame 2 1536 -0.7746806106269039 -0.1374168856037867 1e-5 100 student_output/student_output.txt

testB:  MandelMovie
	./MandelMovie 2 1536 -0.561397233777 -0.643059076016 2 1e-7 5 100 student_output/partB defaultcolormap.txt
	python verify.py testing/testB student_output/partB

memcheckB: MandelMovie
	valgrind --tool=memcheck --leak-check=full --dsymutil=yes --track-origins=yes ./MandelMovie 2 1536 -0.561397233777 -0.643059076016 2 1e-7 5 100 student_output/partB defaultcolormap.txt

BigTest:  MandelMovie
	./MandelMovie 2 1536 -0.561397233777 0.643059076016 2 1e-7 576 400 student_output/BigTest defaultcolormap.txt
	python verify.py testing/BigTest student_output/BigTest

%.o: %.c
	$(CC) -c $(CFLAGS) $<

clean:
	rm -rf *.o
