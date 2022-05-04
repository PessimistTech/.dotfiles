local has_treestr, treesitterCfg = pcall(require, 'nvim-treesitter.configs')
if not has_treestr then
    return 
end

treesitterCfg.setup{
	ensure_installed = { 'go', 'java', 'json', 'javascript', 'bash', 'yaml', 'markdown' },
    highlight = {
        enable = true
    },
}
