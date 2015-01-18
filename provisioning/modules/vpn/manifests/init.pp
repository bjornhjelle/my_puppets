class vpn {

  file { "/etc/openvpn":
    recurse => true,
    owner => "root",
    group => "root",
    source => "puppet:///modules/vpn/openvpn"
  } 
  
  notify {"Husk å endre passord i /etc/openvpn/userpass.txt":}
  
}
