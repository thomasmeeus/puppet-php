require 'spec_helper_acceptance'

describe 'php:pear' do

  describe 'running puppet code' do
    it 'should work with no errors' do
      pp = <<-EOS
        include php

        package { 'pear.phpunit.de/PHPUnit':
          ensure   => present,
          provider => pear,
        }
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes => true)
    end

    describe package('php-pear') do
      it { should be_installed }
    end
  end
end
