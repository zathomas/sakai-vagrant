class sakai::mysql {
  class { 'mysql::server':
    root_password => 'foo'
  }

  class { 'mysql::bindings':
    java_enable => true
  }
  
  mysql::db { 'sakai':
    user     => 'sakai',
    password => 'ironchef',
    host     => 'localhost',
    grant    => ['all'],
  }
}