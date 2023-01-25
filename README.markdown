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

`g:tcs_css` - path to Tailwind's output CSS file.  This needs to be set.


#### How do we know when Tailwind's build process has finished?

Initially I tried to detect a change in the CSS output file's modification time using `BufWritePre` and `BufWritePost` autocommands.  However Tailwind's build finishes in tens of milliseconds while `getftime()` has a resolution of 1 second, so most of the time changes went undetected.

Next I tried detecting a change in the SHA256 checksum.  At this point I realised Tailwind's build can result in the same output CSS, in which case the checksum wouldn't change.

Finally I noticed that if the output CSS does not change, Tailwind does not touch the CSS file at all.  So there's simply no way to detect that the build process has finished.

Now the code just delays for a short time (100ms by default) to give the build time to finish.


## Intellectual property

Copyright Andrew Stewart.  Released under the MIT licence.
