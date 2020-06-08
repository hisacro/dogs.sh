<?php
$IMG_COUNT=20000;
$PATH=$_SERVER['REQUEST_URI'];
$SIZE=23; //DEFAULT
$SLIDESHOW=0; //DEFAULT
$HELP=0; //DEFAULT
switch ($PATH){
        case "/xs": $SIZE=14; break;
        case "/s": $SIZE=23; break;
        case "/m": $SIZE=36; break;
        case "/l": $SIZE=54; break;
        case "/xl": $SIZE=65; break;
        case "/?": $HELP=1; break;
        case "/help": $HELP=1; break;
        case "/": break;
        default: echo "Invalid URL"; exit;
}
putenv("TERM=xterm-256color");
$useragent = $_SERVER ['HTTP_USER_AGENT'];
if (strpos($useragent, 'curl') !== false) {
        if($HELP == 1){
                echo "        _                       _     \n";
                echo "       | |                     | |        __  \n";
                echo "     __| | ___   __ _ ___   ___| |__   o-''|\_____/)\n";
                echo "    / _` |/ _ \ / _` / __| / __| '_ \   \_/|_)     )\n";
                echo "   | (_| | (_) | (_| \__ \_\__ \ | | |     \  __  /\n";
                echo "    \__,_|\___/ \__, |___(_)___/_| |_|     (_/ (_/\n";
                echo "                 __/ |                \n";
                echo "                |___/    github.com/fortwire/dogs.sh \n";
                echo "\nUsage:\n";
                echo " $ curl dogs.sh\n";
                echo " $ curl dogs.sh/{SIZE}       (xs, s, m, l, xl)\n";
                echo " $ curl dogs.sh/?            (help)\n";
                echo "\nExamples:\n";
                echo " $ curl dogs.sh/m            (medium)\n";
                echo " $ curl dogs.sh/xl           (extra large - try fullscreen with F11)\n\n";
                exit;
                }
        } else {
                echo "<body style='background-color:black; color:white;'>";
                echo "<pre>        _                       _     \n";
                echo "       | |                     | |        __  \n";
                echo "     __| | ___   __ _ ___   ___| |__   o-''|\_____/)\n";
                echo "    / _` |/ _ \ / _` / __| / __| '_ \   \_/|_)     )<br>";
                echo "   | (_| | (_) | (_| \__ \_\__ \ | | |     \  __  /<br>";
                echo "    \__,_|\___/ \__, |___(_)___/_| |_|     (_/ (_/<br>";
                echo "                 __/ |                <br>";
                echo "                |___/    github.com/fortwire/dogs.sh<br></pre>";
                echo "<pre style='font-size: 80%; font-family:Courier New,Courier,Lucida Sans Typewriter,Lucida Typewriter,monospace;'>";
                echo "<br><b>Usage:</b><br>";
                echo " $ curl dogs.sh<br>";
                echo " $ curl dogs.sh/{SIZE}       (xs, s, m, l, xl)<br>";
                echo " $ curl dogs.sh/?            (help)<br>";
                echo "<br><b>Examples:</b><br>";
                echo " $ curl dogs.sh/m            (medium)<br>";
                echo " $ curl dogs.sh/xl           (extra large - try fullscreen with F11)<br><br>";
                echo "</pre>";
                echo "</body>";
                exit;
        }
        $RAN = rand(1, $IMG_COUNT);
        $ASCII = shell_exec("cat /var/www/Images/$SIZE/$RAN");
        echo $ASCII;
?>
