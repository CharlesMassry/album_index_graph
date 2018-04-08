class Track
  include Neo4j::ActiveRel

  from_class :Album
  to_class :Song

  property :track_number
end
