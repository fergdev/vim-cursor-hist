# Vim-cursor-hist
------------
A vim plugin that remembers your history of cursor locations allowing you to cycle through them easily. Inspired by QT creators &lt;ALT-Left> &lt;ALT-right> behaviour.

## Usage
------------

Vim-cursor-hist listens for the autocommand CursorHold and adds the current cursor position to the list of stored positions. Forward and back functions are provided to cycle throught the list of stored positions.

Default key mappings are provided below ... feel free to change them to whatever suites you :)
```
nnoremap <leader>j :call g:CursorHistForward()<CR>
nnoremap <leader>k :call g:CursorHistBack()<CR>
```

Currently the cursor history is cleared on the BufferEnter autocommand. Support for jumping between buffers will be added ASAP.

##Installation
------------
### Pathogen (https://github.com/fergdev/vim-cursor-hist)
```
git clone https://github.com/fergdev/vim-cursor-hist ~/.vim/bundle/vim-cursor-hist
```

### Vundle (https://github.com/gmarik/vundle)
```
Plugin 'fergdev/vim-cursor-hist'
```

### NeoBundle (https://github.com/Shougo/neobundle.vim)
```
NeoBundle 'fergdev/vim-cursor-hist'
