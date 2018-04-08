class Album 
  include Neo4j::ActiveNode
  property :title, type: String

  has_many :out, :songs, rel_class: :Track, model_class: :Song
  has_many :in, :artists, rel_class: :Contribution
end
