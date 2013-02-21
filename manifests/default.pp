define download_file(
  $site="",
  $cwd="",
  $creates="",
  $user="",
  $timeout="300") {

    exec { $name:
      command => "/usr/bin/wget ${site}/${name}",
      cwd     => $cwd,
      creates => "${cwd}/${name}",
      user    => $user,
      timeout => $timeout,
    }
}

define svnworkdir($repository, $local_container, $local_name = false, $svn_username = false, $svn_password = false)
{
  $owner_real = $owner ? { false => 0, default => $owner }
  $group_real = $group ? { false => 0, default => $group }
  $local_name_real = $local_name ? { false => $name, default => $local_name }
  Exec {
    path => "/usr/bin:/bin:/opt/local/bin:/usr/local/bin" }
    $retrieve_command = $svn_username ? {
      false   => "svn checkout --non-interactive '$repository' '$local_name_real'",
      default => "svn checkout --non-interactive --username='$svn_username' --password='$svn_password' '$repository' '$local_name_real'"
    }
  exec { "svn-co-$name":
    command => $retrieve_command,
    cwd => $local_container,
    require => [ File["$local_container"], Package["subversion"]],
    creates => "$local_container/$local_name_real/.svn",
    timeout => "0",
  }
}

class apt_update {
  exec { 'apt-get update':
    command => '/usr/bin/apt-get update'
  }
}

class get_tomcat {
  download_file { "apache-tomcat-7.0.37.tar.gz":
      site    => "http://mirrors.ibiblio.org/apache/tomcat/tomcat-7/v7.0.37/bin",                                                                           
      cwd     => "/home/vagrant",                                                                            
      creates => "/home/vagrant/$name",
      user    => "vagrant",
  }

  exec { '/bin/tar xzf apache-tomcat-7.0.37.tar.gz':
    unless => '/usr/bin/test -d /home/vagrant/apache-tomcat-7.0.37',
    cwd    => '/home/vagrant',
    user   => "vagrant",
    require => Download_file["apache-tomcat-7.0.37.tar.gz"],
  }
  
  file { '/home/vagrant/apache-tomcat-7.0.37/sakai':
    ensure => directory,
    owner  => "vagrant",
  }
  
  file { '/home/vagrant/apache-tomcat-7.0.37/sakai/sakai.properties':
    ensure  => file,
    owner   => "vagrant",
    require => File["/home/vagrant/apache-tomcat-7.0.37/sakai"],
    source  => "puppet:///files/sakai.properties",
  }
}

class sakai_dev {
  file { '/vagrant':
    ensure => directory,
  }

  package { 'subversion':
    ensure => present,
  }

  download_file { "apache-maven-3.0.4-bin.tar.gz":
    site => "http://mirrors.ibiblio.org/apache/maven/maven-3/3.0.4/binaries",
    cwd => "/home/vagrant",
    creates => "/home/vagrant/$name",
    user => "vagrant",
  }

  exec { '/bin/tar xzf /home/vagrant/apache-maven-3.0.4-bin.tar.gz':
    unless => '/usr/bin/test -d /home/vagrant/apache-maven-3.0.4',
    cwd    => '/home/vagrant',
    user   => "vagrant",
    require => Download_file["apache-maven-3.0.4-bin.tar.gz"],
  }

  file { "/etc/profile.d/maven.sh":
    ensure => file,
    owner  => "root",
    group  => "root",
    mode   => 644,
    source => 'puppet:///files/maven.sh'
  }
  
  file { "/home/vagrant/.m2":
    ensure => directory,
    owner  => "vagrant",
  }
  
  file { "/home/vagrant/.m2/settings.xml":
    ensure => file,
    owner  => "vagrant",
    source => 'puppet:///files/settings.xml',
    require => File["/home/vagrant/.m2"]
  }

  svnworkdir { sakai:
    repository => "https://source.sakaiproject.org/svn/sakai/tags/sakai-2.9.1-all",
    local_container => "/vagrant",
    local_name => "sakai-src",
  }
}
stage { 'init': before => Stage['main'] }
class {'apt_update': stage => init}
include get_tomcat, sakai_dev, java

class { 'mysql::server':
  config_hash => { 'root_password' => 'foo' }
}

mysql::db { 'sakai':
  user     => 'sakai',
  password => 'ironchef',
  host     => 'localhost',
  grant    => ['all'],
}