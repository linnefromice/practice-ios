.PHONY: lint format all

.DEFAULT_GOAL := all

lint:
	swift format lint -s --configuration .swift-format -r SampleRive
format:
	swift format format --configuration .swift-format -ipr SampleRive
all: lint format
