package 'php5'
package 'libapache2-mod-php5'
package 'mysql-server'
package 'php5-cli'
package 'php5-curl'
package 'php5-intl'
#package 'php5-sqlite'
package 'php5-mysql'
package 'php5-dev'
package 'php5-gd'
package 'php-apc'
package 'php5-xmlrpc'
package 'php5-imagick'
package 'php5-xdebug'
# package 'php5-xsl'
# package 'php5-xhprof'
# package 'php-pear'
#package 'sqlite3'
#package 'make'

# install xslt
# package "libxslt-dev" do
#   package_name value_for_platform(
#     [ "centos", "redhat", "suse", "fedora" ] => { "default" => "libxslt-devel" },
#     "gentoo" => { "default" => "dev-libs/libxslt" },
#     "default" => "libxslt1-dev"
#   )
# end

file "/etc/apache2/sites-enabled/000-default" do
  action :delete
end

template "/etc/apache2/sites-enabled/vhost.conf" do
  user "root"
  mode "0644"
  source "vhost.conf.erb"
  notifies :reload, "service[apache2]"
end

template "/etc/php5/apache2/php.ini" do
  user "root"
  mode "0644"
  source "php.ini.erb"
  notifies :reload, "service[apache2]"
end

template "/etc/php5/cli/php.ini" do
  user "root"
  mode "0644"
  source "php.ini.erb"
end

execute "a2enmod rewrite"

service "apache2" do
  supports :restart => true, :reload => true, :status => true
  action [ :enable, :start ]
end
