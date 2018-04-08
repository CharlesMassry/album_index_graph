class CreateAlbum < Neo4j::Migrations::Base
  def up
    add_constraint :Album, :uuid
  end

  def down
    drop_constraint :Album, :uuid
  end
end
