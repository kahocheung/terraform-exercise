prefix = "test"

azs = ["eu-west-1a", "eu-west-1b"]

rds = {
	identifier = "test-db"
	instance_class = "db.t3.micro"
	major_engine_version = 5.7
	auto_minor_version_upgrade = true
	allocated_storage = 10
}

rds_username = "testuser"
rds_password = "testpassword"

ec3 = {
	min_size = 1
	max_size = 2
	desired_capacity = 1
}
