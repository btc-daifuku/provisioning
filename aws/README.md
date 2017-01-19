# AWS provisioning

Teraformを用いる

## plan

```
terraform plan -var-file=secret.tfvars
```

## apply

```
terraform apply -var-file=secret.tfvars
```

## destory

```
terraform plan -destroy -out=terraform.tfstate -var-file=secret.tfvars
terraform apply terraform.tfstate
```
