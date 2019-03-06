load("//internal:bundle-dev.bzl", _bundle_dev = "bundle_dev")
load("//internal:bundle-prod.bzl", _bundle_prod = "bundle_prod")
load("//internal:stencil.bzl", _stencil = "stencil")

load("//:package.bzl", _rules_stencil_dependencies = "rules_stencil_dependencies")

load("@io_bazel_rules_sass//sass:sass.bzl", _sass_library = "sass_library", _sass_binary = "sass_binary")

stencil = _stencil
bundle_prod = _bundle_prod
bundle_dev = _bundle_dev
sass_library = _sass_library
sass_binary = _sass_binary
rules_stencil_dependencies = _rules_stencil_dependencies