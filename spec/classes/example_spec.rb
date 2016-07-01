require 'spec_helper'

describe 'demo_mco_server' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts.merge({
            :concat_basedir => "/foo"
          })
        end

        context "demo_mco_server class without any parameters" do
          let(:params) {{ }}

          it { is_expected.to compile.with_all_deps }
          it { is_expected.to contain_class('demo_mco_server') }
 
          it { is_expected.to contain_class('demo_mco_server::params') }
          it { is_expected.to contain_class('demo_mco_server::install').that_comes_before('demo_mco_server::config') }
          it { is_expected.to contain_class('demo_mco_server::config') }
          it { is_expected.to contain_class('demo_mco_server::service').that_subscribes_to('demo_mco_server::config') }

          it { is_expected.to contain_service('demo_mco_server') }
          it { is_expected.to contain_package('demo_mco_server').with_ensure('present') }

        end
      end
    end
  end
end
