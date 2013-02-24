stage { 'init': before => Stage['main'] }
class {'sakai::apt_update': stage => init}

include java
include sakai::tomcat
include sakai::mysql
include sakai::maven
include sakai::vim
include sakai::subversion
include sakai::zsh