# ------------------------------------------------------------------------
#
# TheEye.io - Bash Boilerplate for writing script tasks
#
# ------------------------------------------------------------------------

# Enable error handling
set -euo pipefail

# uncomment with bash>4.4 only
#shopt -s inherit_errexit nullglob compat"${BASH_COMPAT=42}"

trap 'catch_output $? $LINENO' ERR
trap 'catch_output $? $LINENO' EXIT

PROGNAME=$(basename $0)
#alias echo="printf"

function catch_output
{
  if [ "$1" != "0" ];
  then
	  echo "Error $1 occurred on $2" && failure_output
  fi
}

function failure_output
{
  echo "{\"state\":\"failure\",\"data\":[\"error\"]}"
  exit 1
}

function success_output
{
  # remove end of line characters
  #output=$(tr -d '\r|\n' < output.json)
  # jq alternative (recommended)
  output=$(cat output.json | jq -c '.')
  printf '{"state":"success","data":%b}' "${output}"
  exit 0
}

# ------------------------------------------------------------------------
#
# write your code into main function
#
# ------------------------------------------------------------------------
function main 
{

  # build the JSON output
  date=$(date --rfc-3339=seconds | sed 's/ /T/')
  cat << JSON > ./output.json
[
  "test arguments",
  {
    "prop1":"val1",
    "prop2":"val2"
  },
  "${date}",
  "another argument"
]
JSON
  
  # output.json will be handled for you
  return 0 # task exit code
}

main
success_output
