# Curl A Dog - Dogs.sh

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
       chmod 755 install.sh
       ./install.sh
       
3. Optional - Custom Domain & Enable SSL

       # 1 - In your DNS Manager. Create A Record > Server IP and CNAME Record > @
       # 2 - In Cerbot, choose to not redirect http to https, so can curl within https:// in cli
       apt install certbot
       sudo certbot certonly --webroot
       certbot --apache -d example.com -d www.example.com
       
4. Optional - Awesome Fullscreen Slide Show

       # Press F11 on terminal then copy & paste the below command into the terminal
       while : ;do curl dogs.sh/xl && sleep 5; done
      
## Acknowledgements

Christian Stigen Larsen for jp2a tool - https://csl.name/jp2a/ <br>
Standford University Dog Image Dataset - http://vision.stanford.edu/aditya86/ImageNetDogs/



