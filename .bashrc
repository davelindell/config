shopt -s expand_aliases
set -o vi
bind '"jk":vi-movement-mode'
bind -m vi-insert "\C-l":clear-screen

alias vim='vim --servername vim'
alias ll='ls -l --color=auto'
alias ls='ls --color=auto'
alias sq='squeue -o "%.8i %.9P %.20j %8u %.2t %.8M %.6D %.4C %R"'
alias grep='grep --color=auto'

export PATH=/home/lindell/local/bin:$PATH
export PATH=~/.npm-global/bin:$PATH
export TERM="xterm-256color"
export VISUAL="vim"
export GDK_BACKEND=x11
export EDITOR=vim
export PATH=$PATH:/opt/anaconda/bin

export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/lib:/opt/cuda/lib64:/opt/cuda/extras/CUPTI/lib64:/home/lindell/local/MATLAB/MATLAB_Runtime/v91/runtime/glnxa64:/home/lindell/local/MATLAB/MATLAB_Runtime/v91/bin/glnxa64:/home/lindell/local/MATLAB/MATLAB_Runtime/v91/sys/os/glnxa64:"
export CUDA_HOME=/opt/cuda

# powerline
powerline-daemon -q
export POWERLINE_COMMAND=powerline
export POWERLINE_CONFIG_COMMAND=powerline-config
POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1
if [ -f /usr/lib/python2.7/site-packages/powerline/bindings/bash/powerline.sh ]; then
    source /usr/lib/python2.7/site-packages/powerline/bindings/bash/powerline.sh
fi
