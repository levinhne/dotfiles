local formatter = {
  filetype = {
    javascript = {
      require("formatter.filetypes.javascript").prettier,
    },
    typescript = {
      require("formatter.filetypes.typescript").prettier,
    },
    dart = {
      require("formatter.filetypes.dart").dartformat,
    },
    lua = {
      require("formatter.filetypes.lua").stylua,
    },
    pyhton = {
      require("formatter.filetypes.python").black,
    },
    ["*"] = {
      require("formatter.filetypes.any").remove_trailing_whitespace,
    },
  },
}

return formatter
