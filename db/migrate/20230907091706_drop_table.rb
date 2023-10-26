class DropTable < ActiveRecord::Migration[7.0]
  disable_ddl_transaction!

  safety_assured do
  def change
    drop_table :topics
  end
  end
end
