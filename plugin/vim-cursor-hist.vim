scriptencoding utf-8
" Cursor hist - vim cursor history for jumping between cursor locations
" Author: Fergus Hewson
" Source: https://github.com/fergdev/vim-cursor-hist
" License: This file is place in the public domain.

"== Script init {{{
if exists('g:CursorHist_loaded') || version < 703
        finish
endif
let g:CursorHist_loaded = 1
" }}}

" == Saving 'cpoptions' {{{
let s:save_cpo = &cpo
set cpo&vim
" }}}

" Mah key mappings
nnoremap <leader>j :call g:CursorHistForward()<CR>
nnoremap <leader>k :call g:CursorHistBack()<CR>

" List for cursor history
let g:cursorhistlist = []

" Pointer for current hisory location
let g:currhistloc = 0

" Clears the current cursors history
function! g:CursorHistClear()
    echom 'CursorHistClear'
    unlet g:cursorhistlist
    let g:cursorhistlist = []

    call g:CursorHistAdd()
    let g:currhistloc = 0
endfunction

" Goes forward in history
function! g:CursorHistForward()
    echom "CursorHistForward"
    let histlen = len(g:cursorhistlist)
    if g:currhistloc =~ histlen -1
        echom 'WE ARE AT THE BEGINING OF TIME'
        return
    end 
    let g:currhistloc = g:currhistloc + 1
    call g:CursorHistUpdateLoc()
endfunction

" Goes back in history
function! g:CursorHistBack()
    echom "CursorHistBack" . g:currhistloc . ' ' . len(g:cursorhistlist)

    if g:currhistloc =~ 0
        echom 'WE AT THE BEGINING OF TIME'
        return
    end
    let g:currhistloc = g:currhistloc - 1
    call g:CursorHistUpdateLoc()
endfunction

" Updates the cursor to the location that currhistloc points to
function! g:CursorHistUpdateLoc()
    echom 'CursorHistUpdate ' . g:currhistloc . ' ' . len(g:cursorhistlist)
    let nextpos = g:cursorhistlist[g:currhistloc]
    echom 'hello'.nextpos
    call cursor(nextpos)
endfunction

" Adds to the current history
function! g:CursorHistAdd()
    echom 'CursorHist Add ' . len(g:cursorhistlist) 
    let currpos = getcurpos()
    call add(g:cursorhistlist, currpos)
    let g:currhistloc = g:currhistloc + 1
endfunction


" List of posible events
" CursorMoved
" CursorMovedI
"
" WinEnter
"
" BufEnter
augroup cursorhist
    au CursorHold * :call g:CursorHistAdd() " Add history on cursor hold

    "au CursorMoved * s:CursorHistAdd() " Add history on cursor movement
    au BufEnter * :call g:CursorHistClear()  " Clear history on new buffer
augroup END

" == Restore 'cpoptions' {{{

let &cpo = s:save_cpo 
unlet s:save_cpo " }}}
