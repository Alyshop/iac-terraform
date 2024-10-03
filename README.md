# iac-terraform

Instruções para executar o projeto

1 - Clonar o Repositório:

git clone https://github.com/Alyshop/iac-terraform.git
cd iac-terraform

2 - Configurar Credenciais AWS:
Certifique-se de que suas credenciais AWS estejam configuradas no seu ambiente.

3 - Inicializar o Terraform:
terraform init

4 - Criar um arquivo terraform.tfvars para as variáveis:
db_password = "sua-senha-segura"
s3_bucket_name = "nome-do-seu-bucket-unico"

5 - Executar o Terraform:
terraform apply


6 - Limpar a Infraestrutura:
terraform destroy