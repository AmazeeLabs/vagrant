directory "/opt/composer" do
    owner "vagrant"
    group "vagrant"
    mode 0755
    action :create
end

execute "Installing Composer" do
  command "curl -sS https://getcomposer.org/installer | php"
  cwd '/opt/composer'
  action :run
end

link "/usr/bin/composer" do
    to "/opt/composer/composer.phar"
end
