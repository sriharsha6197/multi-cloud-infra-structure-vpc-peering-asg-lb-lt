dev:
	rm -rf ./terraform
	
	terraform init --backend-config=dev-env/state.tfvars
	terraform plan -var-file=dev-env/input.tfvars
	terraform apply --auto-approve --var-file=dev-env/input.tfvars
dev-destroy:
	rm -rf ./terraform
	terraform init --backend-config=dev-env/state.tfvars
	terraform destroy --auto-approve --var-file=dev-env/input.tfvars