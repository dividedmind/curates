Sequel.migration do
  change do
    create_table(:rates) do
      column :source, "text", :null=>false
      column :from, "text", :null=>false
      column :to, "text", :null=>false
      column :date, "date", :default=>Sequel::CURRENT_DATE, :null=>false
      column :value, "numeric", :null=>false
      
      primary_key [:source, :from, :to, :date]
    end
    
    create_table(:schema_info) do
      column :version, "integer", :default=>0, :null=>false
    end
  end
end
