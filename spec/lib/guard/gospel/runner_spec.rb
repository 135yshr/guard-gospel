require 'spec_helper'

describe Guard::GoSpel::Runner do
  describe '.run' do
    let(:sut){Guard::GoSpel::Runner.new()}
    it '.run' do
      sut.run
      expect(sut.pid).to_not eq(0)
    end
    it '.run child process' do
      expect(ChildProcess).to receive(build).with('ls')
      sut.run
    end
  end
end