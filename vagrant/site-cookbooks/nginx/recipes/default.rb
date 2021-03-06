#
# Cookbook Name:: nginx
# Recipe:: default
#
# Copyright 2011, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
# Split recipe from base to prevent nginx from starting when e.g.
# installing from source, and allow each of the sub recipes to load
# their own config file.
include_recipe "nginx::base"

template "/etc/nginx/sites-enabled/default" do
   source "server.conf.erb"
   mode 644
   owner "root"
   group "root"
   variables ({
      :server_name => "localhost",
      :application_path => "",
      :upstream => $upstream})
end

service "nginx" do
   supports :start => true, :restart => true, :reload => true
   action [ :enable,  :start]
end
