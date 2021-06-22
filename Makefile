SEVERITIES = HIGH,CRITICAL

ifeq ($(ARCH),)
ARCH=$(shell go env GOARCH)
endif

BUILD_META=-build$(shell date +%Y%m%d)
ORG ?= rancher
TAG ?= dev$(BUILD_META)

ifneq ($(DRONE_TAG),)
TAG := $(DRONE_TAG)
endif

ifeq (,$(filter %$(BUILD_META),$(TAG)))
$(error TAG needs to end with build metadata: $(BUILD_META))
endif

.PHONY: all
all:
	docker build \
		--pull \
		--build-arg TAG=$(TAG) \
		-t $(ORG)/rke2-cloud-provider:$(TAG)-$(ARCH) \
	.

.PHONY: image-push
image-push:
	docker push $(ORG)/rke2-cloud-provider:$(TAG)-$(ARCH) >> /dev/null

.PHONY: image-scan
image-scan:
	trivy --severity $(SEVERITIES) --no-progress --skip-update --ignore-unfixed $(ORG)/rke2-cloud-provider:$(TAG)-$(ARCH)

.PHONY: image-manifest
image-manifest:
	DOCKER_CLI_EXPERIMENTAL=enabled docker manifest create --amend \
    	$(ORG)/rke2-cloud-provider:$(TAG) \
    	$(ORG)/rke2-cloud-provider:$(TAG)-$(ARCH)
    DOCKER_CLI_EXPERIMENTAL=enabled docker manifest push \
    	$(ORG)/rke2-cloud-provider:$(TAG)