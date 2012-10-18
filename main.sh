source $MYBASH/git-completion.sh

function parse_git_dirty {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo -e "\e[0;31m⇪ \e[m " || echo -e "\e[0;32m✔ \e[m "
}

export PS1='$(__git_ps1 "$(parse_git_dirty)" )\e[1;36m\e[40m\W\e[m$(__git_ps1 ":\[\e[0;33m\]%s\[\e[0m\]")$ '
