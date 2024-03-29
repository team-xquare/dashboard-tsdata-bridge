## This is a self-documented Makefile. For usage information, run `make help`:
##
## For more information, refer to https://suva.sh/posts/well-documented-makefiles/

WIRE_TAGS = "oss"

-include local/Makefile
include .bingo/Variables.mk

GO = go
GO_FILES ?= ./pkg/...
SH_FILES ?= $(shell find ./scripts -name *.sh)
GO_BUILD_FLAGS += $(if $(GO_BUILD_DEV),-dev)
GO_BUILD_FLAGS += $(if $(GO_BUILD_TAGS),-build-tags=$(GO_BUILD_TAGS))

targets := $(shell echo '$(sources)' | tr "," " ")

$(NGALERT_SPEC_TARGET):
	+$(MAKE) -C pkg/services/ngalert/api/tooling api.json

gen: $(WIRE)
	@echo "generate go files"
	$(WIRE) gen -tags $(WIRE_TAGS) ./pkg/server

build: ## Build all Go binaries.
	@echo "build go files"
	$(GO) build -o project $(GO_BUILD_FLAGS)