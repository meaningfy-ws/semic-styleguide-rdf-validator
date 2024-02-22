BUILD_PRINT = \e[1;34mSTEP: \e[0m
SHAPES_FILE_OWL = semic-shapes_owl.ttl
SHAPES_FILE_SHACL = semic-shapes_shacl.ttl
DATA_FILE_CORRECT = example-data_correct.ttl
DATA_FILE_WRONG = example-data_wrong.ttl

install:
	@ python -m pip install --upgrade pip
	@ python -m pip install -r requirements.txt

test:
	@ pytest

# NOTE: please validate these files yourself e.g. with Apache Jena's `riot --validate`
generate_aggregate_shapes:
	@ echo "$(BUILD_PRINT)Creating aggregate OWL shapes file output/$(SHAPES_FILE_OWL)"
	@ mkdir -p output
	@ rm -f output/$(SHAPES_FILE_OWL)
	@ find shapes/owl -type f -iname "*.shacl.ttl" -exec grep '^@prefix' {} \; | awk '!x[$$0]++' > output/$(SHAPES_FILE_OWL)
	@ find shapes/owl -type f -iname "*.shacl.ttl" -exec grep -v '^@prefix' {} \; >> output/$(SHAPES_FILE_OWL)
	@ echo "$(BUILD_PRINT)Creating aggregate SHACL shapes file output/$(SHAPES_FILE_SHACL)"
	@ mkdir -p output
	@ rm -f output/$(SHAPES_FILE_SHACL)
	@ find shapes/shacl -type f -iname "*.shacl.ttl" -exec grep '^@prefix' {} \; | awk '!x[$$0]++' > output/$(SHAPES_FILE_SHACL)
	@ find shapes/shacl -type f -iname "*.shacl.ttl" -exec grep -v '^@prefix' {} \; >> output/$(SHAPES_FILE_SHACL)

# WARNING: does not yet separate OWL and SHACL
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

list_rules_covered:
	@ echo "$(BUILD_PRINT)List of rules covered by current shapes:"
	@ grep -R "sh:message.*of SEMIC rule" shapes | sed -e 's/.*of SEMIC rule //' -e 's/:.*//' | sort -u

start-service:
	@ docker-compose --file docker-compose.yml up -d

stop-service:
	@ docker-compose --file docker-compose.yml down

clean:
	@ echo "$(BUILD_PRINT)Cleaning up output folder"
	@ rm -fv output/$(SHAPES_FILE_OWL)
	@ rm -fv output/$(SHAPES_FILE_SHACL)
	@ rm -fv output/$(DATA_FILE_CORRECT)
	@ rm -fv output/$(DATA_FILE_WRONG)
