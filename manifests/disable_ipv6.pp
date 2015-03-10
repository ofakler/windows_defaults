class windows_defaults::disable_ipv6 (
  $ipv6_disable = false,  # ipv6 enabled by default
  $ipv6_reboot  = false,  # do not reboot by default
) {

# Validate ipv6 class
validate_bool($ipv6_disable)
validate_bool($ipv6_reboot)

# IPv6 logic (IPv6 enabled = 0, IPv6 disabled = 1)
if $ipv6_disable {
  $ipv6_setting = '0xFFFFFFFF'
}else{
  $ipv6_setting = '0x0'
}

# Modify the IPv6 registry key
registry::value { 'ipv6':
  key   => 'HKLM\System\CurrentControlSet\Services\Tcpip6\Parameters',
  value => 'DisabledComponents',
  type  => 'dword',
  data  => $ipv6_setting,
}

if $ipv6_reboot {
# Monitor for changes to ipv6 registry to determine whether a system restart is required
reboot { 'after':
 subscribe => registry::value['ipv6'],
 }
 }
 else{
## Create puppet log message that they system was not restart during run and requires a restart to apply settings
#notify {'ipv6rebootmessage':
#name    => 'ipv6 reboot message',
#message => 'The ipv6 settings will be applied after the next system restart',
#}
  }
}

