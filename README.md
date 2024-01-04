# SEMIC Conformance Test Suite for OWL and ShaCL

## Environment

This is a Python 3.8+ project. You may want to create a local virtual
environment to set up and run anything in it:

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

## Installation

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

## Usage

Run the test suite from the toplevel/root of the project folder:

```bash
pytest # or make test
```

For generating the complete ShaCL shapes file aggregated from the
individual test shapes, a convenience Make target is provided:

```bash
make generate_aggregate_shapes
```

This generates the ShACL shapes file in `output/semic-shacl.ttl`.

Alternatively, if you do not have `make`, inspect the Makefile and run the
relevant commands yourself.
