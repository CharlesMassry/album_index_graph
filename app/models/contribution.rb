class Contribution
  include Neo4j::ActiveRel

  from_class :any
  to_class :Artist

  property :credit
  property :role
end
