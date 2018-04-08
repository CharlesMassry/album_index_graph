class Artist 
  include Neo4j::ActiveNode
  property :name, type: String


  has_many :in, :contributions, rel_class: :Contribution
end
