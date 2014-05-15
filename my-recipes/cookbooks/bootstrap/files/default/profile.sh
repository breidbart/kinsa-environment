# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# VirtualenvWrapper Config
export WORKON_HOME=/home/vagrant/.virtualenvs
source /usr/local/bin/virtualenvwrapper.sh
workon djangoproj
cd /vagrant/myproject

# Aliases
alias sh='python manage.py shell'
alias rs='python manage.py runserver [::]:8000'
alias dj='python manage.py'
alias py='python'
alias pyclean='find . -name \"*.pyc\" -delete'
alias ga='git add'
alias gb='git branch'
alias gco='git checkout'
alias gl='git pull'
alias gp='git push'
alias gst='git status'
alias gss='git status -s'
alias frs='foreman start -f Procfile.dev'

# Configure colors
c_reset="\[\e[0m\]" # no color
c_user="\[\e[38;5;66m\]" # teal
c_path="\[\e[38;5;239m\]" # gray
c_git_clean="\[\e[38;5;251m\]" # light gray
c_git_staged="\[\e[38;5;142m\]" # green
c_git_unstaged="\[\e[38;5;124m\]" # red
c_virtualenv="\[\e[38;5;136m\]"

LS_COLORS='di=38;5;25:fi=38;5;248:ex=38;5;142:ln=38;5;198' ; export LS_COLORS

# Function to assemble the Git parsing part of our prompt.
git_prompt () {
  GIT_DIR=`git rev-parse --git-dir 2>/dev/null`

  # Check to see if there is a Git repo in the directory
  # If not, set the GIT_INFO variable to empty and return
  if [ -z "$GIT_DIR" ]; then
    GIT_INFO=
    return 0
  fi

  GIT_HEAD=`cat $GIT_DIR/HEAD`
  GIT_BRANCH=${GIT_HEAD##*/}
  
  if [ ${#GIT_BRANCH} -eq 40 ]; then
      GIT_BRANCH="(no branch)"
  fi
  
  STATUS=`git status --porcelain`
  
  if [ -z "$STATUS" ]; then
      git_color="${c_git_clean}"
  else
    echo -e "$STATUS" | grep -q '^ [A-Z\?]'
    if [ $? -eq 0 ]; then
      git_color="${c_git_unstaged}"
    else
      git_color="${c_git_staged}"
    fi
  fi
  
  GIT_INFO="$git_color$GIT_BRANCH$c_reset "
}

function set_virtualenv () {
  if [ -z "$VIRTUAL_ENV" ]; then
    PYTHON_VIRTUALENV=
  else
    PYTHON_VIRTUALENV="${c_virtualenv}`basename \"$VIRTUAL_ENV\"`${c_reset} "
  fi
}

function set_bash_prompt () {
  # Set the GIT_INFO variable
  git_prompt

  # Set the PYTHON_VIRTUALENV variable.
  set_virtualenv
 
  # Set the bash prompt variable.
  PS1="${c_user}\u${c_reset} ${PYTHON_VIRTUALENV}${GIT_INFO}${c_path}\w${c_reset}$ "
}

# Tell bash to execute this function just before displaying its prompt.
PROMPT_COMMAND=set_bash_prompt
