# Compiler and flags
CXX = g++
CXXFLAGS = -std=c++17
SFML_INC = /opt/homebrew/Cellar/sfml/3.0.0/include
SFML_LIB = /opt/homebrew/Cellar/sfml/3.0.0/lib
SFML_LIBS = -lsfml-graphics -lsfml-window -lsfml-system -lsfml-audio -lsfml-network

# Directories
SRC_DIR = .
BUILD_DIR = build

# Files
SRCS = $(SRC_DIR)/main.cpp
OBJ = $(SRCS:$(SRC_DIR)/%.cpp=$(BUILD_DIR)/%.o)

# Output binary names
DEBUG_BIN = my_game_debug
RELEASE_BIN = my_game_release

# Targets
all: debug

# Debug build
debug: CXXFLAGS += -g
debug: $(DEBUG_BIN)

$(DEBUG_BIN): $(OBJ)
	$(CXX) $(CXXFLAGS) -o $@ $^ -I$(SFML_INC) -L$(SFML_LIB) $(SFML_LIBS)

# Release build
release: CXXFLAGS += -O2
release: $(RELEASE_BIN)

$(RELEASE_BIN): $(OBJ)
	$(CXX) $(CXXFLAGS) -o $@ $^ -I$(SFML_INC) -L$(SFML_LIB) $(SFML_LIBS)

# Object files
$(BUILD_DIR)/%.o: $(SRC_DIR)/%.cpp
	mkdir -p $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) -c -o $@ $< -I$(SFML_INC)

# Clean build artifacts
clean:
	rm -rf $(BUILD_DIR) $(DEBUG_BIN) $(RELEASE_BIN)

# Debug check (Check if debug build exists)
debug_check: $(DEBUG_BIN)
	@echo "Debug build exists: $(DEBUG_BIN)"

# PHONY targets
.PHONY: all clean debug release debug_check
