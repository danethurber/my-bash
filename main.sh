# Add `~/bin` to the `$PATH`
export PATH="$MYBASH/bin:$PATH"

# Git autocomplete `brew install bash_completion`
if [ -f `brew --prefix`/etc/bash_completion ]; then
    . `brew --prefix`/etc/bash_completion
fi

# Load the shell dotfiles, and then some:
for file in $MYBASH/.{aliases,os-aliases}; do
    [ -r "$file" ] && source "$file"
done
unset file


# Prompt
if [ -x /usr/bin/tput ] && tput setaf 1 >& /dev/null; then
    c_git_clean=$(tput setaf 2)
    c_git_dirty=$(tput setaf 1)
    c_git_semi_dirty=$(tput setaf 3)
    c_reset=$(tput sgr0)
else
    c_git_clean=
    c_git_dirty=
    c_reset=
    c_git_semi_dirty=
fi

function branch_status {
    if ! git rev-parse --git-dir > /dev/null 2>&1; then
        return 0
    fi

    git_branch=$(git branch 2> /dev/null | sed -n '/^\*/s/^\* //p')

    if git diff HEAD --quiet 2> /dev/null >&2; then
        status="✔"
        git_color="${c_git_clean}"
        dirty=0
    else
        status="⇪"
        git_color="${c_git_dirty}"
        dirty=1
    fi

    if git diff $git_branch origin/$git_branch --quiet 2> /dev/null >&2; then
        git_color="$git_color"
    else
        if [ dirty=0 ]; then
            git_color="${c_git_semi_dirty}"
        fi
    fi

    echo "$git_color${status} "
}

export PS1='$(__git_ps1 "$(branch_status)" )\e[1;36m\e[40m\W\e[m$(__git_ps1 ":\[\e[0;33m\]%s\[\e[0m\]")$ '
