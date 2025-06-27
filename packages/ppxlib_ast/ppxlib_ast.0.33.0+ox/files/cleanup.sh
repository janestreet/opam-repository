#!/usr/bin/env bash

rm -rf bench dev doc examples metaquot metaquot_lifters old_rtd_doc print-diff runner runner_as_ppx src test traverse ppxlib*.opam

asts_to_remove="402 403 404 405 406 407 408 409 410 411 412 413"
prev_version=

for version in $asts_to_remove; do
  rm astlib/ast_${version}.ml
  if [ -n "$prev_version" ]; then
    rm astlib/migrate_${version}_${prev_version}.ml
    rm astlib/migrate_${prev_version}_${version}.ml
  fi
  prev_version=$version
done

rm astlib/ast_501.ml
rm astlib/migrate_413_414.ml
rm astlib/migrate_414_413.ml
rm astlib/migrate_500_501.ml
rm astlib/migrate_501_500.ml
