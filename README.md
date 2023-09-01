# OPAM repository for OCaml with Jane Street extensions

This repository is a package repository for the [opam package manager](https://opam.ocaml.org). It contains OCaml with Jane Street extensions,
including all Jane Street packages and necessary patches to external packages for building our libraries.

## Installation

**WARNING**: this repository is experimental and is not officially supported by Jane Street. Use at your own risk.

Start by adding the repository to OPAM:

```sh
opam repo add janestreet-bleeding-with-extensions https://github.com/janestreet/opam-repository.git#with-extensions
```

Next, create a new switch with our compiler and a patched version of Dune:

```sh
# This may take some time
opam switch create 4.14.1-jst --repos janestreet-bleeding-with-extensions,default --packages ocaml-base-compiler=4.14.1-18,dune=3.10.0
eval $(opam env --switch 4.14.1-jst)
```

If the installation was successful, you can now use OCaml with our extensions! Try creating `hello.ml` and running it with `ocamlc -o hello hello.ml && ./hello`:

```ocaml
external globalize_string : local_ string -> string = "%obj_dup"

let hello () = local_ "Hello, World!"

let () =
  let local_message = hello () in
  (* Can't print [local_message] -- the value would escape. *)
  let global_message = globalize_string local_message in
  (* Copy the string to create a new global value. *)
  print_endline global_message
;;
```

Our libraries such as Base and Core contain various functions to deal with local values. Install them with `opam install`,
and read their documentation and interface files to learn more. For a general introduction to OCaml and our libraries,
refer to [Real World OCaml](https://dev.realworldocaml.org/index.html).

## Known issues

### ARM64 and other platforms

This compiler version does not yet support ARM64 and other architectures different from x86_64.
Work on supporting ARM64 is being tracked [here](https://github.com/ocaml-flambda/flambda-backend/pull/1691).

For Apple Silicon users, Rosetta 2 can be used to set up the x86_64 version of our compiler:

```sh
arch -x86_64 zsh
# Install Homebrew for x86_64, skip if already present
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "($/usr/local/bin/brew shellenv)"
# Install OPAM for x86_64, skip if already present
brew install opam
opam init
# Continue with default instructions
```

### Windows

This compiler version does not yet support Windows. Windows users are recommended to use WSL 2 to try out our compiler.

### Js_of_ocaml

Support for Js_of_ocaml requires patches to the JSOO compiler, which have not yet been published.
