NAME = libasm.a
NASM = nasm
AR = ar

RM = rm -f

# flags
NASM_FLAGS = -f elf64
AR_FLAGS = rcs

# source files
SRCS_DIR=srcs
SRCS = $(addprefix: $(SRCS_DIR), hello.s)
OBJS = $(SRCS:.s=.o)


$(NAME): $(OBJS)
	$(AR) $(AR_FLAGS) $@ $^

%.o: %.s
	$(NASM) $(NASM_FLAGS) -o $@ $<

all: $(NAME)

clean:
	$(RM) $(OBJS)

fclean: clean
	$(RM) $(NAME)

re:
	make fclean
	make all

.PHONY: all clean fclean re
