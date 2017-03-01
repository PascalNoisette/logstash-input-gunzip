# encoding: utf-8
require "logstash/devutils/rspec/spec_helper"
require "logstash/inputs/gunzip"

describe LogStash::Inputs::Gunzip do

  it_behaves_like "an interruptible input plugin" do
    let(:config) { { "interval" => 100 } }
  end

end
