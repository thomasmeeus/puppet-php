require 'spec_helper_acceptance'

describe 'php' do

  describe 'running puppet code' do
    it 'should work with no errors' do
      pp = <<-EOS

        class php::apache{
          ensure_status => 'stopped',
          package       => 'libapache2-mod-php5',
          inifile       => '/etc/php5/apache2/php.ini',
          settings => {
            set => 
              'PHP/memory_limit' => '1G',
            }
        }
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
