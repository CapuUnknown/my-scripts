return {
    { -- This helps with php/html for indentation
        'captbaritone/better-indent-support-for-php-with-html',
    },
    { -- This helps with ssh tunneling and copying to clipboard
        'ojroques/vim-oscyank',
    },
    { -- Show historical versions of the file locally
        'mbbill/undotree',
    },
    {
        "nvim-lua/plenary.nvim", -- lua functions that many plugins use
        "christoomey/vim-tmux-navigator", -- tmux & split window navigation
    },
    { -- Show CSS Colors
        'brenoprata10/nvim-highlight-colors',
        config = function()
        require('nvim-highlight-colors').setup({})
        end
    },
}
