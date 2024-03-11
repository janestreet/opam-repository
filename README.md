# opam-repository

This repository is a package repository for the [opam package
manager](https://opam.ocaml.org).

It contains the development version of all Jane Street packages. To use
it, type:

```sh
opam repo add janestreet-bleeding https://github.com/janestreet/opam-repository.git
```

Some packages depend on unreleased versions of non-Jane Street packages. These
can be made available with:

```sh
opam repo add janestreet-bleeding-external https://github.com/janestreet/opam-repository.git#external-packages
```

If you are looking to install the repository with our compiler extensions,
please click [here](https://github.com/janestreet/opam-repository/tree/with-extensions).
