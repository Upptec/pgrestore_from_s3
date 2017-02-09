# PGRestore from S3
A small utility to restore a database from a dump-file (gzipped or not) in S3. Companion to [PGDump to S3](https://github.com/Upptec/pgdump_to_s3).

## Requirements

Set these env-vars for pg_rearoew (see [PG ENV-vars](http://www.postgresql.org/docs/current/static/libpq-envars.html)):
  * PGHOST
  * PGPORT (unless 5432)
  * PGUSER
  * PGPASSWORD
(and if need be, other PG env vars according to your needs)

and these for AWS CLI (or less if using EC2-roles) (see [AWS CLI ENV-vars](http://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html#cli-environment)):
  * AWS_ACCESS_KEY_ID
  * AWS_SECRET_ACCESS_KEY
  * AWS_DEFAULT_REGION

## Temp-volume

Be sure to bind a temporary volume to `/restoretemp` (or somewhere else, but set env `TEMP_RESTORE_DIR` to that).

## Command
Entrypoint is the script [restore_from_s3](restore_from_s3).

The script takes these parameters:
    `s3://mybucket/myfolder/mydump target_database`

If dump has `.gz` suffix, it will ungzip-it.

## pg_restore parameters

Utility will use these parameters for restore:
`pg_restore --clean --no-acl --no-owner -d target_database mydump`.

## Example

`docker run --rm -it -e PGHOST=xx -e PGUSER=xx -e PGPASSWORD=xx -e AWS_DEFAULT_REGION=eu-west-1 -e AWS_ACCESS_KEY_ID=xx -e AWS_SECRET_ACCESS_KEY=xx -v /restoretemp upptec/pgrestore_from_s3 s3://my_bucket/my_folder/mydump.gz mydb`

## Howto dump

See [PGDump to S3](https://github.com/Upptec/pgdump_to_s3).
