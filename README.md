## Login information
Login to the bastion server (34.253.192.154):
User: ec2-user

The Bastion host should already have the permissions set to complete this exercise below.
You can copy the exercise to your local machine to do the exercise.
To test and provision the resources in AWS. The AWS keys are provided in /home/ec2-user/aws-keys.txt

## Exercise
The exercise is split in to 2 parts. The first part is to complete the VPC setup and the second part of the exercise is also to complete the setup application stack to successfully deploy this sample PHP application inside the VPC that was created in the first part of the exercise.

Take a look at the configurations and run a plan to figure out what has already been setup and what needs to be fixed or added in order to get things working.

# VPC Setup
1. Complete the VPC setup from terraform-exercise/vpc.
   a. Setup a VPC in eu-west-1 across 2 AZs 1a and 1b named "test-vpc"
      VPC network CIDR 172.30.0.0/24
   b. Split 172.30.0.0/24 into 4 subnets - 2 private and 2 public.
      Tag the subnets with accessible = "private" or accessible = "public".

# Application Setup
Exercise found in terraform-exercise/application
This part of the exercise is deploying a simple PHP application to an EC2 instance and using RDS as the DB Storage.
All the security groups have already been setup

1. Setup EC2 instance in an Autoscaling group - type t3.mirco with 8GB of disk storage.
   Min 1, Desired 1 and Max 2 instances across 2 AZs.

   This stack should be build in the "test-vpc" VPC (which was created earlier):
   - Using Amazon Linux 2 AMI - ami-0bf84c42e04519c85 (or latest)
   - The instance should also be configured with a security group that allows the following access:
	 - Your IP - SSH
	 - Access from Loadbalancer - HTTP
   - Configure the instance to install the relevant packages to run a web server and also mysql client.
     - apache2 or httpd24
     - php7.2 or php72 (pdo, mysqlnd)
     - mycli or mysql57 - client
   - The application installation is defined in user-data stored in templates/test-cloud-init.tpl.
   - For the application setup, we'll need the application to connect to the RDS Instance with these env vars set:
     - RDS_DB_NAME
     - RDS_USERNAME
     - RDS_PASSWORD
     - RDS_HOSTNAME
   - Install Composer
     - ```export COMPOSER_HOME=/usr/lib/composer```
     - ``` curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer```
   - And the following ran to deploy the schema:
     - ```CREATE TABLE IF NOT EXISTS urler(id INT UNSIGNED NOT NULL AUTO_INCREMENT, author VARCHAR(63) NOT NULL, message TEXT, PRIMARY KEY (id))```
   - Run Composer and start the web service
2. Configure an ALB loadbalancer listening on port 80 and forwarding the requests to the ec2 instance.
   - Permit HTTP traffic from all.
3.  Setup an RDS Mysql 5.7 instance with min 5GB of disk storage and access from the ec2 instance on port 3306.
    The RDS instance should only be privately accessible from with the "test" VPC
	- You can use the default MySQL 5.7 parameter and option groups.
	  `default.mysql5.7`

And the following ran to deploy the schema:
```CREATE TABLE IF NOT EXISTS urler(id INT UNSIGNED NOT NULL AUTO_INCREMENT, author VARCHAR(63) NOT NULL, message TEXT, PRIMARY KEY (id))```

Finally once the application is running, verify access to the application.

If you get stuck at any point, you may log in to the console to verify anything.
Also feel free to use any online docs to help with this exercise

# AWS Console
https://zavamed-engineering-interviews.signin.aws.amazon.com/console
