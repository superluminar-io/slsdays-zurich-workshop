---
title: Prerequisites
weight: 5
---

You will need some software to work through this workshop.

## Install software

If you have a Mac run:
```shell
brew install go
brew install awscli
```

## Configure AWS access

```shell
$ export AWS_PROFILE=your-profile 
$ aws configure --profile $AWS_PROFILE 
AWS Access Key ID [None]: <your key>
AWS Secret Access Key [None]: <your secret>
Default region name [None]: eu-central-1
Default output format [None]:
```

## Make sure AWS works

```shell
$ aws sts get-caller-identity
{
    "UserId": "AROAJIFDNOS32O5CUCCXO:1547722234274198000",
    "Account": "123456789012",
    "Arn": "arn:aws:sts::123456789012:something/something/something"
}
```

## Install AWS SAM CLI

Install the [AWS SAM](https://aws.amazon.com/serverless/sam/#Install_SAM_CLI) command line tool.
This tool allows us to build and deploy [Serverless](https://en.wikipedia.org/wiki/Serverless_computing) applications.

```shell
brew tap aws/tap
brew install aws-sam-cli
```
