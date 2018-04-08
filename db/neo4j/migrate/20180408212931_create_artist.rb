class CreateArtist < Neo4j::Migrations::Base
  def up
    add_constraint :Artist, :uuid
  end

  def down
    drop_constraint :Artist, :uuid
  end
end
