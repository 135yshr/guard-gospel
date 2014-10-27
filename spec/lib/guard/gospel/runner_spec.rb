require 'spec_helper'

describe Guard::Gospel::Runner do
  let(:default_options) { Guard::Gospel::Options::DEFAULTS }
  let(:guard_runner){ Guard::Gospel::Runner.new(default_options) }

  describe '#run' do
    let(:proc){ ChildProcess.build(default_options[:cmd], 'test') }
    let(:out) { Tempfile.open(['go_spel', '.tmp'])}

    context 'when success command' do
      it 'return 0' do
        allow(proc).to receive(:exit_code) {0}
        expect(ChildProcess).to receive(:build).with(default_options[:cmd], 'test') { proc }
        expect(::Guard::Notifier).to receive(:notify).with("Success", title: default_options[:title], image: :success, priority: -2)
        guard_runner.run
      end
    end

    context 'when fail command' do
      it "return 1" do
        allow(proc).to receive(:exit_code) {1}
        allow(out).to receive(:readlines) {["F.", "dummy"]}
        expect(Tempfile).to receive(:open).with(['go_spel', '.tmp']) { out }
        expect(::Guard::Notifier).to receive(:notify).with("Failed 2 tests, 1 failure", title: default_options[:title], image: :failed, priority: 2)
        guard_runner.run
      end
    end
  end

end
