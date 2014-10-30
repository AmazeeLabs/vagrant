directory "/home/vagrant/.drush" do
    owner "vagrant"
    group "vagrant"
    mode 0755
    action :create
end

git "/home/vagrant/.drush/drush_safesync" do
    repository "git@github.com:AmazeeLabs/drush_safe_sync.git"
    revision "master"
    user "vagrant"
    action :sync
end
