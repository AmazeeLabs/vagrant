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

git "/opt/xhprof" do
    repository "git@github.com:AmazeeLabs/xhprof.git"
    revision "master"
    user "vagrant"
    action :sync
end

template "/opt/xhprof/xhprof_lib/config.php" do
    source "config.php.erb"
    mode 0644
end

bash "Creating xhprof database" do
    user "vagrant"
    code <<-EOH
        mysql -u root -e 'create database xhprof';
        mysql -u root 'xhprof' -e ' CREATE TABLE `details` (
                                    `id` char(17) NOT NULL,
                                    `url` varchar(255) default NULL,
                                    `c_url` varchar(255) default NULL,
                                    `timestamp` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
                                    `server name` varchar(64) default NULL,
                                    `perfdata` MEDIUMBLOB,
                                    `type` tinyint(4) default NULL,
                                    `cookie` BLOB,
                                    `post` BLOB,
                                    `get` BLOB,
                                    `pmu` int(11) unsigned default NULL,
                                    `wt` int(11) unsigned default NULL,
                                    `cpu` int(11) unsigned default NULL,
                                    `server_id` char(3) NOT NULL default "t11",
                                    `aggregateCalls_include` varchar(255) DEFAULT NULL,
                                    PRIMARY KEY  (`id`),
                                    KEY `url` (`url`),
                                    KEY `c_url` (`c_url`),
                                    KEY `cpu` (`cpu`),
                                    KEY `wt` (`wt`),
                                    KEY `pmu` (`pmu`),
                                    KEY `timestamp` (`timestamp`)
                                    ) ENGINE=MyISAM DEFAULT CHARSET=utf8;';
    EOH
end

template "/etc/apache2/sites-enabled/xhprof.conf" do
  user "root"
  mode "0644"
  source "xhprof.conf.erb"
  notifies :reload, "service[apache2]"
end
