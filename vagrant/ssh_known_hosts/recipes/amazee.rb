# Adding the default hosts where we usually connect to make drush deploy work out of the box
%w[ github.com, amazeeweb1.nine.ch, amazeeweb2.nine.ch, amazeeweb3.nine.ch, amazeeweb4.nine.ch, amazeeweb5.nine.ch, amazeeweb6.nine.ch, amazeedev1.nine.ch, amazeedev2.nine.ch ].each do |host|
  ssh_known_hosts_entry "#{host}"
end
