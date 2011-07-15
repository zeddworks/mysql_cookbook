action :create do
  database = new_resource.database
  owner = new_resource.owner
  host = new_resource.host
  if owner.nil?
    execute "create-mysql-db-#{database}" do
      user "mysql"
      command "mysql -u root -e \"CREATE DATABASE #{database} CHARACTER SET utf8;\""
      not_if "sudo -u mysql bash -c \"mysql -e 'SHOW DATABASES'\" | grep #{database}"
    end
  else
    execute "create-mysql-db-#{database}" do
      user "mysql"
      command "mysql -u root -e \"CREATE DATABASE #{database} CHARACTER SET utf8; GRANT ALL ON #{database}.* TO '#{owner}'@'#{host}';\""
      not_if "sudo -u mysql bash -c \"mysql -e 'SHOW DATABASES'\" | grep #{database}"
    end
  end
end
action :drop do
  database = new_resource.database
  owner = new_resource.owner
  execute "drop-mysql-db-#{database}" do
    user "mysql"
    command "mysql -u root -e \"DROP DATABASE #{database};\""
    only_if "sudo -u mysql bash -c \"mysql -e 'SHOW DATABASES'\" | grep #{database}"
  end
end
