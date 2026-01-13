require "rails_helper"

RSpec.describe WarmupJob, type: :job do
  it "runs without error" do
    expect { described_class.new.perform }.not_to raise_error
  end

  it "preloads something" do
    expect(WarmupService).to receive(:call)
    described_class.new.perform
  end
end
