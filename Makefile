SEVERITIES = HIGH,CRITICAL

UNAME_M = $(shell uname -m)
ARCH=
ifeq ($(UNAME_M), x86_64)
	ARCH=amd64
else ifeq ($(UNAME_M), aarch64)
	ARCH=arm64
else 
	ARCH=$(UNAME_M)
endif

BUILD_META=-build$(shell date +%Y%m%d)
ORG ?= rancher
TAG ?= dev$(BUILD_META)

ifeq (,$(filter %$(BUILD_META),$(TAG)))
$(error TAG $(TAG) needs to end with build metadata: $(BUILD_META))
endif

.PHONY: image-build
image-build:
	docker buildx build \
		--pull \
		--platform=$(ARCH) \
		--load \
		--build-arg TAG=$(TAG) \
		--build-arg ARCH=$(ARCH) \
		-t $(ORG)/rke2-cloud-provider:$(TAG)-$(ARCH) \
	.

.PHONY: image-push
image-push:
	docker push $(ORG)/rke2-cloud-provider:$(TAG)-$(ARCH) >> /dev/null

.PHONY: image-scan
image-scan:
	trivy image --severity $(SEVERITIES) --no-progress --skip-db-update --ignore-unfixed $(ORG)/rke2-cloud-provider:$(TAG)-$(ARCH)

.PHONY: image-manifest
image-manifest:
	DOCKER_CLI_EXPERIMENTAL=enabled docker manifest create --amend \
		$(ORG)/rke2-cloud-provider:$(TAG) \
		$(ORG)/rke2-cloud-provider:$(TAG)-$(ARCH)
	DOCKER_CLI_EXPERIMENTAL=enabled docker manifest push \
		$(ORG)/rke2-cloud-provider:$(TAG)

PHONY: log
log:
	@echo "ARCH=$(ARCH)"
	@echo "TAG=$(TAG)"
	@echo "ORG=$(ORG)"
	@echo "PKG=$(PKG)"
	@echo "SRC=$(SRC)"
	@echo "BUILD_META=$(BUILD_META)"
	@echo "UNAME_M=$(UNAME_M)"
