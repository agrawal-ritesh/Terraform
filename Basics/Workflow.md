Terraform WorkFlow. 


1. terraform init
> It initializes the code. 
>> Working: > Downloads the provider. (Azure, AWS, GCP)
            > Setups the Backend. (it stages the Storage)
            > Initialize Modules. 
    Basically, setting up the tools before starting the work. 


2. terraform plan
> Shows what terraform will do.
>> Working: > Compares the Code vs State vs Real infra. 
            > Generates the Execution plan. 
    A Blueprint for building.


3. terraform apply
> created an update the infrastructure.
>> Working: > Executes the plan. 
            > Creates resources.
            > Updates state file.
    Construction starts. 


4. terraform destroy
> Remove or delete the infrastructure.
     Demolishing the building.


[Write code -> init -> plan -> apply -> (repeat changes) -> destroy]

Basic commands.
terraform [init , plan , apply , destroy]

To ensure the same plan is applies and no manual error. 

terraform plan -out=plan.tfplan

terraform apply plan.tfplan



5. terraform validate 
> Check if terraform code is valid or not. 
>> Finds syntax error.

6. terraform fmt
> Formatting. 
>> Automatically formats the code.
>>> Makes the code clean and readable.