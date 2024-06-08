OPENAI_API_KEY := $(shell echo $$OPENAI_API_KEY)

build:
	dotnet build ./assembllm-openai-csharp.csproj

release:
	dotnet publish ./assembllm-openai-csharp.csproj

test_build:
	extism call ./bin/Debug/net8.0/wasi-wasm/AppBundle/assembllm-openai-csharp.wasm models --input "world" --wasi --log-level info
	@extism call ./bin/Debug/net8.0/wasi-wasm/AppBundle/assembllm-openai-csharp.wasm completion --input "world" --wasi --allow-host "api.openai.com" --log-level info --set-config='{"api_key": "$(OPENAI_API_KEY)"}'

test_release:
	extism call ./bin/Release/net8.0/wasi-wasm/AppBundle/assembllm-openai-csharp.wasm models --input "world" --wasi --log-level info
	@extism call ./bin/Release/net8.0/wasi-wasm/AppBundle/assembllm-openai-csharp.wasm completion --input "world" --wasi --allow-host "api.openai.com" --log-level info --set-config='{"api_key": "$(OPENAI_API_KEY)"}'