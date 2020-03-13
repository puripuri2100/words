PREFIX=/usr/local
TARGET=words
BINDIR=$(PREFIX)/bin
BUILD=_build

.PHONY: build install uninstall clean

build: src
	-mkdir ${BUILD}
	cp src/*.ml src/*.mli ${BUILD}
	cd ${BUILD} && ocamlfind ocamlopt -o ${TARGET} -linkpkg -package "csv" optionState.mli optionState.ml wordList.mli wordList.ml checkWord.mli checkWord.ml printWord.mli printWord.ml main.ml
	cp ${BUILD}/${TARGET} ./

install: ${TARGET}
	mkdir -p $(BINDIR)
	install $(TARGET) $(BINDIR)

uninstall:
	rm -rf $(BINDIR)/$(TARGET)

clean:
	@rm -rf *.cmi *.cmx *.cmo *.o *.out ${BUILD} ${TARGET}
