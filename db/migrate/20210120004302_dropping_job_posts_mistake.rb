class DroppingJobPostsMistake < ActiveRecord::Migration[6.1]
  def change
    drop_table :job_posts
  end
end
