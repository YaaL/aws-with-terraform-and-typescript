# AWS Services with Terraform and Typescript

## Description
This is a demo repo on seting up different AWS services with Terraform and writing lambdas in Typescript. The AWS services incuded are AWS SQS, AWS EventBridge, AWS Kinesis, AWS DynamoDB, AWS API Gateway and AWS Lambda. 

It is assumed that Terraform and Nodejs is already installed on your computer and that you can deploy to an AWS Account using Terraform.

## Architecture
![Architecture](architecture.png)

## Install packages
```bash
$ npm i
```

## Terraform apply
```bash
$ npm run apply # runs terraform init, format, validate, plan and apply
```

## Deploying
```bash
$ npm run deploy # builds the code and runs terraform apply command
```

## Testing
```bash
$ npm run test
```

## Terraforming
```bash
$ npm run tf:init      # terraform init
$ npm run tf:fmt       # terraform format
$ npm run tf:validate  # terraform validate
$ npm run tf:plan      # terraform plan
$ npm run tf:apply     # terraform apply
$ npm run tf:destroy   # terraform destroy
```
