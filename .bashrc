shopt -s expand_aliases

alias ll='ls -l --color=auto'
alias ls='ls --color=auto'
alias sq='squeue -o "%.8i %.9P %.20j %8u %.2t %.8M %.6D %.4C %R"'
alias grep='grep --color=auto'

export DESKIP=10.0.4.113
export PATH=/home/lindell/local/bin:$PATH
export TERM="xterm-256color"
export VISUAL="vim"
export GDK_BACKEND=x11
export EDITOR=vim

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

#dbus-update-activation-environment --all




#:/opt/anaconda/bin:$PATH


#PYTHONPATH=$PYTHONPATH:/usr/lib/python2.7/site-packages:/usr/lib/python2.7/site_packages/gnuradio/blocks
#export PYTHONPATH

#LD_LIBRARY_PATH=/usr/lib/python2.7/site-packages/gnuradio:/usr/lib/python2.7/site-packages/gnuradio/blocks
#export LD_LIBRARY_PATH


# colorschemes
#PS1="\[\033[1;44m\]\u@\h:\W$\[\033[0m\]"

#Perl
#[ $SHLVL -eq 1 ] && eval "$(perl -I$HOME/local/perl_5_20_1 -I/usr/share/texmf/arch/tlpkg -Mlocal::lib=$HOME/local/perl_5_20_1)"
#eval $(perl -I$HOME/local/perl_5_20_1/lib/5.20.1 -Mlocal::lib=$HOME/local/perl_5_20_1)
#export PATH="/home/lindell/local/perl_5_20_1/bin:${PATH}"
#export PERL5LIB=/usr/share/texmf/arch/tlpkg:/usr/share/tlpkg:/home/lindell/local/perl_5_20_1/lib

# Useful commands
# scontrol create reservation starttime=now duration=3-00:00:00 user=lindell flags=ignore_jobs nodes=node02
# watch -d -n1 "squeue --noheader -u lindell | wc | awk '{print \$1}' | sed 's|.*|Num Jobs: &|'"
# ls | grep msfa-a.*-f01 | sed 's|msfa-a-NAm\(1[34]\)-\([0-9][0-9][0-9]\)-.*.ave|\2|; s/^0*\([1-9]\)/\1/;s/^0*$/0/'
# this one uses sed to get rid of leading zeros
# ls | grep msfa-a.*-f01 | sed 's|msfa-a-NAm\(1[34]\)-\([0-9][0-9][0-9]\)-.*.ave|\2-\1|; s/^0*\([1-9]\)/\1/;s/^0*$/0/; s|\(.\?.\?.\)-\(..\)|./combine_sect ascat-slice-reg20\2.def_20\2_\1_\1.meta|'

