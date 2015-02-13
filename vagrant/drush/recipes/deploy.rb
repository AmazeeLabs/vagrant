git "/home/vagrant/.drush/drush_deploy" do
    repository "git@github.com:AmazeeLabs/drush_deploy.git"
    revision "7.x-1.x"
    user "vagrant"
    action :sync
end
