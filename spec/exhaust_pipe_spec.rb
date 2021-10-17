RSpec.describe ExhaustPipe do
  describe "#tailwind" do
    it "takes a list of classes and returns a string" do
      classes = ExhaustPipe.tailwind("m-10", "p-10")
      expect(classes).to eq "m-10 p-10"
    end

    it "can be interapolated with erb" do
      require "erb"

      template = ERB.new <<~TEMPLATE
        <div class=<%= ExhaustPipe.tailwind("m-6", "p-4") %>></div>
      TEMPLATE

      classes = template.result(binding)
      expect(classes).to eq "<div class=m-6 p-4></div>\n"
    end

    it "raises error if two conflicting classes are given" do
      expect {
        ExhaustPipe.tailwind("p-8", "p-10")
      }.to raise_error(ExhaustPipe::TokenConflictError)
    end

    it "does not raise an error if two unknown classes are passed" do
      expect {
        ExhaustPipe.tailwind("primary-button", "secondary-button")
      }.not_to raise_error
    end

    context "when raise_error is false" do
      around do |ex|
        ExhaustPipe.raise_error = false
        ex.run
        ExhaustPipe.raise_error = true
      end

      it "does not raise an error with conflicting classes" do
        expect {
          ExhaustPipe.tailwind("p-8", "p-10")
        }.not_to raise_error
      end
    end
  end
end
