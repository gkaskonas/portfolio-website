unset  AWS_SESSION_TOKEN


if [ $ENVIRONMENT == "main" ]
then
 temp_role=$(aws sts assume-role \
                    --role-arn "arn:aws:iam::119184259962:role/PipelineRole" \
                    --role-session-name "circleci-prod")
else
 temp_role=$(aws sts assume-role \
                    --role-arn "arn:aws:iam::404319983256:role/PipelineRole" \
                    --role-session-name "circleci-dev")
fi


export AWS_ACCESS_KEY_ID=$(echo $temp_role | jq .Credentials.AccessKeyId | xargs)
export AWS_SECRET_ACCESS_KEY=$(echo $temp_role | jq .Credentials.SecretAccessKey | xargs)
export AWS_SESSION_TOKEN=$(echo $temp_role | jq .Credentials.SessionToken | xargs)