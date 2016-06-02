require 'spec_helper_acceptance'

describe 'apache' do

  describe 'running puppet code' do
    it 'should work with no errors' do
      pp = <<-EOS
        include php 
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes => true)
    end

    describe package('php') do
      it { should be_installed }
    end
  end
end
