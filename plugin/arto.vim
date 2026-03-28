if exists('g:loaded_arto')
  finish
endif
let g:loaded_arto = 1

let g:arto_path = get(g:, 'arto_path', has('mac') ? '/Applications/Arto.app' : 'arto')

command! -nargs=* -complete=file Arto call arto#open(<f-args>)
command! -nargs=0 ArtoVersion call arto#version()
