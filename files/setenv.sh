export JAVA_OPTS="-Xdebug -Xrunjdwp:transport=dt_socket,address=8000,server=y,suspend=n -server -Xmx768m -XX:MaxPermSize=320m -Dorg.apache.jasper.compiler.Parser.STRICT_QUOTE_ESCAPING=false -Djava.awt.headless=true -Dcom.sun.management.jmxremote"
CLASSPATH=/usr/share/java/mysql-connector-java.jar

