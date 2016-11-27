require 'spec_helper'

RSpec.describe Enumex::Extenders::EveryTimeExtender do
  describe described_class::Port, '#every_time' do
    it "attaches a method `every_time' to an ActionContainer instance" do
      action = Enumex::Base.new.post_action
      expect(action).to respond_to(:every_time)
    end
  end
end

