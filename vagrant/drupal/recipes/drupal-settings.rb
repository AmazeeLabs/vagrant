template "/home/vagrant/public_html/sites/default/settings.php" do
  source "settings.php.erb"
  variables({
     :database => 'drupal',
     :username => 'root',
     :password => '',
     :prefix => '',
     :host => 'localhost',
     :port => '3306'
  })
  action :create_if_missing
end

%w[ files files/config_vagrant files/config_vagrant/active files/config_vagrant/staging].each do |dir|
  directory "/home/vagrant/public_html/sites/default/#{dir}" do
    mode 00755
  end
end
