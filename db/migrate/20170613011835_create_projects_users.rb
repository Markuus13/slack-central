class CreateProjectsUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :projects_users, id: false do |t|
      t.belongs_to :projects, index: true
      t.belongs_to :users, index: true
    end
  end
end
