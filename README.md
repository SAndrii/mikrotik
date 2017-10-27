# Mikrotik check mini-PCIe slot 3G modem
# Run script every hour:
/system scheduler add name="modem_3G_check_status" start-time="06:10:00" interval="1h" on-event={ /system script run modem_3G_check_status } policy="read,write,test,policy"

# Also useful practice is to reboot device
/system scheduler add name="reboot" start-time="06:00:00" interval="1d" on-event={ /system reboot } policy="read,write,test,policy,reboot"