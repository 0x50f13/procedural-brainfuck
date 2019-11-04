#!/bin/bash
cd $(dirname `which $0`)

# Colors
bold=$(tput bold)
normal=$(tput sgr0)
red=$(tput setaf 1)
green=$(tput setaf 2)
blue=$(tput setaf 4)
yellow=$(tput setaf 11)

echo "Procedural brainfuck build system"


error(){
    echo "${bold}${red}(X): ${normal}${1}"
}

success(){
    echo "${bold}${green}==> ${normal}${1}"
}

warn(){
    echo "${bold}${yellow}==> ${normal}${1}"
}

info(){
    echo "${bold}${blue}==> ${normal}${1}"
}

exec(){
    info "${1}"
    eval "${1}"
    if [ ! $? -eq 0 ]; then
        error "Exec: ${1} failed with non-zero exit code: ${?}"
        exit -1
    fi
}

require_directory(){ # Creates directory if not exist
    if [ ! -d $1 ]; then
        warn "Directory not found: ${1}"
        exec "mkdir ${1}"
    fi
}

change_dir(){
    if [ ! -d $1 ]; then
        error "No such directory: ${1}"
        exit -1
    fi
    info "Entering directory: ${1}"
    cd $1
}

leave_dir(){
    info "Leaving directory: $(pwd)"
    cd $BASEDIR
}

if [ $# -eq 0 ]; then
    error "Please specify target. Use -h option for help."
    exit -1
fi

if [[ $1 == "-h" ]]; then
    echo "Usage:"$0" <-h> [all|clean]"
    echo "-h        Display this help message and exit."
    echo "all       Build procedural brainfuck."
    echo "clean     Remove obj/ bin/ directories."
    exit 0
fi
### BEGIN BUILD SCRIPT ###
BASEDIR=`pwd`
CC="gcc"
CFLAGS="-c"
LD="gcc"
LD_FLAGS=""
OBJ_DIR="obj/"
BIN_DIR="bin/"
EXECUTABLE="pbf"
declare -a SOURCES=("hashtable" "array" "main")

target_clean(){
   info "Cleaning up."
   exec "rm -rf ${OBJ_DIR}"
   exec "rm -rf ${BIN_DIR}"
   success "Cleaned."
}

target_all(){
   require_directory $OBJ_DIR
   require_directory $BIN_DIR
   info "Building procedural brainfuck..."
   for file in "${SOURCES[@]}"
   do
       exec "${CC} ${CFLAGS} ${file}.c -o ${OBJ_DIR}${file}.o"
   done
   change_dir $OBJ_DIR
   objects=$(printf " %s.o" "${SOURCES[@]}")
   exec "${CC} -o ${BASEDIR}/${BIN_DIR}${EXECUTABLE} ${objects}"
}

### END BUILD SCRIPT ###

if [[ `type -t "target_${1}"` == "function" ]]; then
     eval "target_${1}"
     success "Done."
else
     error "No such target:${1}."
fi
