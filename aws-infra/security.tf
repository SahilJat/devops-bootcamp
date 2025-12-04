# --- 1. WEB SERVER SECURITY GROUP (The Shell) ---
resource "aws_security_group" "web_sg" {
  name        = "web-server-sg"
  description = "Allow HTTP and SSH"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "web-sg"
  }
}

# --- WEB RULES (The Logic) ---

# Allow HTTP (Port 80) from Anywhere
resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.web_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

# Allow SSH (Port 22) from Anywhere
resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.web_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

# Allow All Outbound Traffic (So server can run apt update)
resource "aws_vpc_security_group_egress_rule" "allow_all_outbound" {
  security_group_id = aws_security_group.web_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # -1 means "All Protocols"
}


# --- 2. DATABASE SECURITY GROUP (The Shell) ---
resource "aws_security_group" "db_sg" {
  name        = "db-server-sg"
  description = "Allow traffic only from Web Server"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "db-sg"
  }
}

# --- DATABASE RULES (The Logic) ---

# Allow Postgres (5432) ONLY from Web Security Group
# Note: We use 'referenced_security_group_id', not 'cidr_ipv4'
resource "aws_vpc_security_group_ingress_rule" "allow_postgres_from_web" {
  security_group_id            = aws_security_group.db_sg.id
  referenced_security_group_id = aws_security_group.web_sg.id
  from_port                    = 5432
  ip_protocol                  = "tcp"
  to_port                      = 5432
}

# Allow DB to talk to itself (Internal Outbound)
resource "aws_vpc_security_group_egress_rule" "allow_db_outbound" {
  security_group_id = aws_security_group.db_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}