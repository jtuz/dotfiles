export PATH=$HOME/go/bin:$HOME/Applications/netbeans-12.0/netbeans/java/maven/bin:$PATH

# RBENV
type rbenv > /dev/null
if [ "$?" = "0" ]; then
    eval "$(rbenv init -)"
fi

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# PYENV
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1
then
    eval "$(pyenv init --path)"
fi
export PATH="$PATH:$HOME/bin"
eval "$(pyenv virtualenv-init -)"

source <(kubectl completion zsh)

# Custom ENVS
alias ag='ag --path-to-ignore ~/.ignore'
export FZF_DEFAULT_COMMAND='ag --path-to-ignore ~/.ignore --hidden -g ""'
export TERM_ITALICS=true
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
