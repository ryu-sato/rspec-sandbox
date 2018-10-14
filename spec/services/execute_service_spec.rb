require 'rails_helper'

# Service のテストを実施するときには、type: :service を指定する
describe ExecuteService, type: :service do
  let(:execute_service) { ExecuteService.instance }

  before do
    allow(execute_service).to receive(:exec_ruby_code)
  end

  describe '#exec_ruby_code' do
    it 'should be called' do
      expect { execute_service.exec_ruby_code('script.rb', '-U3') }.not_to raise_error
    end
  end
end
