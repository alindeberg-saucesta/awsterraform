export AWS_ACCESS_KEY_ID="yourkey"
export AWS_SECRET_ACCESS_KEY="secret key"
export region = "us-east-1”

aws ec2 create-instance-export-task --instance-id i-0d76d1f0e7cce1cfe --target-environment vmware --export-to-s3-task file://C:\file.json

export-i-0071244a3cff4c8e8

aws ec2 describe-export-tasks --export-i-0071244a3cff4c8e8

aws ec2 describe-export-tasks --export-task-ids export-i-0071244a3cff4c8e8
