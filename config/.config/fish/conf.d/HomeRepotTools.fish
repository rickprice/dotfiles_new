# Need to set the ActiveState user for this code
source ~/.local/bin/set_as_config.sh


function plat -a platform
    if test -n "$platform"
        echo "switching to $platform"
        set -gx AS_PLATFORM $platform
    else
        if test -n "$AS_PLATFORM"
            echo "$AS_PLATFORM"
        else
            echo "prod"
        end
    end
end

function PR_DEPLOY
       USER=$AS_USER pr-deploy
end

function PR -a platform
    echo "Creating login for $platform"
    plat $platform
    echo -e "$AS_USER\n" | apikey new;
end



# function listpy
#        ING_LIST=$@;
#        for ing in ${ING_LIST}; do
#            ingredient search -s language/python -den $ing 2>/dev/null | grep $ing | awk -F\| '{print $3,$5" --version "$4" "$6}';
#        done
# end

# function listper
#        ING_LIST=$@;
#        for ing in ${ING_LIST}; do
#            ingredient search -s language/perl -den $ing 2>/dev/null | grep $ing | awk -F\| '{print $3,$5" --version "$4" "$6}';
#        done
# end

# function listshr
#        ING_LIST=$@;
#        for ing in ${ING_LIST}; do
#            ingredient search -s shared -den $ing 2>/dev/null | grep $ing | awk -F\| '{print $3,$5" --version "$4" "$6}';
#        done
# end
