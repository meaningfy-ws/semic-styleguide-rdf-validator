from pyshacl import validate
from rdflib import Graph

DATA_FILE = "examples/example-data.ttl"
SHACL_FILE = "examples/example-shape.shacl.ttl"


def main(data_file, shacl_file):
    input_data = Graph().parse(data_file)
    shacl_data = Graph().parse(shacl_file)
    # conforms, report_graph, text = validate(input_data, shacl_graph=shacl_data)
    _, _, text = validate(input_data, shacl_graph=shacl_data)

    print(text)

    # if not conforms:
    #     import json
    #     result_list = json.loads(report_graph.serialize(format="json-ld"))
    #     result_message = [d.get("http://www.w3.org/ns/shacl#resultMessage", None) for d in result_list]
    #     print(result_message[1][0]["@value"])
    #     print(report_graph.serialize())


if __name__ == "__main__":
    main(DATA_FILE, SHACL_FILE)
