class sakai::tomcat {
  package { 'tomcat7':
    ensure => present,
  }

  file { '/var/lib/tomcat7/shared/lib':
    ensure => directory,
    owner  => "tomcat7",
    group  => "vagrant",
    mode   => 775,
    require => Package["tomcat7"],
  }

  file { '/var/lib/tomcat7/common/lib':
    ensure => directory,
    owner  => "tomcat7",
    group  => "vagrant",
    mode   => 775,
    require => Package["tomcat7"],
  }

  file { '/var/lib/tomcat7/server/lib':
    ensure => directory,
    owner  => "tomcat7",
    group  => "vagrant",
    mode   => 775,
    require => Package["tomcat7"],
  }

  file { '/var/lib/tomcat7/sakai':
    ensure => directory,
    owner  => "tomcat7",
    group  => "vagrant",
    mode   => 775,
    require => Package["tomcat7"],
  }

  file { '/var/lib/tomcat7/webapps':
    ensure => directory,
    owner  => "tomcat7",
    group  => "vagrant",
    mode   => 775,
    require => Package["tomcat7"],
  }

  file { '/var/lib/tomcat7/components':
    ensure => directory,
    owner  => "tomcat7",
    group  => "vagrant",
    mode   => 775,
    require => Package["tomcat7"],
  }

  file { '/var/lib/tomcat7/sakai/sakai.properties':
    ensure  => file,
    owner   => "tomcat7",
    group   => "vagrant",
    require => File["/var/lib/tomcat7/sakai"],
    source  => "puppet:///files/sakai.properties",
  }

  file { '/usr/share/tomcat7/bin/setenv.sh':
    ensure  => file,
    owner   => "tomcat7",
    group   => "vagrant",
    source  => "puppet:///files/setenv.sh",
    require => Package["tomcat7"],
  }

  file { '/var/lib/tomcat7/conf/catalina.properties':
    ensure  => file,
    owner   => "tomcat7",
    group   => "vagrant",
    source  => "puppet:///files/catalina.properties",
    require => Package["tomcat7"],
  }

  file { '/usr/share/tomcat7/lib/commons-dbcp.jar':
    ensure  => absent,
    require => Package["tomcat7"],
  }

  file { '/usr/share/tomcat7/lib/commons-pool.jar':
    ensure  => absent,
    require => Package["tomcat7"],
  }

  service { 'tomcat7':
    ensure     => stopped,
    enable     => false,
    hasstatus  => true,
    hasrestart => true,
    require    => File[
      "/var/lib/tomcat7/sakai/sakai.properties",
      "/usr/share/tomcat7/bin/setenv.sh",
      "/var/lib/tomcat7/conf/catalina.properties",
      "/usr/share/tomcat7/lib/commons-dbcp.jar",
      "/usr/share/tomcat7/lib/commons-pool.jar"
    ],
  }
}