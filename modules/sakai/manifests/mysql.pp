class sakai::mysql {
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
}