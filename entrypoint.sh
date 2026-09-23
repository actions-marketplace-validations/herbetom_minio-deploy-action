#!/bin/sh
set -eu

[[ -n "${1:+x}" ]] || ( echo "please supply a source as first parameter" && exit 1 )
[[ -n "${2:+x}" ]] || ( echo "please supply a target as second parameter" && exit 1 )

SOURCE=$1; shift
TARGET=$1; shift

export RCLONE_CONFIG_DEPLOY_TYPE=s3
export RCLONE_CONFIG_DEPLOY_PROVIDER=Other
export RCLONE_CONFIG_DEPLOY_ENDPOINT="$S3_ENDPOINT"
export RCLONE_CONFIG_DEPLOY_ACCESS_KEY_ID="$S3_ACCESS_KEY"
export RCLONE_CONFIG_DEPLOY_SECRET_ACCESS_KEY="$S3_SECRET_KEY"

# skip the existence check
export RCLONE_CONFIG_DEPLOY_NO_CHECK_BUCKET=true

if [ -n "${S3_REGION:-}" ]; then
  export RCLONE_CONFIG_DEPLOY_REGION="$S3_REGION"
fi

MODE="${RCLONE_MODE:-copy}"

# $* is intentionally unquoted so extra_args splits into separate flags
# shellcheck disable=SC2086
exec rclone "$MODE" --checksum --stats-one-line -v $* "$SOURCE" "deploy:$TARGET"
