NAME		=	libasm.so

NAMETEST	=	testing

SRCSTEST	=	main.c

SRCS_64		=	strlen_64.S \
			strcmp_64.S \
			strcpy_64.S \
			index_64.S \
			strstr_64.S \
			memset_64.S \
			strmore_64.S \
			memcpy_64.S \
			strdup_64.S

SRCS_32		=	strlen_32.S \
			strcmp_32.S \
			strcpy_32.S \
			index_32.S \
			strstr_32.S \
			memset_32.S \
			strmore_32.S \
			memcpy_32.S \
			strdup_32.S

OBJS_64		=	$(SRCS_64:.S=.o)

OBJS_32		=	$(SRCS_32:.S=.o)

ifeq ($(shell uname -m | grep -o 64), 64)
OBJS		=	$(OBJS_64)
else
OBJS		=	$(OBJS_32)
endif

OBJSTEST	=	$(SRCSTEST:.c=.o)

NASM		=	nasm

CC		=	gcc

NASMFLAGS	=	-f elf64

CFLAGS		=	-c -Wall -Wextra -Werror

RM		=	rm -f

all:		$(NAME)

$(NAME):	$(OBJS)
		@echo -e "linking of $@"
		$(CC) -o $(NAME) $(OBJS) -shared -fPIC
		@echo -e "$(NAME) Compiled"

%.o:		%.S
		$(NASM) $(NASMFLAGS) -o $@ $<

%.o:		%.c
		$(CC) $(CFLAGS) -o $@ $<

clean:
		$(RM) $(OBJS_64) $(OBJS_32)
		$(RM) $(OBJSTEST)

fclean:		clean
		$(RM) $(NAME)
		$(RM) $(NAMETEST)

re:		fclean all

test:		all $(NAMETEST)
		LD_PRELOAD="./$(NAME)" ./$(NAMETEST)

$(NAMETEST):	$(OBJSTEST)
		$(CC) -o $(NAMETEST) $(OBJSTEST)

.PHONY:		all clean fclean re test
