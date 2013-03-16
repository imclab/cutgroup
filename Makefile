STAGING_BUCKET    = s3://cutgroup-staging.smartchicagoapps.org/
PRODUCTION_BUCKET = s3://cutgroup.smartchicagoapps.org/

S3CMD = s3cmd -c .s3cfg \
	--acl-public \
	--no-delete-removed \
	--reduced-redundancy \
	--progress \
	--rexclude '\.git|s3cfg|Makefile|signups.json|.DS_Store' \
	sync ./

all: staging

deploy: minify
	$(S3CMD) $(PRODUCTION_BUCKET)

staging: minify
	$(S3CMD) $(STAGING_BUCKET)

minify:
	uglifyjs assets/js/main.js -c -o assets/js/main-min.js
