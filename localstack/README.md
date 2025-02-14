## Prerequisite
- Docker installed on your system.

## Setup
1.  Install localstack - [see instructions](https://docs.localstack.cloud/getting-started/installation/)
2. Install `tflocal` - a wrapper for `localstack` to work with `Terraform`
    ```bash
    pip3 install terraform-local
    ```

## Execute -
1. Start LocalStack -
    ```bash
    localstack start -d
    localstack status
    ```

2. init - `tflocal init`
3. apply - `tflocal apply`
5. After playing `localstack stop`

## Useful commands 
- Check created s3 resources -
    ```bash
    aws --endpoint-url=http://localhost:4566 s3 ls
    ```
- list lambdas -
    ```bash
    aws --endpoint-url=http://localhost:4566 --region us-east-1 lambda list-functions
    ```
- Run Lambda -
    ```bash
    aws --endpoint-url=http://localhost:4566 --region us-east-1 lambda invoke --function-name my-test-lambda output.json
    ```