class windows_defaults::disable_fw{
  exec{ 'FirewallOff':
  command => 'netsh advfirewall set allprofiles state off',
  unless => 'netsh advfirewall show allprofiles state | findstr OFF > NUL',
  path => $::path,
  }
}