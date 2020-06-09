# Curl A Dog

<pre>
<br>
       | |                     | |        __  
     __| | ___   __ _ ___   ___| |__   o-''|\_____/)
    / _` |/ _ \ / _` / __| / __| '_ \   \_/|_)     )
   | (_| | (_) | (_| \__ \_\__ \ | | |     \  __  /
    \__,_|\___/ \__, |___(_)___/_| |_|     (_/ (_/
                 __/ |                
                |___/                 

Usage:
 $ curl dogs.sh
 $ curl dogs.sh/{SIZE}      (xs, s, m, l, xl)
 $ curl dogs.sh/?           (help)

Examples:
 $ curl dogs.sh/m           (medium)
 $ curl dogs.sh/xl          (extra large - try fullscreen with F11)

</pre>

## Make your own
1. Start 20.04 Ubuntu Server. Digital Ocean is a simple option for this.

2. Run Install Script

       wget https://raw.githubusercontent.com/fortwire/dogs.sh/master/install.sh
       sudo chmod 755 install.sh
       sudo ./install.sh
       
3. Optional - Custom Domain, Enable SSL, Auto-renewal and Metrics

       # 1 - Custom Domain
              # In your DNS Manager. Create A Record > Server IP and CNAME Record > @
       # 2 - Enable SSL
              # In Cerbot, choose to not redirect http to https, so can curl within https:// in cli
              sudo apt install certbot python3-certbot-apache
              sudo certbot --apache -d dogs.sh -d www.dogs.sh
              echo "renew_hook = systemctl reload rabbitmq" >> /etc/letsencrypt/renewal/dogs.sh.conf
              sudo certbot renew --dry-run
       # 3 - Digital Ocean Metrics
              curl -sSL https://repos.insights.digitalocean.com/install.sh | sudo bash
       
4. Optional - Awesome Fullscreen Slide Show

       # Press F11 on terminal then copy & paste the below command into the terminal
       while : ;do curl dogs.sh/xl && sleep 10; done
      
## Acknowledgements

Christian Stigen Larsen for jp2a tool - https://csl.name/jp2a/ <br>
Standford University Dog Image Dataset - http://vision.stanford.edu/aditya86/ImageNetDogs/



