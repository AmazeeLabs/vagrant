execute "apt-get update" do
  command "apt-get update"
  ignore_failure true
  action :run
end

package 'php5'
package 'php5-cli'
package 'php5-mcrypt'
