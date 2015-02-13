git "/home/vagrant/.drush/drush_safesync" do
    repository "git@github.com:AmazeeLabs/drush_safe_sync.git"
    revision "master"
    user "vagrant"
    action :sync
end
