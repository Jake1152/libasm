NAME = main
LIB_NAME = libasm.a
NASM = nasm
AR = ar
RM = rm -f
CC = gcc

# flags
NASM_FLAGS = -f elf64
AR_FLAGS = rcs

# source files
SRCS_DIR = srcs
SRCS = $(addprefix $(SRCS_DIR)/, ft_strlen.s ft_read.s ft_write.s ft_strcpy.s ft_strcmp.s)
# ft_strdup.s
OBJS = $(SRCS:.s=.o)
MAIN = main_other.c

all: $(NAME)

$(LIB_NAME): $(OBJS)
	$(AR) $(AR_FLAGS) $@ $^

$(NAME): $(LIB_NAME) $(MAIN_OBJ)
	$(CC) -o $@ $(MAIN) -L. -lasm

%.o: %.s
	$(NASM) $(NASM_FLAGS) -o $@ $<

clean:
	$(RM) $(OBJS)

fclean: clean
	$(RM) $(LIB_NAME) $(NAME)

re:
	make fclean
	make all

.PHONY: all clean fclean re
