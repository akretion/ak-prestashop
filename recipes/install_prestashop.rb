
#Install Magento code source
unless File.exists?("#{node[:prestashop][:dir]}/installed_code.flag")

  execute "git clone #{node[:prestashop][:git]} prestashop" do
     creates node[:prestashop][:dir]
     cwd node[:prestashop][:dir_www]
     group node[:webserver][:unix_user]
     user node[:webserver][:unix_user]  
  end 

  execute "chmod -R 777 #{node[:prestashop][:dir]}" do
    action :run
  end

  execute "touch #{node[:prestashop][:dir]}/installed_code.flag" do
  end

  #Create a neww database (delete existing if exist)
  #TODO use database provider https://github.com/opscode-cookbooks/database
  execute "mysql -u #{node[:mysql][:db][:username]} -p#{node[:mysql][:db][:password]} -e'DROP DATABASE IF EXISTS #{node[:mysql][:db][:database]}'" do
  end  

  execute "create #{node[:mysql][:db][:database]} database" do
    command "mysql -u #{node[:mysql][:db][:username]} -p#{node[:mysql][:db][:password]} -e'CREATE DATABASE #{node[:mysql][:db][:database]}'"
  end
end

