# Codex 配置

## model-catalog.local.json

为通过 LiteLLM Bedrock proxy 使用的 Claude 模型提供元数据，消除启动时的 "Model metadata not found" 警告。

在 `config.toml` 各 profile 中通过 `model_catalog_json = "~/.codex/model-catalog.local.json"` 引用。
