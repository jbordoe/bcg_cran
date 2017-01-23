Hanami::Model.migration do
  change do
    create_table :packages do

      primary_key :id

      column :name, String, null: false
      column :version, String, null: false
      column :date, DateTime, null: false
      column :description, String
      column :authors, String, null: false
      column :maintainer, String
    end
  end
end
