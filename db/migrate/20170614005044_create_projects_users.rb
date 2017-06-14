class CreateProjectsUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :projects_users do |t|
      t.references :project, foreign_key: true
      t.references :user, foreign_key: true
    end
  end
end
