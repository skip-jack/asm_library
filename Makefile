# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: sadolph <sadolph@student.21-school.ru>     +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/04/29 12:48:54 by sadolph           #+#    #+#              #
#    Updated: 2021/01/15 19:53:57 by sadolph          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# Compile
CC := nasm
FLAGS := -f macho64

# Directories
INCS_DIR := ./includes/
OBJ_DIR := ./obj/
SRC_DIR := ./src/
TEST_DIR := ./tests/

# Files
NAME := libasm.a
TEST_FILE := $(TEST_DIR)test.c
SRCS :=					\
test_free.s				\
ft_read.s				\
ft_strcmp.s				\
ft_strcpy.s				\
ft_strdup.s				\
ft_strlen.s				\
ft_write.s				\
ft_atoi_base.s			\
ft_list_size.s			\
ft_list_push_front.s	\
ft_list_remove_if.s		\
ft_list_sort.s			\

OBJS := ${SRCS:.s=.o}
O_WITH_DIR := $(addprefix $(OBJ_DIR), $(OBJS))

# Rules and dependencies
all: $(NAME)

$(NAME): make_lib make_exec

make_exec:
	gcc -o asm -I $(INCS_DIR) $(TEST_FILE) $(NAME)

make_lib: $(O_WITH_DIR)
	ar rc $(NAME) $?
	ranlib $(NAME)
	@echo "\033[32m$(NAME) successfully created\033[0m" ✅

$(OBJ_DIR)%.o: $(SRC_DIR)%.s $(INCS_DIR)libasm.h
	@mkdir -p $(OBJ_DIR)
	$(CC) $(FLAGS) -I $(INCS_DIR) $< -o $@

# Standard rules
clean:
	rm -rf $(OBJ_DIR)
fclean: clean
	rm -f $(NAME)
	rm -f nasm

re: fclean all

.PHONY: all clean fclean re make_lib make_exec
