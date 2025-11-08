
first: src/first.lisp
	sbcl --noinform --load src/first.lisp >a.svg
	cat a.svg

tests: test/turtle-test.lisp src/turtle.lisp
	sbcl --load ~/.sbclrc --script test/turtle-test.lisp
