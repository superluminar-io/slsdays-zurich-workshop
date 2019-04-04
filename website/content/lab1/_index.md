---
title: Lab 1 - Basics
weight: 10
---

In this lab we will create our first SAM application and explore it.

## Create a S3 deployment Bucket

SAM requires that we provide a S3 Bucket where it can store build artifacts. These artifacts will later be reference in
when deploying our Lambda functions.

So let's create a S3 Bucket:

```shell
export S3_BUCKET=your-bucket-name
aws s3 mb s3://$S3_BUCKET
```

## Bootstrap serverless app

First we bootstrap the SAM "Hello World" example.
Change directories into your `$GOPATH` and create the usual Go boilerplate.

```shell
mkdir -p $GOPATH/src/github.com/<YOUR_NAME>
cd $GOPATH/src/github.com/<YOUR_NAME>
```

Now generate your template.

```shell
export APP_NAME=sam-workshop
sam init --runtime go1.x --name $APP_NAME
```

This will create an example app with the relevant configuration files and directory structure.

```
$ tree
.
├── Makefile
├── README.md
├── hello-world
│   ├── main.go
│   └── main_test.go
└── template.yaml
```

## Build
Since Lambda requires us to provide the compiled binary, we have to build it beforehand.

```shell
$ make build
GOOS=linux GOARCH=amd64 go build -o hello-world/hello-world ./hello-world
```

This compiles the function `hello-world` and places the binary next to the source code files.

## Deploy
SAM facilitates an extra packaging step in which the binary is deployed to the S3 Bucket we created earlier.

```shell
$ sam package \
   --profile $AWS_PROFILE \
   --output-template-file packaged.yaml \
   --s3-bucket $S3_BUCKET
Uploading to 56d6f7ac94a0e8508d61278b952d54e1  4910377 / 4910377.0  (100.00%)
Successfully packaged artifacts and wrote output template to file packaged.yaml.
```
 
To deploy the function and create the AWS components (Lambda function, API Gateway, DNS Entries, IAM Roles) we run:

```shell
$ sam deploy \
   --profile $AWS_PROFILE \
   --template-file packaged.yaml \
   --stack-name $APP_NAME \
   --capabilities CAPABILITY_IAM
Waiting for changeset to be created..
Waiting for stack create/update to complete
Successfully created/updated stack - slsdays-zurich
```

## Run the functions

To run the function we can use either the HTTPS endpoint (via API Gateway) or use the SAM command line tool to invoke the function directly.
Try it out. Figure out the URL by using the `aws cloudformation describe-stacks` command or visiting the AWS Console.

{{% expand "Need help?" %}}
```shell
# Find the endpoint in the cloudformation stack output
ENDPOINT=$(aws cloudformation describe-stacks \
--profile slsdays-zurich \
--stack-name slsdays-zurich \
--query 'Stacks[].Outputs' | grep -oe "https.*\/hello")
# Run curl
curl -v $ENDPOINT

# Or invoke the function directly.
sam local invoke --no-event
```
{{% /expand %}}

Do you notice any differences when running the function via `curl` or when you invoke it directly?
