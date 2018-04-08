class CreateSong < Neo4j::Migrations::Base
  def up
    add_constraint :Song, :uuid
  end

  def down
    drop_constraint :Song, :uuid
  end
end
