class AddContactTypeToPost < ActiveRecord::Migration
  def change
    add_reference :posts, :contact_type, index: true
  end
end
