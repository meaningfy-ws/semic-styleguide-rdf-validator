# SEMIC Style Guide RDF Validator

This project comprises a Python test suite and configuration resources for a
Java service, for validating [OWL](https://www.w3.org/TR/owl2-overview/)
vocabularies and [SHACL](https://www.w3.org/TR/shacl/) shapes, according to the
[SEMIC
conventions](https://semiceu.github.io/style-guide/1.0.0/guidelines-and-conventions.html)
for [semantic data
interoperability](https://joinup.ec.europa.eu/collection/semic-support-centre/semic-style-guide-semantic-engineers),
as part of the [interoperability test bed
(ITB)](https://joinup.ec.europa.eu/collection/interoperability-test-bed-repository/solution/interoperability-test-bed).

The use case is geared towards validating an OWL ontology (rather than its
instance data) like
[ePO](https://github.com/OP-TED/ePO/tree/master/implementation/ePO_core/owl_ontology)
and/or a [SHACL Shapes
file](https://github.com/OP-TED/ePO/tree/master/implementation/ePO_core/shacl_shapes)
(which itself typically validates instance data) to ensure comformance to
applicable SEMIC rules.

## ITB SEMIC SHACL Validator

This service allows you to assess the conformance of an **OWL model**
(ontology) or a **SHaCL Shapes** file with the [SEMIC Style
Guide](https://semiceu.github.io/style-guide/1.0.0/gc-conceptual-model-conventions.html).
For each guideline in the style guide, a set of rules have been implemented,
which assess whether an OWL or SHACL convention is respected. These rules
specify constraints on the structure, relationships, and properties within the
models. The set of rules employed during validation is documented
[here](https://meaningfy-ws.github.io/semic-styleguide-rdf-validator/).

The content to validate can be provided as a **file** or a **URI reference**.
Documentation on using the Interoperability Test Bed (ITB) is available
[here](https://www.itb.ec.europa.eu/docs/guides/latest/validatingRDF/index.html#step-6-use-the-validator).

## SEMIC Conformance Test Suite for OWL and ShaCL

Aside from the `examples/` folder, which is provided for user convenience, only
the `resources/` folder is
[specific](https://www.itb.ec.europa.eu/docs/guides/latest/validatingRDF/) to
the [ITB validator](https://github.com/ISAITB/shacl-validator).

The single SEMIC shapes file `resources/shapes/semic-shapes.ttl` for ITB is
automatically generated from multiple modular SHACL files (with the extension
`.shacl.ttl`) under the toplevel `shapes/` folder, which are used by the Python
unit test files in `test/`.

Support for aggregating data, running a validation command, and testing a local
ITB validator service instance via [Docker](https://www.docker.com/) are also
provided (see `Makefile`, `validation_runner.py` and `docker-compose.yml`
respectively).

### Environment

The unit testing component is a Python 3.8+ project. You may want to create a
local virtual environment to set up and run anything in it:

```bash
python -m venv .venv
source .venv/bin/activate
```

Run `deactivate` to exit out of this environment at any time.

Your Python programming IDE of choice should also have a way to select
this as the "interpreter runtime".

You may also use any other means to run Python programs, such as a
system-installed interpreter, the `pyenv` tool, or the `conda` tool (via a
distribution like Anaconda).

### Installation

Install the prerequisite software/library dependencies via the Python
package manager Pip:

```bash
pip install -r requirements.txt
```

You may want/have to run `python -m pip install --upgrade` to upgrade Pip
itself, so that you have up-to-date dependency resolution.

Alternatively, a convenience Makefile is provided through which you can
simply run `make` (which defaults to running `make install`), if you have
the tool.

### Usage

Run the test suite from the toplevel/root of the project folder:

```bash
pytest # or make test
```

For generating the complete ShaCL shapes file aggregated from the
individual test shapes, a convenience Make target is provided:

```bash
make generate_aggregate_shapes
```

This generates the ShACL shapes file in `output/semic-shacl.ttl` (a version of
which is committed in `resources/shapes`).

Alternatively, if you do not have `make`, inspect the Makefile and run the
relevant commands yourself.
