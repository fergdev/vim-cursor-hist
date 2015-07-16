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
nnoremap <leader>j :call g:CursorHistForawrd()<CR>
nnoremap <leader>k :call g:CursorHistBack()<CR>

" List for cursor history
let s:histlist = []

" Pointer for current hisory location
let s:currhistloc = 0

" Clears the current cursors history
function g:CursorHistClear()
    echo 'CursorHistClear'
    unlet s:histlist
    let histlist = []

    call s:CursorHistAdd()
    let currhistloc = 0
end

" Goes forward in history
function g:CursorHistForward()
    echo "CursorHistForward"
    let histlen = len(s:histlist)
    if s:currhistloc =~ histlen -1
        echo 'WE ARE AT THE BEGINING OF TIME'
        return
    end 
    s:currhistloc = s:currhistloc + 1
    call s:CursorHistUpdateLoc()
endfunction

" Goes back in history
function g:CursorHistBack()
    echo "CursorHistBack"
    if s:currhistloc =~ 0
        echo 'WE AT THE BEGINING OF TIME'
        return
    end
    s:currhistloc = s:currhistloc - 1
    call s:CursorHistUpdateLoc()
endfunction

" Updates the cursor to the location that currhistloc points to
function s:CursorHistUpdateLoc()
    echo 'CursorHistUpdate'
    let nextpos = s:histlist[s:currhistloc]
    cursor(netpos)
end

" Adds to the current history
function s:CursorHistAdd()
    echo 'CursorHist Add' 
    let currpos = getcurpos()
    call add(s:histlist, currpos)
end


" List of posible events
" CursorMoved
" CursorMovedI
"
" WinEnter
"
" BufEnter
augroup cursorhist
    au CursorHold * s:CursorHistAdd() " Add history on cursor hold

    "au CursorMoved * s:CursorHistAdd() " Add history on cursor movement
    au BufEnter * g:CursorHistClear()  " Clear history on new buffer
augroup END

" == Restore 'cpoptions' {{{

let &cpo = s:save_cpo unlet s:save_cpo " }}}
