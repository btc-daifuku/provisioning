# AWS provisioning

Teraformを用いる

## 構築手順

+ 1_network_storageを初期作成の後、個別サービスは個別にprovisioningする
+ 全て再構築の際は、prefixの順にprovisioningする
+ 個別サービスは以下でフォルダを作成し、provisioningfileを作成する
+ Route53 Hosted zoneのみ予め設定されている前提

```
mkdir [prefix[0-9]]_[サービス名]
cp conf/*tf [prefix[0-9]]_[サービス名]
```

## access_key / secret_key

terraform.tfvarsに記載

```
$ cat terraform.tfvars
access_key="[アクセスキー記載]"
secret_key="[シークレットキーを記載]"
```

## plan

```
terraform plan
```

use vars

```
terraform plan -var 'ssh_key_name=hirosue'
```

## apply

```
terraform apply
```

use vars

```
terraform apply -var 'ssh_key_name=hirosue'
```

## show

```
terraform show
```

## destory :boom:

```
terraform destory
```

use vars

```
terraform destroy -var 'ssh_key_name=hirosue'
```
