# make os checks available
source ~/.zmenv/os_check.sh
# install the environment
function source_all() {
    if [ "$#" -ne 1 ]; then
        return
    fi

    local sourcepath="$1"
    if [ ! -d "$sourcepath" ]; then
        return
    fi

    for f in $(find "$sourcepath" -maxdepth 1 -type f); do
        if [[ $f == *.swp ]]; then
            continue
        fi
        source $f
    done
}
source_all ~/.zmenv/aliases.d
source_all ~/.zmenv/exports.d
