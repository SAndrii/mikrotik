# Mikrotik RB912 + Huawei EM770W HSPDA module
#
# https://forum.mikrotik.com/viewtopic.php?t=69807
#
# If status ppp-out2 not connected then check three times with delay 10s, try to reset modem inputted in mini-PCIe slot, typing AT command
#
# Type your interface name and usb port below
:local PPPInter "ppp-out2";
:local PortUsb "usb4"
:local count 0;
:log warning "Starting check modem script";

:while ( $count < 3 )  do={ 
   /interface ppp-client monitor $PPPInter once do={:if ($status != "connected") do= {:set count ($count+1); :log warning  "PPP $PPPInter Link Down (#$count)"; :delay 10; } else={ :set count 4; } };
}
:if ( $count > 0 && $count < 4 ) do={ 
   :log warning "PPP Link Down, Resetting modem";
   /interface disable $PPPInter;
   /interface ppp-client add name="modem_reset" dial-on-demand=no port=$PortUsb modem-init="AT+CFUN=1,1" null-modem=no disabled=no
   :delay 2
   /interface ppp-client remove [/interface ppp-client find name="modem_reset"]
   /interface enable $PPPInter;
}
:if ( $count = 4 ) do={ 
   :log warning "Check modem script stop";
}
