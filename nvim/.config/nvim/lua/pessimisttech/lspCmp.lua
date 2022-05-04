-- local completeopt = { 'menu' , 'menuone' , 'noselect' }
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
local lspServers = { 'gopls', 'jdtls' }
local opts = { noremap=true, silent=true }

vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)

local formatOnSave = function()
    vim.cmd[[
		augroup lsp_buf_format
    		au! BufWritePre <buffer>
    		autocmd BufWritePre <buffer> :lua vim.lsp.buf.formatting_sync()
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

local attach = function(client, buffnr) 
	local filetype = vim.api.nvim_buf_get_option(0, "filetype")
	vim.api.nvim_buf_set_keymap(buffnr, 'n', '<leader>gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
	vim.api.nvim_buf_set_keymap(buffnr, 'n', '<leader>gr', "<cmd>lua require('telescope.builtin').lsp_references(require('telescope.themes').get_ivy())<CR>", opts)
	vim.api.nvim_buf_set_keymap(buffnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
	vim.api.nvim_buf_set_keymap(buffnr, 'n', '<leader>gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
	vim.api.nvim_buf_set_keymap(buffnr, 'n', '<leader>dn', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
	vim.api.nvim_buf_set_keymap(buffnr, 'n', '<leader>dp', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
	vim.api.nvim_buf_set_keymap(buffnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
	vim.api.nvim_buf_set_keymap(buffnr, 'n', '<leader>o', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
    vim.api.nvim_buf_set_keymap(buffnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    vim.api.nvim_buf_set_keymap(buffnr, 'n', '<leader>ts', '<cmd>Telescope treesitter<CR>', opts)
	vim.api.nvim_buf_set_keymap(buffnr, 'n', '<leader>fds', "<cmd>lua require('telescope.builtin').diagnostics(require('telescope.themes').get_ivy())<CR>", opts)
	filetype_attach[filetype](client)
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
