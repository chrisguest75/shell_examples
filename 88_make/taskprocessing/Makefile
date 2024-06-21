folder=../

.PHONY: first
first:
	@echo "Processing first (default)"

.PHONY: target1
target1: dependency1 dependency2
	@echo "Processing target1"

.PHONY: dependency1
dependency1:
	@echo "Processing dependency1"
	ls -l ${folder}

.PHONY: dependency2
dependency2:
	@echo "Processing dependency2"

