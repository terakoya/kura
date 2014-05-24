require 'spec_helper'

describe Stuff, :type => :model do
  let(:attrs) { {title: 'foo'} }
  subject(:stuff) { Stuff.new(attrs) }

  describe "#file=" do
    let(:uploaded_file) { double('uploaded_file') }
    let(:files_dir) { Rails.application.secrets.files_dir }

    before do
      allow(uploaded_file).to receive(:read).and_return("content\n")
      allow(uploaded_file).to receive(:original_filename).
        and_return('foo.jpg')
    end

    it "saves UploadedFile into secrets.files_dir" do
      stuff.file = uploaded_file
      stuff.save!

      expect(stuff.filename).not_to be_nil
      path = File.join(files_dir, stuff.filename)
      expect(File.read(path)).to eq "content\n"
    end
  end

  describe "#filepath" do
    before do
      stuff.filename = 'a.jpg'
      allow(Rails.application.secrets).to receive(:files_dir).
        and_return('/tmp')
    end

    it "returns absolute path where the file exists" do
      expect( stuff.filepath ).to eq '/tmp/a.jpg'
    end
  end

  describe "#expired?" do
    subject { stuff.expired? }
    before { stuff.save }

    it { should eq false }

    context "when expired" do
      let(:attrs) { {title: 'foo', expires_at: 1.day.ago} }
      it { should eq true }
    end
  end

  it "assigns expires_at" do
    expect(stuff.tap(&:save).expires_at).to be_a_kind_of(Time)
  end
end
