# tcs-vim

Integrates [tcs](https://github.com/airblade/tcs) (Tailwind class sorter) with Vim.

Whenever you write an HTML file, the plugin waits for the Tailwind build process to finish and then runs the HTML through `tcs`.


## Shortcomings

This is a quick first draft.  In particular:

- Assumes every HTML file is part of a Tailwind project.
- Only supports HTML files.


## Configuration

`g:tcs_executable` - path to the `tcs` script.  Default: `'tcs'`.

`g:tcs_delay_ms` - how long to wait in milliseconds for Tailwind's build to finish after saving an HTML file.  Default: `100`.

Tailwind doesn't touch the output CSS file if there is no change to the CSS, in which case there's no way to detect the build has finished.  Instead we just give it time to finish.

`g:tcs_css` - path to Tailwind's output CSS file.  This needs to be set.


## Intellectual property

Copyright Andrew Stewart.  Released under the MIT licence.
