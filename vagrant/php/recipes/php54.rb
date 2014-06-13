# Add Ondrej's php5 repository
execute "Add Ondrej's php5-oldstable repository" do
  command "add-apt-repository ppa:ondrej/php5-oldstable"
  ignore_failure true
end

execute "apt-get update" do
  command "apt-get update"
  ignore_failure true
  action :run
end

package 'php5'
package 'php5-cli'
