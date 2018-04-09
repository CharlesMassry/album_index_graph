class Artist 
  include Neo4j::ActiveNode
  property :name, type: String


  has_many :out, :contributions, rel_class: :Contribution
  has_many :out, :albums, rel_class: :Contribution, model_class: :Album
end
