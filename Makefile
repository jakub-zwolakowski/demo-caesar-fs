SHELL := /bin/bash

.PHONY: all
all:
	@echo -e "\\x1b[00;36mgcc -I. caesar.c main.c && ./a.out\\x1b[00m"
	@gcc -I. caesar.c main.c && ./a.out

.PHONY: cov
cov:
	@echo -e "\\x1b[00;36mgcc -I. -fprofile-arcs -ftest-coverage caesar.c main.c && ./a.out\\x1b[00m"
	@gcc -I. -fprofile-arcs -ftest-coverage caesar.c main.c && ./a.out
	@echo ""
	@echo -e "\\x1b[00;36mgcov caesar.c\\x1b[00m"
	@gcov caesar.c

.PHONY: tis
tis:
	@echo -e "\\x1b[00;36mtis-mkfs -generic shift.in:8:0:255 -generic text.in:255:48:90\\x1b[00m"
	@tis-mkfs -generic shift.in:8:0:255 -generic text.in:255:48:90
	@echo -e "\\x1b[00;36mtis-analyzer-gui -64 -I . -val -slevel 1000 caesar.c main_fs.c -no-val-print -fs mkfs_filesystem.c -no-fs-error -val-split-return-function caesar_encrypt:full,caesar_decrypt:full\\x1b[00m"
	@tis-analyzer-gui -64 -I . -val -slevel 1000 caesar.c main_fs.c -no-val-print -fs mkfs_filesystem.c -no-fs-error -val-split-return-function caesar_encrypt:full,caesar_decrypt:full

.PHONY: clean
clean:
	rm -rf a.out a.out.dSYM *.gcov *.gcda *.gcno
