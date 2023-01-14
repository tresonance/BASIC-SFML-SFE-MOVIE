BLACK		=	\033[30;1m
RED			=	\033[31;1m
GREEN		=	\033[32;1m
YELLOW		=	\033[33;1m
BLUE		=	\033[34;1m
PURPLE		=	\033[35;1m
CYAN		=	\033[36;1m
MAGENTA		=	\033[95;1m
GREEN		=	\033[37;1m
RESET		=	\033[0m
CLEAR		=	\033[H\e[J

NAME		= sfe-github-bin

BASE_DIR = ./
OBJ_DIR		=	$(BASE_DIR)obj/


CFLAGS = -I/Library/Frameworks/sfeMovie.framework/Versions/2.0/Headers  -I/usr/local/Cellar/sfml/2.5.1_1/include -framework OpenCL

LIBS		= -std=c++17 -lsfml-graphics -lsfml-window -lsfml-system 
CXX := g++ 


all: $(NAME)
.PHONY : all


# extern geometry bin
$(OBJ_DIR)%.o : $(BASE_DIR)%.cpp
		@mkdir -p $(OBJ_DIR)
		@$(CXX) -c $< -o $@

$(OBJ_DIR)%.o : $(BASE_DIR)%.hpp 
		@$(CXX) -c $< -o $@


# executable
$(NAME):    $(OBJ_DIR)MediaInfo.o $(OBJ_DIR)StreamSelector.o $(OBJ_DIR)UserInterface.o $(OBJ_DIR)main.o 
	@echo ""
	@echo "$(CYAN) MAKE ** Building the executable ** $(RESET)"
	@echo "$(PURPLE) \n\t\t\t........................ $(RESET)"
	@$(CXX) $(CFLAGS) -o $(NAME) $(OBJ_DIR)MediaInfo.o $(OBJ_DIR)StreamSelector.o $(OBJ_DIR)UserInterface.o $(OBJ_DIR)main.o  $(LIBS) /Library/Frameworks/sfeMovie.framework/Versions/2.0/sfeMovie && ./$(NAME) 2>/dev/null
	@echo ""



.PHONY: clean
clean:	
	@echo "\033[48;5;15;38;5;25;1mMAKE ** Removing object files and executable... $(RESET)"
	@rm -rf $(NAME)   $(OBJ_DIR)*.o $(ONLY_BOARD_OBJ_DIR)*.o $(MY_OPENCL_OBJ_DIR)*.o


fclean: 
	
	@rm -rf $(OBJ_DIR)
	@rm -rf $(ONLY_BOARD_OBJ_DIR)
	@rm -rf $(MY_OPENCL_OBJ_DIR)
	@rm -rf $(NAME)
	@rm -rf EXT_BIN
	@rm -rf MY_OPENCL_BIN
	@rm -rf ONLY_BOARD_BIN
	

re: fclean all


install:
	@echo '** Installing...'
	cp $(NAME) /usr/bin/


uninstall:
	@echo '** Uninstalling...'
	$(RM) /usr/bin/$(NAME)
 