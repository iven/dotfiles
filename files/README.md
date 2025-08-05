# Devbox 配置

## 安装步骤

1. 参考 [官方文档](https://www.jetify.com/docs/devbox/installing_devbox/) 安装 Devbox。
2. 执行以下命令安装全局二进制文件：

    ```bash
    $ devbox global install
    ```

## 清理存储

```bash
$ nix-store --gc
$ nix-collect-garbage --delete-old
```
