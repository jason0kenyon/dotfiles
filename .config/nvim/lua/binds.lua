vim.keymap.set('n', '<leader>v', '<CMD>vsplit<CR>')
vim.keymap.set('n', '<leader>q', '<CMD>quit<CR>')
vim.keymap.set('n', '<leader>qq', '<CMD>q!<CR>')
vim.keymap.set('n', '<leader>wq', '<CMD>wq!<CR>')
vim.keymap.set('n', '<leader>n', '<CMD>split<CR>')
vim.keymap.set('i', 'jk', '<ESC>', {noremap=true})
--Quick write
vim.keymap.set('n','<c-k>','<Cmd>w<CR>',{noremap=true})
--Open/close file tree
vim.keymap.set('n', '<c-o>','<Cmd>NvimTreeToggle<CR>')
--Write and compile latex. pdflatex automatically compiles to current directory, so if you can't find your pdf, that's why. Specify output directory with "-output-directory=<directory>" 
--flag. If you prefer, use latexmk, as it supports native previewing. As you updated you source file, latexmk will autocompile continuously as you make changes. The only issue is that
--often latexmk cannot compile files that pdflatex can. The converse is rarely true.
vim.keymap.set('n', '<c-p>','<Cmd>w | !pdflatex -output-directory="." %<CR>')


