# encoding: utf-8
require "logstash/inputs/base"
require "logstash/namespace"
require "stud/interval"
require "socket" # for Socket.gethostname

# This plugin decompress gzip input file

class LogStash::Inputs::Gunzip < LogStash::Inputs::Base
  
  # This is how you configure this input 
  # from your Logstash config.
  #
  # input { 
  #   gunzip {
  #     path => ["./log/access.1.gz"]
  #     codec => plain {
  #         charset => "CP1252"
  #     }
  #   }
  # }

  config_name "gunzip"

  # Codec
  default :codec, "plain"

  # Gz file path
  config :path, :validate => :array, :required => true

  # Open gz files
  public
  def register
          @host = Socket.gethostname
          @gzstream = {}
          @path.each do |path|
                  @logger.info("Opening file", :path => path)
                  @gzstream[path] = Zlib::GzipReader.new(open(path), {"encoding"=>@codec.charset})
          end
  end # def register

  def run(queue)
      @path.each do |path|
          lineNumber = 0
          @gzstream[path].each_line do |line|
              lineNumber = lineNumber+1
              @codec.decode(line) do |event|
                    decorate(event)
                    event.set("host", @hostname) if !event.include?("host")
                    event.set("path", path)
                    event.set("line_number", lineNumber)
                    queue << event
              end
          end
      end

  end # def run

  # Close file
  def stop
    @path.each do |path|
      @gzstream[path].close
    end
  end
end # class LogStash::Inputs::Gunzip
