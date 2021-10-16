RSpec.describe ExhaustPipe do
  describe "#tailwind" do
    subject { described_class.tailwind("a", "b") }

    it "takes a list of classes and returns a string" do
      expect(subject).to eq "a b"
    end
  end
end
