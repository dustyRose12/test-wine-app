class AddDescToPages < ActiveRecord::Migration[5.1]
  def change
    add_column :pages, :desc, :text
  end
end
