RSpec.describe ExhaustPipe::TokenList do
  describe "#add" do
    subject { ExhaustPipe::TokenList.new("p-8") }

    it "adds the given tokens to the existing list" do
      expect(subject.add("m-10")).to eq "p-8 m-10"
    end

    it "raises error if the added tokens conflict with the existing list" do
      expect {
        subject.add("p-10")
      }.to raise_error ExhaustPipe::TokenConflictError, "Only one padding token can be added. Classes [\"p-8\", \"p-10\"] conflict, please remove one of them."
    end
  end

  describe "#override" do
    subject { ExhaustPipe::TokenList.new("p-8") }

    it "adds non-conflicting tokens to the existing list" do
      expect(subject.override("m-10")).to eq "p-8 m-10"
    end

    it "replaces conflicting tokens with the new tokens" do
      expect(subject.override("p-10")).to eq "p-10"
    end
  end
end
