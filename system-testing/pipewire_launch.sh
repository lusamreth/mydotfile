#!/bin/bash

# This scripts require pipewire , 
# pipewire-pulse(void-linux : this package is included in pipewire), 
# pulseaudio -- not necessary but good for backup 


function check_pw {

    pwloc=$(whereis "pipewire" | awk "{print $2}")
    pwpulse=$(whereis "pipewire-pulse" | awk "{print $2}")
    Requirement=(
    "bluez"
    #bluez-utils"
    "pipewire"
    #"pipewire-alsa"
    #"pipewire-jack"
    "pipewire-pulse"
    "wireplumber"
    "libspa-bluetooth"
    "fdkaac"
    )

    for dependency in ${Requirement[@]} 
    do
        check=$(whereis $dependency)
        IFS=":" read -ra pi <<< $check
        if [[ -z "${pi[1]}" ]]; then
            # do second check via package-manager!
            check_pkg_mg=$(xbps-query -s $dependency)
            echo "$check_pkg_mg"
            if [[ -z $check_pkg_mg ]];then
                echo "Cannot find $check! Missing dependency"
                
            fi
        fi
    done

    # if [[ -z "$pwloc" ]];then
    #    echo "Cannot find pipwire! Please set it up!" 
    # elif [[ -z "$pwpulse" ]];then
    #    echo "Cannot find pipwire-pulse lib! Missing dependency!" 
    # fi

}



#pipewire &
retry=20
$(pgrep pipwire)
#keep this that way
#running=($(pgrep pipewire))
running=($(pgrep pipewire))

function retry {
    command=$1
    counter=0 
    max_retry=20
    if [[ -n $2 ]];then
        max_retry=$2 
    fi
    echo "Retrying for $max_retry times!" 
    while [[ $counter -lt $max_retry ]] 
    do
        echo "retyring"
        eval $command && break
        counter=$(($counter + 1))
    done

}


function run_pipe { 
    run_pulse=$1
    ppa_run=($(pgrep pipewire-pulse))


    function print_already_run {
        if ! $run_pulse; then
            echo "Not starting pulse! already run with startup cmd!"
        fi

        echo -e "== pipewire is running under proc:=="
        echo "${running[@]}"

        echo -e "== pipewire-pulse is running under proc: =="
        echo  "${ppa_run[@]}"
    }

    if [ ${#running[@]} -gt 0 ];then
        print_already_run

        if [[ ${#ppa_run[@]} -le 0 ]] && $run_pulse;then
            retry "pipewire-pulse" 10
        else 
            echo "== Setup Completed! =="
            return
        fi

        echo "failed to start pipewire-pulse"
        exit 1
    else 
        retry "pipewire" 10 &
        echo "starting wireplumber next!" 
        wireplumber

        #echo "Failed to start pipewire!"
        return
    fi
    # force to stop 
    exit
}


function check_pactl {
    pactl info | grep -i "pipewire\|server string"
}

check_pw
run_pipe false 
check_pactl

# important : if you want bluetooth please install : libspa-bluetooth
#| grep -i pipewire

#pipewire-pulse
#== System pipewire ==
#!/bin/sh
#mkdir -p /run/pipewire
#umask 000
#PIPEWIRE_RUNTIME_DIR=/run/pipewire pipewire
#
##!/bin/execlineb -P
#foreground { mkdir -p /run/pipewire }
#fdmove -c 2 1
#s6-env PIPEWIRE_RUNTIME_DIR=/run/pipewire execline-umask 000 pipewire
#
#== System pipewire-pulse
##!/bin/sh
#mkdir -p /run/pulse
#umask 000
#PULSE_RUNTIME_PATH=/run pipewire-pulse
#
##!/bin/execlineb -P
#foreground { mkdir -p /run/pulse }
#fdmove -c 2 1
##s6-env PULSE_RUNTIME_PATH=/run execline-umask 000 pipewire-pulse


