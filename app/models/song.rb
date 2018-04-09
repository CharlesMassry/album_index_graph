class Song 
  include Neo4j::ActiveNode
  property :title, type: String
  property :duration, type: Integer


  has_one :out, :album, rel_class: :Track, model_class: :Album
  has_many :in, :artists, rel_class: :Contribution, model_class: :Artist
end
