/*
1. terraform init
   
This command is used to initiate the working directory which contains terraform configuration file.
This command also install the plugins required by provider.
This command will also create the dependency lock file.
This is the first command that needs to be run. 


2. terraform plan -out testing.tfplan

This command will create a execution plan. 
This command helps you to view the changes that terrform is going to make.
This command helps to speficy to save the generated file to disk.


3. terraform apply

This command will execute/take the actions within terraform plan.


4. terraform apply testing.tfplan

This command create the plan for particular terraform file which is been executed recently.
#if you use "terraform apply" only, it creates the whole plan again for execution.


5. terraformm destroy

This command will delete all the resources created usning terraform/ 




*/