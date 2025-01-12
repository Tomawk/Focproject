CPPFLAGS=-g -pthread -Wall
LDFLAGS=-g
LDLIBS=-lcrypto
AR=ar
ARFLAGS=rvs

TARGETS 			=	build/server_main \
						build/client_main


OBJECTSSERVER	=	build/tcp_server.o \
					build/client.o 
					 

OBJECTSCLIENT = build/tcp_client.o  	


INCLUDE_SERVER=	include/util.h \
				include/tcp_server.h \
				include/server_observer.h \
				include/pipe_ret_t.h \
				include/client.h


INCLUDE_CLIENT= include/util.h \
				include/tcp_client.h \
				include/client_observer.h \
				include/pipe_ret_t.h


.PHONY: all clean test directories

.SUFFIXES: .cpp .h

build/%: src/%.cpp 
	g++ $(CPPFLAGS) $(INCLUDES) $(LDFLAGS) -o $@ $< $(LDLIBS)

build/%: src/%.cpp 
	g++ $(CPPFLAGS) $(INCLUDES) $(LDFLAGS) -o $@ $< $(LDLIBS)

build/%.o: %.cpp 
	g++ $(CFLAGS) $(INCLUDES) $(LDFLAGS) -c -o $@ $< $(LDLIBS) 

build/%.o: src/%.cpp 
	g++ $(CFLAGS) $(INCLUDES) $(LDFLAGS) -c -o $@ $< $(LDLIBS) 


all: directories $(TARGETS)


build/server_main: build/server_main.o build/libserver.a $(INCLUDE_SERVER)
	g++ $(CPPFLAGS) $(INCLUDES) $(LDFLAGS) -o $@ $^ $(LDLIBS)


build/client_main: build/client_main.o build/libclient.a $(INCLUDE_CLIENT)
	g++ $(CPPFLAGS) $(INCLUDES) $(LDFLAGS) -o $@ $^ $(LDLIBS)


build/libserver.a: $(OBJECTSSERVER)
	$(AR) $(ARFLAGS) $@ $^


build/libclient.a: $(OBJECTSCLIENT)
	$(AR) $(ARFLAGS) $@ $^


clean:
	rm -rf build/*

directories:
	mkdir -p build