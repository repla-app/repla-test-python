.PHONY: ci ac autocorrect lint

ci: lint
ac: autocorrect

lint:
	rubocop

autocorrect:
	rubocop -a

test:
	run_tests.sh
