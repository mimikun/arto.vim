function! arto#open(...) abort
  let l:arto = s:executable()
  if l:arto ==# ''
    return
  endif
  let l:paths = s:resolve_paths(a:000)
  for l:path in l:paths
    call s:start(l:arto, l:path)
  endfor
endfunction

function! arto#version() abort
  let l:arto = s:executable()
  if l:arto ==# ''
    return
  endif
  echo system(l:arto . ' --version')
endfunction

function! s:executable() abort
  if has('mac')
    let l:app = get(g:, 'arto_path', '/Applications/Arto.app')
    let l:arto = l:app . '/Contents/MacOS/arto'
  else
    let l:arto = get(g:, 'arto_path', 'arto')
  endif
  if !executable(l:arto)
    echohl WarningMsg
    echomsg printf('[arto] Executable not found: %s', l:arto)
    echohl None
    return ''
  endif
  return l:arto
endfunction

function! s:resolve_paths(exprs) abort
  if len(a:exprs) == 0
    let l:path = expand('%:p')
    if l:path ==# ''
      echohl WarningMsg
      echomsg '[arto] No file to open'
      echohl None
      return []
    endif
    return [l:path]
  endif
  return map(copy(a:exprs), 'expand(v:val)')
endfunction

function! s:start(arto, path) abort
  let l:cmd = [a:arto, a:path]
  if has('nvim')
    call jobstart(l:cmd, {'detach': v:true})
  else
    call job_start(l:cmd, {'stoponexit': ''})
  endif
endfunction
