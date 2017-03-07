# encoding: utf-8
require "logstash/devutils/rspec/spec_helper"
require "tempfile"
require "stud/temporary"
require "logstash/inputs/gunzip"

FILE_DELIMITER = LogStash::Environment.windows? ? "\r\n" : "\n"

describe LogStash::Inputs::Gunzip do

  describe "testing with input(conf) do |pipeline, queue|" do
    
      # Create a gz file with "hello\nworld" in it
      tmpfile_path = Stud::Temporary.pathname + '.gz'
      Zlib::GzipWriter.open(tmpfile_path) do |gz|
        gz.write "hello"
        gz.write FILE_DELIMITER
        gz.write "world"
        gz.close
      end
      
      conf = <<-CONFIG
        input {
          gunzip {
            path => ["#{tmpfile_path}"]
          }
        }
      CONFIG
  
      events = input(conf) do |pipeline, queue|
        2.times.collect { queue.pop }
      end

      insist { events[0].get("message") } == "hello"
      insist { events[1].get("message") } == "world"
  
    end
end
