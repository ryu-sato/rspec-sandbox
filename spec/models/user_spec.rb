require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.new(first_name: "John", last_name: "Doe", email: "user@a.a", password: "password") }

  # 姓、名、メール、パスワードがあれば有効な状態であること
  it "is valid with a first name, last name, email, and password" do
    expect(user).to be_valid
  end

  # 名がなければ無効な状態であること
  it "is invalid without a first name" do
    user.first_name = nil
    expect(user).to be_invalid
  end

  # 姓がなければ無効な状態であること
  it "is invalid without a last name" do
    user.last_name = nil
    expect(user).to be_invalid
  end

  # メールアドレスがなければ無効な状態であること
  it "is invalid without an email address" do
    user.email = nil
    expect(user).to be_invalid
  end

  # 重複したメールアドレスなら無効な状態であること
  it "is invalid with a duplicate email address" do
    user.save!
    other = User.new(first_name: "Bob", last_name: "Doe", email: 'user@a.a', password: "password")
    expect(other).to be_invalid
  end

  # ユーザーのフルネームを文字列として返すこと
  it "returns a user's full name as a string" do
    expect(user.name).to eq("John Doe")
  end
end
