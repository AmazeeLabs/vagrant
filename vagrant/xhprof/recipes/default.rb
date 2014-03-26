# install xhprof
php_pear "xhprof" do
    preferred_state "beta"
    action :install
end

directory "/opt/xhprof" do
    owner "vagrant"
    group "vagrant"
    mode 0755
    action :create
end


ssh_known_hosts_entry 'github.com'
git "/opt/xhprof" do
    repository "git@github.com:gajus/xhprof.io.git"
    revision "master"
    user "vagrant"
    action :sync
end

template "/opt/xhprof/xhprof/includes/config.inc.php" do
    source "config.inc.php.erb"
    mode 0644
end

bash "Creating xhprof database" do
    user "vagrant"
    code <<-EOH
        mysql -u root -e 'create database xhprof';
        mysql -u root 'xhprof' < /opt/xhprof/setup/database.sql
    EOH
end

template "/etc/apache2/sites-enabled/xhprof.conf" do
  user "root"
  mode "0644"
  source "xhprof.conf.erb"
  notifies :reload, "service[apache2]"
end