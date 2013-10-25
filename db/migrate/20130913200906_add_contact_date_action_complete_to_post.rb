class AddContactDateActionCompleteToPost < ActiveRecord::Migration
  def change
    add_column :posts, :contact_date, :date
    add_column :posts, :action_item, :text
    add_column :posts, :complete, :boolean, default: false
  end
end
