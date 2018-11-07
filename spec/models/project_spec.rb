require 'rails_helper'

RSpec.describe Project, type: :model do
  let(:user)  { User.create(first_name: "John", last_name: "Doe", email: "john@a.a", password: "password") }
  let(:other) { User.create(first_name: "Bob",  last_name: "Doe", email: "bob@a.a",  password: "password") }

  # ユーザー単位では重複したプロジェクト名を許可しないこと
  it "does not allow duplicate project names per user" do
    same_project_name = 'Same Project Name'
    user.projects.create(name: same_project_name)
    invalid_project = user.projects.build(name: same_project_name)
    expect(invalid_project).to be_invalid
  end

  # 二人のユーザーが同じ名前を使うことは許可すること
  it "allows two users to share a project name" do
    same_project_name = 'Same Project Name'
    user.projects.create(name: same_project_name)
    invalid_project = other.projects.build(name: same_project_name)
    expect(invalid_project).to be_valid
  end
end
