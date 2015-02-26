# Exchange Sources list with our Version which points to CH Servers instead of US
cookbook_file '/etc/apt/sources.list' do
    source 'sources.list'
end

# Run apt-get update to create the stamp file
execute "apt-get-update" do
  command "apt-get update"
  ignore_failure true
  not_if do ::File.exists?('/var/lib/apt/periodic/update-success-stamp') end
end

# For other recipes to call to force an update
execute "apt-get update" do
  command "apt-get update"
  ignore_failure true
  action :nothing
end


execute "apt-get-update-periodic" do
  command "apt-get update"
  ignore_failure true
  only_if do
    File.exists?('/var/lib/apt/periodic/update-success-stamp') &&
    File.mtime('/var/lib/apt/periodic/update-success-stamp') < Time.now - 86400
  end
end

# install python-software properties to enable add-apt-repo
package "python-software-properties"

# Add git repository
execute "Add git repository" do
  notifies :run, resources(:execute => "apt-get-update"), :immediately
  command "add-apt-repository ppa:git-core/ppa"
  ignore_failure true
end

# provides /var/lib/apt/periodic/update-success-stamp on apt-get update
package "update-notifier-common" do
  notifies :run, resources(:execute => "apt-get-update"), :immediately
end

# Install common packages
package 'curl'
package 'vim'
package 'git'
package 'htop'
