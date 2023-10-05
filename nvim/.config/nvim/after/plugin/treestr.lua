local has_treestr, treesitterCfg = pcall(require, 'nvim-treesitter.configs')
if not has_treestr then
    return 
end

treesitterCfg.setup{
	ensure_installed = { 'go', 'java', 'json', 'javascript', 'typescript', 'bash', 'yaml', 'markdown', 'markdown_inline', 'lua' },
    highlight = {
        enable = true
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "<C-space>",
            node_incremental = "<C-space>",
            scope_incremental = false,
            node_decremental = "<bs>",
        },
    },
}
