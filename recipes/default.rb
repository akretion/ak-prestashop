#
# Cookbook Name:: ak-prestashop
# Recipe:: default
#
# Copyright 2013-TODAY Akretion
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe "ak-lnmp"

#Configure NGINX
template "/etc/nginx/sites-available/prestashop" do
  owner "root"
  group "root"
  mode 00777
  source "prestashop.erb"
  variables :port => node[:prestashop][:port], :directory => node[:prestashop][:dir]
  notifies :restart, "service[nginx]"
end

execute "enable prestashop website" do
  command "ln -s ../sites-available/prestashop prestashop"
  cwd "/etc/nginx/sites-enabled"
  group "root"
  user "root"
  action :run
  not_if {File.exist?("/etc/nginx/sites-enabled/prestashop")}
  notifies :restart, "service[nginx]"
end

unless File.exists?("#{node[:prestashop][:dir]}/installed.flag")
  #if node[:pretashop][:restore]
  #  include_recipe "ak-magento::restore_env"
  #else
    include_recipe "ak-prestashop::install_prestashop"
  #end  
end

#Update url if necessary
#TODO


