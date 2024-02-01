import pytest
from pyshacl import validate
from rdflib import Graph

from tests import SHAPES_FOLDER
from tests.unit.owl import TEST_DATA_FOLDER

TEST_FILE_NAME = "only_subsumption_rels"
TEST_DATA_FOLDER = TEST_DATA_FOLDER / TEST_FILE_NAME
SHAPES_FOLDER = SHAPES_FOLDER / "owl"


@pytest.fixture
def shacl_data():
    # Load your SHACL shapes
    return Graph().parse(SHAPES_FOLDER / f"{TEST_FILE_NAME}.shacl.ttl", format="ttl")


@pytest.fixture
def correct_data():
    # Load correct RDF data
    return Graph().parse(
        TEST_DATA_FOLDER / f"{TEST_FILE_NAME}_correct.ttl", format="ttl"
    )


@pytest.fixture
def wrong_data():
    # Load incorrect RDF data
    return Graph().parse(TEST_DATA_FOLDER / f"{TEST_FILE_NAME}_wrong.ttl", format="ttl")


def test_shacl_validation_correct(shacl_data, correct_data):
    # Validate correct RDF data against SHACL shapes
    conforms, report_graph, _ = validate(correct_data, shacl_graph=shacl_data)

    # Assert that the data conforms to the shapes
    assert conforms, f"SHACL validation failed:\n{report_graph.serialize()}"


def test_shacl_validation_wrong(shacl_data, wrong_data):
    # Validate incorrect RDF data against SHACL shapes
    conforms, _, _ = validate(wrong_data, shacl_graph=shacl_data)

    # Assert that the data does not conform to the shapes
    assert not conforms, "SHACL validation succeeded, but it should have failed"


if __name__ == "__main__":
    pytest.main()
