.RECIPEPREFIX =  

VARIABLE1 = variable1
#CC = clang++
OBJECT_DIR = obj
BIN_DIR = bin


all: $(BIN_DIR)/test

.PRECIOUS: $(BIN_DIR)/test 
.PHONY: all clean

$(BIN_DIR)/test: ../README.md
	@echo "VARIABLE1 = $(VARIABLE1)"
	mkdir -p $(BIN_DIR)
	echo "VARIABLE1 = $(VARIABLE1)" >> $(BIN_DIR)/test

clean:
	rm -f $(BIN_DIR)/test
	rmdir $(BIN_DIR) 2>/dev/null || true
