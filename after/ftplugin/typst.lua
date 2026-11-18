vim.cmd([[function GitRoot()
    return fnamemodify(finddir('.git', ";"), ":h")
endfunc

" compile typst doc on write
function TypstWatch()
       vsp
       vertical resize 20
       exec 'terminal ' .. 'typst watch --root ' .. GitRoot() .. " " .. expand("%:")
       exec "norm \<c-w>h"
endfunc

nnoremap <silent> <leader>tc :call TypstWatch()<cr>


function! OpenZathura()
    let pdf = expand('%:p:r') . '.pdf'
    if !filereadable(pdf)
        echo 'PDF not found: ' . pdf
        return
    endif
    if has('nvim')
        call jobstart(['zathura', pdf])
    else
        call job_start(['zathura', pdf])
    endif
endfunction

nnoremap <silent> <leader>fr :call OpenZathura()<cr>

"nnoremap <silent><leader>tr :silent exec "!zathura --fork " . expand("%:p:r") . ".pdf &"<cr>
]])
