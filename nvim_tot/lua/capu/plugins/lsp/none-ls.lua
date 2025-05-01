return {
    "nvimtools/none-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    opts = function(_, opts)
    local nls = require("null-ls")

    opts.sources = vim.list_extend(opts.sources or {}, {
        -- shellcheck diagnostics for shell scripts
        nls.builtins.diagnostics.shellcheck,
    })
    end,
}
