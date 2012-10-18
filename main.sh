source $MYBASH/git-completion.sh

function parse_git_dirty {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "*"
}

function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/[\1$(parse_git_dirty)]/"
}

export PS1='\n\e[0;37m\e[45m★ \e[m \e[1;36m\e[40m\W\e[m$(__git_ps1 ":\[\e[0;33m\]%s\[\e[0m\]\[\e[0;35m\]$(parse_git_dirty)\[\e[0m\]")$ '
