
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical (The owners of Ubuntu)

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}


resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro" # Free tier!

  
  subnet_id = aws_subnet.public.id

  
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  key_name = aws_key_pair.deployer.key_name
  
  associate_public_ip_address = true

  
  user_data = <<-EOF
              #!/bin/bash
              # 1. Update & Install Dependencies
              apt-get update
              apt-get install -y ca-certificates curl gnupg lsb-release

              # 2. Add Docker's Official GPG Key
              mkdir -m 0755 -p /etc/apt/keyrings
              curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg

              # 3. Set up the Repository
              echo \
                "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
                $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

              # 4. Install Docker Engine
              apt-get update
              apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

              # 5. Add 'ubuntu' user to docker group
              usermod -aG docker ubuntu

              # 6. Launch the App (The Magic Move)
              # We run it on port 3000, and Nginx will proxy to it.
              docker run -d -p 3000:3000 --restart always mashidodevelop/devops-bootcamp:latest

              # 7. Install & Configure Nginx (Reverse Proxy)
              apt-get install -y nginx
              
              # Write the Reverse Proxy Config directly
              cat <<EOT > /etc/nginx/sites-available/default
              server {
                  listen 80;
                  location / {
                      proxy_pass http://localhost:3000;
                      proxy_http_version 1.1;
                      proxy_set_header Upgrade \$http_upgrade;
                      proxy_set_header Connection 'upgrade';
                      proxy_set_header Host \$host;
                      proxy_cache_bypass \$http_upgrade;
                  }
              }
              EOT

              # Restart Nginx to apply changes
              systemctl restart nginx
              EOF

  tags = {
    Name = "Terraform-Web-Server"  }
}


output "server_public_ip" {
  value = aws_instance.web.public_ip
}
