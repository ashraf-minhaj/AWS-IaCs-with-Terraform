#!/bin/bash
# Update the package list and install nginx

sudo yum update -y

sudo yum install nginx -y

# Create a basic HTML file
sudo tee /usr/share/nginx/html/index.html > /dev/null <<EOF
<!DOCTYPE html>
<html>
<head>
    <title>Welcome</title>
</head>
<body>
    <h1>Welcome to My Server</h1>
    <p>This content has been updated automatically using Terraform!</p>
</body>
</html>
EOF


# Start and enable nginx
sudo systemctl start nginx
sudo systemctl enable nginx