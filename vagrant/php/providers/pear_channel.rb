
# http://pear.php.net/manual/en/guide.users.commandline.channels.php

require 'chef/mixin/shell_out'
require 'chef/mixin/language'
include Chef::Mixin::ShellOut

def whyrun_supported?
  true
end

action :discover do
  unless exists?
    Chef::Log.info("Discovering pear channel #{@new_resource}")
    execute "#{node['php']['pear']} channel-discover #{@new_resource.channel_name}" do
      action :run
    end
  end
end

action :add do
  unless exists?
    Chef::Log.info("Adding pear channel #{@new_resource} from #{@new_resource.channel_xml}")
    execute "#{node['php']['pear']} channel-add #{@new_resource.channel_xml}" do
      action :run
    end
  end
end

action :update do
  if exists?
    update_needed = false
    begin
      updated_needed = true if shell_out("#{node['php']['pear']} search -c #{@new_resource.channel_name} NNNNNN").stdout =~ /channel-update/
    rescue Chef::Exceptions::CommandTimeout
      # CentOS can hang on 'pear search' if a channel needs updating
      Chef::Log.info("Timed out checking if channel-update needed...forcing update of pear channel #{@new_resource}")
      update_needed = true
    end
    if update_needed
      description = "update pear channel #{@new_resource}"
      converge_by(description) do
        Chef::Log.info("Updating pear channel #{@new_resource}")
        shell_out!("#{node['php']['pear']} channel-update #{@new_resource.channel_name}")
      end
    end
  end
end

action :remove do
  if exists?
    Chef::Log.info("Deleting pear channel #{@new_resource}")
    execute "#{node['php']['pear']} channel-delete #{@new_resource.channel_name}" do
      action :run
    end
  end
end

def load_current_resource
  @current_resource = Chef::Resource::PhpPearChannel.new(@new_resource.name)
  @current_resource.channel_name(@new_resource.channel_name)
  @current_resource
end

private

def exists?
  begin
    shell_out!("#{node['php']['pear']} channel-info #{@current_resource.channel_name}")
    true
  rescue Mixlib::ShellOut::ShellCommandFailed
    false
  end
end
