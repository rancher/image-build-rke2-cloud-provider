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
K3S_MINOR ?=

ifeq ($(TAG),)
ifeq ($(K3S_MINOR),)
K3S_MINOR := 1.34
endif
TAG := $(word 1,$(shell bash ./scripts/source.sh "$(K3S_MINOR)"))$(BUILD_META)
endif

K3S_SOURCE := $(shell bash ./scripts/source.sh "$(TAG)")
ifeq ($(word 2,$(K3S_SOURCE)),)
$(error Could not resolve TAG $(TAG) to a k3s source commit)
endif
K3S_MINOR := $(patsubst v%,%,$(firstword $(subst -r, ,$(word 1,$(K3S_SOURCE)))))
K3S_COMMIT ?= $(word 2,$(K3S_SOURCE))
ifneq ($(K3S_COMMIT),$(word 2,$(K3S_SOURCE)))
$(error K3S_COMMIT does not match the source pin for TAG $(TAG))
endif

REPO ?= rancher
IMAGE ?= $(REPO)/rke2-cloud-provider:$(TAG)

.PHONY: modsync
modsync:
	mkdir -p .cache/modsync
	bash ./scripts/modsync.sh "$(TAG)" "$(K3S_COMMIT)"

.PHONY: clean
clean:
	@if [ "$$(id -u)" -ne 0 ]; then \
		echo "clean removes generated workspaces; run 'sudo make clean'." >&2; \
		exit 1; \
	fi
	rm -rf -- .cache/modsync .cache/mod-sync


.PHONY: image-build
image-build:
	mkdir -p .cache/modsync
	docker buildx build \
		--platform=$(TARGET_PLATFORMS) \
		--load \
		--build-arg TAG=$(TAG) \
		--build-arg K3S_COMMIT=$(K3S_COMMIT) \
		--tag $(IMAGE) \
	.

.PHONY: push-image
push-image:
	mkdir -p .cache/modsync
	docker buildx build \
		$(IID_FILE_FLAG) \
		--sbom=true \
		--attest type=provenance,mode=max \
		--platform=$(TARGET_PLATFORMS) \
		--build-arg TAG=$(TAG) \
		--build-arg K3S_COMMIT=$(K3S_COMMIT) \
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
	@echo "K3S_MINOR=$(K3S_MINOR)"
	@echo "K3S_COMMIT=$(K3S_COMMIT)"
	@echo "REPO=$(REPO)"
	@echo "IMAGE=$(IMAGE)"
	@echo "BUILD_META=$(BUILD_META)"
	@echo "UNAME_M=$(UNAME_M)"
