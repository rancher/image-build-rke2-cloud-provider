SEVERITIES = HIGH,CRITICAL

ifeq ($(TAG),)
TAG = dev
endif

.PHONY: all
all:
	docker build --build-arg TAG=$(TAG) -t rancher/rke2-cloud-provider:$(TAG) .

.PHONY: image-push
image-push:
	docker push rancher/rke2-cloud-provider:$(TAG) >> /dev/null

.PHONY: scan
image-scan:
	trivy --severity $(SEVERITIES) --no-progress --skip-update --ignore-unfixed rancher/rke2-cloud-provider:$(TAG)

.PHONY: image-manifest
image-manifest:
	docker image inspect rancher/rke2-cloud-provider:$(TAG)
	DOCKER_CLI_EXPERIMENTAL=enabled docker manifest create rancher/rke2-cloud-provider:$(TAG) \
		$(shell docker image inspect rancher/rke2-cloud-provider:$(TAG) | jq -r '.[] | .RepoDigests[0]')
