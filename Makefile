NAME = libasm.a
NASM = nasm
AR = ar

RM = rm -f

# flags
NASM_FLAGS = -f elf64
AR_FLAGS = rcs


# source files
SRCS_DIR = srcs
SRCS = $(addprefix $(SRCS_DIR)/, ft_strlen.s)
OBJS = $(SRCS:.s=.o)

%.o: %.s
	$(NASM) $(NASM_FLAGS) -o $@ $<

$(NAME): $(OBJS)
	$(AR) $(AR_FLAGS) $@ $^

all: $(NAME)

clean:
	$(RM) $(OBJS)

fclean: clean
	$(RM) $(NAME)

re:
	make fclean
	make all

.PHONY: all clean fclean re
