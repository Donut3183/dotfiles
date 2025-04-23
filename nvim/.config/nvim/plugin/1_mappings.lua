-- Basic mappings =============================================================
-- NOTE: Most basic mappings come from 'mini.basics'

-- Shorter version of the most frequent way of going outside of terminal window
vim.keymap.set("t", "<C-h>", [[<C-\><C-N><C-w>h]])
vim.keymap.set("t", "<C-k>", [[<C-\><C-N><C-w>k]])
vim.keymap.set("t", "<C-j>", [[<C-\><C-N><C-w>j]])
vim.keymap.set("t", "<C-l>", [[<C-\><C-N><C-w>l]])

-- Disable space in normal mode
vim.keymap.set("n", "<Space>", "<Nop>", { silent = true })
vim.keymap.set("n", "<Esc>", ":noh<CR>", { silent = true, desc = "Clear search highlight" })

-- Move inside completion list with <TAB>
vim.keymap.set("i", "<Tab>", [[pumvisible() ? "\<C-n>" : "\<Tab>"]], { expr = true })
vim.keymap.set("i", "<S-Tab>", [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]], { expr = true })

-- Normal‑mode: Tab → next buffer, Shift‑Tab → previous buffer
vim.keymap.set('n', '<Tab>',    '<Cmd>bnext<CR>',     { desc = 'Next Buffer' })
vim.keymap.set('n', '<S-Tab>',  '<Cmd>bprevious<CR>', { desc = 'Previous Buffer' })

-- Augment accept inline
vim.keymap.set('i', '<C-i>', '<cmd>lua vim.fn["augment#Accept"]()<cr>', { desc = 'Accept Augment suggestion'})

-- Normal mode: Ctrl‑Tab → new tab
vim.keymap.set('n', '<C-t>', '<Cmd>tabnew<CR>', { desc = 'New Tab' })
-- Rebind gt / gT to switch tabs, with descriptions
vim.keymap.set('n', 'gt', '<Cmd>tabnext<CR>',     { desc = 'Next Tab' })
vim.keymap.set('n', 'gT', '<Cmd>tabprevious<CR>', { desc = 'Previous Tab' })

-- Paste before/after linewise
vim.keymap.set({ "n", "x" }, "[p", '<Cmd>exe "put! " . v:register<CR>', { desc = "Paste Above" })
vim.keymap.set({ "n", "x" }, "]p", '<Cmd>exe "put "  . v:register<CR>', { desc = "Paste Below" })

-- Leader mappings ============================================================
-- stylua: ignore start

-- Create global tables with information about clue groups in certain modes
-- Structure of tables is taken to be compatible with 'mini.clue'.
_G.Config.leader_group_clues = {
  { mode = 'n', keys = '<Leader>a', desc = '+ChatGPT' },
  { mode = 'n', keys = '<Leader>b', desc = '+Buffer' },
  { mode = 'n', keys = '<Leader>c', desc = '+Vimtex' },
  { mode = 'n', keys = '<Leader>e', desc = '+Explore' },
  { mode = 'n', keys = '<Leader>f', desc = '+Find' },
  { mode = 'n', keys = '<Leader>g', desc = '+Git' },
  { mode = 'n', keys = '<Leader>l', desc = '+LSP' },
  { mode = 'n', keys = '<Leader>m', desc = '+Map' },
  { mode = 'n', keys = '<Leader>o', desc = '+Other' },
  { mode = 'n', keys = '<Leader>s', desc = '+Thesis' },
  { mode = 'n', keys = '<Leader>t', desc = '+Terminal' },
  { mode = 'n', keys = '<Leader>v', desc = '+Visits' },
  { mode = 'n', keys = '<Leader>p', desc = '+Augment' },

  { mode = 'x', keys = '<Leader>l', desc = '+LSP' },
}

-- Create `<Leader>` mappings
local nmap_leader = function(suffix, rhs, desc, opts)
  opts = opts or {}
  opts.desc = desc
  vim.keymap.set('n', '<Leader>' .. suffix, rhs, opts)
end
local xmap_leader = function(suffix, rhs, desc, opts)
  opts = opts or {}
  opts.desc = desc
  vim.keymap.set('x', '<Leader>' .. suffix, rhs, opts)
end

-- p is for Augment ===========================================================
-- Plugin status
nmap_leader('ps', '<cmd>Augment status<CR>',                'Current status of the plugin')

-- Authentication
nmap_leader('psi', '<cmd>Augment signin<CR>',               'Start the sign in flow')
nmap_leader('pso', '<cmd>Augment signout<CR>',              'Sign out of Augment')

-- Logs
nmap_leader('pl', '<cmd>Augment log<CR>',                   'Plugin log')

-- Chat group header
nmap_leader('pc', '<Nop>',                                  '+Chat')

-- Chat commands
nmap_leader('pcc', '<cmd>Augment chat<CR>',                 'Send a chat message to Augment AI')
nmap_leader('pcn', '<cmd>Augment chat-new<CR>',             'Start a new chat conversation')
nmap_leader('pt', '<cmd>Augment chat-toggle<CR>',           'Toggle the chat panel visibility')
-- s is for misc ==============================================================
nmap_leader('sl', '^v$h<cmd>ChatGPTRun grammar_correction<CR>', 'Select paragraph and correct grammar')
xmap_leader('sl', '^v$h<cmd>ChatGPTRun grammar_correction<CR>', 'Select paragraph and correct grammar')

-- a is for 'ChatGPT' =======================================================
-- single‑mode mapping for launching ChatGPT
nmap_leader('ac', '<Cmd>ChatGPT<CR>', 'ChatGPT')

-- dual‑mode (normal+visual) ChatGPT commands
do
  local chat_cmds = {
    { 'ae',  '<cmd>ChatGPTEditWithInstruction<CR>',    'Edit with instruction'            },
    { 'ag',  '<cmd>ChatGPTRun grammar_correction<CR>',  'Grammar Correction'               },
    { 'ak',  '<cmd>ChatGPTRun keywords<CR>',            'Keywords'                         },
    { 'ar',  '<cmd>ChatGPTRun reduce_passive_voice<CR>','Reduce Passive Voice'             },
    { 'ai',  '<cmd>ChatGPTRun citation_format<CR>',     'Citation Format'                  },
    { 'ame', '<cmd>ChatGPTRun math_check<CR>',          'Math Check'                       },
    { 'as',  '<cmd>ChatGPTRun summarize<CR>',           'Summarize'                        },
    { 'at',  '<cmd>ChatGPTRun academic_style<CR>',      'Academic Style'                   },
    { 'ap',  '<cmd>ChatGPTRun paraphrase<CR>',          'Paraphrase'                       },
    { 'ax',  '<cmd>ChatGPTRun explain_code<CR>',        'Explain Code'                     },
  }

  for _, cmd in ipairs(chat_cmds) do
    local suffix, rhs, desc = unpack(cmd)
    nmap_leader(suffix, rhs, desc)
    xmap_leader(suffix, rhs, desc)
  end
end

-- b is for 'buffer'
nmap_leader('ba', '<Cmd>b#<CR>',                                 'Alternate')
nmap_leader('bd', '<Cmd>lua MiniBufremove.delete()<CR>',         'Delete')
nmap_leader('bD', '<Cmd>lua MiniBufremove.delete(0, true)<CR>',  'Delete!')
nmap_leader('bs', '<Cmd>lua Config.new_scratch_buffer()<CR>',    'Scratch')
nmap_leader('bw', '<Cmd>lua MiniBufremove.wipeout()<CR>',        'Wipeout')
nmap_leader('bW', '<Cmd>lua MiniBufremove.wipeout(0, true)<CR>', 'Wipeout!')

-- VimTeX mappings under <Leader>c ===========================================
-- Info
nmap_leader('ci', '<Plug>(vimtex-info)',           'VimTeX Info')
nmap_leader('cI', '<Plug>(vimtex-info-full)',      'VimTeX Info Full')
-- Table of Contents
nmap_leader('ct', '<Plug>(vimtex-toc-open)',       'VimTeX TOC Open')
nmap_leader('cT', '<Plug>(vimtex-toc-toggle)',     'VimTeX TOC Toggle')
-- Compile
nmap_leader('cc', '<Plug>(vimtex-compile)',        'VimTeX Compile')
nmap_leader('cL', '<Plug>(vimtex-compile-selected)', 'VimTeX Compile Sel')
-- Stop
nmap_leader('ck', '<Plug>(vimtex-stop)',           'VimTeX Stop')
nmap_leader('cK', '<Plug>(vimtex-stop-all)',       'VimTeX Stop All')
-- View & Sync
nmap_leader('cv', '<Plug>(vimtex-view)',           'VimTeX View')
nmap_leader('cr', '<Plug>(vimtex-reverse-search)', 'VimTeX Inverse Search')
-- Log & Errors
nmap_leader('cq', '<Plug>(vimtex-log)',            'VimTeX Log')
nmap_leader('ce', '<Plug>(vimtex-errors)',         'VimTeX Errors')
-- Output & Status
nmap_leader('co', '<Plug>(vimtex-compile-output)', 'VimTeX Compile Output')
nmap_leader('cg', '<Plug>(vimtex-status)',         'VimTeX Status')
nmap_leader('cG', '<Plug>(vimtex-status-all)',     'VimTeX Status All')
-- Clean
nmap_leader('cl', '<Plug>(vimtex-clean)',          'VimTeX Clean')
nmap_leader('cC', '<Plug>(vimtex-clean-full)',     'VimTeX Clean Full')
-- Misc
nmap_leader('cm', '<Plug>(vimtex-toggle-main)',    'VimTeX Toggle Main')
nmap_leader('ca', '<Plug>(vimtex-context-menu)',   'VimTeX Context Menu')
nmap_leader('cx', '<Plug>(vimtex-reload)',         'VimTeX Reload')
nmap_leader('cX', '<Plug>(vimtex-reload-state)',   'VimTeX Reload State')

-- e is for 'explore' and 'edit'
local edit_config_file = function(filename)
  return '<Cmd>edit ' .. vim.fn.stdpath('config') .. '/plugin/' .. filename .. '<CR>'
end
nmap_leader('ed', '<Cmd>lua MiniFiles.open()<CR>',                             'Directory')
nmap_leader('ef', '<Cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<CR>', 'File directory')
nmap_leader('em', edit_config_file('20_mini.lua'),                             'Mini.nvim config')
nmap_leader('eo', edit_config_file('10_options.lua'),                          'Options config')
nmap_leader('ep', edit_config_file('21_plugins.lua'),                          'Plugins config')
nmap_leader('eq', '<Cmd>lua Config.toggle_quickfix()<CR>',                     'Quickfix')

-- f is for 'fuzzy find'
nmap_leader('f/', '<Cmd>Pick history scope="/"<CR>',                      '"/" history')
nmap_leader('f:', '<Cmd>Pick history scope=":"<CR>',                      '":" history')
nmap_leader('fa', '<Cmd>Pick git_hunks scope="staged"<CR>',               'Added hunks (all)')
nmap_leader('fA', '<Cmd>Pick git_hunks path="%" scope="staged"<CR>',      'Added hunks (current)')
nmap_leader('fb', '<Cmd>Pick buffers<CR>',                                'Buffers')
nmap_leader('fc', '<Cmd>Pick git_commits<CR>',                            'Commits (all)')
nmap_leader('fC', '<Cmd>Pick git_commits path="%"<CR>',                   'Commits (current)')
nmap_leader('fd', '<Cmd>Pick diagnostic scope="all"<CR>',                 'Diagnostic workspace')
nmap_leader('fD', '<Cmd>Pick diagnostic scope="current"<CR>',             'Diagnostic buffer')
nmap_leader('ff', '<Cmd>Pick files<CR>',                                  'Files')
nmap_leader('fg', '<Cmd>Pick grep_live<CR>',                              'Grep live')
nmap_leader('fG', '<Cmd>Pick grep pattern="<cword>"<CR>',                 'Grep current word')
nmap_leader('fh', '<Cmd>Pick help<CR>',                                   'Help tags')
nmap_leader('fH', '<Cmd>Pick hl_groups<CR>',                              'Highlight groups')
nmap_leader('fl', '<Cmd>Pick buf_lines scope="all"<CR>',                  'Lines (all)')
nmap_leader('fL', '<Cmd>Pick buf_lines scope="current"<CR>',              'Lines (current)')
nmap_leader('fm', '<Cmd>Pick git_hunks<CR>',                              'Modified hunks (all)')
nmap_leader('fn', '<Cmd>lua require("mini.notify").show_history()<CR>',   'Show notification history')
nmap_leader('fM', '<Cmd>Pick git_hunks path="%"<CR>',                     'Modified hunks (current)')
nmap_leader('fr', '<Cmd>Pick resume<CR>',                                 'Resume')
nmap_leader('fp', '<Cmd>Pick projects<CR>',                               'Projects')
nmap_leader('fR', '<Cmd>Pick lsp scope="references"<CR>',                 'References (LSP)')
nmap_leader('fs', '<Cmd>Pick lsp scope="workspace_symbol"<CR>',           'Symbols workspace (LSP)')
nmap_leader('fS', '<Cmd>Pick lsp scope="document_symbol"<CR>',            'Symbols buffer (LSP)')
nmap_leader('fv', '<Cmd>Pick visit_paths cwd="" preserve_order=true<CR>', 'Visit paths (all)')
nmap_leader('fV', '<Cmd>Pick visit_paths preserve_order=true<CR>',        'Visit paths (cwd)')

-- g is for git
local git_log_cmd = [[Git log --pretty=format:\%h\ \%as\ │\ \%s --topo-order]]
nmap_leader('ga', '<Cmd>Git diff --cached<CR>',                   'Added diff')
nmap_leader('gA', '<Cmd>Git diff --cached -- %<CR>',              'Added diff buffer')
nmap_leader('gc', '<Cmd>Git commit<CR>',                          'Commit')
nmap_leader('gC', '<Cmd>Git commit --amend<CR>',                  'Commit amend')
nmap_leader('gd', '<Cmd>Git diff<CR>',                            'Diff')
nmap_leader('gD', '<Cmd>Git diff -- %<CR>',                       'Diff buffer')
nmap_leader('gg', '<Cmd>lua Config.open_lazygit()<CR>',           'Git tab')
nmap_leader('gl', '<Cmd>' .. git_log_cmd .. '<CR>',               'Log')
nmap_leader('gL', '<Cmd>' .. git_log_cmd .. ' --follow -- %<CR>', 'Log buffer')
nmap_leader('go', '<Cmd>lua MiniDiff.toggle_overlay()<CR>',       'Toggle overlay')
nmap_leader('gs', '<Cmd>lua MiniGit.show_at_cursor()<CR>',        'Show at cursor')
-- bind Get to <Leader>gG and Put to <Leader>gP
nmap_leader('gG', '<Plug>GetDiffCharPair', 'Get Diff Char Pair')
nmap_leader('gP', '<Plug>PutDiffCharPair', 'Put Diff Char Pair')

xmap_leader('gs', '<Cmd>lua MiniGit.show_at_cursor()<CR>',  'Show at selection')


-- l is for 'LSP' (Language Server Protocol)
local formatting_cmd = '<Cmd>lua require("conform").format({ lsp_fallback = true })<CR>'
nmap_leader('la', '<Cmd>lua vim.lsp.buf.code_action()<CR>',   'Actions')
nmap_leader('ld', '<Cmd>lua vim.diagnostic.open_float()<CR>', 'Diagnostics popup')
nmap_leader('lf', formatting_cmd,                             'Format')
nmap_leader('li', '<Cmd>lua vim.lsp.buf.hover()<CR>',         'Information')
nmap_leader('lj', '<Cmd>lua vim.diagnostic.goto_next()<CR>',  'Next diagnostic')
nmap_leader('lk', '<Cmd>lua vim.diagnostic.goto_prev()<CR>',  'Prev diagnostic')
nmap_leader('lR', '<Cmd>lua vim.lsp.buf.references()<CR>',    'References')
nmap_leader('lr', '<Cmd>lua vim.lsp.buf.rename()<CR>',        'Rename')
nmap_leader('ls', '<Cmd>lua vim.lsp.buf.definition()<CR>',    'Source definition')

xmap_leader('lf', formatting_cmd,                             'Format selection')

-- m is for 'map'
nmap_leader('mc', '<Cmd>lua MiniMap.close()<CR>',        'Close')
nmap_leader('mf', '<Cmd>lua MiniMap.toggle_focus()<CR>', 'Focus (toggle)')
nmap_leader('mo', '<Cmd>lua MiniMap.open()<CR>',         'Open')
nmap_leader('mr', '<Cmd>lua MiniMap.refresh()<CR>',      'Refresh')
nmap_leader('ms', '<Cmd>lua MiniMap.toggle_side()<CR>',  'Side (toggle)')
nmap_leader('mt', '<Cmd>lua MiniMap.toggle()<CR>',       'Toggle')

-- o is for 'other'
local trailspace_toggle_command = '<Cmd>lua vim.b.minitrailspace_disable = not vim.b.minitrailspace_disable<CR>'
nmap_leader('oC', '<Cmd>lua MiniCursorword.toggle()<CR>',  'Cursor word hl toggle')
nmap_leader('od', '<Cmd>Neogen<CR>',                       'Document')
nmap_leader('oh', '<Cmd>normal gxiagxila<CR>',             'Move arg left')
nmap_leader('oH', '<Cmd>TSBufToggle highlight<CR>',        'Highlight toggle')
nmap_leader('og', '<Cmd>lua MiniDoc.generate()<CR>',       'Generate plugin doc')
nmap_leader('ol', '<Cmd>normal gxiagxina<CR>',             'Move arg right')
nmap_leader('or', '<Cmd>lua MiniMisc.resize_window()<CR>', 'Resize to default width')
nmap_leader('os', '<Cmd>lua MiniSessions.select()<CR>',    'Session select')
nmap_leader('oS', '<Cmd>lua Config.insert_section()<CR>',  'Section insert')
nmap_leader('ot', '<Cmd>lua MiniTrailspace.trim()<CR>',    'Trim trailspace')
nmap_leader('oT', trailspace_toggle_command,               'Trailspace hl toggle')
nmap_leader('oz', '<Cmd>lua MiniMisc.zoom()<CR>',          'Zoom toggle')

-- - Copy to clipboard and make reprex (which itself is loaded to clipboard)
xmap_leader('rx', '"+y :T reprex::reprex()<CR>',                    'Reprex selection')

-- t is for 'terminal' (uses 'neoterm') and 'minitest'
nmap_leader('tT', '<Cmd>belowright Tnew<CR>',                          'Terminal (horizontal)')
nmap_leader('tt', '<Cmd>vertical Tnew<CR>',                            'Terminal (vertical)')

-- v is for 'visits'
nmap_leader('vv', '<Cmd>lua MiniVisits.add_label("core")<CR>',    'Add "core" label')
nmap_leader('vV', '<Cmd>lua MiniVisits.remove_label("core")<CR>', 'Remove "core" label')
nmap_leader('vl', '<Cmd>lua MiniVisits.add_label()<CR>',          'Add label')
nmap_leader('vL', '<Cmd>lua MiniVisits.remove_label()<CR>',       'Remove label')

local map_pick_core = function(keys, cwd, desc)
  local rhs = function()
    local sort_latest = MiniVisits.gen_sort.default({ recency_weight = 1 })
    MiniExtra.pickers.visit_paths({ cwd = cwd, filter = 'core', sort = sort_latest }, { source = { name = desc } })
  end
  nmap_leader(keys, rhs, desc)
end
map_pick_core('vc', '',  'Core visits (all)')
map_pick_core('vC', nil, 'Core visits (cwd)')
