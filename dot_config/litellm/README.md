# LiteLLM Bedrock Proxy

将 AWS Bedrock Claude 模型暴露为 OpenAI 兼容接口，供 Codex 使用。

## 依赖

```bash
uv tool install litellm
```

AWS credentials 需配置好 `~/.aws/credentials`，确保有 `bedrock:InvokeModel` 权限。

## 首次启动

```bash
pm2 start ~/.local/bin/litellm \
  --name litellm-bedrock \
  --interpreter ~/.local/share/uv/tools/litellm/bin/python \
  -- --config ~/.config/litellm/bedrock.yaml --port 4001
pm2 save
```

## 日常使用

```bash
pm2 restart litellm-bedrock
```

## 在 Codex 中使用

`~/.codex/config.toml` 已配置好 `litellm-bedrock` provider，通过 profile 切换模型：

```bash
codex -p claude-sonnet   # 默认
codex -p claude-opus
codex -p claude-haiku
```

## 注意

`drop_client_metadata.py` 是一个 litellm callback，用于过滤 Codex 发送的 `client_metadata` 字段（Bedrock Converse API 不支持该字段）。升级 litellm 后无需额外操作，callback 会自动生效。
