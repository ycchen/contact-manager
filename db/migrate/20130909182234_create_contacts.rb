class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.string :suffix
      t.string :company
      t.string :department
      t.string :job_title
      t.string :business_street
      t.string :business_city
      t.string :business_state
      t.string :business_zipcode
      t.string :business_fax
      t.string :business_phone
      t.string :business_phone2
      t.string :company_phone
      t.string :home_phone
      t.string :mobile_phone
      t.string :other_phone
      t.string :email
      t.string :website

      t.timestamps
    end
  end
end
