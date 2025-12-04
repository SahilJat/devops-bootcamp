# 1. Create a "Subnet Group"
# RDS needs to know which subnets it is allowed to live in.
resource "aws_db_subnet_group" "default" {
  name       = "main-subnet-group"
  subnet_ids = [aws_subnet.private.id, aws_subnet.private_b.id] 
  # Note: AWS requires at least 2 subnets for High Availability, 
  # even if we only put the DB in one.

  tags = {
    Name = "My DB Subnet Group"
  }
}

# 2. The Database Itself
resource "aws_db_instance" "default" {
  allocated_storage    = 10
  db_name              = "mydb"
  engine               = "postgres"
  engine_version       = "16.9"
  instance_class       = "db.t3.micro"
  username             = "adminuser"
  password             = "mypassword123" # In real life, use Secrets Manager!
  parameter_group_name = "default.postgres16"
  skip_final_snapshot  = true  # Don't backup when destroying (Faster for labs)
  publicly_accessible  = false # SECURITY: No public IP!
  
  # Network Config
  vpc_security_group_ids = [aws_security_group.db_sg.id]
  db_subnet_group_name   = aws_db_subnet_group.default.name
}

# 3. Output the Connection Endpoint
output "db_endpoint" {
  value = aws_db_instance.default.endpoint
}
