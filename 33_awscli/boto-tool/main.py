import argparse
import io
import logging
import logging.config
import sys
import traceback
import yaml
import os
import boto3
from boto3.session import Session

def log_uncaught_exceptions(exc_type, exc_value, exc_traceback):
    if issubclass(exc_type, KeyboardInterrupt):
        sys.__excepthook__(exc_type, exc_value, exc_traceback)
        return

    logging.critical("Exception", exc_info=(exc_type, exc_value, exc_traceback))
    logging.critical(
        "Unhandled Exception {0}: {1}".format(exc_type, exc_value),
        extra={"exception": "".join(traceback.format_tb(exc_traceback))},
    )


def str2bool(v):
    return v.lower() in ("yes", "true", "t", "1")


def signed_upload_put(bucket_name: str, s3_key: str, expires: int):
    logger = logging.getLogger()

    # Replace the following with your own values
    profile_name = os.environ['AWS_PROFILE']

    # Create a session with the specified profile
    session = Session(profile_name=profile_name)

    # Create an S3 client using the session
    s3 = session.client('s3')

    presigned_url = s3.generate_presigned_url(
        ClientMethod='put_object',
        Params={
            'Bucket': bucket_name,
            'Key': s3_key,
            'ContentType': "application/octet-stream",
        },
        ExpiresIn=expires,
    )

    logger.info({ "message": "presigned", "url": f"{presigned_url}"})

def signed_upload_post(bucket_name: str, s3_key: str, expires: int):
    logger = logging.getLogger()

    # Replace the following with your own values
    profile_name = os.environ['AWS_PROFILE']

    # Create a session with the specified profile
    session = Session(profile_name=profile_name)

    # Create an S3 client using the session
    s3 = session.client('s3')

    presigned_url = s3.generate_presigned_post(
        Bucket=bucket_name,
        Key=s3_key,
        Fields= {
        },
        Conditions=[
            #["starts-with", '$content-type', ""],
            #['content-length-range', 10000, 150000],
            #["starts-with", '$x-amz-checksum-sha256', ""],
        ],
        ExpiresIn=expires,
    )

    logger.info({ "message": "presigned", "url": f"{presigned_url}"})

    presigned_url['fields']['file'] = '@{key}'.format(key=s3_key)

    form_values = "\n    ".join(["-F {key}={value} \\".format(key=key, value=value)
                        for key, value in presigned_url['fields'].items()])
    
    curl = 'curl -v {form_values} \n    {url}'.format(form_values=form_values, url=presigned_url['url'])
    logger.info({ "message": "presigned", "curl": f"{curl}"})
    print(curl)

def main():
    with io.open(
        f"{os.path.dirname(os.path.realpath(__file__))}/logging_config.yaml"
    ) as f:
        logging_config = yaml.load(f, Loader=yaml.FullLoader)

    logging.config.dictConfig(logging_config)
    logger = logging.getLogger()

    sys.excepthook = log_uncaught_exceptions

    parser = argparse.ArgumentParser(description="AWS BOTO")
    parser.add_argument("--signed", dest="signed", action="store_true")
    parser.add_argument("--put", dest="put", action="store_true")
    parser.add_argument("--post", dest="post", action="store_true")
    parser.add_argument("--bucket", dest="bucket", type=str)
    parser.add_argument("--prefix", dest="prefix", type=str)
    parser.add_argument("--expires", dest="expires", type=int, default=3600)
    args = parser.parse_args()

    if args.signed:
        logger.info(f"Upload s3://{args.bucket}/{args.prefix}")
        if args.put:
            signed_upload_put(args.bucket, args.prefix, args.expires)
        elif args.post:
            signed_upload_post(args.bucket, args.prefix, args.expires)
        else:
            print("Need to specify --put or --post")
    else:
        parser.print_help()

if __name__ == "__main__":
    # print(f"Enter {__name__}")
    main()
    exit(0)
