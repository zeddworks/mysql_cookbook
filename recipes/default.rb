#
# Cookbook Name:: mysql
# Recipe:: default
#
# Copyright 2011, ZeddWorks
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

package "mysql-server" do
  package_name value_for_platform(
    ["ubuntu", "debian"] => { "default" => "mysql-server" },
    ["redhat"] => { "default" => "mysql-server" }
  )
end

package "mysql-dev" do
  package_name value_for_platform(
    ["ubuntu", "debian"] => { "default" => "libmysqlclient-dev" },
    ["redhat"] => { "default" => "mysql-devel" }
  )
end

if platform? "redhat"
  service "mysqld" do
    supports :restart => true, :reload => true, :status => true
    action [ :enable, :start ]
  end
else
  service "mysql" do
    supports :restart => true, :reload => true, :status => true
    action [ :enable, :start ]
  end
end
