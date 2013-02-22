class sakai::tomcat {
  package { 'tomcat7':
    ensure => present,
  }

  service { 'tomcat7':
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
    require    => Package["tomcat7"],
  }

  file { '/var/lib/tomcat7':
    ensure => directory,
    owner => "tomcat7",
    group => "vagrant",
    mode  => 771,
  }

  file { '/var/lib/tomcat7/shared/lib':
    ensure => directory,
    owner  => "tomcat7",
    group  => "vagrant",
    mode   => 771,
  }

  file { '/var/lib/tomcat7/common/lib':
    ensure => directory,
    owner  => "tomcat7",
    group  => "vagrant",
    mode   => 771,
  }

  file { '/var/lib/tomcat7/sakai':
    ensure => directory,
    owner  => "tomcat7",
    group  => "vagrant",
  }

  file { '/var/lib/tomcat7/sakai/sakai.properties':
    ensure  => file,
    owner   => "tomcat7",
    group   => "vagrant",
    require => File["/var/lib/tomcat7/sakai"],
    source  => "puppet:///files/sakai.properties",
  }
}