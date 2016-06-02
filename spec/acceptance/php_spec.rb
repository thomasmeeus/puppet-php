require 'spec_helper_acceptance'

describe 'php' do

  describe 'running puppet code' do
    it 'should work with no errors' do
      pp = <<-EOS

        class { 'php'  }
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes => true)
    end

    describe package('php') do
      it { should be_installed }
    end

    context  php_config('memory_limit') do
      its(:value) { should eq '1G' }
    end
  end
end
