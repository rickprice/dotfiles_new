# Need to set the ActiveState user for this code
source ~/.local/bin/set_as_config.sh

# Camel setup stuff
# export CAMEL_ROOT=~/camel
# export PERL_USE_UNSAFE_INC=1
# export PERL5LIB=$CAMEL_ROOT/build/lib:$CAMEL_ROOT/local/lib/perl5:$PERL5LIB
# export PATH=$CAMEL_ROOT/vendor/bin:$CAMEL_ROOT/local/bin:$PATH

alias camel='cd ~/camel;docker run -it -v $(pwd):/camel camel-work /usr/bin/sh'
alias centos6='cd ~/camel;docker run -it -v /storage:/storage activestate/centos-6.9-build /usr/bin/sh'
alias centos7='cd ~/camel;docker run -it -v /storage:/storage activestate/centos-7.6-build /usr/bin/sh'
alias prune='docker system prune'
#alias rebase='/home/marcg/scripts/rebase.sh'
#alias scanner='cd /home/marcg/TheHomeRepot/service/pythonscanner'
#alias fusebox='ssh -i ~/.ssh/kc-aws ec2-user@fusebox.activestate.build'
alias bet='cd ~/TheHomeRepot/lib/python/ActiveStatePlatform'
alias ripenv='pipenv --rm && pipenv install --dev'
# alias tidyall='~/perl5/perlbrew/perls/perl-5.26.1/bin/tidyall'

function be() { cd ~/TheHomeRepot/lib/python; pipenv shell; }


function plat() {
    if [ -n "$1" ]
    then
        echo "switching to $1"
        export AS_PLATFORM=$1
    else
        echo ${AS_PLATFORM:-prod}
    fi
}

function PR-DEPLOY() {
       USER=$AS_USER pr-deploy
}

function PR() {
       plat $1;
       echo -e "$AS_USER\n" | ~/TheHomeRepot/lib/python/ActiveStatePlatform/tools/apikey.py new;
}

alias prod='plat prod'
alias staging='plat staging'

function review-list(){
       LIST=$@
       inventory-review --src-env $AS_PLATFORM --target-env prod $(for i in $LIST; do IID=$(ingredient search -en $i|grep $i|awk '{print $4}') 2>/dev/null; echo " --ingredient $IID "; done)
}

function review-prep(){
       LIST=$@
       echo $(for i in $LIST; do IID=$(ingredient search -en $i|grep $i|awk '{print $4}') 2>/dev/null; echo " --ingredient $IID "; done)
       echo -e "\ninventory-review --src-env $AS_PLATFORM --target-env prod\n"
}

alias cam='cd ~/camel'
alias recipes='cd ~/camel/build/recipes'
alias tools='cd ~/TheHomeRepot/lib/python/ActiveStatePlatform/tools/'
alias asp='cd ~/TheHomeRepot/lib/python/ActiveStatePlatform/'


function camel_report(){
       LOG_NUM=$1;
       cd ~/camel;
       echo -e "Camel Update :dromedary_camel:\ncommit: $(git log -1 --pretty=format:'%H')";
       ingredient search -den camel -s builder 2>/dev/null| grep camel | tail -1 | awk '{print "version: "$8"\ning_id: ",$6"\nver_id: ",$10}';
       echo -e "\nChangeLog:\n";
       LOG=$(git log -${LOG_NUM} --pretty=format:'%h%  - %d% %s <%an>' --abbrev-commit --no-merges);
       echo "$LOG" | sed -e 's/ \((.*)\)//g'
}

function tidy-add(){
       FILE=$@;
       for i in ${FILE}; do
          tidyall $i;
          git add $i;
      done
}

function listpy(){
       ING_LIST=$@;
       for ing in ${ING_LIST}; do
           ingredient search -s language/python -den $ing 2>/dev/null | grep $ing | awk -F\| '{print $3,$5" --version "$4" "$6}';
       done
}

function listper(){
       ING_LIST=$@;
       for ing in ${ING_LIST}; do
           ingredient search -s language/perl -den $ing 2>/dev/null | grep $ing | awk -F\| '{print $3,$5" --version "$4" "$6}';
       done
}

function listshr(){
       ING_LIST=$@;
       for ing in ${ING_LIST}; do
           ingredient search -s shared -den $ing 2>/dev/null | grep $ing | awk -F\| '{print $3,$5" --version "$4" "$6}';
       done
}

function ispy(){
       ing=$1;
       ingredient load -s language/python -en $ing;
}

function isper(){
       ing=$1;
       ingredient load -s language/perl -en $ing;
}

function isshr(){
       ing=$1;
       ingredient load -s shared -en $ing;
}

function dependency_update(){
       dep=$1
       shift
       output_file=$1
       shift
       LIST=$@

       echo "$(for i in $LIST; do singpy $i; done)" |grep .| awk -v DEST=$AS_PLATFORM -v DEP=$dep '{print "inventory-api copy ingredient --src-env prod "$4" "DEST" "$5,$6" --field-name dependency_sets --field-value " DEP}' > $output_file
}

function run_update(){
       while read -r line; do echo $line; echo $($line | egrep 'provided_features|version'); echo; done < $1
}

function get_patch(){
       PATCH=$1
       FILE=$(inventory-api get patch ${PATCH} | grep content | awk -F\' "{print \$4}")
       echo "Downloading patch from: $FILE"
       aws s3 cp ${FILE} .
}

function get_patches(){
       SPACE=$1
       MOD=$2
       VER=$3

      for PATCH in $(ingredient search -s ${SPACE} -den ${MOD} -v ${VER} --json | jq -r '.[0].patches [].patch_id'); do echo ${PATCH}; get_patch ${PATCH}; done
}

function get_build_script(){
       BS=$1
       FILE=$(inventory-api get build-script $BS | grep script\': | awk -F\' "{print \$4}")
       echo "Downloading build-script from: $FILE"
       aws s3 cp s3://platform-sources/build_scripts/${FILE} .
}

alias git=hub

# Fixes from Marc Gutman for enabling and disabling triggers on a PR
alias dbt_off="psql -d inventory_pr_$AS_PLATFORM -h pgdev.ceurkm6upyli.us-east-1.rds.amazonaws.com -U pb_admin -p 5432 -c 'SELECT disable_feature_trigger();'"
alias dbt_on="psql -d inventory_pr_$AS_PLATFORM -h pgdev.ceurkm6upyli.us-east-1.rds.amazonaws.com -U pb_admin -p 5432 -c 'SELECT enable_feature_trigger();'"
