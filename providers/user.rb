action :create do
  user = new_resource.user
  password = new_resource.password
  host = new_resource.host
  if password.nil?
    execute "create-mysql-user-#{user}" do
      user "mysql"
      command "mysql -u root -e \"CREATE USER '#{user}'@'#{host}';\""
      not_if "sudo -u mysql bash -c \"mysql -e 'SELECT user FROM mysql.user;'\" | grep #{user}"
    end
  else
    execute "create-mysql-user-#{user}" do
      user "mysql"
      command "mysql -u root -e \"CREATE USER '#{user}'@'#{host}' IDENTIFIED by '#{password}' ;\""
      not_if "sudo -u mysql bash -c \"mysql -e 'SELECT user FROM mysql.user;'\" | grep #{user}"
    end
  end
end

action :drop do
  user = new_resource.user
  execute "drop-mysql-user-#{user}" do
    user "mysql"
    command "mysql -u root -e \"DROP USER '#{user}'@'#{host}';\""
    only_if "sudo -u mysql bash -c \"mysql -e 'SELECT user FROM mysql.user;'\" | grep #{user}"
  end
end
