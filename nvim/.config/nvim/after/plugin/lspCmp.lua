-- local completeopt = { 'menu' , 'menuone' , 'noselect' }
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lspServers = { 'gopls', 'jdtls', 'ts_ls' }
local opts = { noremap=true, silent=true }

ensure_installed = {
    "go",
    "gomod",
    "gowork",
    "gosum",
}
vim.diagnostic.config({ virtual_text = true })

vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '<leader>et', function()
    vim.diagnostic.config({ virtual_text = not vim.diagnostic.config().virtual_text })
end, { desc = "Toggle diagnostics inline outut" })

local formatOnSave = function(buffnr)
    local group = vim.api.nvim_create_augroup("LspFormat." .. buffnr, {})

    vim.api.nvim_create_autocmd("BufWritePre", {
        group = group,
        buffer = buffnr,
        callback = function()
            vim.lsp.buf.format({
                async = false,
            })
        end,
    })
end

local filetype_attach = setmetatable({
	go = function(buffnr)
        formatOnSave(buffnr)
	end,
	java = function(buffnr)
        formatOnSave(buffnr)
	end,
},
{})

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local buffnr = args.buf
        local filetype = vim.bo[buffnr].filetype

        local telescope = require('telescope.builtin')
        local themes = require('telescope.themes')

        pcall(vim.treesitter.start)
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

        local map = function(lhs, rhs)
            vim.keymap.set('n', lhs, rhs, {
                buffer = buffnr,
                noremap = true,
                silent = true,
            })
        end

        map('<leader>gd', vim.lsp.buf.definition) 
        map('<leader>gr', function()
            require('telescope.builtin').lsp_references(require('telescope.themes').get_ivy())
        end)
        map('K', vim.lsp.buf.hover)
        map('<leader>gt', vim.lsp.buf.type_definition)
        map('<leader>dn', vim.diagnostic.goto_next)
        map('<leader>dp', vim.diagnostic.goto_prev)
        map('<leader>rn', vim.lsp.buf.rename)
        map('<leader>o', vim.lsp.buf.format)
        map('<leader>ca', vim.lsp.buf.code_action)
        map('<leader>ts', require('telescope.builtin').treesitter)
        map('<leader>gi', require('telescope.builtin').lsp_implementations)
        map('<leader>fds', function()
            require('telescope.builtin').diagnostics(require('telescope.themes').get_ivy())
        end)

        if filetype_attach[filetype] then 
            filetype_attach[filetype](buffnr)
        end
    end
})

-- TODO implement support for lombok in jdtls
for _, server in pairs(lspServers) do
	vim.lsp.config(server, {
		capabilities = capabilities,
	})
    vim.lsp.enable(server)
end

local cmp = require('cmp')
local lspkind = require('lspkind')

cmp.setup({
    snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body)
      end,
    },
  
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
  
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'nvim_lua' },
      { name = 'luasnip' }, 
      { name = 'path' },
      { name = 'buffer' },
    }),
  
    formatting = {
        format = lspkind.cmp_format({
            mode = "symbol_text",
            menu = {
                buffer = '[buf]',
                nvim_lsp = '[LSP]',
                nvim_lua = '[api]',
                path = '[path]',
                luasnip = '[snip]',
            }
        })
    },

    views = {
        entries = 'native',
    }
})

require('Comment').setup()

