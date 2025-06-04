-- local completeopt = { 'menu' , 'menuone' , 'noselect' }
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
local lspServers = { 'gopls', 'jdtls', 'ts_ls' }
local opts = { noremap=true, silent=true }
vim.diagnostic.config({ virtual_text = true })

vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.keymap.set('n', '<leader>et', function()
    vim.diagnostic.config({ virtual_text = not vim.diagnostic.config().virtual_text })
end, { desc = "Toggle diagnostics inline outut" })

local formatOnSave = function()
    vim.cmd[[
		augroup lsp_buf_format
    		au! BufWritePre <buffer>
    		autocmd BufWritePre <buffer> :lua vim.lsp.buf.format()
   		augroup END
 	]]
end

local filetype_attach = setmetatable({
	go = function(client)
        formatOnSave()
	end,
	java = function(client)
        formatOnSave()
	end,
},
{})

local bufMapN = function(buffnr, keymap, callback)
    local options = {
        noremap = opts.noremap,
        silent = opts.silent,
        callback = function()
            callback()
        end,
    }
    vim.api.nvim_buf_set_keymap(buffnr, 'n', keymap, '', options)
end

local attach = function(client, buffnr) 
	local filetype = vim.api.nvim_buf_get_option(0, "filetype")
    bufMapN(buffnr, '<leader>gd', vim.lsp.buf.definition) 
	bufMapN(buffnr, '<leader>gr', function()
        require('telescope.builtin').lsp_references(require('telescope.themes').get_ivy())
    end)
	bufMapN(buffnr, 'K', vim.lsp.buf.hover)
	bufMapN(buffnr, '<leader>gt', vim.lsp.buf.type_definition)
	bufMapN(buffnr, '<leader>dn', vim.diagnostic.goto_next)
	bufMapN(buffnr, '<leader>dp', vim.diagnostic.goto_prev)
	bufMapN(buffnr, '<leader>rn', vim.lsp.buf.rename)
	bufMapN(buffnr, '<leader>o', vim.lsp.buf.format)
    bufMapN(buffnr, '<leader>ca', vim.lsp.buf.code_action)
    bufMapN(buffnr, '<leader>ts', require('telescope.builtin').treesitter)
    bufMapN(buffnr, '<leader>gi', require('telescope.builtin').lsp_implementations)
	bufMapN(buffnr, '<leader>fds', function()
        require('telescope.builtin').diagnostics(require('telescope.themes').get_ivy())
    end)

    if filetype_attach[filetype] then 
	    filetype_attach[filetype](client)
    end
end

-- TODO implement support for lombok in jdtls
for _, server in pairs(lspServers) do
	require('lspconfig')[server].setup {
		capabilities = capabilities,
		on_attach = attach
	}
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

