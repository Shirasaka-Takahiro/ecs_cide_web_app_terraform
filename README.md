README.md
■Set-Up
1. Create S3 for tfstate
2. Generate public and private key
3. Write resource's variables in terraform.tfvars

■Resources
<br />
Network
<br />
ECS Fargate
<br />
ACM
<br />
ALb x 1(HTTP & HTTPS Listener)
<br />
Route53
<br />
CodeStartConnections(GitHub)
<br />
CodeBuild
<br />
CodeDeploy
<br />
CodePipeline
<br />
CloudWatch
<br />

■Caution
Need to edit nginx conf depending on a developing environment
<br />
1. Use localhost:9000 on ECS on Fargate
2. Use fastcgi_pass app01:9000 on docker-compose

■Deploy
1. Move to direstory
2. terraform init
3. terraform plan
4. terraform apply
5. Connect Codepipeline to GitHub on AWS console
6. Re-deploy Codepipeline