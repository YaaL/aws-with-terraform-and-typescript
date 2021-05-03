# AWS Services with Terraform and Typescript

## Description
This is a demo repo on seting up different AWS services with Terraform and writing lambdas in Typescript. The AWS services incuded are AWS SQS, AWS EventBridge, AWS CloudWatch, AWS API Gateway, AWS DynamoDB and AWS Lambda. 

It is assumed that Terraform and Nodejs is already installed on your computer and that you can deploy to an AWS Account using Terraform.

## Architecture
![Architecture](architecture.png)

## Install
```bash
$ npm i
```

## Build
```bash
$ npm run build
```

## Testing
```bash
$ npm run test
```

## Deploying
```bash
$ npm run deploy
```

## Terraforming
```bash
$ tf:fmt       # terraform format
$ tf:init      # terraform init
$ tf:validate  # terraform validate
$ tf:plan      # terraform plan
$ tf:apply     # terraform apply
$ tf:destroy   # terraform destroy
```
