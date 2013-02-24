class sakai::zsh {
  package { "git":
    ensure => present,
  }
  
  package { "zsh":
    ensure => present,
  }
  
  user { "vagrant":
    ensure => present,
    shell  => "/bin/zsh",
  }
  
  vcsrepo { "/home/vagrant/.oh-my-zsh":
    ensure   => present,
    provider => git,
    source   => "git://github.com/robbyrussell/oh-my-zsh.git",
    require  => Package["git"],
  }
  
  file {"/home/vagrant/.zshrc":
    ensure  => file,
    source  => "/home/vagrant/.oh-my-zsh/templates/zshrc.zsh-template",
    require => Vcsrepo["/home/vagrant/.oh-my-zsh"],
  }
}