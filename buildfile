require 'rubygems'
require "bundler/setup"
require 'buildr-dependency-extensions'

# Version number for this release
VERSION_NUMBER = "1.4.#{ENV['BUILD_NUMBER'] || 'SNAPSHOT'}"
# Group identifier for your projects
GROUP = "com.springsense"
COPYRIGHT = "(C) Copyright 2011, 2012, 2013 SpringSense Trust. All rights reserved. Licensed under  the Apache License, Version 2.0. See file LICENSE."

# Specify Maven 2.0 remote repositories here, like this:
repositories.remote << "http://www.ibiblio.org/maven2"
repositories.remote << "http://repo1.maven.org/maven2"
repositories.remote << "http://maven.mashape.com/releases"
repositories.release_to = 'sftp://artifacts:repository@ci.internal.springsense.com/home/artifacts/repository'

desc "The Java_api_bindings project"
define "java_api_bindings" do
  extend PomGenerator

  project.version = VERSION_NUMBER
  project.group = GROUP
  manifest["Implementation-Vendor"] = COPYRIGHT
  
  GSON = artifact('com.google.code.gson:gson:jar:1.6')
  OPENCSV = artifact('net.sf.opencsv:opencsv:jar:2.3')  
  GUAVA = artifact('com.google.guava:guava:jar:r09')
  
  MASHAPE = [ artifact('com.mashape.unicorn:unicorn-java:jar:1.0.0'),    
    artifact('org.apache.httpcomponents:httpmime:jar:4.2.3'),
    artifact('org.json:json:jar:20090211'), 
    artifact('org.apache.httpcomponents:httpclient:jar:4.2.3'),
    artifact('org.apache.httpcomponents:httpcore:jar:4.2.2'),
    artifact('commons-codec:commons-codec:jar:1.6'),
    artifact('commons-logging:commons-logging:jar:1.1.1'),
     ]

  JUNIT4 = artifact("junit:junit:jar:4.8.2")
  HAMCREST = artifact("org.hamcrest:hamcrest-core:jar:1.2.1")
  MOCKITO = artifact("org.mockito:mockito-all:jar:1.8.5")
  COMMONS_IO = artifact("commons-io:commons-io:jar:2.0.1")
  COMMONS_LANG = artifact("commons-lang:commons-lang:jar:2.3")

  compile.with GSON, GUAVA, OPENCSV, *MASHAPE
  compile.using :target => "1.5"
  test.compile.with JUNIT4, HAMCREST, MOCKITO, COMMONS_IO, COMMONS_LANG
  
  package(:jar)
end
