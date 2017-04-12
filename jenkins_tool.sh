
usage() {
    echo "Usage: $(basename $0) <jenkins_job_name>"
    echo "   Ex: $(basename $0) pitrix-project"
}

if [ $# -ne 1 ]; then
    echo "Error: invalid parameters"
    usage
    exit 1
fi

JOB_URL=http://x.x.x.x:8080/view/devops/job/${1}
JOB_STATUS_URL=${JOB_URL}/lastBuild/api/json

GREP_RETURN_CODE=0

# Start the build
curl $JOB_URL/build?delay=0sec

# Poll every thirty seconds until the build is finished
while [ $GREP_RETURN_CODE -eq 0 ]
do
    sleep 30
    # Grep will return 0 while the build is running:
    curl --silent $JOB_STATUS_URL | grep result\":null > /dev/null
    GREP_RETURN_CODE=$?
done

curl --silent $JOB_STATUS_URL | grep result\":\"SUCCESS > /dev/null
GREP_RETURN_CODE=$?
if [ $GREP_RETURN_CODE -ne 0 ]; then
    echo Build failed
else
    echo Build succeeded
fi
exit $GREP_RETURN_CODE
