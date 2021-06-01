CC = g++
CXXFLAGS = -Wall -O3 -std=c++11 -Wno-comment
UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Darwin)
LIBS := -framework OpenGL -lglut -lm
CXXFLAGS += -Wno-deprecated 
else
LIBS = -Wl,--no-as-needed -lpthread -lGL -lglut -lm -lGLU -pthread
endif


all: visualizer 

# solutions
visualizer: main.o ObjModel.o core.o
	$(CC) $(CXXFLAGS) -o $@ $^ $(LIBS)

clean:
	rm -f *.o visualizer
