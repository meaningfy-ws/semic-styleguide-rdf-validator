BUILD_PRINT = \e[1;34mSTEP: \e[0m
SHAPES_FILE = semic-shapes.ttl
DATA_FILE_CORRECT = example-data_correct.ttl
DATA_FILE_WRONG = example-data_wrong.ttl

install:
	@ python -m pip install --upgrade pip
	@ python -m pip install -r requirements.txt

test:
	@ pytest

generate_aggregate_shapes:
	@ echo "$(BUILD_PRINT)Creating aggregate shapes file output/$(SHAPES_FILE)"
	@ mkdir -p output
	@ rm -f output/$(SHAPES_FILE)
	@ find shapes -type f -iname "*.shacl.ttl" -exec grep '^@prefix' {} \; | awk '!x[$$0]++' > output/$(SHAPES_FILE)
	@ find shapes -type f -iname "*.shacl.ttl" -exec grep -v '^@prefix' {} \; >> output/$(SHAPES_FILE)

generate_aggregate_data:
	@ echo "$(BUILD_PRINT)Creating aggregate example data files"
	@ mkdir -p output
	@ rm -vf output/$(DATA_FILE_CORRECT)
	@ echo "-> output/$(DATA_FILE_CORRECT)"
	@ find tests/test_data -type f -iname "*correct.ttl" -exec grep '^@prefix' {} \; | awk '!x[$$0]++' > output/$(DATA_FILE_CORRECT)
	@ find tests/test_data -type f -iname "*correct.ttl" -exec grep -v '^@prefix' {} \; >> output/$(DATA_FILE_CORRECT)
	@ rm -vf output/$(DATA_FILE_WRONG)
	@ echo "-> output/$(DATA_FILE_WRONG)"
	@ find tests/test_data -type f -iname "*wrong.ttl" -exec grep '^@prefix' {} \; | awk '!x[$$0]++' > output/$(DATA_FILE_WRONG)
	@ find tests/test_data -type f -iname "*wrong.ttl" -exec grep -v '^@prefix' {} \; >> output/$(DATA_FILE_WRONG)

clean:
	@ echo "$(BUILD_PRINT)Cleaning up output folder"
	@ rm -v output/$(SHAPES_FILE)
