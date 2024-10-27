_wifiman_completions() {
    local commands="status list on off connect listp speed disconnect"

    COMPREPLY=($(compgen -W "$commands" -- "${COMP_WORDS[1]}"))
}

complete -F _wifiman_completions wifiman
