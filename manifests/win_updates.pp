class windows_defaults::win_updates(
$update_dry_run = true, #Dry Run Variable
)
{
validate_bool($update_dry_run)
if $update_dry_run {
windows_updates::list {'All Windows Updates':
  ensure => 'present',
  dry_run => 'C:\\des_wuerd_er_installen.txt',
  name => '*'}
notify {"Updates wuerden nicht laufen":}
}
else {
notify {"Updates wuerden laufen":}
windows_updates::list {'All Windows Updates':
  ensure => 'present',
  name => '*'}
}
}

