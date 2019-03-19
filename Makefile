init:
	pip3 install -r requirements.txt

test:
	pytest tests

package:
	python setup.py bdist_wheel

clean:
	rm -rf __pycache__ batch_classify/__pycache__ tests/__pycache__ .pytest_cache build dist batch_classify.egg-info

env:
	cp .env.example .env
