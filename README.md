# cloud-resume-challenge-tf
Rebuilding using terraform for backend and integrating circleci / storing state in terraform cloud



<h2>Description</h2>

I decided to rebuild the backend using Terraform and integrate a CI/CD pipeline using CircleCI.  Terraform State backend is stored in Terraform Cloud.  I re-used the circleci config.yml file from Hashicorp's learn circleci lab as a basic template.

<br />





<h2>Languages and Utilities Used</h2>



- <b>Terraform</b> 

- <b>CircleCI</b>



<h2>Environments Used </h2>



- <b>Ubuntu</b> (22.04)



<h2>CircleCI example</h2>

push a git commit and circleCI will build a tf plan and hold.  Once approved, it will apply the tf plan, build the tf destroy plan and hold here.

<br> </br>

![gitpush](https://user-images.githubusercontent.com/85902399/210657959-507d1862-f7b8-459f-8750-d4e55b9197a2.png)

![circle](https://user-images.githubusercontent.com/85902399/210658157-08b9fa63-37d5-400c-882c-7cc4f3d5b3d4.png)

<br> </br>
<br> </br>


- Validated resources are built in aws web client

<br> </br>
<br> </br>
![dynamodb](https://user-images.githubusercontent.com/85902399/210658757-75e65bba-d386-4179-a142-fe27db63ba22.png)

<br> </br>
<br> </br>

- Validated TF State is updated and versioned on Terraform Cloud.




![tfstate](https://user-images.githubusercontent.com/85902399/210658423-1c62612c-4cdd-4d5c-8202-cd40f629dc29.png)



- Validated CircleCI apply job


- ![circlecivalid](https://user-images.githubusercontent.com/85902399/211437788-59b9ad5e-8886-4ed9-84a9-3c77baacca2f.png)




