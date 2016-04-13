class AddVote < ActiveRecord::Migration
  def change
  	create_table :votes do |t|
		t.references :user
		t.references :song
	end
  end
end
