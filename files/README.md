# Nix 配置文件

## 安装步骤

1. 参考 [官方文档](https://nixos.org/manual/nix/stable/installation/installing-binary.html) 安装 Nix。
2. 执行以下命令切换到配置，其中 `<profile>` 为配置名：

    ```bash
    $ nix build --no-link '.#homeConfigurations.<profile>.activationPackage'
    $ "$(nix path-info '.#homeConfigurations.<profile>.activationPackage')"/activate
    ```
3. 如果上步报 same priority 错误，执行以下命令再试：

    ```bash
    $ nix-env --set-flag priority 4 nix
    ```

4. 以后每次更新后执行以下命令即可：

    ```bash
    $ home-manager switch --flake '.#<profile>'
    ```
