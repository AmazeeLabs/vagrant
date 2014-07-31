execute 'Installing RVM' do
  command "curl -sSL https://get.rvm.io | bash -s stable"
  action :run
  not_if { ::File.exists?("/usr/local/rvm")}

end

execute "Install Ruby 1.9.3" do
    command "rvm install ruby-1.9.3"
    action :run
end


execute "Install Ruby 2.0.0" do
    command "rvm install ruby-2.0.0-p451"
    action :run
end
