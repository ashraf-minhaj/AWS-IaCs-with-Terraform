This project is being tested on floci.

Deploy a local floci env -

```bash
# docker run --rm -p 4566:4566 floci/floci:latest
docker compose up -d
```

```
aws --endpoint-url http://localhost:4566 \
eks create-cluster \
    --name dev-cluster \
    --role-arn arn:aws:iam::000000000000:role/eks-role \
    --resources-vpc-config subnetIds=subnet-00000001
```

check your resources -
```bash
aws --endpoint-url http://localhost:4566 eks list-clusters
```