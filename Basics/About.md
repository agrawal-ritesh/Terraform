 #                                                Terraform
### Infrastructure as Code
1. Your Cloud Setup written in Code.
2. Same Setup can be reused anytime. 
3. No manual mistakes. 


=============================
- About:

1. Providers. 
> Plugins that allows terraform to talk to cloud services.

2. Resources. 
> Blocks to create a resource using Terraform.
-> To create a resource group or virtual machine or networks.

3. Variables. 
> Inputs that allows the customization which changing the actual code.
>> ExampleL: Think of Pizza.
   >>>{Base is same, Cheese is same, Cooking method is same.} -> Actual Code.
           {Size, Toppings, Spice level} -> Variables. 

4. Locals.
> These are the variables, but used inside the code only. 

[
Difference: 
Variables -> Input from Users. 
Locals -> Internal calculation.
]

5. Output.
> Its show the results of what is created. 

6. Modules. 
> A reusable block of terraform. 
>> Example: Think of a gated society. 
{You create a blue print for 1 flat in society.} -> Module created
{ You use the same blue print as copy paste for next 50 flats.} -> Module Reused.

7. Remote Backend. 
> A  place where terraform stores its .tfstate file remotely instead of local machine. 
>> Example: AWS S3, Azure Storage, Terraform cloud. 
{Notebook vs Goodle Docs}

8. Locking. 
> A mechanism that prevents multiple people from running the terraform apply at same time. [It helps in avoiding the infrastructe conflicts]
>> In Azure, we have a built in locking mechanism if backend file is store in Azure blob. 
{Blob leases automatically locked the terraform state file, if 1 person is running the terrafrom apply}
>>> Example: Bathroom Lock. 
{You lock the door, others cannot enter. Once you come out, the door is unlocked}

++ We can use DynamoDB locking if want something to be done externally. 

9. State
> A file that keeps track of the infrastructure.
> Tells what you want vs. what exists.


10. Drift.
> It happens when your real infrastruce is changed manually, outside terraform. 
>> Example:
{You create a VM with size D4s_V5 using terraform code.
Somone from the team, manually from Azure portal changed the VM size to D16s_v4.}
--> This makes the Drift. 

>>> How to detect the Drift. 
       Run the command. -> terraform plan

    This command will compare the Code vs State vs Real Infra.

    output -> VM_size: D16s_v4 > D4s_V5

+    When you run terraform apply,
    the terrafrom will revert the infra back to D4s_V5

That means terraform always try to make real infra match your code. 

