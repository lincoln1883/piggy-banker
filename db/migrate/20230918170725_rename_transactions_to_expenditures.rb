class RenameTransactionsToExpenditures < ActiveRecord::Migration[7.0]
  def change
    rename_table :transactions, :expenditures
  end
end
