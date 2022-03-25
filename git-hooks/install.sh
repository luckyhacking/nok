# 安装pre-commit服务
brew install pre-commit

# 生成.git/hooks/pre-commit文件
pre-commit install


# 生成.git/hooks/commit-msg文件
curl -kSL https://raw.githubusercontent.com/luckyhacking/nok/main/git-hooks/commit-msg.sh | sh 


# 新建配置文件，并写入
filename=".pre-commit-config.yaml"

cat>"${filename}"<<EOF
repos:
  - repo: 'https://github.com/pre-commit/pre-commit-hooks'
    rev: v4.1.0
    hooks:
      - id: check-yaml
      - id: end-of-file-fixer
      - id: trailing-whitespace
  - repo: 'https://github.com/golangci/golangci-lint'
    rev: v1.44.2
    hooks:
      - id: golangci-lint

  # [dnephin/pre-commit-golang: Golang hooks for pre-commit](https://github.com/dnephin/pre-commit-golang)
  - repo: 'https://github.com/dnephin/pre-commit-golang'
    rev: v0.5.0
    hooks:
      - id: go-fmt
      - id: go-vet
#      - id: go-lint
      - id: go-imports
#      - id: go-cyclo
#        args:
#          - '-over=15'
      - id: validate-toml
      - id: no-go-testing
      - id: golangci-lint
#      - id: go-critic
      - id: go-unit-tests
      - id: go-build
      - id: go-mod-tidy

  - repo: https://github.com/psf/black
    rev: 22.1.0
    hooks:
      - id: black
EOF

# 升级配置文件中工具版本
pre-commit autoupdate
