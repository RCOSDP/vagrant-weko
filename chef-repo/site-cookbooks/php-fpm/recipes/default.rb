# -*- coding: utf-8 -*-
# インストール
package "php-fpm" do
  package_name node['php-fpm']['package_name']
  action :install
end

#サービス設定
service "php-fpm" do
  provider node['php-fpm']['service_provider'] if node['php-fpm']['service_provider']
  service_name node['php-fpm']['service_name']
  supports :start => true, :stop => true, :restart => true, :reload => true
  action [ :enable, :start ]
end

#設定
template "#{node['php-fpm']['dir']}/php.ini" do
 source "php.ini.erb"
 notifies :restart, "service[php-fpm]"
end

