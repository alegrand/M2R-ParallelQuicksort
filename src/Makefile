parallelQuicksort: parallelQuicksort.o

PEDANTIC_PARANOID_FREAK =       -g -Wall -Wshadow -Wcast-align \
				-Waggregate-return -Wmissing-prototypes -Wmissing-declarations \
				-Wstrict-prototypes -Wmissing-prototypes -Wmissing-declarations \
				-Wmissing-noreturn  \
				-Wpointer-arith -Wwrite-strings -finline-functions -O0

REASONABLY_CAREFUL_DUDE =	-g -Wall -O2
NO_PRAYER_FOR_THE_WICKED =	-w -O3
WARNINGS = 			$(PEDANTIC_PARANOID_FREAK)
CFLAGS = $(WARNINGS) -pthread -lrt -std=c99 
LIBS = 

%: %.o
	$(CC) $(INCLUDES) $(DEFS) $(CFLAGS) $^ $(LIBS) -o $@ 

%.o: %.c
	$(CC) $(INCLUDES) $(DEFS) $(CFLAGS) -c -o $@ $<

clean:
	rm -f parallelQuicksort *.o *~
