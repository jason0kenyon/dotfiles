--Quick enter normal mode
vim.keymap.set('i', 'jk', '<ESC>', {noremap=true})
--Quick write
vim.keymap.set('n','<c-k>','<Cmd>w<CR>',{noremap=true})
--Open/close file tree
vim.keymap.set('n', '<c-o>','<Cmd>NvimTreeToggle<CR>')
--Write and compile latex. pdflatex automatically compiles to current directory, so if you can't find your pdf, that's why. Specify output directory with "-output-directory=<directory>" 
--flag. If you prefer, use latexmk, as it supports native previewing. As you updated you source file, latexmk will autocompile continuously as you make changes. The only issue is that
--often latexmk cannot compile files that pdflatex can. The converse is rarely true.
vim.keymap.set('n', '<c-p>','<Cmd>w | !pdflatex -output-directory="." %<CR>')
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }


