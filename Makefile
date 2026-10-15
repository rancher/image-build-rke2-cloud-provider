SEVERITIES = HIGH,CRITICAL

UNAME_M = $(shell uname -m)
ifndef TARGET_PLATFORMS
	ifeq ($(UNAME_M), x86_64)
		TARGET_PLATFORMS:=linux/amd64
	else ifeq ($(UNAME_M), aarch64)
		TARGET_PLATFORMS:=linux/arm64
	else 
		TARGET_PLATFORMS:=linux/$(UNAME_M)
	endif
endif

BUILD_META=-build$(shell date +%Y%m%d)
TAG ?= ${GITHUB_ACTION_TAG}

ifeq ($(TAG),)
TAG := v1.34.12$(BUILD_META)
endif

ifeq (,$(filter %$(BUILD_META),$(TAG)))
$(error TAG $(TAG) needs to end with build metadata: $(BUILD_META))
endif

REPO ?= rancher
IMAGE ?= $(REPO)/rke2-cloud-provider:$(TAG)


.PHONY: image-build
image-build:
	docker buildx build \
		--platform=$(TARGET_PLATFORMS) \
		--load \
		--build-arg TAG=$(TAG) \
		--tag $(IMAGE) \
	.

.PHONY: push-image
push-image:
	docker buildx build \
		$(IID_FILE_FLAG) \
		--sbom=true \
		--attest type=provenance,mode=max \
		--platform=$(TARGET_PLATFORMS) \
		--build-arg TAG=$(TAG) \
		--tag $(IMAGE) \
		--push \
		.

.PHONY: image-scan
image-scan:
	trivy image --severity $(SEVERITIES) --no-progress --skip-db-update --ignore-unfixed $(IMAGE)

PHONY: log
log:
	@echo "TARGET_PLATFORMS=$(TARGET_PLATFORMS)"
	@echo "TAG=$(TAG)"
	@echo "REPO=$(REPO)"
	@echo "IMAGE=$(IMAGE)"
	@echo "BUILD_META=$(BUILD_META)"
	@echo "UNAME_M=$(UNAME_M)"
