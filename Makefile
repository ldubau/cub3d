NAME		= cub3d

SRC_DIR		= sources
OBJ_DIR		= object
INC_DIR		= header

CC			= cc
CFLAGS		= -Wall -Wextra -Werror -I$(INC_DIR)
RM			= rm -rf

GREEN		= \033[0;32m
YELLOW		= \033[0;33m
BLUE		= \033[0;34m
RED			= \033[0;31m
RESET		= \033[0m

FILES		=
SRC			= $(addprefix $(SRC_DIR)/, $(FILES))
OBJ			= $(patsubst $(SRC_DIR)/%.c,$(OBJ_DIR)/%.o,$(SRC))

all: $(NAME)

$(NAME): $(OBJ)
	@$(CC) $(CFLAGS) $(OBJ) -o $@
	@printf "$(GREEN)[SUCCESS]$(RESET) $(NAME)

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c $(INC_DIR)/cub3d.h
	@mkdir -p $(dir $@)
	@$(CC) $(CFLAGS) -c $< -o $@
	@printf "$(BLUE)[CC]$(RESET) $<\n"

clean:
	@$(RM) $(OBJ_DIR)
	@printf "$(YELLOW)[CLEAN]$(RESET) object files removed\n"

fclean: clean
	@$(RM) $(NAME)
	@printf "$(RED)[FCLEAN]$(RESET) $(NAME) removed\n"

re: fclean all

.PHONY: all clean fclean re
