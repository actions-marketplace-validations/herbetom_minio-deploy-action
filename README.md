# S3 Deploy GitHub Action

This is a fork from foldspace-stack/minio-deploy-action with some changes.
Run [rclone][] in GitHub Actions to deploy files to S3 compatible object storage.

## Usage

Put the following step in your workflow:

```yml
- name: S3 Deploy
  uses: herbetom/s3-deploy-action@v2
  with:
    endpoint: ${{ secrets.S3_ENDPOINT }}
    access_key: ${{ secrets.S3_ACCESS_KEY }}
    secret_key: ${{ secrets.S3_SECRET_KEY }}
    bucket: 'mybucket'
    # Optional inputs with their defaults:
    source_dir: 'public'
    target_dir: '/'
    extra_args: ''
    mode: 'copy' # use 'sync' to delete files not present
```

Workflow example:

```yml
name: Deploy

on:
  pull_request:
    types: [opened, synchronize]
  push:
    branches:
      - master

jobs:
  build:
    name: Deploy
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v7

      - name: S3 Deploy
        uses: herbetom/s3-deploy-action@v2
        with:
          endpoint: ${{ secrets.S3_ENDPOINT }}
          access_key: ${{ secrets.S3_ACCESS_KEY }}
          secret_key: ${{ secrets.S3_SECRET_KEY }}
          bucket: 'mybucket'
          source_dir: 'public'
          target_dir: '/'
          mode: 'snyc'
```

## License

Licensed under the MIT license. See [LICENSE](LICENSE).
