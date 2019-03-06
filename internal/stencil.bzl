
stencilFiles = provider("transitive_sources")

def get_transitive_srcs(srcs, deps):

  return depset(
      srcs,
      transitive = [dep[stencilFiles].transitive_sources for dep in deps],
  )

stencil_ATTRS = {
  "entry_point": attr.label(allow_files = True, single_file = True),
  "deps": attr.label_list(),
  "srcs": attr.label_list(allow_files = True),
  "_stencil": attr.label(
        default=Label("//internal:stencil"),
        executable=True,
        cfg="host"),
}

def _stencil(ctx):
  args = ctx.actions.args()
  args.add(["compile", ctx.file.entry_point.path])
  args.add(["-o", ctx.outputs.build.path])

  ctx.actions.run(
      mnemonic = "stencil",
      executable = ctx.executable._stencil,
      outputs = [ctx.outputs.build],
      inputs = [ctx.file.entry_point],
      arguments = [args]
  )

  trans_srcs = get_transitive_srcs(ctx.files.srcs, ctx.attr.deps) + [ctx.outputs.build]

  return [
      stencilFiles(transitive_sources = trans_srcs),
      DefaultInfo(files = trans_srcs),
  ]

stencil = rule(
  implementation = _stencil,
  attrs = stencil_ATTRS,
  outputs = {
      "build": "%{name}.js"
  }
)