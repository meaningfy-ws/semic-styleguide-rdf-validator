BUILD_PRINT = \e[1;34mSTEP: \e[0m
SHAPES_FILE = semic-shapes.ttl

install:
	@ python -m pip install --upgrade pip
	@ python -m pip install -r requirements.txt

test:
	@ pytest

generate_aggregate_shapes:
	@ echo "$(BUILD_PRINT)Creating aggregate shapes file output/$(SHAPES_FILE)"
	@ mkdir -p output
	@ rm -f output/$(SHAPES_FILE)
	@ find -type f -iname "*.shacl.ttl" -exec grep '^@prefix' {} \; | awk '!x[$$0]++' > output/$(SHAPES_FILE)
	@ find -type f -iname "*.shacl.ttl" -exec grep -v '^@prefix' {} \; >> output/$(SHAPES_FILE)

clean:
	@ echo "$(BUILD_PRINT)Cleaning up output folder"
	@ rm -v output/$(SHAPES_FILE)
