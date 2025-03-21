.PHONY: lint format all

.DEFAULT_GOAL := all

lint:
	swift format lint -s --configuration .swift-format -r Sources
format:
	swift format format --configuration .swift-format -ipr Sources
all: format lint