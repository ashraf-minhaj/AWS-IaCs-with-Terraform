#! /bin/bash
sudo apt-get update
sudo apt-get install -y apache2
sudo systemctl start apache2
sudo systemctl enable apache2
IP=$(curl http://checkip.amazonaws.com)
echo "<center>The page was created automatically by  Ashraf Minhaj! IP $IP</center>" | sudo tee /var/www/html/index.html