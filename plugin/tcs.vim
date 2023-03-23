let g:tcs_executable    = get(g:, 'tcs_executable',    'tcs')
let g:tcs_delay_ms      = get(g:, 'tcs_delay_ms',      250)
let g:tcs_sticky_cursor = get(g:, 'tcs_sticky_cursor', v:true)


function! Tcs(...)
  if !s:prerequisites() | return | endif

  if g:tcs_sticky_cursor
    let [word, offset] = s:cursor()
  endif

  call s:exec_tcs()
  execute 'checktime' bufnr()

  if g:tcs_sticky_cursor
    call s:move_cursor(word, offset)
  endif
endfunction


function! TcsAsync()
  call timer_start(g:tcs_delay_ms, 'Tcs')
endfunction


function! s:prerequisites()
  let outcome = v:true

  if !executable(g:tcs_executable)
    echoerr "'".g:tcs_executable."' is not executable. Please set g:tcs_executable"
    let outcome = v:false
  endif

  if !exists('g:tcs_css')
    echoerr "[vim-tcs] Please set g:tcs_css"
    let outcome = v:false
  elseif !filereadable(g:tcs_css)
    echoerr "[vim-tcs] '".g:tcs_css."' is not readable. Please set g:tcs_css"
    let outcome = v:false
  endif

  return outcome
endfunction


" Returns the Tailwind class under the cursor and the offset within
" that word.
function! s:cursor()
  let tailwind_class = matchstr(expand('<cWORD>'), '\v[^"'']+\ze(["''>])*$')
  let i = stridx(getline('.'), tailwind_class)
  let col = getcursorcharpos('.')[2]
  return [tailwind_class, col-i]
endfunction


" Moves the cursor to the offset within the word on the current line.
function s:move_cursor(word, offset)
  let i = stridx(getline('.'), a:word)
  if i != -1
    call setcursorcharpos(line('.'), i + a:offset)
  endif
endfunction


function! s:exec_tcs()
  call system(g:tcs_executable.' '.g:tcs_css.' '.expand('%:p'))
endfunction
