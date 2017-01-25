# AWS provisioning

Teraformを用いる

## 構築手順

+ 1_network_storageを初期作成の後、個別サービスは個別にprovisioningする
+ 全て再構築の際は、prefixの順にprovisioningする
+ 個別サービスは以下でフォルダを作成し、provisioningfileを作成する

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

### when required vars

```
terraform plan \
 -var 'ssh_key_name=hirosue' \
 -var 'security_group_public=sg-8d8019ea' \
 -var 'public_subnet_1=subnet-9df09aeb' \
 -var 'public_subnet_2=subnet-10962548'
```

## apply

```
terraform apply
```

### when required vars

```
terraform apply \
 -var 'ssh_key_name=hirosue' \
 -var 'security_group_public=sg-cc63fbab' \
 -var 'public_subnet_1=subnet-c3a7d2b5' \
 -var 'public_subnet_2=subnet-e0fe4cb8'
```

## show

```
terraform show
```

## destory

```
terraform plan -destroy -out=terraform.tfstate
pwd
```
