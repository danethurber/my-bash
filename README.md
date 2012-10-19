# Usage

```bash
mkdir ~/.bash && cd ~/.bash
git clone git@github.com:danethurber/my-bash.git
```
add this to your .bash_profile

```bash
export MYBASH=~/.bash/my-bash
source $MYBASH/main.sh
```

add to gitconfig
```bash
[include]
    path = ~/.bash/my-bash/.gitconfig
```