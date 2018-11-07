require 'rails_helper'

RSpec.describe Note, type: :model do
  describe "search message for a term" do
    let(:user)  { User.create(first_name: "John", last_name: "Doe", email: "john@a.a", password: "password") }
    let(:test_messages) { ["hogehoge", "higehige", "mogemoge"] }
    let(:notes) { 3.times.map.with_index {|arr, n| user.notes.create(message: test_messages[n]) } }

    context "when a match is found" do
      # 検索文字列に一致するメモを返すこと
      it "returns notes that match the search term" do
        examples = [
          { message: "hoge", notes: [notes[0]] },
          { message: "hige", notes: [notes[1]] },
          { message: "moge", notes: [notes[2]] },
          { message: "oge",  notes: [notes[0], notes[2]]}
        ]
        examples.each do |e|
          expect(Note.search(e[:message])).to match_array(e[:notes])
        end
      end
    end

    context "when no match is found" do
      # 検索結果が1件も見つからなければ空のコレクションを返すこと
      it "returns an empty collection" do
        expect(Note.search("John Doe")).to be_empty
      end
    end
  end
end
