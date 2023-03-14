# tcs-vim

Integrates [tcs](https://github.com/airblade/tcs) (Tailwind class sorter) with Vim.

Whenever you write an HTML file, the plugin waits for the Tailwind build process to finish and then runs the HTML through `tcs`.


## Installation

Install `tcs` somewhere on your `PATH`.

Install this plugin like every other vim plugin :)

Set `g:tcs_css` to point to the CSS file which Tailwind CLI generates.

I have this snippet in my vimrc:

```vim
function! s:is_tailwind()
  return !empty(findfile('tailwind.config.js', '.;')) ||
       \ !empty(findfile('config/tailwind.config.js', '.;'))
endfunction

autocmd BufEnter *.html,*.slim if s:is_tailwind() |
      \   setlocal autoread |
      \ endif
autocmd BufWritePost *.html,*.slim if s:is_tailwind() |
      \   call TcsAsync() |
      \ endif
```


## Configuration

`g:tcs_executable` - path to the `tcs` script.  Default: `'tcs'`.

`g:tcs_delay_ms` - how long to wait in milliseconds for Tailwind's build to finish after saving an HTML file.  Default: `100`.

Tailwind doesn't touch the output CSS file if there is no change to the CSS, in which case there's no way to detect the build has finished.  Instead we just give it time to finish.

`g:tcs_css` - path to Tailwind's output CSS file.  This needs to be set.


## Intellectual property

Copyright Andrew Stewart.  Released under the MIT licence.
