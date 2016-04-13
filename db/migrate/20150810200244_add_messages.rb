class AddMessages < ActiveRecord::Migration
  def change
  	create_table :songs do |t|
  		t.references :user
		  t.string :Song_title
		  t.string :Author
		  t.string :URL
		  t.timestamps
		end
  end
end
