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

export WORKON_HOME=/home/vagrant/.virtualenvs
source /usr/local/bin/virtualenvwrapper.sh
workon djangoproj

alias cw='compass watch myproject/static_media/stylesheets'
alias sh='python manage.py shell'
alias rs='python manage.py runserver [::]:8000'
alias rsp='python manage.py runserver_plus [::]:8000'
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

# Configure colors, if available.
if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    c_reset='\[\e[0m\]'
    c_user='\[\e[0;32m\]'
    c_path='\[\e[1;34m\]'
    c_git_clean='\[\e[0;37m\]'
    c_git_staged='\[\e[0;32m\]'
    c_git_unstaged='\[\e[0;31m\]'
else
    c_reset=
    c_user=
    c_path=
    c_git_clean=
    c_git_staged=
    c_git_unstaged=
fi

# Add the title bar information when it is supported.
case $TERM in
xterm*|rxvt*)
    TITLEBAR='\[\e]0;\u@\h: \w\a\]';
    ;;
*)
    TITLEBAR="";
    ;;
esac

# Function to assemble the Git parsing part of our prompt.
git_prompt ()
{
    GIT_DIR=`git rev-parse --git-dir 2>/dev/null`
    if [ -z "$GIT_DIR" ]; then
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
    echo "[$git_color$GIT_BRANCH$c_reset]"
}

# Thy holy prompt.
PROMPT_COMMAND="$PROMPT_COMMAND PS1=\"${TITLEBAR}(`basename ${VIRTUAL_ENV}`)${c_user}\u${c_reset}@${c_user}\h${c_reset}:${c_path}\w${c_reset}\$(git_prompt)\$ \" ;"

cd /vagrant/myproject
