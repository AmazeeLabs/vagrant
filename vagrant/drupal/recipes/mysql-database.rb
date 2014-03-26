bash "Create Database" do
  user "root" # see attributes section below
  code <<-EOH
    echo "create database IF NOT EXISTS drupal" | mysql
    EOH
end
