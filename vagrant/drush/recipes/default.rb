directory "/opt/drush" do
    owner "vagrant"
    group "vagrant"
    mode 0755
    action :create
end

ssh_known_hosts_entry 'github.com'

git "/opt/drush" do
    repository "git@github.com:AmazeeLabs/drush.git"
    revision "master"
    user "vagrant"
    action :sync
end

link "/usr/bin/drush" do
    to "/opt/drush/drush"
end
