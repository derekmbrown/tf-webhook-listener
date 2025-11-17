TF_FOLDER=tf/

init:
	terraform -chdir=$(TF_FOLDER)$(ENV) init

plan:
	terraform -chdir=$(TF_FOLDER)$(ENV) plan

apply:
	terraform -chdir=$(TF_FOLDER)$(ENV) apply

apply_auto:
	terraform -chdir=$(TF_FOLDER)$(ENV) apply --auto-approve

destroy:
	terraform -chdir=$(TF_FOLDER)$(ENV) destroy

destroy_auto:
	terraform -chdir=$(TF_FOLDER)$(ENV) destroy  --auto-approve

test_api:
	sh scripts/test_api.sh $(ENV)

view_api_logs:
	sh scripts/view_api_logs.sh $(ENV)

view_function_logs:
	sh scripts/view_function_logs.sh $(ENV)