let g:tcs_executable = get(g:, 'tcs_executable', 'tcs')
let g:tcs_delay_ms = get(g:, 'tcs_delay_ms', 100)


function! Tcs(...)
  if !s:prerequisites() | return | endif
  call s:exec_tcs()
  execute 'checktime' bufnr()
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


function! s:exec_tcs()
  call system(g:tcs_executable.' '.g:tcs_css.' '.expand('%:p'))
endfunction
