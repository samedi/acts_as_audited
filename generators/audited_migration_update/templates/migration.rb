class <%= class_name %> < ActiveRecord::Migration
  def self.up
    add_column :audits, :comment, :string
    add_column :audits, :associated_id, :integer
    add_column :audits, :associated_type, :string
  end

  def self.down
    remove_column :audits, :comment
    remove_column :audits, :associated_id
    remove_column :audits, :associated_type
  end
end
