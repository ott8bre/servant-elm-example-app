all: backend frontend

.PHONY: backend
backend:
	stack build --install-ghc --copy-bins

.PHONY: frontend
frontend: frontend/dist/app.js

frontend/dist/app.js: frontend/src/*.elm frontend/src/Generated/*.elm
	mkdir -p $(@D) && elm-make frontend/src/Main.elm --output $@

frontend/src/Generated/Api.elm: code-generator/*.hs api/**/*.hs backend
	mkdir -p $(@D) && stack exec code-generator

.PHONY: serve
serve:
	stack exec backend
