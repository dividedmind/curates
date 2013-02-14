Sequel.migration do
  change do
    create_table :rates do
      String :source, null: false
      String :from, null: false, limit: 3
      String :to, null: false, limit: 3
      Date :date, null: false, default: :now.sql_function
      primary_key [:source, :from, :to, :date]
      Numeric :value
    end
  end
end
