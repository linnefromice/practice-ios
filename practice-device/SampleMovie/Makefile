.PHONY: lint format all

.DEFAULT_GOAL := all

lint:
	swift format lint -s --configuration .swift-format -r SampleMovie
format:
	swift format format --configuration .swift-format -ipr SampleMovie
all: lint format
