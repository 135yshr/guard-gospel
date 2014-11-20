require 'spec_helper'

describe Guard::Gospel::Runner do
  let(:default_options) { Guard::Gospel::Options::DEFAULTS }
  let(:guard_runner){ Guard::Gospel::Runner.new(default_options) }

  describe '#run' do
    let(:proc){ ChildProcess.build(default_options[:cmd], 'test') }
    let(:out) { Tempfile.new([default_options[:basename], default_options[:tempdir]])}

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
        allow(out).to receive(:readlines) {["\\e[31m\\e[1m.\\e[0m\\e[31m\\e[1mF\\e[0m\n", "dummy"]}
        expect(Tempfile).to receive(:new).with(['go_spel', '.tmp']) { out }
        expect(::Guard::Notifier).to receive(:notify).with("Failed 2 tests, 1 failure", title: default_options[:title], image: :failed, priority: 2)
        guard_runner.run
      end

      it "return 1 failed to 3" do
        allow(proc).to receive(:exit_code) {1}
        allow(out).to receive(:readlines) {["\\e[31m\\e[1m.\\e[0m\\e[31m\\e[1mF\\e[0m\\e[31m\\e[1mF\\e[0m\\e[31m\\e[1mF\\e[0m\\e[31m\\e[1m.\\e[0m", "dummy"]}
        expect(Tempfile).to receive(:new).with(['go_spel', '.tmp']) { out }
        expect(::Guard::Notifier).to receive(:notify).with("Failed 5 tests, 3 failure", title: default_options[:title], image: :failed, priority: 2)
        guard_runner.run
      end
    end
  end

end
