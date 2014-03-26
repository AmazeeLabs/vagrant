directory "/home/vagrant/.drush" do
    owner "vagrant"
    group "vagrant"
    mode 0755
    action :create
end

git "/home/vagrant/.drush/drush_deploy" do
    repository "git@github.com:AmazeeLabs/drush_deploy.git"
    revision "7.x-1.x"
    user "vagrant"
    action :sync
end