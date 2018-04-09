class Contribution
  include Neo4j::ActiveRel

  from_class :Artist
  to_class :any

  property :credit
  property :role
end
