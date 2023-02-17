" Copyright 2021-2023, Gaurav Juvekar
" SPDX-License-Identifier: MIT

if !exists("g:deluminator#themes")
    let g:deluminator#themes = {
\       "light": "solarized8_light"
\     , "dark": "solarized8_dark"
\   }
endif


if !has('nvim')


function! deluminator#Callback(channel, msg)
    if a:msg ==? 'dark'
        execute 'colorscheme ' . g:deluminator#themes["dark"]
    elseif a:msg ==? 'light'
        execute 'colorscheme ' . g:deluminator#themes["light"]
    endif
endfunction

function! deluminator#start()
    if exists("g:deluminator_running")
        return
    endif

    let job = job_start("deluminator --monitor",
\                       {"out_cb": "deluminator#Callback"})

    if job_status(job) ==? "run"
        let g:deluminator_running = 1
    else
        execute 'colorscheme ' . g:deluminator#themes["light"]
    endif
endfunction


else


function! deluminator#Callback(job_id, data, event)
    if a:event == 'stdout'
        let l:light_or_dark = trim(join(a:data, ''))
        if l:light_or_dark ==? 'dark'
            execute 'colorscheme ' . g:deluminator#themes["dark"]
        elseif l:light_or_dark ==? 'light'
            execute 'colorscheme ' . g:deluminator#themes["light"]
        endif
    endif
endfunction

function! deluminator#start()
    if exists("g:deluminator_running")
        return
    endif

    let job = jobstart("deluminator --monitor",
\                      {"on_stdout": function("deluminator#Callback")})

    if jobwait([job], 0)[0] == -1
        let g:deluminator_running = 1
    else
        execute 'colorscheme ' . g:deluminator#themes["light"]
    endif
endfunction


endif
