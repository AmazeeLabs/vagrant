directory "/opt/drush" do
    owner "vagrant"
    group "vagrant"
    mode 0755
    action :create
end

# Composer Json holds information about what drush verison we need
cookbook_file "/opt/drush/composer.json" do
    source "composer.json"
    action :create_if_missing
end

execute "composer install" do
    cwd "/opt/drush"
    action :run
end

link "/usr/bin/drush" do
    to "/opt/drush/vendor/bin/drush"
end
