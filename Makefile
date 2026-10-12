NAME		= cub3d

SRC_DIR		= sources
OBJ_DIR		= object
INC_DIR		= header

LIBFT_DIR	= Libft
LIBFT		= $(LIBFT_DIR)/libft.a

LIBMLX_DIR	= minilibx-linux
LIBMLX		= $(LIBMLX_DIR)/libmlx.a

CC			= cc
CFLAGS		= -Wall -Wextra -Werror -I$(INC_DIR) -I$(LIBFT_DIR) -I$(LIBMLX_DIR)
LIBS		= $(LIBMLX) $(LIBFT) -lXext -lX11 -lm
RM			= rm -rf

RED			= \033[0;31m
GREEN		= \033[0;32m
YELLOW		= \033[0;33m
BLUE		= \033[0;34m
ORANGE		= \033[38;5;208m
RESET		= \033[0m

FILES		= cub3d.c
SRC			= $(addprefix $(SRC_DIR)/, $(FILES))
OBJ			= $(patsubst $(SRC_DIR)/%.c,$(OBJ_DIR)/%.o,$(SRC))

all: $(NAME)

$(NAME): $(OBJ) $(LIBFT) $(LIBMLX)
	@$(CC) $(CFLAGS) $(OBJ) $(LIBS) -o $(NAME)
	@printf "$(GREEN)[SUCCESS]$(RESET) $(NAME) is ready to launch !\n"

$(LIBFT):
	@$(MAKE) -C $(LIBFT_DIR) --no-print-directory -s
	@printf "$(ORANGE)[MAKE]$(RESET) libft\n"

$(LIBMLX):
	@$(MAKE) -C $(LIBMLX_DIR) -f Makefile.mk INC=/usr/include \
		--no-print-directory -s > /dev/null 2>&1
	@printf "$(ORANGE)[MAKE]$(RESET) libmlx\n"

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c $(INC_DIR)/cub3d.h
	@mkdir -p $(dir $@)
	@$(CC) $(CFLAGS) -c $< -o $@
	@printf "$(BLUE)[CC]$(RESET) $<\n"

clean:
	@$(RM) $(OBJ_DIR)
	@$(MAKE) -C $(LIBFT_DIR) clean --no-print-directory -s
	@$(MAKE) -C $(LIBMLX_DIR) -f Makefile.mk clean --no-print-directory -s
	@printf "$(YELLOW)[CLEAN]$(RESET) object files removed\n"

fclean: clean
	@$(RM) $(NAME)
	@$(MAKE) -C $(LIBFT_DIR) fclean --no-print-directory -s
	@printf "$(RED)[FCLEAN]$(RESET) $(NAME) and libraries removed\n"

re: fclean all

.PHONY: all clean fclean re
