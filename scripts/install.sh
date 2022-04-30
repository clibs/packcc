#!/usr/bin/env bash
## begin
source="$(cat < "${BASH_SOURCE[0]}" | tail -n +10 | xargs)"
jq ".install = \"$source\"" clib.json > clib.json.tmp
mv clib.json clib.json.bak
mv clib.json.tmp clib.json
exit
## end
## Source begins on line #10
if $(uname -s | grep -q MINGW); then
  {
    which clang 2>/dev/null && make -C build/mingw-clang && {
      install -b build/mingw-clang/release/bin/packcc ${PREFIX:-/usr/local}/bin/packcc || install -b build/mingw-clang/release/bin/packcc $HOME/.local/bin/packcc;
    };
  } || {
    which gcc 2>/dev/null && make -C build/mingw-gcc && {
      install -b build/mingw-gcc/release/bin/packcc ${PREFIX:-/usr/local}/bin/packcc || install -b build/mingw-gcc/release/bin/packcc $HOME/.local/bin/packcc;
    };
  };
else
  {
    which clang 2>/dev/null && make -C build/clang && {
      install -b build/clang/release/bin/packcc ${PREFIX:-/usr/local}/bin/packcc || install -b build/clang/release/bin/packcc $HOME/.local/bin/packcc;
    };
  } || {
    which gcc 2>/dev/null && make -C build/gcc && {
      install -b build/gcc/release/bin/packcc ${PREFIX:-/usr/local}/bin/packcc || install -b build/gcc/release/bin/packcc $HOME/.local/bin/packcc;
    };
  };
fi
