CONX=$(sudo nmcli -t -f GENERAL.CONNECTION --mode tabular device show $DEVICE | head -1)
sudo nmcli -f connection.metered connection show $CONX
sudo nmcli connection modify $CONX connection.metered no
sudo nmcli -f connection.metered connection show $CONX
