# Step 1: Install Nginx
sudo apt update
sudo apt install nginx

# Step 2: Create a Sample HTML Page
sudo vim /var/www/html/index.html

# Add your HTML content and save the file.

# Step 3: Configure Nginx
sudo vim /etc/nginx/sites-available/sample-site

# Inside the configuration file, add the Nginx server block configuration, and replace 'your-instance-IP' with your instance's IP address:
# server {
#     listen 80;
#     server_name your-instance-IP;

#     root /var/www/html;
#     index index.html;

#     access_log /var/log/nginx/sample-site-access.log;
#     error_log /var/log/nginx/sample-site-error.log;

#     location / {
#         try_files $uri $uri/ =404;
#     }
# }

# Save the configuration file and create a symbolic link:
# sudo ln -s /etc/nginx/sites-available/sample-site /etc/nginx/sites-enabled/

# Step 4: Create Log Files
sudo touch /var/log/nginx/sample-site-access.log
sudo touch /var/log/nginx/sample-site-error.log
sudo chmod 644 /var/log/nginx/sample-site-*.log

# Step 5: Test and Restart Nginx
sudo nginx -t
sudo service nginx restart

# Step 6: Install Netdata
bash <(curl -Ss https://my-netdata.io/kickstart.sh)

# Step 7: Create a Netdata Custom Log Configuration
sudo vim /etc/netdata/python.d/nginx_log.conf

# Inside the configuration file, add the Netdata custom log configuration to monitor Nginx access logs:
# localhost:
#     name: nginx_access
#     path: /var/log/nginx/sample-site-access.log
#     type: log
#     update_every: 10
#     dimensions:
#         log_file: sample-site-access
#     command: tail -n 0 -F
#     data_source: lines
#     family: log
#     value: log_rate
#     chart: nginx.access

# Save the configuration file.

# Step 8: Reload Netdata
sudo systemctl restart netdata

# The setup is complete. Replace placeholders like 'your-instance-IP' with your actual values.
