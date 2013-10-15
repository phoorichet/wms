class AddLastParseLineToStorage < ActiveRecord::Migration
  def change
    add_column :storages, :last_parsed_line, :integer
  end
end
