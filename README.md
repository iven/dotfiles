# 个人配置文件

## 安装方法

### macOS

```bash
$ brew install chezmoi
$ chezmoi init --apply --ssh iven
```

### Arch Linux

```bash
$ sudo pacman -S chezmoi
$ chezmoi init --apply --ssh iven
```

### 其他系统

```bash
$ cd /tmp && sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply --ssh iven
```
