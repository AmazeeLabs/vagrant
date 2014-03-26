directory "/opt/drush" do
    owner "vagrant"
    group "vagrant"
    mode 0755
    action :create
end

template "/opt/drush/composer.json" do
    source "composer.json"
end

execute "composer install" do
    cwd "/opt/drush"
    action :run
end

link "/usr/bin/drush" do
    to "/opt/drush/vendor/bin/drush"
end
