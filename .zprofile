export PATH=$HOME/go/bin:$HOME/Applications/netbeans-12.0/netbeans/java/maven/bin:$PATH

# Perl ENVS
PATH="/home/jtuzp/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/jtuzp/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/jtuzp/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/jtuzp/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/jtuzp/perl5"; export PERL_MM_OPT;

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

# DENO
export DENO_INSTALL="/home/jtuzp/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

source <(kubectl completion zsh)

# Custom ENVS
alias ag='ag --path-to-ignore ~/.ignore'
export FZF_DEFAULT_COMMAND='ag --path-to-ignore ~/.ignore --hidden -g ""'
export TERM_ITALICS=true
export PYENV_VIRTUALENV_DISABLE_PROMPT=1

# export FZF_DEFAULT_OPTS='
#   --color fg:#5d6466,bg:#1e2527
#   --color bg+:#ef7d7d,fg+:#2c2f30
#   --color hl:#dadada,hl+:#26292a,gutter:#1e2527
#   --color pointer:#373d49,info:#606672
#   --border
#   --color border:#1e2527
#   --height 13'

export FZF_DEFAULT_OPTS='--color=fg:#f8f8f2,bg:#282a36,hl:#bd93f9 --color=fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9 --color=info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6 --color=marker:#ff79c6,spinner:#ffb86c,header:#6272a4'
