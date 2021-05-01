unset  AWS_SESSION_TOKEN


if [ $ENVIRONMENT == "prod" ]
then
 temp_role=$(aws sts assume-role \
                    --role-arn "arn:aws:iam::119184259962:role/PipelineRole" \
                    --role-session-name "circleci-prod")
elif [ $ENVIRONMENT == "test" ]
then
 temp_role=$(aws sts assume-role \
                    --role-arn "arn:aws:iam::380477309410:role/PipelineRole" \
                    --role-session-name "circleci-test")
else
 temp_role=$(aws sts assume-role \
                    --role-arn "arn:aws:iam::404319983256:role/PipelineRole" \
                    --role-session-name "circleci-dev")
fi


echo export AWS_ACCESS_KEY_ID=$(echo $temp_role | jq .Credentials.AccessKeyId | xargs) >> "BASH_ENV"
echo export AWS_SECRET_ACCESS_KEY=$(echo $temp_role | jq .Credentials.SecretAccessKey | xargs) >> "BASH_ENV"
echo export AWS_SESSION_TOKEN=$(echo $temp_role | jq .Credentials.SessionToken | xargs) >> "BASH_ENV"