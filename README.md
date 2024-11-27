# OPAM repository for OCaml with Jane Street extensions

This repository is a package repository for the [opam package manager](https://opam.ocaml.org). It contains OCaml with Jane Street language
extensions, including all Jane Street packages and necessary patches to external packages for building our libraries.

## Installation

**WARNING**: this repository is experimental and is not officially supported by Jane Street. Use at your own risk.

Start by adding the repository to OPAM:

```sh
opam repo add with-extensions https://github.com/janestreet/opam-repository.git#with-extensions
```

Next, create a new switch with our compiler:

```sh
# This may take some time
opam switch create 5.2.0+flambda2 --repos with-extensions,default
eval $(opam env --switch 5.2.0+flambda2)
```

If the installation was successful, you can now use OCaml with our extensions! Try creating `hello.ml` and running it with `ocamlc -o hello hello.ml && ./hello`:

```ocaml
external globalize_string : string @ local -> string = "%obj_dup"

let () =
  let local_message : string @@ local = "Hello, World" in
  (* Can't print [local_message] -- the value would escape. *)
  let global_message = globalize_string local_message in
  (* Copy the string to create a new global value. *)
  print_endline global_message
;;
```

Our switch now supports developer tooling such as `ocamlformat` or `merlin`!
Be sure to install versions of those tools marked with `+jst`, and enjoy
editor support in VSCode, Emacs and Vim:

```sh
opam pin ocamlformat.0.26.2+jst merlin.5.2.1-502+jst ocaml-lsp-server.1.19.0+jst utop.2.14.0+jst
```

Our libraries such as Base and Core contain various functions to deal with local values. Install them with `opam install`,
and read their documentation and interface files to learn more. For a general introduction to OCaml and our libraries,
refer to [Real World OCaml](https://dev.realworldocaml.org/index.html).

## Known issues

### Platforms other than x86_64 or ARM64

This compiler version does not yet support architectures other than x86_64 or ARM64.

### Windows

This compiler version does not yet support Windows. Windows users are recommended to use WSL 2 to try out our compiler.
