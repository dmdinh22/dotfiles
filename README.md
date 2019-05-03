# dotfiles
## To pull into new machine
- `git clone --separate-git-dir=$HOME/.dotfiles https://github.com/<username>/dotfiles.git dotfiles-tmp`
- `rsync --recursive --verbose --exclude '.git' dotfiles-tmp/ $HOME/`
- `rm --recursive dotfiles-tmp`
