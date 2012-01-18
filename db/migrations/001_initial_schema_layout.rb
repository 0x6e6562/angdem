Sequel.migration do
  up do
    create_table(:users) do
      String    :id, :primary_key => true, :size => 50
      String    :password, :size => 60, :null => false
      String    :email, :unique => true, :null => false
      TrueClass :active, :null => false, :default => false
      DateTime  :member_since, :null => false
    end
    
    create_table(:activations) do
      String    :code, :primary_key => true, :size => 64
      DateTime  :created_at, :null => false
      String    :user_id, :null => false, :unique => true
    end
    
    alter_table(:activations) do
      add_foreign_key [:user_id], :users, :key=>:id, :name => 'fk_activation_user'
    end
  end
  down do
    drop_table(:activations)
    drop_table(:users)
  end
end