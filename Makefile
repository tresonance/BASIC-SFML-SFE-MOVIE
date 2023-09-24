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

#IBRAHIMA_DIR=/Users/ibrahimatraore/
COURSES_DIR=~/COURSES
ONLY_BOARD_DIR =$(COURSES_DIR)/ONLY_BOARD
# Where to find headers 
SFE_SFML_LIBS=$(COURSES_DIR)/SFE_SFML_IMGUI_LIBS
BASIC_SFE_DIR=$(SFE_SFML_LIBS)/basic_sfe

OBJ_DIR		=	obj/
LIBS		=  -std=c++17 -lsfml-graphics -lsfml-window -lsfml-system -lsfml-audio
CXX := g++

NO_WARNINGS_FLAGS=-Wno-deprecated -Wno-c++11-extensions -Wno-inconsistent-missing-override -lsfml-graphics -lsfml-window -lsfml-system
SFML_HEADERS_DIR=${BASIC_SFE_DIR}/sfml_headers 

# SO Library Name without prefix lib and extensio .so
SO_LIBRARY_NAME = sfe_sfml_imgui_svg_bin

CXXFLAGS=-std=c++11 $(NO_WARNINGS_FLAGS) -I$(SFML_HEADERS_DIR) -I$(FFmpeg_HEADERS_DIR) -I$(SFE_HEADERS_DIR) -framework OpenCL 




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
	$(shell rm libsfe_sfml_imgui_svg_bin.so && ln -s ~/COURSES/SFE_SFML_IMGUI_LIBS/basic_all_in_one/libsfe_sfml_imgui_svg_bin.so libsfe_sfml_imgui_svg_bin.so > /dev/null )
	@$(CXX) $(CXXFLAGS) -L`pwd`  -l$(SO_LIBRARY_NAME) $(LIBS) -o $(NAME) $(OBJ_DIR)MediaInfo.o $(OBJ_DIR)StreamSelector.o $(OBJ_DIR)UserInterface.o $(OBJ_DIR)main.o   && ./$(NAME) 2>/dev/null
	@echo ""



.PHONY: clean
clean:	
	@echo "\033[48;5;15;38;5;25;1mMAKE ** Removing object files and executable... $(RESET)"
	@rm -rf $(NAME)   $(OBJ_DIR)*.o 


fclean: 
	
	@rm -rf $(OBJ_DIR)
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
 