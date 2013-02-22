stage { 'init': before => Stage['main'] }
class {'sakai::apt_update': stage => init}
include sakai::tomcat, sakai::sakai_dev, java

class { 'mysql::server':
  config_hash => { 'root_password' => 'foo' }
}

class { 'mysql::java': }

mysql::db { 'sakai':
  user     => 'sakai',
  password => 'ironchef',
  host     => 'localhost',
  grant    => ['all'],
}