#
# ~/.bash_profile
#
export MATLAB_JAVA=/usr/lib/jvm/java-8-openjdk/jre
[[ -f ~/.bashrc ]] && . ~/.bashrc

export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$ANDROID_HOME/tools/bin

export PYTHONPATH=/opt/caffe/python

